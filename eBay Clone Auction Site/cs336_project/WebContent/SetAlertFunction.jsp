<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"  import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>d
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Setting alert</title>
</head>
<body style="background-color:AntiqueWhite">
<% 
PrintWriter writer = response.getWriter();
writer.println("<h2>Alert is set</h2>");

try{
    ApplicationDB db = new ApplicationDB();
    Connection con = db.getConnection();
    Object username = session.getAttribute("user");
    String item_id = request.getParameter("itemTextField");
    String message = "";
    PreparedStatement st = con.prepareStatement("select msg_id from item_alerts order by msg_id desc limit 1");
	ResultSet rs = st.executeQuery();
    String msg_id = rs.next() ? Integer.toString(rs.getInt(1) + 1) : String.valueOf(1);
    
    //Set alerts
	String str = "insert into item_alerts values ("+msg_id+",'"+item_id+"','"+username+"','"+message+"')";
	int rows = con.createStatement().executeUpdate(str);
} 


	
catch(Exception e){      
    out.println("ERROR:" + e);       
} 
%>

<form id="goBack" action="SetAlerts.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
</body>
</html>