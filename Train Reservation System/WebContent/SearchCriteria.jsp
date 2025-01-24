<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Results</title>
</head>
<body style="background-color:AntiqueWhite">

<%

PrintWriter writer = response.getWriter();
writer.println("<h2>List of All Items sorted by the given filters</h2>");
try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String color = request.getParameter("colortext");
	String model = request.getParameter("modeltext");
	String brand = request.getParameter("brandtext");
	String item = request.getParameter("itemtext");
	String title = request.getParameter("titletext");
	
	if(color == null && model == null && brand == null && brand == null && item == null && title == null ){
		return;
	}
	
	String stmt = "SELECT * from item_auction inner join electronics on item_auction.item_id=electronics.item_id where ";
	int count = 0;
	
	if(color != null){
		if(count == 0){
			stmt = stmt + "color=" + "\""+color+"\"";
		}
		else{
			stmt = stmt + "and color=" + "\""+color+"\"";
		}
		
		count+=1;
	}
	
	
	if(model != null){
		if(count == 0){
			stmt = stmt + "model_num=" + "\""+model+"\"";
		}
		else{
			stmt = stmt + "and model_num=" + "\""+model+"\"";
		}
		
		count+=1;
	}
	
	if(brand != null){
		if(count == 0){
			stmt = stmt + "brand=" + "\""+brand+"\"";
		}
		else{
			stmt = stmt + "and brand=" + "\""+brand+"\"";
		}
		
		count+=1;
	}
	
	if(item != null){
		if(count == 0){
			stmt = stmt + "item_auction.item_id=" + "\""+item+"\"";
		}
		else{
			stmt = stmt + "and item_auction.item_id=" + "\""+item+"\"";
		}
		
		count+=1;
	}
	
	if(title != null){
		if(count == 0){
			stmt = stmt + "title=" + "\""+title+"\"";
		}
		else{
			stmt = stmt + "and title=" + "\""+title+"\"";
		}
		
		count+=1;
	}
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Brand</th><th>Color</th><th>Model Number</th><th>Start</th><th>End</th><th>Secret Price</th><th>Current Bidding Value</th><th>Status</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   				+rs.getString("brand")+"</td><td>"
	   			    +rs.getString("color")+"</td><td>"
	   			    +rs.getInt("model_num")+"</td><td>"
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
<br><br>
<form id="goBack" action="SearchFor.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Home"/>
</form>
</body>
</html>