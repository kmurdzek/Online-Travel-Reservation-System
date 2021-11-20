<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//	String message = request.getParameter("");
	String fullName = (String)session.getAttribute("name");
	String departure_date = request.getParameter("departure_date");
	String return_date = request.getParameter("return_date");
	String departure_airport = request.getParameter("departure_airport");
	String arrival_airport = request.getParameter("arrival_airport");
	String one_way = request.getParameter("flight_type");
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement check = con.createStatement();
		//if the flight is round trip just run the query get flights on the 
		//return date
		
		
		
		con.close();
		db.closeConnection(con);
	}catch (Exception e) {
	out.print(e);
}
	
//	out.print(message);
%>
<h1>Welcome <% out.print(fullName); %></h1>
</body>
</html>
