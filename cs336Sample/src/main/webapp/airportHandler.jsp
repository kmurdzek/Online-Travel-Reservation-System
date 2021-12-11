<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Handle Airport Info</title>
</head>
<body>
<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
String original_name = request.getParameter("original_name");
String new_name = request.getParameter("new_name");
String airport_handler = request.getParameter("handle_airport");
String query = "";

if(original_name.equals("")){
	con.close();
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please enter original name for airport!" name="user_message"/>
	</jsp:forward>
	<% 
}

if(airport_handler == null){
	%>
	<jsp:forward page = "customerRepIndex.jsp">
	<jsp:param value="Please select an action!" name="user_message"/>
	</jsp:forward>
	<% 
}

//before doing anything check to see if the airport is already added or not 
Statement check = con.createStatement();
String check_table = "SELECT count(*) from airport where airport_id = '" + original_name +"'"; //query to check
ResultSet result = check.executeQuery(check_table); // executes query
result.next(); //moves the cursor of what column its looking at
if(result.getInt(1) == 1){
	//airport exists --> only EDIT/DELETE
	if(airport_handler.equals("add_airport")){
		con.close();
%>
<jsp:forward page = "customerRepIndex.jsp">
<jsp:param value="This airport already exists in the database, please add a different one!" name="user_message"/>
</jsp:forward>
<% 
	

	} else if (airport_handler.equals("edit_airport")){
		if(new_name.equals("")){
			%>
			<jsp:forward page = "customerRepIndex.jsp">
			<jsp:param value="Please enter new name to edit airport!" name="user_message"/>
			</jsp:forward>
			<%
		}
		Statement stmt = con.createStatement();
		PreparedStatement statement = con.prepareStatement("update airport set airport_id = ? where airport_id = ?");
		statement.setString(1, new_name);
		statement.setString(2, original_name);
		statement.executeUpdate();
		con.close();
		out.print("Successfully edited airport name to: "+new_name+".");
		
	} else { //delete airport 
		
		
		query = "delete airport from airport where airport_id = ? ";
		PreparedStatement statement = con.prepareStatement(query);
		statement.setString(1, original_name);
		statement.executeUpdate();
		con.close();

		out.print("Successfully deleted airport: "+original_name+"."); 
		
	}
	
	//con.close();
} else { //airport doesn't exist --> only ADD
	if(airport_handler.equals("add_airport")){
		Statement stmt = con.createStatement();
		String insert = "INSERT INTO airport(airport_id)"
				+ "VALUES (?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
		//Add parameters of the query. 
		ps.setString(1, original_name);
		//Run the query against the DB
		ps.executeUpdate();
		con.close();
	
		out.print("Successfully added airport: "+original_name+".");
		 
	} else {//return error for edit/delete because airport does not exist
			con.close();
		%>
		<jsp:forward page = "customerRepIndex.jsp">
		<jsp:param value="Cannot edit or delete airport that does not exist in the database!" name="user_message"/>
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