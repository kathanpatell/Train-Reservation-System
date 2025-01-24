<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*,java.util.Date,  java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Buyer</title>
</head>
<body style="background-color:AntiqueWhite">

<%
PrintWriter writer = response.getWriter();
writer.println("<h1>Welcome Buyer!</h1><h2>Current Bids</h2>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
        
    ResultSet rs = null;
	PreparedStatement st;
	
	// check for automatic bids --> if auction not closed or upper limit not yet reached, keep incrementing
    st = con.prepareStatement("Select a.item_id, a.increment, secret_max, curr_value, title from automatic_bid a join item_auction using(username) where a.username='"+username+"' and status='open'"); 
	rs = st.executeQuery();
    if (rs != null){
    	while(rs.next()){
    		// for every automatic bid set up, check the item details
    		int item_id;
    		float buyer_increment, secret_max, curr_value;
    		String title;
    		
    		item_id = rs.getInt("item_id");
    		buyer_increment = rs.getFloat("increment");
    		secret_max = rs.getFloat("secret_max");
    		curr_value = rs.getFloat("curr_value");
    		title = rs.getString("title");
    		
    		// check if can add new bid
    		if (buyer_increment + curr_value <= secret_max) {
    			ResultSet rs2 = null;  		
				PreparedStatement st2 = con.prepareStatement("select bid_num from bid order by bid_num desc limit 1");
    	 		rs2 = st2.executeQuery();
    	 		rs2.next();
    	 		String bid_num = Integer.toString(rs.getInt("bid_num)") + 1);
    	 		String value = Float.toString(buyer_increment + curr_value);
    	 	
    	 		// TODO only insert if a row with the specified id number does not exist, otherwise update the row
    	 		String str = String.format("INSERT INTO bid (bid_num,username,item_id,increment,value) values(%s, %s, %s, %s, %s, %s)", bid_num, "'"+username+"'", item_id, buyer_increment, value);
    	 		Statement stmt = con.createStatement();
    	        int rows = stmt.executeUpdate(str);        
    		
    	        // update item auction to show current winning bid
    	        str = String.format("update item_auction set winning_bid = %s where item_id = %s", bid_num, item_id);
    	      	stmt = con.createStatement();
    	       	rows = stmt.executeUpdate(str);
    	       	
    	       	str = String.format("update item_auction set curr_value = %s where item_id = %s", value, item_id);
    	      	stmt = con.createStatement();
    	       	rows = stmt.executeUpdate(str);
    	       	        
    	        // alert other buyers that a bid has been placed
    	        str = String.format("select username from bid where item_id = %s and username <> '%s'", item_id, username);
    	        st2 = con.prepareStatement(str);
    	 		rs2 = st.executeQuery();
    	 		if (rs2 != null){
    	 			while(rs2.next()){
    	 				// get latest msg_id
    					ResultSet rs3 = null; 
    	    			PreparedStatement st3 = null;
    	    			st3 = con.prepareStatement("select count(msg_id) from item_alerts");
    		   			rs3 = st2.executeQuery();
    		   			rs3.next();
    		   		    String msg_id = Integer.toString(rs3.getInt(1) + 1);
    		   		     				
    	 				// alert this user
    	 				String curr_user = rs.getString("username");
    	 				str = String.format("insert into item_alerts values (%s, %s, %s, 'You've been outbid for item# %s: %s')", msg_id, item_id, curr_user, item_id,title);
    	 				stmt = con.createStatement();
    	 				rows = stmt.executeUpdate(str);
    	 			}
    			}
    		}
    	}
    	
    	
    }
			
    rs = null;
    PreparedStatement email_st = con.prepareStatement("Select * from bid b join item_auction using(item_id) where b.username=\""+username+"\" order by bid_num desc limit 10"); // limit to most recent 10 bids
	rs = email_st.executeQuery();
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Increment</<th><th>Bid Value</th><th>Current Value</th></tr>");
	   	while(rs.next()){	   			
	   		writer.println("<tr><td>"
	   				+rs.getString("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   		   		+rs.getString("Increment")+"</td><td>"
	   		   		+rs.getString("value")+"</td><td>"

	   				+rs.getString("curr_value")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
}

catch(Exception e){      
    out.println("ERROR:" + e);       
}      

%>

<br> 
<form id="bidType">
<button type="submit" name="manualBid" formaction="CreateBidManual.jsp">Place a Manual Bid</button>
<button type="submit" name="autoBid" formaction="CreateBidAutomatic.jsp">Place an Automatic Bid</button>
</form>

<form id="showType">
<button type="submit" name="allBids" formaction="ShowBids.jsp">View All My Bids</button>
</form>

<form id="showAlerts" action="ShowAlerts.jsp">
<input type="submit" name="showAlerts" value="Show My Alerts"/>
</form>

<form id="goBack" action="SearchBuyerByUserName.jsp">
<input type="submit" name="goBack" value="Search Buyer"/>
</form>

<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>