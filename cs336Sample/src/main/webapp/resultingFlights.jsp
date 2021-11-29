<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
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
//	String message = request.getParameter("");
	String fullName = (String)session.getAttribute("name");
	
	%><h1>Check the available flights <% out.print(fullName); %></h1><%
	String departure_date = request.getParameter("departure_date");
	if (session.getAttribute("departure_date") == null){
		session.setAttribute("departure_date", departure_date);	
	}
	String return_date = request.getParameter("return_date");
	if (session.getAttribute("return_date") == null){
		session.setAttribute("return_date", return_date);	
	}
	String departure_airport = request.getParameter("departure_airport");
	if (session.getAttribute("departure_airport") == null){
		session.setAttribute("departure_airport", departure_airport);	
	}
	
	String arrival_airport = request.getParameter("arrival_airport");
	if(session.getAttribute("arrival_airport") == null){
		session.setAttribute("arrival_airport", arrival_airport);	
	}
	String flight_type = request.getParameter("flight_type");
	if(session.getAttribute("flight_type") == null){
		session.setAttribute("flight_type", flight_type);	
	}
	String sort_by = request.getParameter("sort_by");
	if (departure_date == null){
		departure_date = (String)session.getAttribute("departure_date");
		return_date = (String)session.getAttribute("return_date");	
		departure_airport = (String)session.getAttribute("departure_airport");	
		arrival_airport = (String)session.getAttribute("arrival_airport");
		flight_type = (String)session.getAttribute("flight_type");
		
	}
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		//if the flight is round trip just run the query get flights on the 
		//return date
		Statement check = con.createStatement();
		
		PreparedStatement update_seats = con.prepareStatement("update flight f set f.occupied_seats = (select count(*) from ticket t where t.available = 0 and t.flight_number = f.flight_number and f.departure_date = ? and f.departure_airport = ? and f.arrival_airport = ? )");

		update_seats.setDate(1, java.sql.Date.valueOf(departure_date));
		update_seats.setString(2, departure_airport);
		update_seats.setString(3, arrival_airport);
		update_seats.executeUpdate();
		
		
		ResultSet result = executeQueryHelper(sort_by, departure_date, departure_airport, arrival_airport, con);
		//ResultSet result = check.executeQuery(departure_flight); // executes query
		
		
		ResultSet result_2 = null;
		out.print("<th>");
		out.print("Sort By ");
		
		out.print("<form name =sort  method =get action =resultingFlights.jsp>");
		//out.print("<select name = \"sort_by\"  onchange = \"response.setHeader(\"Refresh\", \"0; URL=http://localhost:8080/cs336project/resultingFlights.jsp\") >");
		out.print("<select name = sort_by id =sorting_options >");	
		out.print("<option value = \"None\">None</option>");
		out.print("<option value = \"price_low_to_high\">Price(Low to high)</option>");
		out.print("<option value = \"price_high_to_low\">Price(High to Low)</option>");
		out.print("<option value = \"take_off_time_earliest_first\">Take off time (earliest first)</option>");
		out.print("<option value = \"take_off_time_latest_first\">Take off time (latest first)</option>");
		out.print("<option value = \"landing_time_earliest_first\">Landing Time (earliest first)</option>");
		out.print("<option value = \"landing_time_latest_first\">Landing Time (latest first)</option>");
		out.print("<option value = \"duration_of_flight_shortest_first\">Duration of flight (shortest first)</option>");
		out.print("<option value = \"duration_of_flight_longest_first\">Duration of flight (longest first)</option>");	

		out.print("</select>");
		out.print("<input type=submit name=sort_submit value=Sort >");
		out.print("</form>");
		//session.setAttribute("sort_by", session.getAttribute(“sort_by”));
		
		//if (session.getAttribute("sort_by") != null){
		//	RequestDispatcher rd = (javax.servlet.RequestDispatcher)request.getRequestDispatcher("resultingFlights.jsp"); 
		//	rd.forward(request, response);			
		//}
		
		
		out.print("</th>");
		out.print("<form method= post action = checkout.jsp>");
		if(flight_type.equals("Round-Trip")){
			//run it once dont let user not check an option

			update_seats.setDate(1, java.sql.Date.valueOf(return_date));
			update_seats.setString(2, arrival_airport);
			update_seats.setString(3, departure_airport);
			update_seats.executeUpdate();
	
			%><h2>Departing Flights</h2><%
			
			populate_table(result, out,0,session);
			result_2 = executeQueryHelper(sort_by, return_date, arrival_airport,departure_airport, con);
			//result_2 = check.executeQuery(arrival_flight);
			%><h2>Returning Flights</h2><%
			populate_table(result_2, out,1,session);		
		}else{
			%><h2>Departing Flights</h2><%
			populate_table(result, out,0,session);
		}
		out.print("<input type='submit' name='command' value='Book Tickets'/>");
		out.print("</form>");
		//populates the departing table
		
		
		
		con.close();
		db.closeConnection(con);
	}catch (Exception e) {
	out.print(e);
}
	
