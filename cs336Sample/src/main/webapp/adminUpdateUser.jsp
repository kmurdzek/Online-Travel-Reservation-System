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
	String prev_username = request.getParameter("prev_username");
	String new_username = request.getParameter("new_username");
	String new_password = request.getParameter("new_password");
	if(new_username == ""){
		//means user wants to update password
		new_username = prev_username;
		PreparedStatement statement = con.prepareStatement("update users set password = ? where username = ?");
		statement.setString(1, new_password);
		statement.setString(2, prev_username);
		statement.executeUpdate();
	}else if(new_password == ""){
		//means that user want to update user name
		PreparedStatement statement = con.prepareStatement("update users set username = ? where username = ?");
		statement.setString(1, new_username);
		statement.setString(2, prev_username);
		statement.executeUpdate();
	}else{
		//means user wants to update both
		PreparedStatement statement = con.prepareStatement("update users set username = ?, password = ? where username = ?");
		statement.setString(1, new_username);
		statement.setString(2, new_password);
		statement.setString(3, prev_username);
		statement.executeUpdate();
	}
	//update username and password
	
		%>
		<jsp:forward page = "adminIndex.jsp">
		<jsp:param value="Successfully updated user" name="user_message"/>
		</jsp:forward>
		
		<% 
%>
</body>
</html>