<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer Rep Account Manage</title>
</head>
<body style="background-color:AntiqueWhite">
<%
    try{
    	    	
    	ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	
    	
    	String submit_type = request.getParameter("submitBtn");
    	String username = request.getParameter("user");
    	String email = request.getParameter("email");   
        String password = request.getParameter("password"); 
        String name = request.getParameter("name");
        //java.util.Date dob = new java.util.Date();
        
       
        
         
         
	        ResultSet rs = null;
	        PreparedStatement email_st = con.prepareStatement("Select username from customer_rep where username=\""+username+"\"");
	        rs = email_st.executeQuery();
	    	        
	        if (rs.isBeforeFirst()) {
	            out.print("Username already exists!");
	        }
	        else
	        {
	        	
	        	try {
	        	    
		        	String str = "INSERT INTO customer_rep (username,password,name,email) values(" + "\""+username+"\""+ "," + "\""+password+"\"" + "," + "\""+name+"\"" + "," + "\""+email+"\"" + ")";
		        	out.print(str);
		            Statement stmt = con.createStatement();
		            int rows = stmt.executeUpdate(str);
		            response.setStatus(301);
		         	response.setHeader("Location", "CustomerRepHomePage.jsp");
		         	response.setHeader("Connection", "close");
	        	}
	        	catch (Exception e) {
	        	      out.print("Error creating account.");
	        	    }
	        }
        
   }
   catch(Exception e){      
       out.println("ERROR:" + e);       
   }      
%>

</body>
</html>