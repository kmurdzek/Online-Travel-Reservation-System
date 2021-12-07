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
      </style>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement check = con.createStatement();
String flight_number = request.getParameter("flight_number");
String query = "";


out.print("<h1>Waiting List for flight number "+flight_number+"</h1>");
query = "select username from waitlisted where flight_number= '"+flight_number;

ResultSet result = check.executeQuery(query);
populate_table(result, out, 0, session);


%>
		<form method="post" action="customerRepIndex.jsp">
		  <input type="submit" name="user_message" value="Return to Customer Rep Page"/>
		  <br>
		</form>
</body>
</html>
<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session){

	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("User");
	out.print("</th>");
	out.print("<th>");
	out.print("Airline");
	out.print("</th>");
	out.print("<th>");
	out.print("Flight Number");
	out.print("</th>");
	out.print("<th>");
	out.print("</tr>");
	out.print("</tr>");
	
	while(result.next()){
		out.print("<tr>");


		
		String flightNum = result.getString("flight_number");
		String user = result.getString("username");
		out.print("<td name = user"+flightNum+" value = "+user+"'>");
		out.print(user);
		out.print("</td>");
		
		
		String airline_name = result.getString("airline_id");
		out.print("<td name = arrival"+flightNum+" value = "+airline_name+"'>");
		out.print(airline_name);
		out.print("</td>");
		
		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>