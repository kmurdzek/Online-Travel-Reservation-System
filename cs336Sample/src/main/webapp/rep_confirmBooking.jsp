<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, java.time.format.DateTimeFormatter, java.time.LocalDateTime"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>Your booking has been confirmed</h1>
<% try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	
		Statement check = con.createStatement();
		String departing_flight = (String)session.getAttribute("departing_flight_number");
		double basePriceDeparting = Double.parseDouble((String)session.getAttribute("price"+departing_flight));
		double totalCostDeparting = basePriceDeparting;
		double bookingFeeDeparting = 0;
		int departing_ticket_id = Integer.parseInt(request.getParameter("departing_ticket"));
		int departing_class = Integer.parseInt(request.getParameter("departing_class"));
		switch(departing_class){
		case 2:
			totalCostDeparting+=10;
			bookingFeeDeparting+=10;
			break;
		case 3:
			totalCostDeparting+=20;
			bookingFeeDeparting+=20;
			break;
		}
		PreparedStatement statement = con.prepareStatement("insert into purchases values(?,?,?,?,?,?,?)");
		statement.setString(1,(String)session.getAttribute("user"));
		statement.setInt(2,departing_ticket_id);
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);  
		statement.setDate(3, date);
		statement.setTime(4, Time.valueOf(java.time.LocalTime.now()));
		statement.setDouble(5,totalCostDeparting);
		statement.setDouble(6,basePriceDeparting);
		statement.setDouble(7,bookingFeeDeparting);
		statement.executeUpdate();
		PreparedStatement statement_2 = con.prepareStatement("update ticket set available = 1, class = ? where ticket_id = ?");
		statement_2.setInt(1, departing_class);
		statement_2.setInt(2,departing_ticket_id);
		
		
		
		int val  = statement_2.executeUpdate();
		System.out.println(val);
		if(session.getAttribute("flight_type").equals("Round-Trip")){
			String returning_flight = (String)session.getAttribute("returning_flight_number");
			double basePriceReturning = Double.parseDouble((String)session.getAttribute("price"+returning_flight));
			double totalCostReturning = basePriceReturning;
			int returning_ticket_id = Integer.parseInt(request.getParameter("returning_ticket"));
			int returning_class = Integer.parseInt(request.getParameter("returning_class"));
			int bookingFeeReturning = 0;
			switch(returning_class){
			case 2:
				totalCostReturning+=10;
				bookingFeeReturning+=10;
				break;
			case 3:
				totalCostReturning+=20;
				bookingFeeReturning+=20;
				break;
			}
			statement.setString(1,(String)session.getAttribute("username"));
			statement.setInt(2,returning_ticket_id);   
			statement.setDate(3, date);
			statement.setTime(4, Time.valueOf(java.time.LocalTime.now()));
			statement.setDouble(5,totalCostReturning);
			statement.setDouble(6,basePriceReturning);
			statement.setDouble(7,bookingFeeReturning);
			//statement puts connects the user and the ticket now we need to update ticket table
			statement.executeUpdate();
			statement_2.setInt(1,returning_class);
			statement_2.setInt(2,returning_ticket_id);
			statement_2.executeUpdate();
			
		}
		con.close();
		db.closeConnection(con);
} catch (Exception e) {
		out.print(e);
	}
%>
		<form method="post" action="index.jsp">
		  <input type="submit" name="user_message" value="Return to Homepage"/>
		  <br>
		</form>
</body>
</html>