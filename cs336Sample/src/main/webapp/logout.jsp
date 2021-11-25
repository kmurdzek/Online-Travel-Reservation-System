
<%
session.invalidate();
//this will throw an error
System.out.println("Session Invalidated");
response.sendRedirect("landingPage.jsp");
 
%>