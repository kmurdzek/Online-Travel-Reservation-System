<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Plane Ticketing</title>
	</head>
	
	<body>
		<%

		String message = request.getParameter("user_message");
		if(message == null){
			message = "Welcome please log in or create an account";
		}
		out.print(message); %> <!-- output the same thing, but using 
	                                      jsp programming -->
							  
		<br>
		<form method="post" action="logIntoAccountLogic.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		  <table>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>		  
			</table>
			<input type="submit" name="command" value="Sign in"/>
		  <br>
		</form>
		
		
		<form method="post" action="createAccountForm.jsp">
		  <input type="submit" name="user_message" value="Create New Account"/>
		  <br>
		</form>
		<br>
	


</body>
</html>