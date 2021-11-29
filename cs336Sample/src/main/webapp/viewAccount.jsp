<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
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
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement check = con.createStatement();
String get_upcoming_flights = "select * from purchases p join ticket t on p.ticket_id=t.ticket_id join flight f on t.flight_number = f.flight_number where username = '"+(String)session.getAttribute("user")+"' and f.departure_date >='"+java.time.LocalDate.now()+"'";
ResultSet upcoming_flights = check.executeQuery(get_upcoming_flights);
%><h2>Your Upcoming Flights</h2><%
populate_table(upcoming_flights, out, 0, session);
%><h2>Your Past Flights</h2><%
String get_past_flights = "select * from purchases p join ticket t on p.ticket_id=t.ticket_id join flight f on t.flight_number = f.flight_number where username = '"+(String)session.getAttribute("user")+"' and f.departure_date <'"+java.time.LocalDate.now()+"'";
ResultSet past_flights = check.executeQuery(get_past_flights);
populate_table(past_flights, out, 1, session);
//we need a query to get the users upcoming flights
//need a query to get the users past flights
//going to join the purchases table with the flight table
//also get the seat that the user is assigned to from the ticket table
%>
</body>
</html>
<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session){
	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("Flight Number");
	out.print("</th>");
	out.print("<th>");
	//print out column header
	out.print("Departing From");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Arriving At");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Departing Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Departing Time");
	out.print("</th>");
	out.print("<th>");
	out.print("Arriving Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Arriving Time");
	out.print("</th>");
	out.print("<th>");
	out.print("Your Seat");
	out.print("</th>");

	
	out.print("</tr>");
	out.print("</tr>");
	while(result.next()){
		out.print("<tr>");

		String flightNum = result.getString("flight_number");
		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		
		String depart = result.getString("departure_airport");
		out.print("<td><label name = 'departure"+flightNum+"' value = "+depart+"/>");
		session.setAttribute("departure"+flightNum, depart);
		out.print(depart);
		out.print("</td>");
		
		String arrive = result.getString("arrival_airport");
		out.print("<td name = arrival"+flightNum+" value = "+arrive+"'>");
		session.setAttribute("arrival"+flightNum, arrive);
		out.print(arrive);
		out.print("</td>");
		
		String departure_date = result.getString("departure_date");
		out.print("<td name = depart_date"+flightNum+" value = "+departure_date+">");
		session.setAttribute("depart_date"+flightNum, departure_date);
		out.print(departure_date);
		out.print("</td>");
		
		String departure_time = result.getString("departure_time");
		out.print("<td name = depart_time"+flightNum+" value = "+departure_time+">");
		session.setAttribute("depart_time"+flightNum, departure_time);
		out.print(departure_time);
		out.print("</td>");
		
		String arrival_date = result.getString("arrival_date");
		out.print("<td name = arrival_date"+flightNum+" value = "+arrival_date+">");
		session.setAttribute("arrival_date"+flightNum, arrival_date);
		out.print(arrival_date);
		out.print("</td>");
		
		String arrival_time = result.getString("arrival_time");
		out.print("<td name = arrival_time"+flightNum+" value = "+arrival_time+">");
		session.setAttribute("arrival_time"+flightNum, arrival_time);
		out.print(arrival_time);
		out.print("</td>");
		
		String seat = result.getString("seat");
		out.print("<td name = seat"+flightNum+" value = "+seat+">");
		session.setAttribute("seat"+flightNum, seat);
		out.print(seat);
		out.print("</td>");
		
		int type_class = Integer.parseInt(result.getString("class"));
		String type_string = "";
		switch(type_class){
		case 1:
			type_string = "Economy Class";
			break;
		case 2:
			type_string = "Business Class";
			break;
		case 3:
			type_string = "First Class";
			break;
		}
			
		out.print("<td name = seat"+flightNum+" value = "+type_string+""+">");
		session.setAttribute("seat"+flightNum, type_string+"");
		out.print(type_string);
		out.print("</td>");
		/*
		String price = result.getString("price");
		out.print("<td name = price"+flightNum+" value = "+price+">");
		session.setAttribute("price"+flightNum, price);
		out.print("$"+price);
		out.print("</td>");
		*/
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>