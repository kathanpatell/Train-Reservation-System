<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Handle</title>
</head>
<body style="background-color:AntiqueWhite">
<% 
			
		try {
			ApplicationDB db = new ApplicationDB();
			Connection con = db.getConnection();
			
			
			Object username = session.getAttribute("user");
			String question = request.getParameter("question");
			String await = "Awaiting response from the customer representative";
			String closed = "no";
	    	
	    	// get latest ticket num
	    	PreparedStatement stmt = con.prepareStatement("select ticket_num from queries order by ticket_num");
			ResultSet rs = stmt.executeQuery();
			String ticket_num = rs.next() ? Integer.toString(rs.getInt(1) + 1) : String.valueOf(1);
			
			if(username != null  && question != null && !question.isEmpty()){
				
				String insert = "INSERT INTO queries (ticket_num, user_username, date, question, answer, closed)" + " VALUES (" +"\""+ticket_num+"\""+","+"\""+username+"\"" + "," + "NOW()" + "," + "\""+question+"\"" + "," +"\""+await+"\""+","+"\""+closed+"\""+")";
				
				PreparedStatement ps = con.prepareStatement(insert);
				int rows = con.createStatement().executeUpdate(insert);
				PrintWriter writer = response.getWriter();
				writer.println("<h2>Your Question has been submitted</h2>");
				
			} else {
				out.print("Question not submitted");
				return;
			}    
		} 
		
		catch(Exception e) {
	        out.print("<p>Error connecting to MYSQL server.</p>" + e);
	        e.printStackTrace();
	    } 

		        
		        
	%>
<form id="goBack" action="FAQ.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
</body>
</html>