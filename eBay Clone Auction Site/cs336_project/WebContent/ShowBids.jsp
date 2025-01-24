<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>All Bids</title>
</head>
<body style="background-color:AntiqueWhite">
<%
PrintWriter writer = response.getWriter();
writer.println("<h1>All of My Bids</h1>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    
    PreparedStatement st = con.prepareStatement("Select * from bid b join item_auction using(item_id) where b.username=\""+username+"\" order by bid_num desc");
    ResultSet rs = st.executeQuery();

    if (rs != null){
    	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Increment</th><th>Current Value</th></tr>");
	   	while(rs.next()){	   			
	   		writer.println("<tr><td>"
	   				+rs.getString("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
	   		   		+rs.getString("Increment")+"</td><td>"
	   				+rs.getString("value")+"</tr>");
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