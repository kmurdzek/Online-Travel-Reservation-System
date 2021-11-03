<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
		%>
				<!--  Make an HTML table to show the results in: -->
		<form method="post" action="#">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		  <table>
		  <tr>    
				<td>First Name</td><td><input type="text" name="f_name"></td>
				</tr>
				<tr>    
					<td>Last name</td><td><input type="text" name="l_name"></td>
				</tr>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>		  
			</table>
			<input type="submit" name="command" value="Create Account"/>
		  <br>
		</form>

		<%

		String fname = request.getParameter("f_name");
		String lname = request.getParameter("l_name");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		if(fname == null ||fname == "" || lname == "" || username == "" || password == ""){
			System.out.println("Invalid");
		}else{
			
			//before inserting want to check that the username does not already exist
			Statement check = con.createStatement();
			String check_table = "SELECT count(*) from users where username = '" + username +"'"; //query to check
			ResultSet result = check.executeQuery(check_table); // executes query
			result.next(); //moves the cursor of what column its looking at
			if(result.getInt(1) == 1){
				//user exists cannot insert
				out.print("This username is already taken, try a new username");
				con.close();
			}else{
			System.out.println(fname + " " + lname + " " + username + " " + password);
			//if none are null we can add it into the database
			//Create a SQL statement
			Statement stmt = con.createStatement();

			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO users(username, password, fname, lname, is_admin, is_customer, is_customer_rep)"
					+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);

			//Add parameters of the query. 
			ps.setString(1, username);
			ps.setString(2, password);
			ps.setString(3, fname);
			ps.setString(4, lname);
			ps.setBoolean(5, false);
			ps.setBoolean(6, false);
			ps.setBoolean(7, true);
			//Run the query against the DB
			ps.executeUpdate();
			con.close();
			out.print("Insert succeeded!");
			}
		}
		
		%>
			<%
			//close the connection.
			db.closeConnection(con);
			%>			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
</body>
</html>