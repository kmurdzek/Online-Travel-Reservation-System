<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Handle Aircraft Info</title>
</head>
<body>
<%
String aircraft_name = request.getParameter("aircraft_model");
String num_seats = request.getParameter("num_seats");
String aircraft_handler = request.getParameter("handle_aircraft");
String days_of_op = request.getParameter("days_of_op");
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
if(aircraft_name.equals("")){
	con.close();
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please enter aircraft model number!" name="user_message"/>
	</jsp:forward>
	<% 
}

if(aircraft_handler == null){
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please select an action!" name="user_message"/>
	</jsp:forward>
	<% 
}

if(aircraft_handler.equals("add_aircraft")&&(num_seats.equals("") || days_of_op.equals(""))){
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Cannot add aircraft without answering all fields!" name="user_message"/>
	</jsp:forward>
	
	<% 
}

int model_number = Integer.parseInt(aircraft_name);


//before doing anything check to see if the airport is already added or not 
Statement check = con.createStatement();
String check_table = "SELECT count(*) from aircraft where aircraft_model_number = '" + model_number +"'"; //query to check
ResultSet result = check.executeQuery(check_table); // executes query
result.next(); //moves the cursor of what column its looking at
if(result.getInt(1) == 1){
	//aircraft exists --> only EDIT/DELETE
	if(aircraft_handler.equals("add_aircraft")){
		con.close();
%>
<jsp:forward page = "customerRepIndex.jsp">
<jsp:param value="This aircraft already exists in the database, please add a different one!" name="user_message"/>
</jsp:forward>
<% 
	

	} else if (aircraft_handler.equals("edit_aircraft")){
		if(!num_seats.equals("")){
			int seats = Integer.parseInt(num_seats);
			Statement stmt = con.createStatement();
			PreparedStatement statement = con.prepareStatement("update aircraft set number_of_seats = ? where aircraft_model_number = ?");
			statement.setInt(1, seats);
			statement.setInt(2, model_number);
			statement.executeUpdate();
			out.print("Successfully updated number of seats to: "+num_seats+"");
		}
		
		if(!days_of_op.equals("")){
			Statement stmt = con.createStatement();
			PreparedStatement statement = con.prepareStatement("update aircraft set days_of_operation = ? where aircraft_model_number = ?");
			statement.setString(1, days_of_op);
			statement.setInt(2, model_number);
			statement.executeUpdate();
			out.print("Successfully updated days of operation to: "+days_of_op+"");
		}
		
		con.close();
	 
		
	} else { //delete aircraft
		PreparedStatement statement = con.prepareStatement("delete from aircraft where aircraft_model_number = ?");
		statement.setInt(1, model_number);
		statement.executeUpdate();
		con.close();
		out.print("Successfully deleted aircraft: "+model_number+"");
		
		
	}
	
	//con.close();
} else { //aircraft doesn't exist --> only ADD
	if(aircraft_handler.equals("add_aircraft")){
		int seats = Integer.parseInt(num_seats);
		Statement stmt = con.createStatement();
		String insert = "INSERT INTO aircraft(aircraft_model_number, number_of_seats, days_of_operation)"
				+ "VALUES (?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. 
		ps.setInt(1, model_number);
		ps.setInt(2, seats);
		ps.setString(3, days_of_op);
		//Run the query against the DB
		ps.executeUpdate();
		con.close();
	
		out.print("Successfully added aircraft: "+model_number+" with number of seats: "+seats+" and days of operation: "+days_of_op+".");
	} else {//return error for edit/delete because aircraft does not exist
			con.close();
		%>
		<jsp:forward page = "customerRepIndex.jsp">
		<jsp:param value="Cannot edit or delete aircraft that does not exist in the database!" name="user_message"/>
		</jsp:forward>
		
		<% 
	}
	
}
%>

		<form action="customerRepIndex.jsp" method="post">
    	<button>Return to Customer Rep Dashboard</button>
   		 </form>

</body>
</html>