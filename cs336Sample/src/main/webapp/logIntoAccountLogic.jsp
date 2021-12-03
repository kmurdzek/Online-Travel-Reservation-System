<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% try {
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		if(username == "" || password == ""){
			System.out.println("Missing username, or password");%>

			<jsp:forward page = "landingPage.jsp">
			<jsp:param value="Invalid login attempt" name="user_message"/>
			</jsp:forward>

		<%}
		else{
			// to successfully login, we need to verify that the username exists, and the corresponding password is correct
			Statement check = con.createStatement();
			String check_username_in_table = "SELECT count(*) from users where username = '" + username +"' "; //query to check
			ResultSet result = check.executeQuery(check_username_in_table); // executes query
			result.next();
			if (result.getInt(1) == 1){
				//the username exists in the database, and we can check the password to verify if that is also correct	
				String check_password_for_username = "SELECT count(*) FROM users WHERE username = '" + username + "' AND password = '"+ password +"'  ";
				result = check.executeQuery(check_password_for_username);
				result.next();
				
				if (result.getInt(1) == 1){
					//successful login
					//con.close();
					out.print("Login succeeded");
					String fullNameQuery = "SELECT fname, lname, is_admin, is_customer_rep, is_customer FROM users WHERE username = '" + username + "'";
					result = check.executeQuery(fullNameQuery);
					result.next();
					String fName = result.getString("fname");
					String lName = result.getString("lname");
					boolean isAdmin = result.getBoolean("is_admin");
					boolean isCustomerRep = result.getBoolean("is_customer_rep");
					boolean isCustomer = result.getBoolean("is_customer");
					String fullName = fName + " " + lName; 
					//here we would start a session for the user
					session.setAttribute("user", username);
					session.setAttribute("name", fullName);
					if (isAdmin){
						response.sendRedirect("adminIndex.jsp");
					}else if(isCustomerRep){
						response.sendRedirect("customerRepIndex.jsp");
					}else{
						response.sendRedirect("index.jsp");
					}

					
					}
				else{
					System.out.println("Invalid username, password combination");
					con.close();%>
					
					<jsp:forward page = "landingPage.jsp">
					<jsp:param value="Invalid username/password combination" name="user_message"/>
					</jsp:forward>
					 
				<%}
			} 
			else {
				//the username DNE in the database
				con.close(); %>

				<jsp:forward page = "landingPage.jsp">
				<jsp:param value="Invalid Username" name="user_message"/>
				</jsp:forward>
			<%}
		}
		 //close the connection.
		db.closeConnection(con);
	} catch (Exception e) {
			out.print(e);
		}%>
	
</body>
</html>