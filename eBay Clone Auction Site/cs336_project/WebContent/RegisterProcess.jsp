<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*, java.text.*, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register Process</title>
</head>
<body>
<
<%@ page import ="java.sql.*" %>
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
        
        String dob = request.getParameter("dob");
        String phone = request.getParameter("phone");
        String addr = request.getParameter("address");
        
        // check if any of them are missing
        if (submit_type.isEmpty() || username.isEmpty() || email.isEmpty() || password.isEmpty() || name.isEmpty() || dob.isEmpty() ||
        	phone.isEmpty() || addr.isEmpty())
        {
        	out.print("Please complete all of the fields.");
    	}
        
         
        else {
	        ResultSet rs = null;
	        PreparedStatement email_st = con.prepareStatement("Select username from user_account where username=\""+username+"\"");
	        rs = email_st.executeQuery();
	    	        
	        if (rs.isBeforeFirst()) {
	            out.print("Username already exists!");
	        }
	        else
	        {
	        	
	        	try {
	        	    
		        	String str = "INSERT INTO user_account (username,password,name,phone,dob,address,email) values('"+username+"','"+password+"','"+name+"','"+phone+"','"+dob+"','"+addr+"','"+email+"')";
		            Statement stmt = con.createStatement();
		            int rows = stmt.executeUpdate(str);
		            response.setStatus(301);
		         	response.setHeader("Location", "Login.jsp");
		         	response.setHeader("Connection", "close");
	        	}
	        	catch (Exception e) {
	        	      out.print("Error creating account.");
	        	    }
	        }
        
        }
   }
   catch(Exception e){      
       out.println("ERROR:" + e);       
   }      
	%>
</body>
</html>