<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//	String message = request.getParameter("user_message");
	String fullName = (String)session.getAttribute("name");
//	out.print(message);
%>

	<h1>Welcome <% out.print(fullName); %></h1>
	<form method ="post" action = "resultingFlights.jsp">
	<fieldset>
	<legend>Enter Desired Flight Information</legend>
	<label for = "departure_airport">Departure Airport:</label><br>
	<input type = "text" id = "departure_airport" name = "departure_airport"><br>
	<label for = "arrival_airport">Arrival Airport:</label><br>
	<input type = "text" id = "arrival_airport" name = "arrival_airport"><br><br>
	
	<label for = "departure_date">Departure Date:</label><br>
	<input type = "text" id = "departure_date" name = "departure_date"><br>
	<label for = "arrival_airport">Return Date:</label><br>
	<input type = "text" id = "return_date" name = "return_date"><br><br>
	
	<input type="radio" id="one-way" name="flight_type" value="One-Way">
  	<label for="one-way">One-Way</label><br>
  	<input type="radio" id="round-trip" name="flight_type" value="Round-Trip">
  	<label for="round-trip">Round-Trip</label><br><br>
	<input type = "submit" value ="Get Flights">
	</fieldset>
	</form>
	<form method="post" action="landingPage.jsp">
	<br>
	<br>
	<input type="submit" name="user_message" value="Log out"/>
		<%
		String message = request.getParameter("user_message");
		if(message!=null && message.equals("Log out")){
			session.invalidate(); 
		}
	%>
	<br>
	
	</form>
	

</body>
</html>