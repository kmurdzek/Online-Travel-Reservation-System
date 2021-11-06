<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//	String message = request.getParameter("user_message");
	String fullName = request.getParameter("user_full_name");
//	out.print(message);
%>

	<h1>Welcome <% out.print(fullName); %></h1>
	
	<form method="post" action="landingPage.jsp">
	<input type="submit" name="user_message" value="Log out"/>
	<br>
	
	</form>
	

</body>
</html>