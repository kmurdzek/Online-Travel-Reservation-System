<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*"%>
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
%>
<h1>Here is your selected flight <% out.print((String)session.getAttribute("name")); %></h1>
<table>

<tr>
<th></th>
<th>Flight Number</th>
<th>Departure Airport</th>
<th>Arrival Airport</th>
<th>Departing Date/Time</th>
<th>Arriving Date/Time</th>
<th>Seats Available</th>
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
</tr>

<%
String returning_flight= request.getParameter("flight1");
if(returning_flight != null){
	//means its a one way
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
	</tr>
	<%
}
%>
</table>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	

Statement check = con.createStatement();
//confirm booking update customer ticket relationship update seat available
String query = "";

%>
</body>
</html>