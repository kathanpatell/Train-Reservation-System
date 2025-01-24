<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>My Alerts</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();
writer.println("<h1>My Alerts</h1>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    
    PreparedStatement st = null;
    ResultSet rs = null;

	// show list of alerts for the buyer
	st = con.prepareStatement("Select * from item_alerts i join item_auction using(item_id) where i.username = '" + username + "' order by msg_id desc");
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Message ID</th><th>Item ID</th><th>Item Title</th><th>Message</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"	   				
	   				+rs.getInt("msg_id")+"</td><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   		   	    +rs.getString("message")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
		
} 

	
catch(Exception e){      
    out.println("ERROR:" + e);       
} 



%>

<br>
<form id="goBack" action="Buyer.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>