<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Delete Account</title>
</head>
<body style="background-color:AntiqueWhite">
<%

PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("customerRep");

	String stmt = "delete from customer_rep where username=" + "\""+username+"\"";
	//out.print(stmt);
	PreparedStatement st = con.prepareStatement(stmt);
	
	int rows = con.createStatement().executeUpdate(stmt);
	
	writer.println("<h2>Account deleted</h2>");
	//Create a query and table for similar items

}
catch(Exception e){      
   out.println("ERROR:" + e);  
}     
%>
</body>
</html>