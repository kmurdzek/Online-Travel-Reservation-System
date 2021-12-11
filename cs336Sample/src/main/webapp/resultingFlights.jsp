<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
<%@ page import ="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.time.Duration"%>
<%@ page import ="java.text.SimpleDateFormat,java.util.Date" %>

<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%

//System.out.println(request.getParameter("first_time"));
if (request.getParameter("departure_airport") != null){
	Enumeration<String> enumeration = session.getAttributeNames();
	if (enumeration != null){
		//System.out.println("Attributes being deleted are:");
		while (enumeration.hasMoreElements()) {
			String attributeName = enumeration.nextElement();
			if (attributeName.equals("user") || attributeName.equals("name")){
				continue;
			}
	  		session.removeAttribute(attributeName);
		}
	}
}
else{
	Enumeration<String> enumeration = session.getAttributeNames();
	if (enumeration.nextElement() != null){
		System.out.println("Attributes now are:");
		while (enumeration.hasMoreElements()) {
			String attributeName = enumeration.nextElement();

		}
	}
}

	String fullName = (String)session.getAttribute("name");
	
	%><h1>Check the available flights <% out.print(fullName); %></h1><%
	
	String departure_date_flexibility = request.getParameter("departure_date_flexibility");
	String return_date_flexibility = request.getParameter("return_date_flexibility");
	String departure_date = request.getParameter("departure_date");
	String return_date = request.getParameter("return_date");
	String departure_airport = request.getParameter("departure_airport");
	String arrival_airport = request.getParameter("arrival_airport");
	String flight_type = request.getParameter("flight_type");
    String departure_date_min = null;
	String departure_date_max = null;
	String return_date_min = null;
	String return_date_max = null;
	
	if (departure_date_flexibility != null){
		int dep_date_flexibility_int = Integer.parseInt(departure_date_flexibility);
		int ret_date_flexibility_int = Integer.parseInt(return_date_flexibility);
		SimpleDateFormat format=new SimpleDateFormat("yyyy-MM-dd");  
	    ///////////////////////////////////////////////////////////////////////////
		Date departure_date_as_formatted = format.parse(departure_date);
		
		Calendar c = Calendar.getInstance();
		c.setTime(departure_date_as_formatted);
		c.add(Calendar.DATE, dep_date_flexibility_int);
		Calendar max_dep_date = c;
		Date m_d_d_date = max_dep_date.getTime();
		departure_date_max = format.format(m_d_d_date);   ///////////
		//System.out.println(departure_date);

		c.setTime(departure_date_as_formatted);
		c.add(Calendar.DATE, 0-dep_date_flexibility_int);
		Calendar min_dep_date = c;
		Date m_d_date = min_dep_date.getTime();
		departure_date_min = format.format(m_d_date);  //////////////
		
		//////////////////////////////////////////////////////////////////////
		if(flight_type.equals("Round-Trip")){
		Date return_date_as_formatted = format.parse(return_date);
		c.setTime(return_date_as_formatted);
		c.add(Calendar.DATE, ret_date_flexibility_int);
		Calendar max_ret_date = c;
		Date m_r_r_date = max_ret_date.getTime();
		return_date_max = format.format(m_r_r_date);
		
		c.setTime(return_date_as_formatted);
		c.add(Calendar.DATE, 0-ret_date_flexibility_int);
		Calendar min_ret_date = c;
		Date m_r_date = min_ret_date.getTime();
		return_date_min = format.format(m_r_date);
		}
	}
	
	String sort_by;
	if (request.getParameter("sort_by") != null){
		sort_by = request.getParameter("sort_by");
		//if (session.getAttribute("airlines") != null){
			//ArrayList<>
		//}
		
	}
	else if(session.getAttribute("sort_by") != null){
		sort_by = (String)session.getAttribute("sort_by");
	}
	else{
		sort_by = "none";
	}
	
    ArrayList<String> airlines = new ArrayList<String>(); //= request.getParameterValues("airlines");
	if (request.getParameterValues("airlines") != null){
		System.out.println("Here");
		for (int i = 0; i < request.getParameterValues("airlines").length; i ++){
			String temp = request.getParameterValues("airlines")[i];
			if (temp.contains("_")){
				temp = temp.replace('_', ' ');
			}
			airlines.add(temp);
		}
		session.setAttribute("airlines", airlines);
		//System.out.println("The Airlines in the list are:");
		String listString = String.join(", ", airlines);
		//System.out.println("airlines are: "+listString);
	}
	//else if (request.getParameterValues("airline") == null){
	//	session.setAttribute("airlines", null);
	//}
	else if (request.getParameterValues("airlines") == null && request.getParameter("sort_by") != null){
		
		airlines = ((ArrayList<String>)session.getAttribute("airlines"));
	}
	//else if (session.getAttribute("airlines") != null){
		//airlines = ((ArrayList<String>)session.getAttribute("airlines"));
	//else{
		//airlines = ((ArrayList<String>)session.getAttribute("airlines"));
		//String cool = "";
	//}
	
	int price_max;
	if (request.getParameter("price_max") != null){
		price_max = Integer.parseInt((String)request.getParameter("price_max"));
	}
	else if (session.getAttribute("price_max") != null){
		String p_ma = (String)session.getAttribute("price_max"); 
		price_max = Integer.parseInt(p_ma);
	}

	else{
		price_max = 5000;
	}
		
	String departure_time_min;
	if (request.getParameter("departure_time_min") != null){
		departure_time_min = request.getParameter("departure_time_min");
	}
	else if (session.getAttribute("departure_time_min") != null){
		departure_time_min = (String)session.getAttribute("departure_time_min");
	}
	else{
		departure_time_min = "00:00:00";
	}
	
