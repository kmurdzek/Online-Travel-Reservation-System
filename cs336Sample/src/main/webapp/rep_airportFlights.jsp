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
<title>Insert title here</title>
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
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement check = con.createStatement();
String airport_name = request.getParameter("airport_name");
String query = "";


out.print("<h1>All flights from/to "+airport_name+"</h1>");
//query = "select * from flight where arrival_airport = "+airport_name+" or departure_airport= " +airport_name;
query = "select * from flight where arrival_airport = '"+airport_name+"' or departure_airport= '" +airport_name+"'";


ResultSet result = check.executeQuery(query);
populate_table(result, out, 0, session);


%>
		<form method="post" action="customerRepIndex.jsp">
		  <input type="submit" name="user_message" value="Return to Customer Rep Page"/>
		  <br>
		</form>
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
	out.print("Arrival Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Arrival Time");
	out.print("</th>");
	out.print("<th>");
	out.print("Arrival Airport");
	out.print("</th>");
	out.print("<th>");
	out.print("DepartureDate");
	out.print("</th>");
	out.print("<th>");
	out.print("Departure Time");
	out.print("</th>");
	out.print("<th>");
	out.print("Departure Airport");
	out.print("</th>");

	
	

	while(result.next()){
		out.print("<tr>");


		
		String flightNum = result.getString("flight_number");
		String arrivalDate = result.getString("arrival_date");
		String arrivalTime = result.getString("arrival_time");
		String arrivalAirport = result.getString("arrival_airport");
		String depDate = result.getString("departure_date");
		String depTime = result.getString("departure_time");
		String depAirport = result.getString("departure_airport");

		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		out.print("<td>");
		out.print(arrivalDate);
		out.print("</td>");
		out.print("<td>");
		out.print(arrivalTime);
		out.print("</td>");
		out.print("<td>");
		out.print(arrivalAirport);
		out.print("</td>");
		out.print("<td>");
		out.print(depDate);
		out.print("</td>");
		out.print("<td>");
		out.print(depTime);
		out.print("</td>");
		out.print("<td>");
		out.print(depAirport);
		out.print("</td>");
				
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>
