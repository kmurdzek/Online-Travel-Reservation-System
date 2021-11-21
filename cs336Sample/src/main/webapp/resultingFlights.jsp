<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*"%>
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
		if(flight_type.equals("Round-Trip")){
			//run it once dont let user not check an option
			String arrival_flight = "SELECT * from flight f where f.departure_date = '"+ return_date 
					+" ' and f.departure_airport = '" + arrival_airport+"'"
							+" and f.arrival_airport = '" + departure_airport + "'";
			%><h2>Departing Flights</h2><%
			populate_table(result, out);
			result_2 = check.executeQuery(arrival_flight);
			%><h2>Returning Flights</h2><%
			populate_table(result_2, out);
			
		}else{
			%><h2>Departing Flights</h2><%
			populate_table(result, out);
			
		}
		
		//populates the departing table
		
		
		
		con.close();
		db.closeConnection(con);
	}catch (Exception e) {
	out.print(e);
}
	
//	out.print(message);
%>
<%! void populate_table(ResultSet result,JspWriter out){
	try{
	out.print("<body>");
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<td>");
	out.print("Flight Number");
	out.print("</td>");
	out.print("<td>");
	//print out column header
	out.print("Departing From");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Arriving At");
	out.print("</td>");
	//make a column
	out.print("<td>");
	out.print("Departing Date");
	out.print("</td>");
	out.print("<td>");
	out.print("Departing Time");
	out.print("</td>");
	out.print("<td>");
	out.print("Arriving Date");
	out.print("</td>");
	out.print("<td>");
	out.print("Arriving Time");
	out.print("</td>");
	out.print("<td>");
	out.print("Seats Available");
	out.print("</td>");
	out.print("</tr>");
	while(result.next()){
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//Print out current bar name:
		out.print(result.getString("flight_number"));
		out.print("</td>");
		out.print("<td>");
		//Print out current beer name:
		out.print(result.getString("departure_airport"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("arrival_airport"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("departure_date"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("departure_time"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("arrival_date"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("arrival_time"));
		out.print("</td>");
		out.print("<td>");
		//Print out current price
		out.print(result.getString("occupied_seats"));
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");
	out.print("</body>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>

</body>
</html>
