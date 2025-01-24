<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Auctions</title>
</head>
<body>
<%
PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String item_id = request.getParameter("itemText");
	String stmt = "delete from item_auction where item_id=" + "\""+item_id+"\"";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	int rows = con.createStatement().executeUpdate(stmt);
	
	writer.println("<h2>Auction Removed</h2>");
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>
</body>
</html>