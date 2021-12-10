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
<title>Home</title>
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
	<form method="post" action="editReservation.jsp">
	<h5>Please enter Ticket ID, Flight Number and what you would like to edit.</h5>
	
		  <table>
		  <tr>  
		  
		  </tr>
		  <tr>    
					<td>Ticket ID:</td><td><input type="text" name="ticket_id"></td>
				</tr>
				<tr>    
					<td>Flight Number:</td><td><input type="text" name="flight_number"></td>
				</tr>
				<tr>
					<td>Departure Airport:</td><td><input type="text" name="departure_airport"></td>
					<td>Departure Date [yyyy-mm-dd]:</td><td><input type="text" name="departure_date"></td>
					<td>Departure Time:</td><td><input type="text" name="departure_time"></td>  
				</tr>  
				<tr>    
					<td>Arrival Airport:</td><td><input type="text" name="arrival_airport"></td>
					<td>Arrival Date [yyyy-mm-dd]:</td><td><input type="text" name="arrival_date"></td>    
					<td>Arrival Time:</td><td><input type="text" name="arrival_time"></td>
				</tr>
				<tr>
					<td>Seat:</td><td><input type="text" name="seat_number"></td>
					
				</tr>
				<tr>
					<td>Upgrade Class [Business/First]:</td><td><input type="text" name="select_class"></td>
				</tr>
					 <tr><td><input type="submit" name="command" value="EDIT"/></td></tr>	  
			</table>
			
		  <br>
		</form>
	</fieldset>		
	
	 <br>
	<br>
	
		
	
	<fieldset>
	<legend>Add, Edit, or Delete Aircraft</legend>
	<form method="post" action="aircraftHandler.jsp">
		<h4>To Add:</h4>
	<h5>Please enter all of the following information.</h5>
	<h4>To Edit:</h4>
	<h5>Please enter the aircraft model number and what you would like to edit.</h5>
	<h4>To Delete:</h4>
	<h5>Please enter the aircraft model number.</h5>
		  <table>
		  <tr>  
		  </tr>
		  <tr>    
					<td>Aircraft Model Number:</td><td><input type="text" name="aircraft_model"></td>
				</tr>
				<tr>    
					<td>Number of Seats:</td><td><input type="text" name="num_seats"></td>
				</tr>
				<tr>
					<td>Days of the Week the Aircraft Operates:</td><td><input type="text" name="days_of_op"></td>
				</tr>
				<tr>
					<td>Select Action:</td>
					<td><input type=radio name="handle_aircraft" value= "add_aircraft">Add</td>
					<td><input type=radio name="handle_aircraft" value= "edit_aircraft">Edit</td>
					<td><input type=radio name="handle_aircraft" value= "delete_aircraft">Delete</td>
				</tr>		
					 <tr><td><input type="submit" name="command" value="Submit"/></td></tr>	  
			</table>
		  <br>
		</form>
	</fieldset>
		<br>
		<br>
		
		<fieldset>
	<legend>Add, Edit, or Delete Airport</legend>
	<form method="post" action="airportHandler.jsp">
		<h4>To Add/Delete:</h4>
	<h5>Please enter original airport name.</h5>
	<h4>To Edit:</h4>
	<h5>Please enter original airport name and new airport name.</h5>
		  <table>
		  <tr>  
		  </tr>
		  <tr>    
					<td>Original Airport Name:</td><td><input type="text" name="original_name"></td><td>New Airport Name:</td><td><input type="text" name="new_name"></td>
				</tr>
				<tr>
					<td>Select Action:</td>
					<td><input type=radio name="handle_airport" value= "add_airport">Add</td>
					<td><input type=radio name="handle_airport" value= "edit_airport">Edit</td>
					<td><input type=radio name="handle_airport" value= "delete_airport">Delete</td>
				</tr>		
					 <tr><td><input type="submit" name="command" value="Submit"/></td></tr>	  
			</table>
			
		  <br>
		</form>
	</fieldset>
		<br>
		<br>
		
			<fieldset>
	<legend> Add, Edit, or Delete Flight</legend>
	<form method="post" action="flightHandler.jsp">
	<h4>To Add:</h4>
	<h5>Please enter all of the following information.</h5>
	<h4>To Edit:</h4>
	<h5>Please enter the flight number and what you would like to edit.</h5>
	<h4>To Delete:</h4>
	<h5>Please enter the flight number.</h5>
		  <table>
		  <tr>  
		  
		  </tr>
				<tr>    
					<td>Flight Number:</td><td><input type="text" name="flight_number"></td>
					<td>Occupied Seats:</td><td><input type="text" name="occupied_seats"></td>
				</tr>
				<tr>
					<td>Departure Airport:</td><td><input type="text" name="departure_airport"></td>
					<td>Departure Date [yyyy-mm-dd]:</td><td><input type="text" name="departure_date"></td>
					<td>Departure Time:</td><td><input type="text" name="departure_time"></td>  
				</tr>  
				<tr>    
					<td>Arrival Airport:</td><td><input type="text" name="arrival_airport"></td>
					<td>Arrival Date [yyyy-mm-dd]:</td><td><input type="text" name="arrival_date"></td>    
					<td>Arrival Time:</td><td><input type="text" name="arrival_time"></td>
				</tr>	
				<tr>
				<td>Flight Type [Domestic/International]:</td><td><input type="text" name="flight_type"></td>
				</tr>
				<tr>
					<td>Select Action:</td>
					<td><input type=radio name="handle_flight" value= "add_flight">Add</td>
					<td><input type=radio name="handle_flight" value= "edit_flight">Edit</td>
					<td><input type=radio name="handle_flight" value= "delete_flight">Delete</td>
				</tr>			
					 <tr><td><input type="submit" name="command" value="Submit"/></td></tr>	  
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
					<td>Airport Name</td><td><input type="text" name="airport_name"></td>
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
	<form action="answerQuestion.jsp" method="post">
        <h5>Question ID:</h5>
        <input name="question_id" type="text">
        <h5>Response:</h5>
        <input name="answer" type="text"/>
        <br><br>
        <button>Send</button>
    </form>
		<br>
		
    <%
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement check = con.createStatement();
	    

	  //write a query to access all questions
	String getQuestions = "select * from questions";
	ResultSet question = check.executeQuery(getQuestions);
	  
	populate_table_2(question, out, 0, session);
	con.close();

    db.closeConnection(con);
    %>
	
	</fieldset>
	<br>
	<fieldset>
	<form action="logout.jsp" method="post">
	<button>Logout</button>
	</form>
	</fieldset>
	</body>
	</html>

<%! void populate_table_2(ResultSet result,JspWriter out, int type, HttpSession session){
	//populates question table with all questions
	try{
	out.print("<table style='width:100%'>");
	out.print("<tr>");
	out.print("<th style='width:25%'>");
	out.print("Question ID");
	out.print("</th>");
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
		out.print(question_id);
		out.print("</td>");
		
		String question = result.getString("question");
		out.print("<td>");
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
	
	
	
	
	
	