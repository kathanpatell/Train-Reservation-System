<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Process</title>
</head>
<body style="background-color:AntiqueWhite">
<%

PrintWriter writer = response.getWriter();

try{
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	Object username = session.getAttribute("customerRep");
	String update_username = request.getParameter("usertext");
	String password = request.getParameter("passtext");
	String name = request.getParameter("nametext");
	String email = request.getParameter("emailtext");
	
	String open = "open";
	String pending = "pending";
	
	
	String stmt = "update customer_rep set ";
	//out.print(stmt);
	String stmt1 = "SELECT * from item_auction inner join electronics on item_auction.item_id=electronics.item_id where ";
	int count = 0;
	
	if(update_username != null){
		if(count == 0){
			stmt = stmt + "username=" + "\""+update_username+"\"";
			stmt1 = stmt1 + "username=" + "\""+update_username+"\"";
		}
		else{
			stmt = stmt + ", username=" + "\""+update_username+"\"";
			stmt1 = stmt1 + "and username=" + "\""+update_username+"\"";
			
		}
		
		count+=1;
	}
	
	
	if(password != null){
		if(count == 0){
			stmt = stmt + "password=" + "\""+password+"\"";
			stmt1 = stmt1 + "password=" + "\""+password+"\"";
		}
		else{
			stmt = stmt + ", password=" + "\""+password+"\"";
			stmt1 = stmt1 + "and password=" + "\""+password+"\"";
		}
		
		count+=1;
	}
	
	if(name != null){
		if(count == 0){
			stmt = stmt + "name=" + "\""+name+"\"";
			stmt1 = stmt1 + "name=" + "\""+name+"\"";
		}
		else{
			stmt = stmt + ", name=" + "\""+name+"\"";
			stmt1 = stmt1 + "and name=" + "\""+name+"\"";
		}
		
		count+=1;
	}
	
	if(email != null){
		if(count == 0){
			stmt = stmt + "email=" + "\""+email+"\"";
			stmt1 = stmt1 + "email=" + "\""+email+"\"";
		}
		else{
			stmt = stmt + ", email=" + "\""+email+"\"";
			stmt1 = stmt1 + "and email=" + "\""+email+"\"";
		}
		
		count+=1;
	}
	
	stmt = stmt + " where username=" + "\""+username+"\"";
	
    ResultSet rs = null; 
	
	PreparedStatement st = con.prepareStatement(stmt);
	
	int rows = con.createStatement().executeUpdate(stmt);
	
	writer.println("<h2>Account updated</h2>");
	//Create a query and table for similar items
	
}
catch(Exception e){      
   out.println("ERROR:" + e);  
}      
%>
</body>
</html>