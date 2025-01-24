<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Reply</title>
</head>
<body style="background-color:AntiqueWhite">

<%
PrintWriter writer = response.getWriter();
writer.println("<h2>All Questions</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	Object username = session.getAttribute("customerRep");
	
	String stmt = "select * from queries";
	
	PreparedStatement st = con.prepareStatement(stmt);

	ResultSet rs = null;
		
		rs = st.executeQuery();
		
		if (rs != null){
		   	writer.println("<table BORDER=1>"
		               +"<tr><th>Ticket Number</th><th>Username</th><th>Customer Rep.</th><th>Date</th><th>Question</th><th>Answer</th><th>Closed</th></tr>");
		   	while(rs.next()){	 
		   		writer.println("<tr><td>"
		   				+rs.getInt("ticket_num")+"</td><td>"
		   				+rs.getString("user_username")+"</td><td>"
		   				+rs.getString("cr_username")+"</td><td>"
		   			    +rs.getString("date")+"</td><td>"
		   			    +rs.getString("question")+"</td><td>"
		   		   		+rs.getString("answer")+"</td><td>"
		   		   	 	+rs.getString("closed")+"</tr>");
		    }
		   	
		   	writer.println("</table>");
		}
}
catch(Exception e){
	out.print("ERROR: " + e);
}
%>

<br>
<form action="Answer.jsp" method="post">
	<label>Select Open Ticket Number: </label>
	<input type="text" name="ticketText" required>
	<input type="submit" value="Submit">					
</form>

<br><br>
<form id="goBack" action="CustomerRepHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>