//	System.out.println(departure_time_min);

	
	String departure_time_max;
	if (request.getParameter("departure_time_max") != null){
		departure_time_max = request.getParameter("departure_time_max");
	}
	else if (session.getAttribute("departure_time_max") != null){
		departure_time_max = (String)session.getAttribute("departure_time_max");
	}
	else{
		departure_time_max = "23:59:59";	
	}
	
	//System.out.println(departure_time_max);

	String landing_time_min;
	if (request.getParameter("landing_time_min") != null){
		landing_time_min = request.getParameter("landing_time_min");
	}
	else if (session.getAttribute("landing_time_min") != null){
		landing_time_min = (String)session.getAttribute("landing_time_min");
	}
	else{
		landing_time_min = "00:00:00";
	}
	
	//System.out.println(landing_time_min);

	
	String landing_time_max;
	if (request.getParameter("landing_time_max") != null){
		landing_time_max = request.getParameter("landing_time_max");
	}
	else if (session.getAttribute("landing_time_max") != null){
		landing_time_max = (String)session.getAttribute("landing_time_max");
	}
	else{
		landing_time_max = "23:59:59";
	}
	
//	System.out.println(landing_time_max);
	
	int number_of_stops;
	if (request.getParameter("number_of_stops") != null){
		number_of_stops = Integer.parseInt((String)request.getParameter("number_of_stops"));
	}
	else if (session.getAttribute("number_of_stops") != null){
		number_of_stops = Integer.parseInt((String)session.getAttribute("number_of_stops"));
	}
	else{
		number_of_stops = 0;
	}
	
	//System.out.println("")
	//System.out.println("price max:"+price_max);
	//System.out.println("departure time min:"+departure_time_min);
	//System.out.println("departure time max:"+departure_time_max);
	//System.out.println("landing time min:"+landing_time_min);
	//System.out.println("landing time max:"+landing_time_max);
	//System.out.println("number of stops:"+number_of_stops);
	
	
	if (departure_date == null){
		departure_date = (String)session.getAttribute("departure_date");
	}
	if (return_date == null){
		return_date = (String)session.getAttribute("return_date");	
	}
	if (departure_airport == null){
		departure_airport = (String)session.getAttribute("departure_airport");	
	}
	if (arrival_airport == null){
		arrival_airport = (String)session.getAttribute("arrival_airport");
	}
	if (flight_type == null){
		flight_type = (String)session.getAttribute("flight_type");
	}
	if (return_date_min == null){
		return_date_min = (String)session.getAttribute("return_date_min");
	}
	if (return_date_max == null){
		return_date_max = (String)session.getAttribute("return_date_max");
	}
	if (departure_date_min == null){
		departure_date_min = (String)session.getAttribute("departure_date_min");
	}
	if (departure_date_max == null){
		departure_date_max = (String)session.getAttribute("departure_date_max");
	}
	
	try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();	

		//if the flight is round trip just run the query get flights on the 
		//return date
		Statement check = con.createStatement();
		PreparedStatement update_seats = con.prepareStatement("update flight f set f.occupied_seats = (select count(*) from ticket t where t.available = 0 and t.flight_number = f.flight_number and f.departure_date = ? and f.departure_airport = ? and f.arrival_airport = ? )");

		update_seats.setDate(1, java.sql.Date.valueOf(departure_date));
		update_seats.setString(2, departure_airport);
		update_seats.setString(3, arrival_airport);
		update_seats.executeUpdate();
		
		//ResultSet result = executeQueryHelper(sort_by, departure_date_min,departure_date,departure_date_max, departure_airport, arrival_airport, con);
		//ResultSet result = check.executeQuery(departure_flight); // executes query
		
		ResultSet result_2 = null;
		
		out.print("<table>");
		out.print("<tr>");
		
		out.print("<th>");
		out.print("Sort By ");
		
		out.print("<form name =sort  method =get action =resultingFlights.jsp>");
		out.print("<select name = sort_by id =sorting_options >");	
		session.setAttribute("sort_by", null);

		if (sort_by.equals("none")){
			out.print("<option value = \"none\" selected>None</option>");
		}
		else{
			out.print("<option value = \"none\" >None</option>");
		}
		
		if (sort_by.equals("price_low_to_high")){
			out.print("<option value = \"price_low_to_high\" selected>Price(Low to high)</option>");	
		}
		else{
			out.print("<option value = \"price_low_to_high\">Price(Low to high)</option>");
		}
		
		if (sort_by.equals("price_high_to_low")){
			out.print("<option value = \"price_high_to_low\" selected>Price(High to Low)</option>");
		}
		else{
			out.print("<option value = \"price_high_to_low\">Price(High to Low)</option>");	
		}
		
		if (sort_by.equals("take_off_time_earliest_first")){
			out.print("<option value = \"take_off_time_earliest_first\" selected>Take off time (earliest first)</option>");
		}
		else{
			out.print("<option value = \"take_off_time_earliest_first\">Take off time (earliest first)</option>");	
		}
		
		if (sort_by.equals("take_off_time_latest_first")){
			out.print("<option value = \"take_off_time_latest_first\" selected>Take off time (latest first)</option>");
		}
		else{
			out.print("<option value = \"take_off_time_latest_first\">Take off time (latest first)</option>");	
		}
		
		if(sort_by.equals("landing_time_earliest_first")){
			out.print("<option value = \"landing_time_earliest_first\" selected>Landing Time (earliest first)</option>");
		}
		else{
			out.print("<option value = \"landing_time_earliest_first\">Landing Time (earliest first)</option>");	
		}
		
		if (sort_by.equals("landing_time_latest_first")){
			out.print("<option value = \"landing_time_latest_first\" selected>Landing Time (latest first)</option>");	
		}
		else{
			out.print("<option value = \"landing_time_latest_first\">Landing Time (latest first)</option>");
		}
		
		if (sort_by.equals("duration_of_flight_shortest_first")){
			out.print("<option value = \"duration_of_flight_shortest_first\" selected>Duration of flight (shortest first)</option>");		
		}
		else{
			out.print("<option value = \"duration_of_flight_shortest_first\">Duration of flight (shortest first)</option>");	
		}
		
		if (sort_by.equals("duration_of_flight_longest_first")){
			out.print("<option value = \"duration_of_flight_longest_first\" selected>Duration of flight (longest first)</option>");	
		}
		else{
			out.print("<option value = \"duration_of_flight_longest_first\">Duration of flight (longest first)</option>");				
		}
		out.print("</select>");
		out.print("<input type=submit name=sort_submit value=Sort >");
		session.setAttribute("sort_by", sort_by);
		out.print("</form>");
		out.print("</th>");
		
		//Statement checkt = con.createStatement();
		String get_all_airlines_query = "Select * from airline";
		ResultSet all_airlines = check.executeQuery(get_all_airlines_query);
		
			out.print("<td>");
			out.println("Airlines");
			out.print("<form name =filters  method =get action =resultingFlights.jsp value = \"none\"");
				out.print("<ul style=list-style-type:none>");
				while (all_airlines.next()){					
					String airlineName = all_airlines.getString("airline_name");
					if (airlineName.contains(" ")){
						airlineName = airlineName.replace(' ','_');
					}
					String airlineNameOutput = airlineName.replace('_', ' ');
					//System.out.println(airlineName);
					String state;
					if (airlines != null){
					if(airlines.contains(airlineNameOutput)){
						state = String.format("<li><input checked name = airlines type=checkbox value = %s>%s</option></li>", airlineName, airlineNameOutput);
					}
					else{	
						state = String.format("<li><input name = airlines type=checkbox value = %s>%s</option></li>", airlineName, airlineNameOutput);
						//System.out.println(airlineName);

					}
					}
					else{
						state = String.format("<li><input name = airlines type=checkbox value = %s>%s</option></li>", airlineName, airlineNameOutput);

					}
					out.print(state);
				}
				out.print("</td>");

				out.print("<td>");
				out.print("Price<br>");
				String mPrice;
				if (price_max == 5000){
					mPrice = "<input name = price_max type=\"range\" min=\"0\" max=\"5000\" value=\"5000\"><br>";
				}
				else{
					mPrice = String.format("<input name = price_max type=\"range\" min=\"0\" max=\"5000\" value=\"%d\"><br>", price_max);
				}
				out.print(mPrice);
				out.print("<small>Selecting $5000 will show flights of $5000+</small>");

				out.print("</td>");
				
				out.print("<td>");
				out.print("Take Off Times<br><br>");
				out.println("Earliest: ");
				String dep_er;
				if (!(departure_time_min.equals("00:00:00"))){
					dep_er = String.format("<input type=text name=\"departure_time_min\" min=00:00:00 max=23:59:59 placeholder=00:00:00 value =%s size = 6><br>",departure_time_min);
				}
				else{
					dep_er = "<input type=text name=\"departure_time_min\" min=00:00:00 max=23:59:59 placeholder=00:00:00 value=00:00:00 size = 6><br>";
				}
				out.print(dep_er);
				out.println("Latest: ");
				
				String dep_la;
				if (!(departure_time_max.equals("23:59:59"))){
					dep_la = String.format("<input type=text name=\"departure_time_max\" min=00:00:00 max=23:59:59 placeholder=00:00:00 value = %s size = 6><br>",departure_time_max);
				}
				else{
					dep_la = "<input type=text name=\"departure_time_max\" min=00:00:00 max=23:59:59 placeholder=23:59:59 value=23:59:59 size = 6><br>";
				}
				out.print(dep_la);
				out.println("<small>Range: 00:00:00 to 23:59:59</small>");
				out.print("</td>");
				
				
				
				out.print("<td>");
				out.print("Landing Times<br><br>");
				out.println("Earliest: ");
				String la_er;
				if (!(landing_time_min.equals("00:00:00"))){
					la_er = String.format("<input type=text name=\"landing_time_min\" min=00:00:00 max=24:59:59 placeholder=00:00:00 value =%s size = 6 ><br>", landing_time_min);
				}
				else{
					la_er = "<input type=text name=\"landing_time_min\" min=00:00:00 max=24:59:59 placeholder=00:00:00 value =00:00:00 size = 6 ><br>";
				}

				out.print(la_er);
				out.println("Latest: ");
				String la_la;
				if (!(landing_time_max.equals("23:59:59"))){
					la_la = String.format("<input type=text name=\"landing_time_max\" min=00:00:00 max=23:59:59 placeholder=00:00:00 value =%s size = 6 ><br>", landing_time_max);
				}
				else{
					la_la = "<input type=text name=\"landing_time_max\" min=00:00:00 max=23:59:59 placeholder=23:59:59 value=23:59:59 size = 6 ><br>";
				}
				out.print(la_la);
				out.println("<small>Range: 00:00:00 to 23:59:59</small>");
				out.print("</td>");
				
				out.print("<td>");
				out.print("Number of Stops<br><br>");
				String numStops;
				if (number_of_stops == 0){
					numStops = "<input type=number step = 1 name=\"number_of_stops\" min=0 size = 1 value = 0><br>";
				}
				else{
					numStops = String.format("<input type=number step = 1 name=\"number_of_stops\" min=0 size = 1 value =%d><br>",number_of_stops); 
				}
				out.print(numStops);
				out.print("</td>");
					//out.print("select name = filtered_airlines[]  multiple = multiple");			
					// name = filter_by[airline]>");	
				out.print("</ul>");
				
				out.print("<td>");
				out.print("<input type=submit name=filter_submit value=Filter >"); 
				
		String soSoStupid = Integer.toString(number_of_stops);
		session.setAttribute("number_of_stops",soSoStupid);
		session.setAttribute("landing_time_max", landing_time_max);
		session.setAttribute("landing_time_min",landing_time_min);
		session.setAttribute("departure_time_min",departure_time_min);
		session.setAttribute("departure_time_max",departure_time_max);
		
		String soStupid = Integer.toString(price_max); 
		session.setAttribute("price_max",soStupid);
		//session.setAttribute("airlines",airlines);
		
			//System.out.println("price max:"+price_max);
	//System.out.println("departure time min:"+departure_time_min);
	//System.out.println("departure time max:"+departure_time_max);
	//System.out.println();
	///System.out.println();
		
		out.print("</tr>");
		out.print("</table>");
		out.print("</form>");
		out.print("<form method= get action = checkout.jsp>");
		
		ResultSet result = executeQueryHelper(sort_by, departure_date_min,departure_date,departure_date_max, departure_airport, arrival_airport, con, airlines, price_max, departure_time_min, departure_time_max, landing_time_min, landing_time_max, number_of_stops);

		try{
		if(flight_type.equals("Round-Trip")){
			session.setAttribute("flight_type", flight_type);
			session.setAttribute("return_date", return_date);	
			session.setAttribute("departure_date", departure_date);	
			session.setAttribute("departure_airport", departure_airport);
			session.setAttribute("arrival_airport", arrival_airport);
			session.setAttribute("return_date_max", return_date_max);
			session.setAttribute("return_date_min", return_date_min);
			session.setAttribute("departure_date_max", departure_date_max);
			session.setAttribute("departure_date_min", departure_date_min);
			//session.setAttribute("airline_name", f) 
			
			update_seats.setDate(1, java.sql.Date.valueOf(return_date));
			update_seats.setString(2, arrival_airport);
			update_seats.setString(3, departure_airport);
			update_seats.executeUpdate();
	
			%><h2>Departing Flights</h2><%
			
			populate_table(result, out,0,session, sort_by);
			result_2 = executeQueryHelper(sort_by, return_date_min, return_date, return_date_max,arrival_airport,departure_airport, con, airlines, price_max, departure_time_min, departure_time_max, landing_time_min, landing_time_max, number_of_stops);
			//result_2 = check.executeQuery(arrival_flight);
			%><h2>Returning Flights</h2><%
			populate_table(result_2, out,1,session, sort_by);	

		}else{
			%><h2>Departing Flights</h2><%
			session.setAttribute("flight_type", flight_type);
			session.setAttribute("return_date", return_date);	
			session.setAttribute("departure_date", departure_date);	
			session.setAttribute("departure_airport", departure_airport);
			session.setAttribute("arrival_airport", arrival_airport);
			session.setAttribute("return_date_max", return_date_max);
			session.setAttribute("return_date_min", return_date_min);
			session.setAttribute("departure_date_max", departure_date_max);
			session.setAttribute("departure_date_min", departure_date_min);
	
			populate_table(result, out,0,session, sort_by);

			}
		}
		catch (Exception e){
			System.out.println(e);
		}
		
		out.print("<input type='submit' name='command' value='Book Tickets'/>");
		out.print("</form>");
		//populates the departing table
		
		con.close();
		db.closeConnection(con);
	}catch (Exception e) {
	out.print(e);
}
	
