<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction</title>
</head>
<body style="background-color:AntiqueWhite">
<h1>Welcome to the AUCTION application!</h1>
<h2>Please select whether you'd like to proceed as a buyer or seller.</h2>


<%
PrintWriter writer = response.getWriter();

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    ResultSet rs = null;
	PreparedStatement st;
	String pending = "pending";
	// check if any new auctions started and change from pending to open
    st = con.prepareStatement("Select * from item_auction where status=" + "\""+pending+"\""); 
	rs = st.executeQuery();
	
    if (rs != null){
    	while(rs.next()){
    		// for every pending auction, compare date
    		String datetime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			String start = rs.getString("start");

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");		
			
			System.out.println(start);

			
			if (sdf.parse(datetime).compareTo(sdf.parse(start)) >= 0){
	    		String item_id = Integer.toString(rs.getInt("item_id"));
				// update status in item_auction
	    		String str = String.format("update item_auction set status = 'open' where item_id = %s", item_id);
				int rows = con.createStatement().executeUpdate(str);
			}
    	}
    

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
		  		
			
    	
    }
			
  
}

catch(Exception e){      
    out.println("ERROR:" + e);       
}      

%>


<form id="userType">
<label for="usertType">Select user type: </label>
<button type="submit" name="buyerBtn" formaction="Buyer.jsp">Buyer</button>
<button type="submit" name="sellerBtn" formaction="Seller.jsp">Seller</button>
</form>
<br>
<form id="searchFunctions">
<label for="searchFunctions">Search Functions: </label>
<button type="submit" name="allSearch" formaction="SearchAll.jsp">Search All</button>
<button type="submit" name="searchBy" formaction="SearchBy.jsp">Sort Filters</button>
<button type="submit" name="searchFor" formaction="SearchFor.jsp">Search Filters/Similar items</button>
</form>
<br>
<form id="userFunctions">
<label for="userFunctions">User Functions: </label>
<button type="submit" name="bidHistory" formaction="BidHistory.jsp">Bid History</button>
<button type="submit" name="bidHistory" formaction="SetAlerts.jsp">Set Alerts</button>
</form>

<br>
<form id="Questions">
<label for="Questions">Questions: </label>
<button type="submit" name="FAQ" formaction="FAQ.jsp">Frequently Asked Questions</button>
</form>


<br>
<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>
</body>
</html>