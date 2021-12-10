<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Handle Flight Info</title>
</head>
<body>

<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
String flight_number = request.getParameter("flight_number");
String flight_handler = request.getParameter("handle_flight");
String occupied_seats = request.getParameter("occupied_seats");
String departure_airport = request.getParameter("departure_airport");
String departure_date = request.getParameter("departure_date");
String departure_time = request.getParameter("departure_time");
String arrival_airport = request.getParameter("arrival_airport");
String arrival_date = request.getParameter("arrival_date");
String arrival_time = request.getParameter("arrival_time");
String flight_type = request.getParameter("flight_type"); //domestic or international
Boolean domestic = false;
Boolean international = false;
String query ="";

if(flight_type.equals("Domestic")){
	domestic = true;
	international = false;
}
if(flight_type.equals("International")){
	international = true;
	domestic = false;
}
if(flight_number.equals("")){
	con.close();
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please enter flight number!" name="user_message"/>
	</jsp:forward>
	<% 
}

if(flight_handler == null){
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please select an action!" name="user_message"/>
	</jsp:forward>
	<% 
}

if(flight_handler.equals("add_flight")){//add flight
	if(occupied_seats.equals("") || departure_airport.equals("") || departure_date.equals("") || departure_time.equals("")
			||  arrival_airport.equals("") || arrival_date.equals("") || arrival_time.equals("") || flight_type.equals("")){
		%>
		<jsp:forward page = "customerRepIndex.jsp">
		<jsp:param value="Please enter all the following information to add a flight!" name="user_message"/>
		</jsp:forward>
		<%
	}
}

int flight_num = Integer.parseInt(flight_number);


	
	//before inserting want to check that the flight does not already exist
			Statement check = con.createStatement();
			String check_table = "SELECT count(*) from flight where flight_number = '" + flight_num +"'"; //query to check
			ResultSet result = check.executeQuery(check_table); // executes query
			result.next(); //moves the cursor of what column its looking at
			if(result.getInt(1) == 1){
				if(flight_handler.equals("add_flight")){
					//flight exists cannot add
					con.close();
					%>
					<jsp:forward page = "customerRepIndex.jsp">
					<jsp:param value="A flight under this number already exists, please try again!" name="user_message"/>
					</jsp:forward>
					<%
				}
				if(flight_handler.equals("edit_flight")){ //edit existing flight
					if(!occupied_seats.equals("")){
						int seats = Integer.parseInt(occupied_seats);
						Statement stmt = con.createStatement();
						PreparedStatement statement = con.prepareStatement("update flight set occupied_seats = ? where flight_number = ?");
						statement.setInt(1, seats);
						statement.setInt(2, flight_num);
						statement.executeUpdate();
						out.print("Occupied seats has been modified to "+seats+".");
					}
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
					if(!flight_type.equals("")){
						if(flight_type.equals("Domestic") || flight_type.equals("domestic")){
							domestic = true;
							international = false;
							Statement stmt = con.createStatement();
							PreparedStatement statement = con.prepareStatement("update flight set is_domestic = ?, is_international = ? where flight_number = ?");
							statement.setBoolean(1, domestic);
							statement.setBoolean(2, international);
							statement.setInt(3, flight_num);
							statement.executeUpdate();
							out.print("Flight type has been modified to "+flight_type+".");
						} else if(flight_type.equals("International") || flight_type.equals("international")) {
							domestic = false;
							international = true;
							Statement stmt = con.createStatement();
							PreparedStatement statement = con.prepareStatement("update flight set is_domestic = ?, is_international = ? where flight_number = ?");
							statement.setBoolean(1, domestic);
							statement.setBoolean(2, international);
							statement.setInt(3, flight_num);
							statement.executeUpdate();
							out.print("Flight type has been modified to "+flight_type+".");
						}
						
					}
					
					
					con.close(); 
				} else { //delete flight --> delete ticket
					//Statement check = con.createStatement();
					query = "delete flight, ticket from flight inner join ticket on ticket.flight_number = flight.flight_number where flight.flight_number = "+flight_number+" ";
					check.executeQuery(query);
					con.close();
					out.print("Flight: "+flight_num+" has successfully been deleted.");
					
				}

			}else{ //flight does not exist, can add 
				
				if(flight_handler.equals("add_flight")){//add flight
					int seats = Integer.parseInt(occupied_seats);
					Statement stmt = con.createStatement();
					String insert = "INSERT INTO flight(flight_number, arrival_date, arrival_time, arrival_airport, departure_date, departure_time, departure_airport, occupied_seats, is_domestic, is_international)"
							+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					//Create a Prepared SQL statement allowing you to introduce the parameters of the query
					PreparedStatement ps = con.prepareStatement(insert);
					//Add parameters of the query. 
					ps.setInt(1, flight_num);
					ps.setString(2, arrival_date);
					ps.setString(3, arrival_time);
					ps.setString(4, arrival_airport);
					ps.setString(5, departure_date);
					ps.setString(6, departure_time);
					ps.setString(7, departure_airport);
					ps.setInt(8, seats);
					ps.setBoolean(9, domestic);
					ps.setBoolean(10, international);
					//Run the query against the DB
					ps.executeUpdate();
					con.close();
					out.print("Flight: "+flight_num+" has successfully been added with arrival date: "+arrival_date+", arrival time: "+arrival_time+", arrival airport: "+arrival_airport+", departure date: "+departure_date+", departure time: "+departure_time+", departure airport: "+departure_airport+", occupied seats: "+seats+", and type: "+flight_type+".");
					
				} else {//flight doesn't exist, can't edit or delete
					con.close();
					%>
					<jsp:forward page = "customerRepIndex.jsp">
					<jsp:param value="Flight does not exist, please try again!" name="user_message"/>
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