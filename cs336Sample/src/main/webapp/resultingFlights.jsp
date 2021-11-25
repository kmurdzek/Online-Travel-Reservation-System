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
	String return_date = request.getParameter("return_date");
	String departure_airport = request.getParameter("departure_airport");
	String arrival_airport = request.getParameter("arrival_airport");
	String flight_type = request.getParameter("flight_type");
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		//if the flight is round trip just run the query get flights on the 
		//return date
		Statement check = con.createStatement();
		String departure_flight = "SELECT * from flight f where f.departure_date = '"+ departure_date 
				+" ' and f.departure_airport = '" + departure_airport+"'"
						+" and f.arrival_airport = '" + arrival_airport + "'"; //query to check
		ResultSet result = check.executeQuery(departure_flight); // executes query
		ResultSet result_2 = null;
		out.print("<form method= post action = checkout.jsp>");
		if(flight_type.equals("Round-Trip")){
			//run it once dont let user not check an option
			String arrival_flight = "SELECT * from flight f where f.departure_date = '"+ return_date 
					+" ' and f.departure_airport = '" + arrival_airport+"'"
							+" and f.arrival_airport = '" + departure_airport + "'";
			%><h2>Departing Flights</h2><%
			
			populate_table(result, out,0,session);
			result_2 = check.executeQuery(arrival_flight);
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
		
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>

</body>
</html>
