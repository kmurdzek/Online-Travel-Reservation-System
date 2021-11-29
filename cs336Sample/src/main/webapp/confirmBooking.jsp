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
		int departing_ticket_id = Integer.parseInt(request.getParameter("departing_ticket"));
		PreparedStatement statement = con.prepareStatement("insert into purchases values(?,?,?,?,?,?,?)");
		statement.setString(1,(String)session.getAttribute("user"));
		statement.setInt(2,departing_ticket_id);
		long millis=System.currentTimeMillis();  
		java.sql.Date date=new java.sql.Date(millis);  
		statement.setDate(3, date);
		statement.setTime(4, Time.valueOf(java.time.LocalTime.now()));
		statement.setDouble(5,0);
		statement.setDouble(6,0);
		statement.setDouble(7,0);
		PreparedStatement statement_2 = con.prepareStatement("update ticket set available = 1 where ticket_id = ?");
		statement_2.setInt(1,departing_ticket_id);
		statement_2.executeUpdate();
		if(session.getAttribute("flight_type").equals("Round_trip")){
			int returning_ticket_id = Integer.parseInt(request.getParameter("returning_ticket"));
			statement.setString(1,(String)session.getAttribute("user"));
			statement.setInt(2,returning_ticket_id);   
			statement.setDate(3, date);
			statement.setTime(4, Time.valueOf(java.time.LocalTime.now()));
			statement.setDouble(5,0);
			statement.setDouble(6,0);
			statement.setDouble(7,0);
			//statement puts connects the user and the ticket now we need to update ticket table
			statement.executeUpdate();
			statement_2.setInt(1,returning_ticket_id);
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