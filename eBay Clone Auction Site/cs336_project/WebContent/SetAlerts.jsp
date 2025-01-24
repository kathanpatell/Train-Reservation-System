<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>d
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
function alertName(){
alert("Alert has been set");
} 
</script>

<meta charset="ISO-8859-1">
<title>Set Alert</title>
</head>
<body style="background-color:AntiqueWhite">
<% 
PrintWriter writer = response.getWriter();
writer.println("<h2>List of All Items</h2>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    
    PreparedStatement st = null;
    ResultSet rs = null;
    String pending = "pending";
  	
    
    
	// show list of auctions
	st = con.prepareStatement("Select * from item_auction inner join electronics on item_auction.item_id  where item_auction.item_id=electronics.item_id and status=" + "\""+pending+"\"");
	rs = st.executeQuery();
	
	if (rs != null){
	   	writer.println("<table BORDER=1>"
	               +"<tr><th>Item ID</th><th>Title</th><th>Start</th><th>End</th><th>Secret Price</th><th>Current Bidding Value</th><th>Status</th></tr>");
	   	while(rs.next()){	 
	   		writer.println("<tr><td>"
	   				+rs.getInt("item_id")+"</td><td>"
	   				+rs.getString("title")+"</td><td>"
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

<form id="alertFunctions">
<label for="alertFunctions">Item ID: </label>
<input type="text" name="itemTextField" required/>
<button type="submit" name="setAlert" formaction="SetAlertFunction.jsp" onSubmit="alertName()">Set Alert</button>
</form>

<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>