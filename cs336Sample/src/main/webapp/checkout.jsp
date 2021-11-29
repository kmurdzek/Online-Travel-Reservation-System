<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
      <style>
         table, th, td {
            border: 1px solid black;
            font-family: Arial, Helvetica, sans-serif;
  			border-collapse: collapse;
  			padding: 8px;

         }
         th{
         font-family: Helvetica;
           padding-top: 12px;
  		padding-bottom: 12px;
  		text-align: left;
 		 background-color: #1fb4cf;
  		color: white;
         }
      </style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String departing_flight = request.getParameter("flight0");
String dep = (String)session.getAttribute("departure"+departing_flight);
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
List <Ticket> seat_list = new ArrayList<Ticket>();
Statement check = con.createStatement();
//confirm booking update customer ticket relationship update seat available
String get_seats = "select ticket_id, seat from ticket t where t.flight_number = "+departing_flight+" and t.available = 0";
ResultSet result = check.executeQuery(get_seats);
while (result.next()) {
    String seat = result.getString("seat");   
    int ticket_id = result.getInt("ticket_id");
    seat_list.add(new Ticket(ticket_id, seat));
} 
session.setAttribute("seat_list", seat_list);

%>
<h1>Here is your selected flight <% out.print((String)session.getAttribute("name")); %></h1>
<form action="confirmBooking.jsp" method="post">
<table>

<tr>
<th></th>
<th>Flight Number</th>
<th>Departure Airport</th>
<th>Arrival Airport</th>
<th>Departing Date/Time</th>
<th>Arriving Date/Time</th>
<th>Seats Available</th>
<th>Select a Seat </th>
</tr>

<tr>
<td>Departing</td>
<td><% out.print((String)session.getAttribute("flight_number"+departing_flight)); %> </td>
<td><% out.print((String)session.getAttribute("departure"+departing_flight)); %> </td>
<td><% out.print((String)session.getAttribute("arrival"+departing_flight)); %> </td>
<td><% out.print((String)session.getAttribute("depart_date"+departing_flight)+ " " + 
		(String)session.getAttribute("depart_time"+departing_flight)); %> </td>
<td><% out.print((String)session.getAttribute("arrival_date"+departing_flight)+ " " + 
		(String)session.getAttribute("arrival_time"+departing_flight)); %> </td>
<td><% out.print((String)session.getAttribute("occupied_seats"+departing_flight)); %> </td>

<td> 
<select name="departing_ticket">
        <c:forEach items="${seat_list}" var="ticket">
            <option value="${ticket.get_ticket_id()}">${ticket.get_seat()}</option>
        </c:forEach>
    </select>

</td>
</tr>

<%
String returning_flight= request.getParameter("flight1");
if(returning_flight != null){
	//means its a one way
	List <Ticket> seat_list_2 = new ArrayList<Ticket>();
	String get_seats_2 = "select ticket_id, seat from ticket t where t.flight_number = "+returning_flight+" and t.available = 0";
	ResultSet result_2 = check.executeQuery(get_seats_2);
	while (result_2.next()) {
	    String seat = result_2.getString("seat");   
	    int ticket_id = result_2.getInt("ticket_id");
	    seat_list_2.add(new Ticket(ticket_id, seat));
	} 
	session.setAttribute("seat_list_2", seat_list_2);
	%>
	<tr>
<td>Returning</td>
<td><% out.print((String)session.getAttribute("flight_number"+returning_flight)); %> </td>
<td><% out.print((String)session.getAttribute("departure"+returning_flight)); %> </td>
<td><% out.print((String)session.getAttribute("arrival"+returning_flight)); %> </td>
<td><% out.print((String)session.getAttribute("depart_date"+returning_flight)+ " " + 
		(String)session.getAttribute("depart_time"+returning_flight)); %> </td>
<td><% out.print((String)session.getAttribute("arrival_date"+returning_flight)+ " " + 
		(String)session.getAttribute("arrival_time"+returning_flight)); %> </td>
<td><% out.print((String)session.getAttribute("occupied_seats"+returning_flight)); %> </td>
<td>
<select name="returning_ticket">
        <c:forEach items="${seat_list_2}" var="ticket">
            <option value="${ticket.get_ticket_id()}">${ticket.get_seat()}</option>
        </c:forEach>
    </select>

</td>
	</tr>
	<%
}
%>
</table>
        <br/><br/>
    <input type="submit" value="Confirm Booking" />
    </form>


<%

con.close();
db.closeConnection(con);
%>
   

</body>
</html>