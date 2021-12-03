<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <style>
      td {
        height: 40px;
        width: 120px;
        text-align: center;
        vertical-align: middle;
      }
    </style>
</head>
<body>
<%
//need to add edit or delete a customer or customer rep
//make 3 tables, one to add with all info, one to update with all info
//another tiny line that could delete using username

%>
		<%

		String message = request.getParameter("user_message");
		if(message == null){
			message = "Welcome Admin";
		}
		out.print(message); %>
		<form method="post" action="adminCreateUser.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		  <table>
		  <tr>  
		  <th>Create a User</th>
		  </tr>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
				<tr>
					<td>First Name</td><td><input type="text" name="first_name"></td>
				</tr>		
				<tr>
					<td>Last Name</td><td><input type="text" name="last_name"></td>
				</tr>	
				<tr>
					<td>Select User Type</td>
					<td><input type=radio name="type_of_user" value= "admin">Admin</td>
					<td><input type=radio name="type_of_user" value= "customer_rep">Customer Representitive</td>
					<td><input type=radio name="type_of_user" value= "customer">Customer</td>
				</tr>		
					 		  
			</table>
			<input type="submit" name="command" value="Create User"/>
		  <br>
		</form>
		 <br>
		  <br>
		   <br>
			<form method="post" action="adminUpdateUser.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		  <table>
		  <tr>  
		  <th>Update a User</th>
		  </tr>
				<tr>    
					<td>Current Username</td><td><input type="text" name="prev_username"></td><td>New Username</td><td><input type="text" name="new_username"></td>
				</tr>
				<tr>
				<td></td><td></td><td>OR</td>
				</tr>
				<tr>
					<td></td><td></td><td>New Password</td><td><input type="text" name="new_password"></td>
				</tr>	
					 		  
			</table>
			<input type="submit" name="command" value="Update"/>
		  <br>
		  <br>
		  <br>
		  <br>
		</form>
		<form method="post" action="adminDeleteUser.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		  <table>
		  <tr>  
		  <th>Delete a User</th>
		  </tr>
				<tr>    
					<td>Username</td><td><input type="text" name="delete_username"></td>
				</tr>
					 		  
			</table>
			<input type="submit" name="command" value="Delete"/>
		  <br>
		</form>
				<form method="post" action="adminDeleteUser.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
		<br>
		<br>
		<br>
		  <table>
		  <tr>  
		  <th>Get Sales Report For Particular month</th>
		  </tr>
				<tr>    
					<td><input type="submit" name="delete_username" value = "Get Sales"></td>
				</tr>
					 		  
			</table>
		  <br>
		</form>
</body>
</html>