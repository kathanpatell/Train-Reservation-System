<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Place Manual Bid</title>
</head>
<body style="background-color:AntiqueWhite">
<%
	PrintWriter writer = response.getWriter();
	writer.println("<h1>Place a Bid</h1><h2>Available Items</h2>");
	
	try{
	    ApplicationDB db = new ApplicationDB();
	    Connection con = db.getConnection();
	    Object username = session.getAttribute("user");
	    
	    //show all items in auction -- but not their own
	    ResultSet rs = null; 
	    PreparedStatement st = con.prepareStatement("Select * from item_auction join electronics using (item_id) where status='open' and username <> '" + username + "' order by item_id desc limit 10" );
	    rs = st.executeQuery();
		
		if (rs != null){
		   	writer.println("<table BORDER=1>"
		               +"<tr><th>Item Name</th><th>Item ID</th><th>Start</th><th>End</th><th>Initial Price</th><th>Current Bidding Value</th><th>Minimum Increment</th><th>Model Number</th><th>Brand</th><th>Color</th></tr>");
		   	while(rs.next()){	   			
		   		writer.println("<tr><td>"
		   				+rs.getString("title")+"</td><td>"
		   				+rs.getString("item_id")+"</td><td>"
		   		   		+rs.getTimestamp("start")+"</td><td>"
		   		   	 	+rs.getTimestamp("end")+"</td><td>"
		   	           	+rs.getFloat("initial_price")+"</td><td>"
		   	           	+rs.getFloat("curr_value")+"</td><td>"
		   	           	+rs.getFloat("increment")+"</td><td>"
		   				+rs.getInt("model_num")+"</td><td>"
		   				+rs.getString("brand")+"</td><td>"
		   				+rs.getString("color")+"</tr>");
		    }
		   	
		   	writer.println("</table>");
		}
	}
	catch(Exception e){      
	    out.println("ERROR:" + e);       
	} 
	
%>

<h2>Manual Bid</h2>Place a bid manually.<br><br>
<form id="bidForm" action="CreateBidManualProcess.jsp">
	<div id="manualSelectItem">&emsp;ItemID: <input type="text" name="manualSelectItem" placeholder="0"/></div> <br>
	<div id="manualIncrement">&emsp;Increment: <input type="text" name="manualIncrement" min="0.01" placeholder="0"/></div> <br>
	<input type="submit" name="placeBid" value="Place Bid"/>
</form>

<form id="showType">
<button type="submit" name="allAuctions" formaction="ShowAuctionsBuyer.jsp">View All Auctions</button>
</form>

<form id="goBack" action="Buyer.jsp">
	<br><br><br>
	<input type="submit" name="goBack" value="Go Back"/>
</form>


</body>
</html>