<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
<%@ page import ="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.time.Duration"%>
<%@ page import ="java.text.SimpleDateFormat,java.util.Date" %>
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
	String flight_number = request.getParameter("flight_number");
	String username = request.getParameter("username");
	String airline = request.getParameter("airline");
	Statement check = con.createStatement();
	String query = "";
	boolean byUser = false;
	boolean byAirline = false;
	boolean byFlight = false;
	
	if(username!=""){
		query = "select sum(p.total_cost) as revenue from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number where p.username = '"+username+"' group by f.flight_number";
		byUser = true;
	}else if(airline!=""){
		query = "select sum(p.total_cost) as revenue from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on f.flight_number = b.flight_number where b.airline_id = '"+airline+"' group by f.flight_number";
		byAirline = true;
	}
	else if(flight_number!=""){
		query = "select sum(p.total_cost) as revenue from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number where f.flight_number = "+flight_number+" group by f.flight_number";
		byFlight = true;
	}else{
		System.out.println("everything null");
	}
	ResultSet result = check.executeQuery(query);
	int revenue = 0;
	while(result.next()){
		 revenue = Integer.parseInt(result.getString("revenue"));
	}
	String query2 = "";
	
	if(byUser){
		out.print("<h1>Revenure for User: "+username+", totaled to : $"+revenue+"</h1>");
		query2 = "select * from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on f.flight_number = b.flight_number where p.username = '"+username+"'";

		//now we need to make a query to display the flights that contributed to revenue
	}else if(byAirline){
		out.print("<h1>Revenure for Airline: "+airline+" totaled to : $"+revenue+"</h1>");
		//now we need to make a query to display the flights that contributed
		query2 = "select * from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on f.flight_number = b.flight_number where b.airline_id = '"+airline+"'";

	}else if(byFlight){
		out.print("<h1>Revenure for Flight: "+flight_number+" totaled to : $"+revenue+"</h1>");
		query2 = "select * from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on f.flight_number = b.flight_number where f.flight_number = "+flight_number+"";


	}
	out.print("<h2>List of Flights Contributing to the Revenue Total: </h2>");
	ResultSet result2 = check.executeQuery(query2);
	populate_table(result2, out, 0, session);
%>
		<form method="post" action="adminIndex.jsp">
		  <input type="submit" name="user_message" value="Return to Admin Page"/>
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
	out.print("User");
	out.print("</th>");
	out.print("<th>");
	out.print("Airline");
	out.print("</th>");
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
	out.print("Price");
	out.print("</th>");

	
	out.print("</tr>");
	out.print("</tr>");
	
	while(result.next()){
		out.print("<tr>");


		
		String flightNum = result.getString("flight_number");
		String user = result.getString("username");
		out.print("<td name = user"+flightNum+" value = "+user+"'>");
		out.print(user);
		out.print("</td>");
		
		
		String airline_name = result.getString("airline_id");
		out.print("<td name = arrival"+flightNum+" value = "+airline_name+"'>");
		out.print(airline_name);
		out.print("</td>");
		
		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		
		String depart = result.getString("departure_airport");
		out.print("<td><label name = 'departure"+flightNum+"' value = "+depart+"/>");
		out.print(depart);
		out.print("</td>");
		
		String arrive = result.getString("arrival_airport");
		out.print("<td name = arrival"+flightNum+" value = "+arrive+"'>");
		out.print(arrive);
		out.print("</td>");
		
		String departure_date = result.getString("departure_date");
		out.print("<td name = depart_date"+flightNum+" value = "+departure_date+">");
		out.print(departure_date);
		out.print("</td>");
		
		String departure_time = result.getString("departure_time");
		out.print("<td name = depart_time"+flightNum+" value = "+departure_time+">");
		out.print(departure_time);
		out.print("</td>");
		
		String arrival_date = result.getString("arrival_date");
		out.print("<td name = arrival_date"+flightNum+" value = "+arrival_date+">");
		out.print(arrival_date);
		out.print("</td>");
		
		String arrival_time = result.getString("arrival_time");
		out.print("<td name = arrival_time"+flightNum+" value = "+arrival_time+">");
		out.print(arrival_time);
		out.print("</td>");
		
		String cost = result.getString("total_cost");
		out.print("<td name = seat"+flightNum+" value = "+cost+">");
		out.print("$" + cost);
		out.print("</td>");
		
		
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>