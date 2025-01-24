<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*, java.text.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction Process</title>
</head>
<body>
<
<%@ page import ="java.sql.*" %>

	<%
	
	
    try{
    	    	
    	ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	
    	// get latest item_id
    	PreparedStatement stmt = con.prepareStatement("select item_id from item_auction order by item_id desc limit 1;");
		ResultSet rs = stmt.executeQuery();
	    String item_id = rs.next() ? Integer.toString(rs.getInt(1) + 1) : String.valueOf(1);
	    
    	Map params = request.getParameterMap();
    	
    	// get all values
    	String username = (String) session.getAttribute("user");
    	String type = (String) request.getParameter("electronicType");
    	String title = ((String[])params.get("title"))[0] ;
		String model_num = ((String[])params.get("model_num"))[0];
	    String brand = ((String[])params.get("brand"))[0];
	    String color = ((String[])params.get("color"))[0];	
		String start = ((String[])params.get("start"))[0];
	    String end = ((String[])params.get("end"))[0];
	    String initial = ((String[])params.get("initial"))[0];
	    String reserve = ((String[])params.get("reserve"))[0];
	    String increment = ((String[])params.get("inc"))[0];	

	    // supplementary values
	    String storage = ((String[])params.get("storage"))[0];
	    String carrier = ((String[])params.get("carrier"))[0];
	    String screen = ((String[])params.get("screen"))[0];
	    String resolution = ((String[])params.get("resolution"))[0];
	    String connectivity = (String) request.getParameter("connectivity");
	    String cancelling = (String) request.getParameter("noiseCancelling");
	    
	    System.out.println(storage +": " + carrier + ": " + screen + " :" +  resolution+ ": " + connectivity+ ": " +cancelling);

	    // some logistics TODO
	    if (reserve.isEmpty()) 
	    	reserve = "0.00";
	    
	 
	    if (username != null){
	    
		  	// check type-specific conditions
	    	if(type.equals("phone")){
	    		if(storage.isEmpty() || carrier.isEmpty())
	    			out.println("If selecting a Phone please fill out all of the relevant fields.");
	    		else {
	    			
	    			// insert into item_auction and electronics
	    		    String str = "insert into item_auction values ("+item_id+",'"+username+"','"+start+"','"+end+"',"+initial+","+reserve+","+increment+","+initial+",null,'"+title+"','pending')";
	    			int rows = con.createStatement().executeUpdate(str);
	    		    str = "insert into electronics values ("+model_num+",'"+brand+"','"+color+"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);
	    			
	    			str = "insert into phone values ("+model_num+","+storage+",'"+carrier+"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);	
	    	    	
	    			response.setStatus(301);
	    	    	response.setHeader("Location", "Seller.jsp");
	    	     	response.setHeader("Connection", "close");
	    	        
	    	     	
	    		}
	    	}
	    	else if(type.equals("tv")){
	    		if(screen.isEmpty() || resolution.isEmpty())    	
	    			out.print("If selecting a Television please fill out all of the relevant fields.");
	    		else{
	    			// insert into item_auction and electronics
	    		    String str = "insert into item_auction values ("+item_id+",'"+username+"','"+start+"','"+end+"',"+initial+","+reserve+","+increment+","+initial+",null,'"+title+"','pending')";
	    			int rows = con.createStatement().executeUpdate(str);
	    		    str = "insert into electronics values ("+model_num+",'"+brand+"','"+color+"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);
	    			
	    			str = "insert into television values ("+model_num+",'"+screen+"','"+resolution+"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);
	    			
	    	    	response.setStatus(301);
	    	    	response.setHeader("Location", "Seller.jsp");
	    	     	response.setHeader("Connection", "close");
	    	        
	    		}
	    	}
	    	
	    	else if(type.equals("headphones")){
	
	    		if (cancelling == null || connectivity == null)   	
	    			out.print("If selecting Headphones please fill out all of the relevant fields.");   	
	    		else{
	    			
	    			// insert into item_auction and electronics
	    		    String str = "insert into item_auction values ("+item_id+",'"+username+"','"+start+"','"+end+"',"+initial+","+reserve+","+increment+","+initial+",null,'"+title+"','pending')";
	    			int rows = con.createStatement().executeUpdate(str);
	    		    str = "insert into electronics values ("+model_num+",'"+brand+"','"+color+"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);
	    			str = "insert into headphones values ("+model_num+",'"+connectivity+"','"+ cancelling +"',"+item_id+")";
	    			rows = con.createStatement().executeUpdate(str);
	    			
	    	    	response.setStatus(301);
	    	    	response.setHeader("Location", "Seller.jsp");
	    	     	response.setHeader("Connection", "close");
	    	        
	    		
	    		}
	    	}
    	}
	           
	    else
	    	out.println("Please log out and try again.");
    }
	    			
   catch(Exception e){      
	   out.println("Error creating Auction.\n");       
       out.println(e);
   }      
	%>
</body>
</html>