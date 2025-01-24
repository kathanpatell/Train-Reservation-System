<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Total Earnings</title>
</head>
<body style="background-color:AntiqueWhite">
<%

PrintWriter writer = response.getWriter();
writer.println("<h2>Total Earnings</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String color = request.getParameter("colortext");
	String model = request.getParameter("modeltext");
	String brand = request.getParameter("brandtext");
	String item = request.getParameter("itemtext");
	String title = request.getParameter("titletext");
	String open = "open";
	String pending = "pending";
	String closed = "close%";

	
	String total_stmt = "select sum(winning_bid) from item_auction where status like " + "\""+closed+"\"" ;
	
	String item_total_stmt = "select count(item_id) from item_auction where status like " + "\""+closed+"\"";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(total_stmt);
	
	rs = st.executeQuery();
	
	
	String total = "";
	
	if (rs != null){
		rs.next();
		total = rs.getString(1);
	}
	if(total == null){
		total="0.0";
	}
	
	st = con.prepareStatement(item_total_stmt);
	
	rs = st.executeQuery();
	
	String item_sum = "";
	
	if (rs != null){
		rs.next();
		item_sum = rs.getString(1);
	}
	
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Number of Items</th><th>Total Earnings</th></tr>");
	    
	   		writer.println("<tr><td>"
	   				+item_sum+"</td><td>"
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