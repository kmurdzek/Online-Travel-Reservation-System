<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	String fname = request.getParameter("first_name");
	String lname = request.getParameter("last_name");
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String user_type = request.getParameter("type_of_user");
	boolean isAdmin = false;
	boolean isCustomerRep = false;
	boolean isCustomer = false;
	if(user_type.equals("admin")){
		isAdmin = true;
	}else if(user_type.equals("customer_rep")){
		isCustomerRep = true;
	}else{
		isCustomer = true;
	}
	if(fname == "" || lname == "" || username == "" || password == ""){
		System.out.println("Invalid");
		%>
		<jsp:forward page = "adminIndex.jsp">
		<jsp:param value="Invalid create user attempt" name="user_message"/>
		</jsp:forward>
		<% 
	}else{
		
		//before inserting want to check that the username does not already exist
		Statement check = con.createStatement();
		String check_table = "SELECT count(*) from users where username = '" + username +"'"; //query to check
		ResultSet result = check.executeQuery(check_table); // executes query
		result.next(); //moves the cursor of what column its looking at
		if(result.getInt(1) == 1){
			//user exists cannot insert
			con.close();
			%>
		<jsp:forward page = "adminIndex.jsp">
		<jsp:param value="This username is already taken, try a new username" name="user_message"/>
		</jsp:forward>
			<% 
		}else{
		System.out.println(fname + " " + lname + " " + username + " " + password);
		//if none are null we can add it into the database
		//Create a SQL statement
		Statement stmt = con.createStatement();
		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO users(username, password, fname, lname, is_admin, is_customer_rep, is_customer)"
				+ "VALUES (?, ?, ?, ?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. 
		ps.setString(1, username);
		ps.setString(2, password);
		ps.setString(3, fname);
		ps.setString(4, lname);
		ps.setBoolean(5, isAdmin);
		ps.setBoolean(6, isCustomerRep);
		ps.setBoolean(7, isCustomer);
		//Run the query against the DB
		ps.executeUpdate();
		con.close();
	
		%>
		<jsp:forward page = "adminIndex.jsp">
		<jsp:param value="Successfully added user" name="user_message"/>
		</jsp:forward>
		
		<% 
		//on success redirect to login
		//if the insert succeeded load up the login page
		//otherwise go back to the html page to create account
		}
	}
	
		//close the connection.
		db.closeConnection(con);		
	} catch (Exception e) {
		out.print(e);
	%>
	
	</body>
	</html>