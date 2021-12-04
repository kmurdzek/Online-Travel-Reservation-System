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
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();	
Statement check = con.createStatement();

String start_date = (request.getParameter("sales_month"))+"-01";
SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd"); 
Date start_of_month = format.parse(start_date);
Calendar c = Calendar.getInstance();
c.setTime(start_of_month);
c.add(Calendar.MONTH, 1);
Calendar end_date_calen = c;
Date end_date = end_date_calen.getTime();
String end_date1  = format.format(end_date);
String query = "select sum(total_cost) as total_cost from purchases where purchase_date >= '"+start_date+"' and purchase_date <= '"+end_date1+"'";
System.out.println(query);
ResultSet result = check.executeQuery(query);

while(result.next()){
	out.print("<h1>Monthly revenue for the month starting "+start_date+" is $"+result.getString("total_cost") +"");
}

%>
		<form method="post" action="adminIndex.jsp">
		  <input type="submit" name="user_message" value="Return to Admin Page"/>
		  <br>
		</form>
</body>
</html>