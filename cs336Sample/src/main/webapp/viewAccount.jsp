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
         textarea{
         font-size: 14px;
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

String get_past_flights = "select * from purchases p join ticket t on p.ticket_id=t.ticket_id join flight f on t.flight_number = f.flight_number where username = '"+(String)session.getAttribute("user")+"' and f.departure_date <'"+java.time.LocalDate.now()+"'";
ResultSet past_flights = check.executeQuery(get_past_flights);

if (past_flights.isBeforeFirst() ) {    //if previous flights not displaying this is why
	%><h2>Your Past Flights</h2><%
    populate_table(past_flights, out, 1, session);
}

String get_waitlisted_flights = "select * from waitlisted w join flight f on w.flight_number = f.flight_number join flight_operated_by b on f.flight_number = b.flight_number where username = '"+session.getAttribute("user")+"'";
//write a query to get your waitlisted flights if its null then dont show it
ResultSet waitlisted_flights = check.executeQuery(get_waitlisted_flights);

if (waitlisted_flights.isBeforeFirst() ) {    //if previous flights not displaying this is why
	%><h2>Your Waitlisted Flights</h2><%
    populate_table_3(waitlisted_flights, out, 2, session);
}


//write a query to access all questions
String getQuestions = "select * from questions";
ResultSet question = check.executeQuery(getQuestions);



//we need a query to get the users upcoming flights
//need a query to get the users past flights
//going to join the purchases table with the flight table
//also get the seat that the user is assigned to from the ticket table

//possibly display flights that were waitlisted on, if the flight is no longer full possibly allow to book
//it


//going to display a table of Faqs, when a customer asks a question it will be shown in the 
//table but it wont have an answer until customer rep answers the question,
//each question has a question id associated with it
//
%>
<br>
<br>
<fieldset>
		<legend>Ask a Customer Representative a Question
		</legend>
		<form method="post" action="askQuestion.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		<br>
	
					<textarea name = "question" rows = "4" cols="50"></textarea><br><br>
					<input type="submit" name="question_submit" value = "Submit">


		</form>
		</fieldset>
		<br>
		<br>
<fieldset>
		<legend>Search for Question by Keywords
		</legend>
		<br>

		<form  method="post" action="searchQuestion.jsp"> 
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
		<textarea name = "question_browse" rows = "4" cols="50"></textarea><br><br>
		<input type="submit" name="search_submit" value = "Search">
		</form>
		<%

		%>
				<br>

</fieldset>
<br>
<br>
<fieldset>
		<legend>Frequently Asked Questions
		</legend>
		<br>

		
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
		<%
		populate_table_2(question, out, 0, session);
					con.close();
					db.closeConnection(con);
		%>
				<br>

</fieldset>
<br>
<br>
		<form method="post" action="index.jsp">
		  <input type="submit" name="user_message" value="Return to Homepage"/>
		  <br>
		</form>

</body>
</html>
<%! void populate_table_3(ResultSet result,JspWriter out, int type, HttpSession session){
	//populates question table with all questions
	try{
	out.print("<table>");
	out.print("<tr>");
	out.print("<th>");
	out.print("Flight Number");
	out.print("</th>");
	out.print("<th>");
	out.print("Airline");
	out.print("</th>");
	out.print("<th>");
	out.print("Departing From");
	out.print("</th>");
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
	out.print("Available Seats");
	out.print("</th>");
	out.print("<th>");
	out.print("Book");
	out.print("</th>");
	out.print("</tr>");
	

	while(result.next()){
		out.print("<tr>");
		String flightNum = result.getString("flight_number");
		out.print("<td><label name = flight_number value = "+flightNum+"/>");
		out.print(flightNum);
		out.print("</td>");
		
		String airline_id = result.getString("airline_id");
		out.print("<td><label name = airline_id value = "+airline_id+"/>");
		out.print(airline_id);
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
		
		String seats_available = result.getString("occupied_seats");
		out.print("<td><label name = seats_available value = "+seats_available+"/>");
		out.print(seats_available);
		out.print("</td>");
		int seats = Integer.parseInt(seats_available);
		if(seats > 0){
		out.print("<td>");
		out.print("<form action = resultingFlights.jsp?departure_airport="+depart+"&arrival_airport="+arrive+"&departure_date="+departure_date+"&departure_date_flexibility=0&return_date=&return_date_flexibility=0&flight_type=One-Way method= post >");
		out.print("<input type='submit' name='command' value='Book'/>");
		out.print("</form>");
		out.print("</td>");
		}else{
			out.print("<td>");
			out.print("Flight is Full");
			out.print("</td>");
		}
		out.print("</tr>");
	}
	
	out.print("</table>");
	
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>
<%! void populate_table_2(ResultSet result,JspWriter out, int type, HttpSession session){
	//populates question table with all questions
	try{
	out.print("<table style='width:100%'>");
	out.print("<tr>");
	out.print("<th style='width:50%'>");
	out.print("Question");
	out.print("</th>");
	out.print("<th style='width:50%'>");
	out.print("Answer");
	out.print("</th>");
	out.print("</tr>");

	while(result.next()){
		out.print("<tr>");
		String question_id = result.getString("question_id");
		out.print("<td><label name = question_id value = "+question_id+"/>");
		String question = result.getString("question");
		out.print(question);
		out.print("</td>");
		
		String answer = result.getString("answer");
		if(answer == null){
			out.print("<td  style = 'font-style: italic' >");
			out.print("A representative has not replied yet.");
		}else{
			out.print("<td>");
			out.print(answer);	
		}
		
		out.print("</td>");
		
		out.print("</tr>");
	}
	
	out.print("</table>");
	
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>
<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session){
	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("Ticket id");
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
	out.print("Your Seat");
	out.print("</th>");
	out.print("<th>");
	out.print("Class");
	out.print("</th>");
	out.print("<th>");
	out.print("Cancel Flight");
	out.print("</th>");
	
	out.print("</tr>");
	out.print("</tr>");
	
	while(result.next()){
		
		out.print("<tr>");
		String ticket_id = result.getString("ticket_id");
		out.print("<td><label name = ticket_id value = "+ticket_id+"/>");
		out.print(ticket_id);
		out.print("</td>");
		
		String flightNum = result.getString("flight_number");
		out.print("<td><label name = flight_number value = "+flightNum+"/>");
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
		
			
		out.print("<td name = class"+flightNum+" value = "+type_string+""+">");
		session.setAttribute("class"+flightNum, type_string+"");
		out.print(type_string);
		out.print("</td>");
		
		out.print("<td>");
		out.print("<form action = cancelFlight.jsp method= post >");
		out.print("<input type='submit' name='command' value='Cancel'/>");
		out.print("<input type=hidden name=ticket_id value='"+ticket_id+"'>");
		out.print("<input type=hidden name=flight_number value='"+flightNum+"'>");
		out.print("<input type=hidden name=class value='"+type_string+"'>");
		out.print("</form>");
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