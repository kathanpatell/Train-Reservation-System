<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Auction</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String stmt = "SELECT * from item_auction";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Start</th><th>End</th><th>Secret Price</th><th>Current Bidding Value</th><th>Status</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   		   		+rs.getTimestamp("start")+"</td><td>"
	   		   	 	+rs.getTimestamp("end")+"</td><td>"
	   	           	+rs.getFloat("secret_min")+"</td><td>"
	   		   	    +rs.getFloat("curr_value")+"</td><td>"
	   	           	+rs.getString("status")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
    
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>

<br>
<form action="RemoveAuctionsProcess.jsp" method="post">
	<label>Select Item ID: </label>
	<input type="text" name="itemText" required>
	<input type="submit" value="Submit">					
</form>

<br><br>
<form id="goBack" action="CustomerRepHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>