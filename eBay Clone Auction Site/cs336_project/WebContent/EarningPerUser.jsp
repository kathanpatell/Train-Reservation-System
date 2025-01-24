<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Earning per User</title>
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
	
	String total_stmt = "select username, count(item_auction.item_id), sum(winning_bid) from item_auction where item_auction.status like " + "\""+closed+"\"" + " group by username" ;
	
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
	
	st = con.prepareStatement(total_stmt);
	
	rs = st.executeQuery();
	   	
	   	
	   	if (rs != null){
	   		writer.println("<table BORDER=1>"
		               +"<tr><th>Usernames</th><th>Number of items</th><th>Total Earning</th></tr>");
		   	while(rs.next()){	 
		   		writer.println("<tr><td>"
		   				+rs.getString("username")+"</td><td>"
		   				+rs.getString(2)+"</td><td>"
		   	           	+rs.getString(3)+"</tr>");
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