<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Logging in.</title>
</head>
<script>

</script>
<body>
	<%@ page import ="java.sql.*" %>
	<%
    try{
    	ApplicationDB db = new ApplicationDB();
    	Connection con = db.getConnection();
    	
    	String submit_type = request.getParameter("submitBtn");
    	String role = request.getParameter("role");
    	String username = request.getParameter("user");   
        String password = request.getParameter("password");   
        ResultSet rs = null;
    	System.out.println(role);

    	if(submit_type.equals("Register")){
        	response.setStatus(301);
         	response.setHeader("Location", "Register.jsp");
         	response.setHeader("Connection", "close");
        }
    	
    	 // if no role clicked
    	 else if (role == null ){
            out.println("Please pick an account role.");

        }
        
     	
        else{  
        	        
	        if(role.equals("user") && submit_type.equals("Login")){
	            PreparedStatement pst = con.prepareStatement("Select username,password from user_account where username=? and password=?");
	            pst.setString(1, username);
	            pst.setString(2, password);
	            rs = pst.executeQuery();
	    	}
	    	else if(role.equals("admin")){
	            PreparedStatement pst = con.prepareStatement("Select username,password from admin where username=? and password=?");
	            pst.setString(1, username);
	            pst.setString(2, password);
	            rs = pst.executeQuery();
	    	}
	    	else if(role.equals("customerRep")){
	            PreparedStatement pst = con.prepareStatement("Select username,password from customer_rep where username=? and password=?");
	            pst.setString(1, username);
	            pst.setString(2, password);
	            rs = pst.executeQuery();
	    	}
	     
	 
	        if(rs != null && rs.next()){         
	           	out.println("Valid login credentials");
	        	response.setStatus(301);
	        	if (role.equals("user")){
		        	response.setHeader("Location", "UserHomePage.jsp");
			     	// set username attribute it for user
			    	session.setAttribute("user",username);   
	        	}
	        	else if (role.equals("admin")){
	        		response.setHeader("Location", "AdminHomePage.jsp");
	        		session.setAttribute("admin",username);
	        	}
	        	else{
	        		response.setHeader("Location", "CustomerRepHomePage.jsp");
	        		session.setAttribute("customerRep",username);
	        	}
	        		
	        	response.setHeader("Connection", "close");
	    	}
	  
	        else
	           out.println("Invalid login credentials");     
        }
   }
   catch(Exception e){      
       out.println("ERROR:" + e);       
   }      
	%>
</body>
</html>