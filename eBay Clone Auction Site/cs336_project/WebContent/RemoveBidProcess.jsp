<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove Bids</title>
</head>
<body style="background-color:AntiqueWhite">

<%
PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String bid_num = request.getParameter("bidText");
	String stmt = "delete from bid where bid_num=" + "\""+bid_num+"\"";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	int rows = con.createStatement().executeUpdate(stmt);
	
	writer.println("<h2>Bid Removed</h2>");
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>

</body>
</html>