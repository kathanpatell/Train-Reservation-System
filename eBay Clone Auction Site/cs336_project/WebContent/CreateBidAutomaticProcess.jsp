<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid Automatic Process</title>
</head>
<body>

<%
	try{    	
    	ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	Object username = session.getAttribute("user");
    	
    	if (username == null)
    	{
    		out.println("Please re-login.");
    		out.println("<form id='goBack' action='Login.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
    	}
    	
    	String item_id = request.getParameter("automaticSelectItem");
    	String increment = request.getParameter("automaticIncrement");
    	String secret_max = request.getParameter("automaticUpperLimit");
    	
    	// check if missing any fields
    	if(item_id.isEmpty() || increment.isEmpty() ){
    		out.println("Please fill out all of the fields.");
    		return;
    	}
    	
	    // some logistics TODO
	    if (secret_max.isEmpty())
	    	secret_max = "2147483647"; // this is the max int value in sql
	   	
    	
    	ResultSet rs = null; 
    	PreparedStatement st = con.prepareStatement("Select exists(Select * from item_auction where item_id = "+item_id+") exist");
 		rs = st.executeQuery();
 		rs.next();
 		if (rs.getInt("exist") != 1)
 		{
 			out.println("That item does not exist!");
    		out.println("<form id='goBack' action='CreateBidAutomatic.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
 		}
    	
 		// check if that item was auctioned by the user -- can't bid on it then
 		rs = null;
    	st = con.prepareStatement("Select * from item_auction where username='" + username + "'and item_id="+item_id);
    	rs = st.executeQuery();
    	if (rs.next()) {
      		out.println("You cannot bid on your own item.");
    		out.println("<form id='goBack' action='CreateBidAutomatic.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
			return;
    	} 		
 		
 		// check if user has set automatic bidding on item
    	rs = null;
    	st = con.prepareStatement("Select * from automatic_bid where username='" + username + "'and item_id="+item_id);
    	rs = st.executeQuery();
    	if (rs.next()) {
      		out.println("You have already set automatic bidding for this item.");
    		out.println("<form id='goBack' action='CreateBidAutomatic.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
			return;
    	}
 		
    	// check if increment is less than the required one by seller
    	rs = null; 
    	st = con.prepareStatement("Select curr_value, increment, title from item_auction where item_id = "+item_id); 
 		rs = st.executeQuery();
 		rs.next();
 		
 		float curr_value = rs.getFloat("curr_value");
 		float min_increment = rs.getFloat("increment");
    	String title = rs.getString("title"); 
    	rs = null; 
    	
    	if (Float.parseFloat(increment) < min_increment)
    	{
    		out.println("Your increment must be atleast " + min_increment+".");
    		out.println("<form id='goBack' action='CreateBidAutomatic.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
    	}
    	
    	rs = null; 
 		st = con.prepareStatement("select bid_num from bid order by bid_num desc limit 1");
 		rs = st.executeQuery();
 		
 		String bid_num = rs.next() ? Integer.toString(rs.getInt("bid_num") + 1) : String.valueOf(1);
 		
 		String value = String.valueOf(curr_value+Float.parseFloat(increment)); // update the value of the item -- assuming no one else is creating a bid at the same time
 		
 		// check if value is more than secret limit
 		if (Float.parseFloat(value) > Float.parseFloat(secret_max)){
 			out.println("The value of the item will be more than your upper limit. Please change your limit or go back.");
    		out.println("<form id='goBack' action='CreateBidAutomatic.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
 		}
 		
 		// insert into automatic bid table
       	String str = String.format("insert into automatic_bid values('%s', %s, %s, %s)", username, item_id, increment, secret_max);
       	Statement stmt = con.createStatement();
       	int rows = stmt.executeUpdate(str);  
        
 		// TODO only insert if a row with the specified id number does not exist, otherwise update the row
 		str = String.format("INSERT INTO bid (bid_num,username,item_id,increment,value) values(%s, %s, %s, %s, %s)", bid_num, "'"+username+"'", item_id, increment, value);
 		out.println(str);
 		stmt = con.createStatement();
        rows = stmt.executeUpdate(str);        
        
        // update item auction to show current winning bid
        str = String.format("update item_auction set winning_bid = %s where item_id = %s", bid_num, item_id);
      	stmt = con.createStatement();
       	rows = stmt.executeUpdate(str);  
       	
       	str = String.format("update item_auction set curr_value = %s where item_id = %s", value, item_id);
      	stmt = con.createStatement();
       	rows = stmt.executeUpdate(str);
       	
        // alert other buyers that a bid has been placed
        str = String.format("select username from bid where item_id = %s and username <> '%s'", item_id, username);
        st = con.prepareStatement(str);
 		rs = st.executeQuery();
 		if (rs != null){ 
 			while(rs.next()){
 				// get latest msg_id
				ResultSet rs2 = null; 
    			PreparedStatement st2 = null;
    			st2 = con.prepareStatement("select msg_id from item_alerts order by msg_id desc limit 1");
	   			rs2 = st2.executeQuery();
	   			rs2.next();
	   		    String msg_id = Integer.toString(rs2.getInt(1) + 1);
	   		     				
 				// alert this user
 				String curr_user = rs.getString("username");
 				str = String.format("insert into item_alerts values (%s, %s, %s, 'You've been outbid for item# %s: %s')", msg_id, item_id, curr_user, item_id,title);
 				stmt = con.createStatement();
 				rows = stmt.executeUpdate(str);
 			}
 		}
 		
 		// TODO close - priya
 		response.setStatus(301);
    	response.setHeader("Location", "Buyer.jsp");
     	response.setHeader("Connection", "close");
        
	}
	catch(Exception e){      
   		out.println("ERROR:" + e);       
	}   
    	
%>

<form id="goBack" action="CreateBidAutomatic.jsp">
	<br><br><br>
	<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>