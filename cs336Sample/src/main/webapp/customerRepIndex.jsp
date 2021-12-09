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
      td {
        height: 40px;
        width: 120px;
        text-align: center;
        vertical-align: middle;
      }
      th{
       height: 40px;
        width: 120px;
        text-align: center;
        vertical-align: middle;
      }
    </style>
</head>
<body>
		<%

		String message = request.getParameter("user_message");
		if(message == null){
			message = "Welcome Customer Representative";
		}
		out.print(message); %>
		
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
			
			
		<form method ="get" action = "rep_resultingFlights.jsp">
		<fieldset>
			<legend>Enter Desired Flight Information</legend>
			
				<label for = "username">User Name:<br>
					<input type = "text" id = "username" name = "username" size="6"><br>
					</label>
					
				<label for = "departure_airport">Departure Airport:<br>
					<input type = "text" id = "departure_airport" name = "departure_airport" size="4"><br>
					</label>
				<label for = "arrival_airport">Arrival Airport:<br>
					<input type = "text" id = "arrival_airport" name = "arrival_airport" size="4"><br><br>
					</label>
	
				<label for = "departure_date">Departure Date:</label><br>
					<input type = "date"  value="" placeholder="yyyy-mm-dd" id = "departure_date" name = "departure_date" size = "10"><br>
				<label for = "departure_date_flexibility">Departure Date Flexibility</label><br>
					<input type = "number" id = "departure_date_flexibility" name = "departure_date_flexibility" value ="0" min="0" max="365" step = "1" size="1"><label> Days</label><br> <br>
					
				<label for = "return_date">Return Date:</label><br>
					<input type = "date"  value=""  placeholder="yyyy-mm-dd" id = "return_date" name = "return_date" size = "10"><br>
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
		
		
		 <br>
		  <br>
		   
			
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
			
	<fieldset>
	<legend>Edit Reservation</legend>
	<form method="post" action="adminDeleteUser.jsp">
		  <table>
		  <tr>  
		  </tr>
				<tr>    
					<td>Ticket ID</td><td><input type="text" name="delete_username"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Edit"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
		  <br>
		</form>
	</fieldset>		
	
	 <br>
	<br>
	
		
	
	<fieldset>
	<legend>Add, Edit, Delete information for aircrafts, airports, and flights</legend>
	<form method="post" action="adminDeleteUser.jsp">
		  <table>
		  <tr>  
		  </tr>
				<tr>    
					<td>Flight Number</td><td><input type="text" name="delete_username"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Submit"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
		</form>
	</fieldset>
		<br>
		<br>
		
	
	
	<form method="post" action="rep_waitinglist.jsp">
	<fieldset>
	<legend>Waiting List</legend>
		  <table>
		  <tr>  
		  </tr>
				<tr>    
					<td>Flight Number</td><td><input type="text" name="flight_number"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Submit"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
		
	</fieldset>
	</form>
		<br>
		<br>
		
		
	<form method="post" action="rep_airportFlights.jsp">
	<fieldset>
	<legend>List Flights for Airport</legend>
		  <table>
		  <tr>  
		  </tr>
				<tr>    
					<td>Airport Name</td><td><input type="text" name="delete_username"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Submit"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
	</fieldset>
	</form>
	
		<br>
		<br>
		
		
		
		
	<fieldset>
	<legend>User Questions</legend>
	<form method="post" action="adminDeleteUser.jsp">
		  <table>
		  <tr>  
		  </tr>
		  <td>There will be a table of questions here</td>
				<tr>    
					<td>Answer:</td><td><input type="text" name="delete_username"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Submit"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
		</form>
	</fieldset>