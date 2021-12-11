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
//need to add edit or delete a customer or customer rep
//make 3 tables, one to add with all info, one to update with all info
//another tiny line that could delete using username

%>
		<%

		String message = request.getParameter("user_message");
		if(message == null){
			message = "Welcome Admin";
		}
		out.print(message); %>
		
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
	<fieldset>
	<legend>Create a User</legend>
	<form method="post" action="adminCreateUser.jsp">
		  <table>
		  <tr>  
		  
		  </tr>
				<tr>    
					<td>Username</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="password"></td>
				</tr>
				<tr>
					<td>First Name</td><td><input type="text" name="first_name"></td>
				</tr>		
				<tr>
					<td>Last Name</td><td><input type="text" name="last_name"></td>
				</tr>	
				<tr>
					<td>Select User Type</td>
					<td><input type=radio name="type_of_user" value= "admin">Admin</td>
					<td><input type=radio name="type_of_user" value= "customer_rep">Customer Representitive</td>
					<td><input type=radio name="type_of_user" value= "customer">Customer</td>
				</tr>		
					 <tr><td><input type="submit" name="command" value="Create User"/></td></tr>	  
			</table>
			
		  <br>
		</form>
		</fieldset>
		 <br>
		  <br>
		   <br>
			
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
	<fieldset>
	
	<legend>Update a User</legend>
	<form method="post" action="adminUpdateUser.jsp">
		  <table>
				<tr>    
					<td>Current Username</td><td><input type="text" name="prev_username"></td><td>New Username</td><td><input type="text" name="new_username"></td>
				</tr>
				<tr>
				<td></td><td></td><td>OR</td>
				</tr>
				<tr>
					<td></td><td></td><td>New Password</td><td><input type="text" name="new_password"></td>
				</tr>	
				<tr>
				<td><input type="submit" name="command" value="Update"/></td>
				</tr>
			</table>
			
			
		  <br>
		  <br>

		</form>
	</fieldset>
				  <br>
		  <br>
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
	<fieldset>
	<legend>Delete a User</legend>
	<form method="post" action="adminDeleteUser.jsp">
		  <table>
		  <tr>  
		  </tr>
				<tr>    
					<td>Username</td><td><input type="text" name="delete_username"></td>
				</tr>
				<tr>
				<td>
				<input type="submit" name="command" value="Delete"/>
				</td>
				</tr>
					 		  
			</table>
			
		  <br>
		</form>
	</fieldset>
		<br>
		<br>
		<fieldset>
		<legend>Get Monthly Sales</legend>
		
		<form method="post" action="generateMonthSales.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->
		  <table>

				<tr>    
				<td>Enter Sales Year and Month</td>
				<td>
					<input type = "date"  value="" placeholder="yyyy-mm" id = "departure_date" name = "sales_month" size = "8"><br>
					<input type="submit" name="sales_button" value = "Get Sales"></td>
				</tr>
					 		  
			</table>
		  <br>
		</form>
		</fieldset>
		<br>
		<br>
		<fieldset>
		<legend>Get Reservation Lists
		</legend>
				<form method="post" action="generateReservationList.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		<br>
		  <table>
		  <tr>  

		  <td>By Flight Number</td>
		  <th></th>
		  <td>By Customer Username</td>
		  </tr>
				<tr>    
				<td>
					<input type = "text"  value="" name = "flight_number" size = "8"><br><br>
					<input type="submit" name="sales_button" value = "Get by Flight Number"></td>
				
				<td></td>
				<td>
					<input type = "text"  value="" name = "username" size = "8"><br><br>
					<input type="submit" name="sales_button" value = "Get by Username"></td>
				</tr>
					 		  
			</table>
		  <br>
		</form>
		</fieldset>
		<br>
		<br>
		<fieldset>
		<legend>Get Revenue Summary
		</legend>
				<form method="post" action="generateRevenueSummary.jsp">
		    <!-- note the show.jsp will be invoked when the choice is made -->
			<!-- The next lines give HTML for radio buttons being displayed -->

		<br>
		  <table>
		  <tr>  

		  <td>By Flight Number</td>
		  <th></th>
		  <td>By Customer Username</td>
		  <th></th>
		  <td>By Airline ID</td>
		  </tr>
				<tr>    
				<td>
					<input type = "text"  value="" name = "flight_number" size = "8"><br><br>
					<input type="submit" name="flight_num" value = "Get by Flight Number"></td>
				
				<td></td>
				<td>
					<input type = "text"  value="" name = "username" size = "8"><br><br>
					<input type="submit" name="sales_button" value = "Get by Username"></td>
					<td></td>
				<td>
					<input type = "text"  value="" name = "airline" size = "8"><br><br>
					<input type="submit" name="sales_button" value = "Get by Airline"></td>
				</tr>
					 		  
			</table>
		  <br>
		</form>
		</fieldset>
		<br>
		<br>
				<fieldset>
		<legend>Customer That Generated Most Revenue
		</legend>
		<br>
		  <table>
		  <tr>  

		  <th>Top spender</th>
		  </tr>
				<tr>    
				</tr>
					 		  
			</table>
							<%
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				Statement check = con.createStatement();
				String query = "select p.username, Sum(p.total_cost) as rev from purchases p join ticket t on t.ticket_id = p.ticket_id group by p.username order by rev desc LIMIT 1";
				ResultSet result = check.executeQuery(query);
				String username = "";
				String rev = "";
				while(result.next()){
					username= result.getString("username");
					rev = result.getString("rev");
				}
				out.println("<p>User: "+username+", with a total spending of $"+rev+" </p>");
				%>
		  <br>
		</fieldset>
		<br>
		<br>
		<fieldset>
		<legend>Flights ordered in most tickets sold
		</legend>
		<br>

				<%
				long millis=System.currentTimeMillis(); 
				String query2 = "select f.flight_number, sum(t.available) as tickets_sold, f.*, b.* from flight f join flight_operated_by b on f.flight_number = b.flight_number join ticket t on  f.flight_number= t.flight_number where f.departure_date >= '"+new java.sql.Date(millis) +"' group by f.flight_number order by tickets_sold desc";
				System.out.println(query2);
				ResultSet result2 = check.executeQuery(query2);
				populate_table(result2, out, 0, session);
				%>
		  <br>
		</fieldset>
	<br>
	<fieldset>
	<form action="logout.jsp" method="post">
	<button>Logout</button>
	</form>
	</fieldset>

