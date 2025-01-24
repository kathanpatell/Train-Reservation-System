<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Seller</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();
writer.println("<h1>Welcome Seller!</h1><h2>History of Item Auctions</h2>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    
    PreparedStatement st = null;
    ResultSet rs = null;

	// check any closed auctions -- check if past date and winning_bid is null
	String datetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
  	st = con.prepareStatement("Select * from item_auction where status = 'open' and username='"+username+"' and end <= '"+datetime+"'");
	rs = st.executeQuery();
  	
	while(rs.next()){
  		String item_id = Integer.toString(rs.getInt("item_id"));
  		String title = rs.getString("title");
  		
  		// check if winning_bid is null (that means no bids) and no winners
		if (rs.getInt("winning_bid") == 0){ // default for getInt if null is 0
			String str = "update item_auction set status = 'closed-no winner' where item_id="+item_id;
			int rows = con.createStatement().executeUpdate(str);
			continue;
		}
  		
 		else { // check if curr value > secret min
 			String winning_bid = Integer.toString(rs.getInt("winning_bid"));
 		
			if (rs.getFloat("curr_value") >= rs.getFloat("secret_min")){
		   		
		   		PreparedStatement st2 = con.prepareStatement("Select username from bid where bid_num="+winning_bid);
				ResultSet rs2 = st2.executeQuery();
	   			rs2.next();
	   			
	   			// alert winner here
	   			String winning_username = rs2.getString("username");
	   			
	   			// get latest msg_id
    			st2 = con.prepareStatement("select msg_id from item_alerts order by msg_id desc limit 1");
	   			rs2 = st2.executeQuery();
	   			rs2.next();
	   		    String msg_id = Integer.toString(rs2.getInt(1) + 1);

	   			String str = "insert into item_alerts values (" + msg_id + ","+item_id+ ",'"+winning_username+"','Congratulations! You have the highest bid for item# "+item_id+": " + title+"')";
				int rows = con.createStatement().executeUpdate(str);
				
				// TODO - alert the other users they lost?
				
				// close auction
		   		str = "update item_auction set status = 'closed-winner' where item_id="+item_id ;
				rows = con.createStatement().executeUpdate(str);

	   		}
		
			// else no winner
			else{
				String str = "update item_auction set status = 'closed-no winner' where item_id="+item_id;
				int rows = con.createStatement().executeUpdate(str);
			}
		}
  		
	}
    
    
	// show list of auctions
	st = con.prepareStatement("Select * from item_auction join electronics using (item_id) where username=\""+username+"\" order by item_id desc limit 10 ");
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
<form id="createAuction" action="CreateAuction.jsp">
<input type="submit" name="auction" value="Auction New Item"/>
</form>
<br>
<form id=showMyAuctions action="ShowAuctionsSeller.jsp">
<input type="submit" name="showAuctions" value="View All My Auctions"/>
</form>
<br>
<form id="goBack" action="SellerUserName.jsp">
<input type="submit" name="goBack" value="Search Seller"/>
</form>
<br>
<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>