//	out.print(message);
%>
<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session){
	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("Select");
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
	out.print("Seats Available");
	out.print("</th>");
	out.print("<th>");
	out.print("Tickets Pricing From");
	out.print("</th>");

	
	out.print("</tr>");
	out.print("</tr>");
	while(result.next()){
		out.print("<tr>");

		String flightNum = result.getString("flight_number");
		out.print("<td>");
		out.print(" <input type= radio name=flight"+type+" value="+flightNum+"> ");
		session.setAttribute("flight_number"+flightNum, flightNum);
		
		System.out.println("flight_number"+flightNum);
		out.print("</td>");
		
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
		
		String occupied_seats = result.getString("occupied_seats");
		out.print("<td name = occupied_seats"+flightNum+" value = "+occupied_seats+">");
		session.setAttribute("occupied_seats"+flightNum, occupied_seats);
		out.print(occupied_seats);
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
<%! ResultSet executeQueryHelper(String sort_by, String departure_date, String departure_airport, String arrival_airport, Connection con){
	try{
	Statement check = con.createStatement();
	String departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date 
			+" ' and f.departure_airport = '" + departure_airport+"'"
			+" and f.arrival_airport = '" + arrival_airport + "'";
			
		
	if (sort_by == null){
		//departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "'"; //query to check
		departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date 
				+" ' and f.departure_airport = '" + departure_airport+"'"
				+" and f.arrival_airport = '" + arrival_airport + "'";
		
		
		System.out.println(departure_flight);
				
	}
	else if (sort_by.equals("price_low_to_high")){
		departure_flight = "SELECT distinct f.flight_number, MIN(price) as price, f.* from flight f join ticket t on f.flight_number = t.flight_number where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and t.available = 0 GROUP BY f.flight_number " ;
	}
	else if (sort_by.equals("price_high_to_low")){
		departure_flight = "SELECT distinct f.flight_number, MAX(price) as price, f.* from flight f join ticket t on f.flight_number = t.flight_number where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and t.available = 0 GROUP BY f.flight_number " ; 
	}
	else if (sort_by.equals("take_off_time_earliest_first")){
		departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' ORDER BY f.departure_time " ;
	}
	else if (sort_by.equals("take_off_time_latest_first")){
		departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' ORDER BY f.departure_time DESC" ;
	}
	else if (sort_by.equals("landing_time_earliest_first")){
		departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' ORDER BY f.arrival_time" ;
	}
	else if (sort_by.equals("landing_time_latest_first")){
		departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date +" ' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' ORDER BY f.arrival_time DESC" ;
	}
	ResultSet returning = check.executeQuery(departure_flight);
	return returning;
	}catch(SQLException e){
		System.out.println(e);
	}
	return null;
	}
%>

</body>
</html>
