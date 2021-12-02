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

	<form method ="get" action = "resultingFlights.jsp">
		<fieldset>
			<legend>Enter Desired Flight Information</legend>
				<label for = "departure_airport">Departure Airport:<br>
					<input type = "text" id = "departure_airport" name = "departure_airport" size="1"><br>
					</label>
				<label for = "arrival_airport">Arrival Airport:<br>
					<input type = "text" id = "arrival_airport" name = "arrival_airport" size="1"><br><br>
					</label>
	
				<label for = "departure_date">Departure Date:</label><br>
					<input type = "date"  value="" placeholder="yyyy-mm-dd" id = "departure_date" name = "departure_date" size = "8"><br>
				<label for = "departure_date_flexibility">Departure Date Flexibility</label><br>
					<input type = "number" id = "departure_date_flexibility" name = "departure_date_flexibility" value ="0" min="0" max="365" step = "1" size="1"><label> Days</label><br> <br>
					
				<label for = "return_date">Return Date:</label><br>
					<input type = "date"  value=""  placeholder="yyyy-mm-dd" id = "return_date" name = "return_date" size = "8"><br>
				<label for = "return_date_flexibility">Return Date Flexibility</label><br>
					<input type = "number" id = "return_date_flexibility" name = "return_date_flexibility" value ="0" min="0" max="365" step = "1" size="1"><label> Days</label><br> <br>
					
				 <label>Flight Type</label><br><br> 
					<input type="radio" id="one-way" name="flight_type" value="One-Way">
					<label for="one-way">One-Way</label><br><br>
					
  					<input type="radio" id="round-trip" name="flight_type" value="Round-Trip">
					<label for="round-trip">Round-Trip</label><br><br>
				
				
				
				<input type = "submit" value ="Get Flights">
		</fieldset>
	</form>
	
	<form method="post" action="logout.jsp">
		<br><br>
			<input type="submit" value="Log out"/>
		<br>
	</form>
	
	<form method="post" action="viewAccount.jsp">
		<input type="submit" value="My Account"/>
	</form>

</body>
</html>