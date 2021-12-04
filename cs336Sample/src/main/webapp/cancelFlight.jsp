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
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement check = con.createStatement();
int ticket_id = Integer.parseInt(request.getParameter("ticket_id"));
int flight_number = Integer.parseInt(request.getParameter("flight_number"));
System.out.println(flight_number);
//update the ticket table, make the ticket available
//update purchase table delete the purchase
//print your flight has been canceled for X amount
//need to get the flight number as well
PreparedStatement update_tix = con.prepareStatement("update ticket t set available = 0, class = 0 where ticket_id = ?");
update_tix.setInt(1, ticket_id);
update_tix.executeUpdate();
PreparedStatement delete_purchase = con.prepareStatement("delete from purchases p where ticket_id = ? and username = ?");
delete_purchase.setInt(1, ticket_id);
delete_purchase.setString(2, (String)session.getAttribute("user"));
delete_purchase.executeUpdate();
//increase the number of available seats
PreparedStatement increaseSeat = con.prepareStatement("update flight f set f.occupied_seats = f.occupied_seats+1 where f.flight_number = ?");
increaseSeat.setInt(1, flight_number);
increaseSeat.executeUpdate();
String flight_class = request.getParameter("class");

con.close();
db.closeConnection(con);
%>
<h1>Successfully canceled your flight reservation</h1>
<%
if(flight_class.equals("Economy Class")){
	out.print("<h2>Your booking was cancelled with an additional fee</h2>");
}else{
	out.print("<h2>Your booking was cancelled at no additional cost</h2>");
}
%>
<form method="post" action="viewAccount.jsp">
	<input type="submit" name="user_message" value="Return to My Account"/>
	<br>
</form>
</body>
</html>