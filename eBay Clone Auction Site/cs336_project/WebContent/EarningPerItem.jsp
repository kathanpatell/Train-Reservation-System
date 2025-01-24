<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earnings per item</title>
</head>
<body style="background-color:AntiqueWhite">

<%
PrintWriter writer = response.getWriter();
writer.println("<h2>Earnings per item</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String open = "open";
	String pending = "pending";
	String closed = "close%";

	
	String total_stmt = "select item_id, title, winning_bid from item_auction where status like " + "\""+closed+"\"" ;
	
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
	
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Earning</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   	           	+rs.getString("winning_bid")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
	
	
    
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