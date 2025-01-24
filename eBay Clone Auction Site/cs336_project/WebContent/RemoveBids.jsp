<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Remove bids</title>
</head>
<body style="background-color:AntiqueWhite">

<%
PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("user");
	String id = request.getParameter("itemIdText");
	String stmt = "SELECT * from bid";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Bid Num</th><th>Username</th><th>Item ID</th><th>Increment</th><th>value</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("bid_num")+"</td><td>"
	   				+rs.getString("username")+"</td><td>"
	   			    +rs.getInt("item_id")+"</td><td>"
	   			    +rs.getFloat("increment")+"</td><td>"
	   		   		+rs.getFloat("value")+"</tr>");
	    }
	   	
	   	writer.println("</table>");
	}
    
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>

<br>
<form action="RemoveBidProcess.jsp" method="post">
	<label>Select Bid Number: </label>
	<input type="text" name="bidText" required>
	<input type="submit" value="Submit">					
</form>

<br><br>
<form id="goBack" action="CustomerRepHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>