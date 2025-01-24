<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auctions Buyer</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();
writer.println("<h1>All Open Auctions</h1>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    
    PreparedStatement st = null;
    ResultSet rs = null;

	// show list of auctions for buyer to participate in -- but not their own
	st = con.prepareStatement("Select * from item_auction join electronics using (item_id) where status='open' and username <> '" + username + "' order by item_id desc");
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Start</th><th>End</th><th>Current Bidding Value</th>></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   		   		+rs.getTimestamp("start")+"</td><td>"
	   		   	 	+rs.getTimestamp("end")+"</td><td>"
	   		   	    +rs.getFloat("curr_value")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
		
} 

	
catch(Exception e){      
    out.println("ERROR:" + e);       
} 



%>

<br>
<form id="createManualBid" action="CreateBidManual.jsp">
<input type="submit" name="bid" value="Place a Manual Bid"/>
</form>
<form id="createAutomaticBid" action="CreateBidAutomatic.jsp">
<input type="submit" name="bid" value="Place an Automatic Bid"/>
</form>
<br>
<form id="goBack" action="Buyer.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>