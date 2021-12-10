<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
   <head>
   <meta charset="UTF-8">
      <title>Edit Reservation</title>
     
   </head>
   <body>
<h3>Modify Reservation</h3>

<% 

String ticket_id = request.getParameter("ticket_id");
String flight_number = request.getParameter("flight_number");
String departure_airport = request.getParameter("departure_airport");
String departure_date = request.getParameter("departure_date");
String departure_time = request.getParameter("departure_time");
String arrival_airport = request.getParameter("arrival_airport");
String arrival_date = request.getParameter("arrival_date");
String arrival_time = request.getParameter("arrival_time");
String seat = request.getParameter("seat_number");
String select_class = request.getParameter("select_class");
int business = 1;
int first = 2;
ApplicationDB db = new ApplicationDB();
Connection con = db.getConnection();

if(ticket_id.equals("") || flight_number.equals("")){
	con.close();
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please enter Ticket ID AND Flight Number!" name="user_message"/>
	</jsp:forward>
	<% 
}

int flight_num = Integer.parseInt(flight_number);
int ticket = Integer.parseInt(ticket_id);

Statement check = con.createStatement();
String check_table = "SELECT count(*) from ticket where ticket_id = '" + ticket + "'"; //query to check
ResultSet result = check.executeQuery(check_table); // executes query
result.next(); //moves the cursor of what column its looking at
if(result.getInt(1) == 1){//ticket exists can edit
	
	if(!departure_airport.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set departure_airport = ? where flight_number = ?");
		statement.setString(1, departure_airport);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Departure airport has been modified to "+departure_airport+".");
	}
	if(!departure_date.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set departure_date = ? where flight_number = ?");
		statement.setString(1, departure_date);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Departure date has been modified to "+departure_date+".");
	}
	if(!departure_time.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set departure_time = ? where flight_number = ?");
		statement.setString(1, departure_time);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Departure time has been modified to "+departure_time+".");
	}
	if(!arrival_airport.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set arrival_airport = ? where flight_number = ?");
		statement.setString(1, arrival_airport);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Arrival airport has been modified to "+arrival_airport+".");
	}
	if(!arrival_date.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set arrival_date = ? where flight_number = ?");
		statement.setString(1, arrival_date);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Arrival date has been modified to "+arrival_date+".");
	}
	if(!arrival_time.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update flight set arrival_time = ? where flight_number = ?");
		statement.setString(1, arrival_time);
		statement.setInt(2, flight_num);
		statement.executeUpdate();
		out.print("Arrival time has been modified to "+arrival_time+".");
	}
	if(!seat.equals("")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update ticket set seat = ? where ticket_id = ?");
		statement.setString(1, seat);
		statement.setInt(2, ticket);
		statement.executeUpdate();
		out.print("Seat has been modified to "+seat+".");
	}
	if(select_class.equals("Business") || select_class.equals("business")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update ticket set class = ? where ticket_id = ?");
		statement.setInt(1, business);
		statement.setInt(2, ticket);
		statement.executeUpdate();
		out.print("Seat has been upgraded to "+select_class+" for an additional fee.");
	}
	if(select_class.equals("First") || select_class.equals("first")){
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update ticket set class = ? where ticket_id = ?");
		statement.setInt(1, first);
		statement.setInt(2, ticket);
		statement.executeUpdate();
		out.print("Seat has been upgraded to "+select_class+" for an additional fee.");
	}
	con.close();
	
} else { //ticket doesn't exist can't edit
	con.close();
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Reservation doesn't exist." name="user_message"/>
	</jsp:forward>
	<% 
}
%>

	<form action="customerRepIndex.jsp" method="post">
    	<button>Return to Customer Rep Dashboard</button>
    </form>

    
</body>
</html>