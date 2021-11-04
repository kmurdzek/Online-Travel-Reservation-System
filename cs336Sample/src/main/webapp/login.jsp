<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String message = request.getParameter("user_message");
	out.print(message);
%>
		<form method="post" action="createAccount.jsp">
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
</body>
</html>