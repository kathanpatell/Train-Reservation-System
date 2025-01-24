<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Answer</title>
</head>
<body style="background-color:AntiqueWhite">

<% 

PrintWriter writer = response.getWriter();
writer.println("<h2>Answer</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Object username = session.getAttribute("customerRep");
	String ticket = request.getParameter("ticketText");
	
	String stmt = "update queries set cr_username="+"\""+username+"\""+ " where ticket_num=" + "\""+ticket+"\"";
	ResultSet rs = null;
	PreparedStatement st = con.prepareStatement(stmt);
		
	int rows = con.createStatement().executeUpdate(stmt);
		
	session.setAttribute("ticket", ticket);
	    
	stmt = "";
		
}
catch(Exception e){
	out.print("ERROR: " + e);
}
%>

<form action="InsertAnswer.jsp" method="post">
	<div>Reply: <textarea required rows="4"  placeholder="Enter answer"cols="50" name="answer">
	</textarea><br/><br/></div>
	<input type="submit" value="Submit">					
</form>	

<br><br>
<form id="goBack" action="SelectQuestionToReply.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>