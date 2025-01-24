<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid Manual Process</title>
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
    	
    	String item_id = request.getParameter("manualSelectItem");
    	String increment = request.getParameter("manualIncrement");
    	
    	// check if missing any fields
    	if(item_id.isEmpty() || increment.isEmpty()){
    		out.println("Please fill out all of the fields.");
    		return;
    	}
    	
    	ResultSet rs = null; 
    	PreparedStatement st = con.prepareStatement("Select exists(Select * from item_auction where item_id = "+item_id+") exist");
 		rs = st.executeQuery();
 		rs.next();
 		if (rs.getInt("exist") != 1)
 		{
 			out.println("That item does not exist!");
    		out.println("<form id='goBack' action='CreateBid.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
 		}
    	
 		// check if that item was auctioned by the user -- can't bid on it then
 		rs = null;
    	st = con.prepareStatement("Select * from item_auction where username='" + username + "'and item_id="+item_id);
    	rs = st.executeQuery();
    	if (rs.next()) {
      		out.println("You cannot bid on your own item.");
    		out.println("<form id='goBack' action='CreateBid.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
			return;
    	} 		
 		
 		// check if user has set automatic bidding on item
    	rs = null;
    	st = con.prepareStatement("Select * from automatic_bid where username='" + username + "'and item_id="+item_id);
    	rs = st.executeQuery();
    	if (rs.next()) {
    		out.println("You have already set automatic bidding for this item.");
    		out.println("<form id='goBack' action='CreateBid.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
			return;
    	}
 		
    	rs = null; 
    	st = con.prepareStatement("Select curr_value, increment, title from item_auction where item_id = "+item_id); 
 		rs = st.executeQuery();
 		rs.next();
 		
 		float curr_value = rs.getFloat("curr_value");
 		float min_increment = rs.getFloat("increment");
    	String title = rs.getString("title"); 
    	
    	if (Float.parseFloat(increment) < min_increment)
    	{
    		out.println("Your increment must be atleast " + min_increment+".");
    		out.println("<form id='goBack' action='CreateBid.jsp'> <br><br><br> <input type='submit' name='goBack' value='Go Back'/></form>");
    		return;
    	}
    	    	    	
    	rs = null; 
 		st = con.prepareStatement("Select count(*) from bid");
 		rs = st.executeQuery();
 		rs.next();
 		String bid_num = Integer.toString(rs.getInt("cont(*)") + 1);
 		
 		String value = String.valueOf(curr_value+Float.parseFloat(increment)); // update the value of the item -- assuming no one else is creating a bid at the same time
 		
 		// TODO only insert if a row with the specified id number does not exist, otherwise update the row
 		String str = String.format("INSERT INTO bid (bid_num,username,item_id,secret_max,increment,value) values(%s, %s, %s, %s, %s, %s)", bid_num, "'"+username+"'", item_id, "NULL", increment, value);
 		out.println(str);
 		Statement stmt = con.createStatement();
        int rows = stmt.executeUpdate(str);        
               
        // update item auction to show current winning bid
        str = String.format("update table item_auction set winning_bid = %s where item_id = %s", bid_num, item_id);
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
    			st2 = con.prepareStatement("select count(msg_id) from item_alerts");
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

<form id="goBack" action="CreateBid.jsp">
	<br><br><br>
	<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>