//	out.print(message);
%>

<%! 
	String queryBuilder(String sort_by, String departure_date_min, String departure_date, String departure_date_max, String departure_airport, String arrival_airport, ArrayList<String> airlines, int price_max, String departure_time_min, String departure_time_max, String landing_time_min, String landing_time_max,int number_of_stops){
		String pricing = "";
		if (price_max == 5000){
			pricing = Integer.toString(Integer.MAX_VALUE);
		}
		else{
			pricing = Integer.toString(price_max);
		}
		
		boolean boxesWereChecked = false;
		boolean firstTime = true;
		boolean putAnAnd = false;

		String addTheseAirlineNames = "";
		
		String def = "a.airline_name= ";
		//String feedThis = def.repeat(airlines.size());
		//System.out.println(feedThis);
		if (airlines != null){
			

		if (airlines.size() != 0){
			boxesWereChecked = true;
			putAnAnd = true;
			//addTheseAirlineNames += "and ";
			for (int i = 0; i < airlines.size(); i ++){
				String a_name = airlines.get(i);
				String addThis = "";
				if (i == airlines.size() -1){
					//no comma
					addThis = String.format("'%s' )", a_name);
				}
				else{
					addThis = String.format("'%s', ", a_name);
				}
				
				
				//if (firstTime){
					//addThis = String.format("a.airline_name =  '%s' ",a_name);
					//firstTime = false;
				
				//}
				//else{
					//addThis = String.format(" or a.airline_name =  '%s' ",a_name);
					//addThis = String.format(" or a.airline_name =  '%s' ",a_name);

				//}
				//System.out.println(addThis);
				addTheseAirlineNames+= addThis;
				
			}
			//System.out.println(addTheseAirlineNames);
		}
		}
		
		
		
		String okok = "";
		String first = "";
		String second = "";
		String mid = "";
		if (putAnAnd){
			okok = "and ";
			first = "(";
			second = ")";
			mid = "a.airline_name IN ( ";
		}
		
		if (!boxesWereChecked){
			addTheseAirlineNames = "";	
		}
		
		
		String departure_flight = "";
		
		if (sort_by.equals("none")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"' and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY RAND()", okok, mid , addTheseAirlineNames);
			
		}
		else if (sort_by.equals("price_low_to_high")){
			//SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration 
			//from flight f join ticket t on f.flight_number = t.flight_number 
							//join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number 
							//join airline a on a.airline_id = o.airline_id 
			//where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' 
				//and f.departure_airport = '" + departure_airport+"' 
				//and f.arrival_airport = '" + arrival_airport + "' 
				//and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' '" + addTheseAirlineNames +"' GROUP BY f.flight_number ORDER BY RAND()					
			departure_flight = String.format("SELECT distinct f.flight_number, MIN(price) as price, o.*, f.*,a.*, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY price", okok, mid ,addTheseAirlineNames) ;
			//System.out.println(departure_flight);
		}
		else if (sort_by.equals("price_high_to_low")){
			departure_flight = String.format("SELECT distinct f.flight_number, MIN(price) as price, o.*, f.*,a.*, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY price DESC", okok, mid ,addTheseAirlineNames) ;
		}
		else if (sort_by.equals("take_off_time_earliest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY f.departure_time ", okok, mid ,addTheseAirlineNames);
		}
		else if (sort_by.equals("take_off_time_latest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY f.departure_time DESC", okok, mid,addTheseAirlineNames);
		}
		else if (sort_by.equals("landing_time_earliest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY f.arrival_time", okok,mid ,addTheseAirlineNames);
		}
		else if (sort_by.equals("landing_time_latest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY f.arrival_time DESC", okok,mid ,addTheseAirlineNames);
		}
		else if (sort_by.equals("duration_of_flight_shortest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY flight_duration", okok, mid,addTheseAirlineNames);
		}
		else if (sort_by.equals("duration_of_flight_longest_first")){
			departure_flight = String.format("SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration from flight f join ticket t on f.flight_number = t.flight_number join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number join airline a on a.airline_id = o.airline_id where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' and f.departure_airport = '" + departure_airport+"'"+" and f.arrival_airport = '" + arrival_airport + "' and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"' and t.price <= '" + pricing +"' and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "' %s %s %s GROUP BY f.flight_number ORDER BY flight_duration DESC", okok, mid,addTheseAirlineNames);

		}
		System.out.println(departure_flight);
		
	//SELECT *, TIMEDIFF(Concat(f.arrival_date, ' ',f.arrival_time), Concat(f.departure_date, ' ',f.departure_time)) as flight_duration 
	//from flight f join ticket t on f.flight_number = t.flight_number 
					//join flight_operated_by o on f.flight_number = o.flight_number and t.flight_number = o.flight_number 
					//join airline a on a.airline_id = o.airline_id 
	//where f.departure_date >= '" + departure_date_min+" ' and f.departure_date <= '" + departure_date_max+"' 
		//and f.departure_airport = '" + departure_airport+"' 
		//and f.arrival_airport = '" + arrival_airport + "' 
		//and f.departure_time >= '" + departure_time_min+" ' and f.departure_time <= '" + departure_time_max +"'
		//and t.price <= '" + pricing +"'
		//and f.arrival_time >= '" + landing_time_min + "' and f.arrival_time <= '" + landing_time_max + "'
		//'" + addTheseAirlineNames +"'
		//GROUP BY f.flight_number 
		//ORDER BY RAND()		

		return departure_flight;
	}
