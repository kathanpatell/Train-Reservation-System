<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="background-color:AntiqueWhite">

<% 

PrintWriter writer = response.getWriter();
writer.println("<h2>Answer Updated</h2>");

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	String answer = request.getParameter("answer");
	String yes = "yes";
	Object username = session.getAttribute("customerRep");
	Object ticket = session.getAttribute("ticket");
	
	String stmt = "update queries set answer="+"\""+answer+"\"" +" , closed=" +"\""+yes+"\""+ " where ticket_num=" + "\""+ticket+"\"";
	ResultSet rs = null;
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	int rows = con.createStatement().executeUpdate(stmt);
}
	
catch(Exception e){
	out.print("ERROR: " + e);
}
%>

<br><br>
<form id="goBack" action="SelectQuestionToReply.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>