<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*, javax.servlet.jsp.*, javax.servlet.http.HttpSession"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
         textarea{
         font-size: 14px;
         }
      </style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>

<%
ApplicationDB db = new ApplicationDB();	
Connection con = db.getConnection();
Statement check = con.createStatement();
String question = request.getParameter("question_browse");
String query = "SELECT * FROM questions WHERE";
	String arr[] =question.split(" ");//splits the question for each word
	int sizeOfArr = arr.length;
	int i = 0;
	for(String word : arr){ //i made this a lot more confusing than it should be lol	
		if(i == sizeOfArr-1){
			query+=" question like '%"+word+"%'";
		}else{
		query+=" question like '%"+word+"%' or";
		}
		i++;
	}
	ResultSet result = check.executeQuery(query);
	session.setAttribute("question", question);
	out.print("<h1>Results from searching by keywords: "+question+" </h1>");
	try{
	out.print("<table style='width:100%'>");
	out.print("<tr>");
	out.print("<th style='width:50%'>");
	out.print("Question");
	out.print("</th>");
	out.print("<th style='width:50%'>");
	out.print("Answer");
	out.print("</th>");
	out.print("</tr>");
	while(result.next()){
		String question_out = result.getString("question");
		out.print("<td>");
		out.print(question_out);
		out.print("</td>");
		String answer = result.getString("answer");
		if(answer == null){
			out.print("<td  style = 'font-style: italic' >");
			out.print("A representative has not replied yet.");
		}else{
			out.print("<td>");
			out.print(answer);	
		}
		
		out.print("</td>");
		out.print("</tr>");
	}
	out.print("</table>");
	
	}catch(Exception e){
		System.out.println(e);
	}
	
%>

<br>
<br>
		<form method="post" action="viewAccount.jsp">
		  <input type="submit" name="user_message" value="Return to Account"/>
		  <br>
		</form>
</body>
</html>