%>

<%! void populate_table(ResultSet result,JspWriter out, int type, HttpSession session, String sort_by){

	try{
	out.print("<table>");
	out.print("<tr>");
	//make a column
	out.print("<th>");
	out.print("Select");
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
	
	out.print("<th>");
	out.print("Flight Duration");
	out.print("</th>");
	
	out.print("<th>");
	out.print("Seats Available");
	out.print("</th>");
	out.print("<th>");
	out.print("Price");
	out.print("</th>");

	
	out.print("</tr>");
	out.print("</tr>");
	
	while(result.next()){
		out.print("<tr>");

		String flightNum = result.getString("flight_number");
		
		System.out.println(flightNum);
		out.print("<td>");
		out.print(" <input type= radio name=flight"+type+" value="+flightNum+"> ");
		session.setAttribute("flight_number"+flightNum, flightNum);
		
//		System.out.println("flight_number"+flightNum);
		out.print("</td>");
		
		String airline_abv = result.getString("airline_id");
		session.setAttribute("airline_id"+flightNum, airline_abv);

		out.print("<td name = arrival"+airline_abv+" value = "+airline_abv+"'>");
		out.print(airline_abv);
		out.print("</td>");
		
		out.print("<td>");
		out.print(flightNum);
		out.print("</td>");
		
		String depart = result.getString("departure_airport");
		System.out.println(depart);
		out.print("<td name = departure"+flightNum+" value = "+depart+"'>");
		session.setAttribute("departure"+flightNum, depart);
		out.print(depart);
		out.print("</td>");
		
		String arrive = result.getString("arrival_airport");
		out.print("<td name = arrival"+flightNum+" value = "+arrive+"'>");
		session.setAttribute("arrival"+flightNum, arrive);
		out.print(arrive);
		out.print("</td>");
		
		String departure_date = result.getString("departure_date");
		out.print("<td name = depart_date"+flightNum+" value = "+departure_date+">");
		session.setAttribute("depart_date"+flightNum, departure_date);
		out.print(departure_date);
		out.print("</td>");
		
		String departure_time = result.getString("departure_time");
		out.print("<td name = depart_time"+flightNum+" value = "+departure_time+">");
		session.setAttribute("depart_time"+flightNum, departure_time);
		out.print(departure_time);
		out.print("</td>");
		
		String arrival_date = result.getString("arrival_date");
		out.print("<td name = arrival_date"+flightNum+" value = "+arrival_date+">");
		session.setAttribute("arrival_date"+flightNum, arrival_date);
		out.print(arrival_date);
		out.print("</td>");
		
		String arrival_time = result.getString("arrival_time");
		out.print("<td name = arrival_time"+flightNum+" value = "+arrival_time+">");
		session.setAttribute("arrival_time"+flightNum, arrival_time);
		out.print(arrival_time);
		out.print("</td>");
		
		String flight_duration = result.getString("flight_duration");
		out.print("<td name = flight_duration"+flightNum+" value = "+flight_duration+">");
		session.setAttribute("flight_duration"+flightNum, flight_duration);
		out.print(flight_duration + " hours");
		out.print("</td>");
		
		
		String occupied_seats = result.getString("occupied_seats");
		out.print("<td name = occupied_seats"+flightNum+" value = "+occupied_seats+">");
		session.setAttribute("occupied_seats"+flightNum, occupied_seats);
		out.print(occupied_seats);
		out.print("</td>");
		
		String price = result.getString("price");
		out.print("<td name = price"+flightNum+" value = "+price+">");
		session.setAttribute("price"+flightNum, price);
		out.print("$"+price);
		out.print("</td>");
		
		out.print("</tr>");
	}
	out.print("</table>");
	}catch(Exception e ) {
		System.out.println(e);
		
	}
}
%>
<%! ResultSet executeQueryHelper(String sort_by, String departure_date_min, String departure_date, String departure_date_max, String departure_airport, String arrival_airport, Connection con, ArrayList<String> airlines, int price_max, String departure_time_min, String departure_time_max, String landing_time_min ,String landing_time_max,int number_of_stops){
	try{
	Statement check = con.createStatement();
	String departure_flight = queryBuilder(sort_by, departure_date_min, departure_date, departure_date_max, departure_airport, arrival_airport, airlines, price_max, departure_time_min, departure_time_max, landing_time_min, landing_time_max, number_of_stops);
	
	ResultSet returning = check.executeQuery(departure_flight);
	return returning;
	}catch(SQLException e){
		System.out.println(e);
	}
	return null;
	}
%>

</body>
</html>
