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
String flight_number = request.getParameter("flight_number");
String username = request.getParameter("username");
String query = "";

//check which ones null, if null then dont do that one have two queries
if(username == ""){
	out.print("<h1>Reservations for flight number "+flight_number+"</h1>");
	//if username is null were getting the reservations by flight_num
	query = "select * from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on b.flight_number = f.flight_number where t.flight_number = "+flight_number+" group by t.ticket_id";
}else{
	//otherwise were getting by username
	out.print("<h1>Reservations for "+username+"</h1>");
	query = "select * from purchases p join ticket t on t.ticket_id = p.ticket_id join flight f on t.flight_number = f.flight_number join flight_operated_by b on b.flight_number = f.flight_number  where p.username = '"+username+"' group by t.ticket_id";
}
ResultSet result = check.executeQuery(query);
populate_table(result, out, 0, session);


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
	out.print("Seat");
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
		
		String seat = result.getString("seat");
		out.print("<td name = seat"+flightNum+" value = "+seat+">");
		out.print(seat);
		out.print("</td>");
		
		
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>