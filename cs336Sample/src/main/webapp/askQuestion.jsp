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
	
	String question = request.getParameter("question");
	System.out.println(question);
	//here were going to put the question in the question table 
	//then redirect the user to back to the view account page
	//on redirect the question will be displayed
	Statement stmt = con.createStatement();
	String insert = "INSERT INTO questions(question)"
						+ "VALUES (?)";
	PreparedStatement ps = con.prepareStatement(insert);
	ps.setString(1, question);
	ps.executeUpdate();
	
	con.close();
	db.closeConnection(con);
	%>

	<jsp:forward page = "viewAccount.jsp">
	<jsp:param value="Question added" name="user_message"/>
	</jsp:forward>
<%
%>

</body>
</html>