<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, java.time.format.DateTimeFormatter, java.time.LocalDateTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>You have joined the waitlist</h1>
<%
try{
String username = (String)session.getAttribute("username");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement check = con.createStatement();
//check the table to see if the persons already on the flight waitlist
//if the flight is not even full dont put on the waitlist?
//if a user cancels and a person on the waitlist books, remove the entry from the waitlist
String departing_flight_num = (String)session.getAttribute("departing_flight_number");
String returning_flight_num = (String)session.getAttribute("returning_flight_number");

PreparedStatement statement = con.prepareStatement("insert into waitlisted values(?,?)");
statement.setString(1,username);
statement.setInt(2, Integer.parseInt(departing_flight_num));
statement.executeUpdate();
if(returning_flight_num!=null){
statement.setString(1,username);
statement.setInt(2, Integer.parseInt(returning_flight_num));
statement.executeUpdate();
}
}catch(Exception e){
	out.print(e);
}
%>
		<form method="post" action="customerRepIndex.jsp">
		  <input type="submit" name="user_message" value="Return to Homepage"/>
		  <br>
		</form>
</body>
</html>