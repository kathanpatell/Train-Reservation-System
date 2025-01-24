<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earning per item type</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();
writer.println("<h2>Earnings of all Phones</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String open = "open";
	String pending = "pending";
	String closed = "close%";
	
	String total_stmt = "select sum(winning_bid), count(item_auction.item_id) from item_auction inner join phone on item_auction.item_id=phone.item_id where item_auction.status like " + "\""+closed+"\"" ;
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(total_stmt);
	
	rs = st.executeQuery();
	
	
	String total = "";
	String count = "";
	
	if (rs != null){
		rs.next();
		total = rs.getString(1);
		count = rs.getString(2);
	}
	if(total == null){
		total="0.0";
	}
	
	//st = con.prepareStatement(stmt);
	//rs = st.executeQuery();
	
	
	
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Number of phones</th><th>Total Earning</th></tr>");
	   		 
	   		writer.println("<tr><td>"
	   				+count+"</td><td>"
	   	           	+total+"</tr>");
	    
	   	
	   	writer.println("</table>");
	   	
	    writer.println("<h2>Earnings of all Televisions</h2>");
	
		total_stmt = "select sum(winning_bid), count(item_auction.item_id) from item_auction inner join television on item_auction.item_id=television.item_id where item_auction.status like " + "\""+closed+"\"" ;
		
	     rs = null; 
		
		 st = con.prepareStatement(total_stmt);
		
		rs = st.executeQuery();
		
		
		if (rs != null){
			rs.next();
			total = rs.getString(1);
			count = rs.getString(2);
		}
		if(total == null){
			total="0.0";
		}
		
		//st = con.prepareStatement(stmt);
		//rs = st.executeQuery();
		
		
		
		   	writer.println("<table BORDER=1>"
		               +"<tr><th>Number of TV</th><th>Total Earning</th></tr>");
		   		 
		   		writer.println("<tr><td>"
		   				+count+"</td><td>"
		   	           	+total+"</tr>");
		    
		   	
		   	writer.println("</table>");
		
		   	
		    writer.println("<h2>Earnings of all Televisions</h2>");
			
			total_stmt = "select sum(winning_bid), count(item_auction.item_id) from item_auction inner join headphones on item_auction.item_id=headphones.item_id where item_auction.status like " + "\""+closed+"\"" ;
			
		     rs = null; 
			
			 st = con.prepareStatement(total_stmt);
			
			rs = st.executeQuery();
			
			
			if (rs != null){
				rs.next();
				total = rs.getString(1);
				count = rs.getString(2);
			}
			if(total == null){
				total="0.0";
			}
			
			//st = con.prepareStatement(stmt);
			//rs = st.executeQuery();
			
			
			
			   	writer.println("<table BORDER=1>"
			               +"<tr><th>Number of HeadPhones</th><th>Total Earning</th></tr>");
			   		 
			   		writer.println("<tr><td>"
			   				+count+"</td><td>"
			   	           	+total+"</tr>");
			    
			   	
			   	writer.println("</table>");
	
	
	
    
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>
<br><br>
<form id="goBack" action="AdminHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
</body>
</html>