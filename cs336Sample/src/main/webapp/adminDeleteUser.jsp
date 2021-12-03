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
String username = request.getParameter("delete_username");
PreparedStatement statement = con.prepareStatement("delete from users where username = ?");
statement.setString(1, username);
statement.executeUpdate();
%>
<jsp:forward page = "adminIndex.jsp">
<jsp:param value="Successfully deleted user" name="user_message"/>
</jsp:forward>

<% 
%>

</body>
</html>