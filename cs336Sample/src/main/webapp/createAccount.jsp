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
		System.out.println(fname + " " + lname);
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