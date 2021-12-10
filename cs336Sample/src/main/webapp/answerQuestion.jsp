<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
<%@ page import ="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.time.Duration"%>
<%@ page import ="java.text.SimpleDateFormat,java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Answer Customer Question</title>
</head>
<body>

<%

String question_id = request.getParameter("question_id");

String answer = request.getParameter("answer");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement stmt = con.createStatement();

if(question_id.equals("") || answer.equals("")){
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please enter Question ID AND Reply!" name="user_message"/>
	</jsp:forward>
	<% 
}


PreparedStatement statement = con.prepareStatement("update questions set answer = ? where question_id = ?");
int qid = Integer.parseInt(request.getParameter("question_id"));
statement.setString(1, answer);
statement.setInt(2, qid);
statement.executeUpdate();
out.print("Reply has been sent.");
con.close();
		    
		
	%>
	<form action="customerRepIndex.jsp" method="post">
    	<button>Return to Customer Rep Dashboard</button>
    </form>
</body>
</html>