</body>
</html>
<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session){

	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("Tickets Sold");
	out.print("</th>");
	out.print("<th>");
	out.print("Airline");
	out.print("</th>");
	out.print("<th>");
	out.print("Flight Number");
	out.print("</th>");
	out.print("<th>");
	//print out column header
	out.print("Departing From");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Arriving At");
	out.print("</th>");
	//make a column
	out.print("<th>");
	out.print("Departing Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Departing Time");
	out.print("</th>");
	out.print("<th>");
	out.print("Arriving Date");
	out.print("</th>");
	out.print("<th>");
	out.print("Arriving Time");
	out.print("</th>");
	
	out.print("</tr>");
	out.print("</tr>");
	
	while(result.next()){
		out.print("<tr>");


		
		String flightNum = result.getString("flight_number");
		
		String tickets_sold = result.getString("tickets_sold");
		out.print("<td name = sold"+flightNum+" value = "+tickets_sold+"'>");
		out.print(tickets_sold);
		out.print("</td>");
		
		String airline_name = result.getString("airline_id");
		out.print("<td name = arrival"+flightNum+" value = "+airline_name+"'>");
		out.print(airline_name);
		out.print("</td>");
		
		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		
		String depart = result.getString("departure_airport");
		out.print("<td><label name = 'departure"+flightNum+"' value = "+depart+"/>");
		out.print(depart);
		out.print("</td>");
		
		String arrive = result.getString("arrival_airport");
		out.print("<td name = arrival"+flightNum+" value = "+arrive+"'>");
		out.print(arrive);
		out.print("</td>");
		
		String departure_date = result.getString("departure_date");
		out.print("<td name = depart_date"+flightNum+" value = "+departure_date+">");
		out.print(departure_date);
		out.print("</td>");
		
		String departure_time = result.getString("departure_time");
		out.print("<td name = depart_time"+flightNum+" value = "+departure_time+">");
		out.print(departure_time);
		out.print("</td>");
		
		String arrival_date = result.getString("arrival_date");
		out.print("<td name = arrival_date"+flightNum+" value = "+arrival_date+">");
		out.print(arrival_date);
		out.print("</td>");
		
		String arrival_time = result.getString("arrival_time");
		out.print("<td name = arrival_time"+flightNum+" value = "+arrival_time+">");
		out.print(arrival_time);
		out.print("</td>");
		
		
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>