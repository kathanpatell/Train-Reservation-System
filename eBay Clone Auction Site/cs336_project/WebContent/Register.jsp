<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
</head>
<body style="background-color:AntiqueWhite">
<h1>Registration</h1>

<form name="form" action="RegisterProcess.jsp" id="registerForm"  method="post" onsubmit="return validRegister();">  
Username: <input required type="text" name="user"/><br/><br/>  
<div id="pw">Password: <input required type="text" name="password"/><br/><br/> </div>
<div id="na">Name: <input required type="text" name="name"/><br/><br/> </div>
<div id="em">Email: <input required type="email" name="email"/><br/><br/> </div>
Date of Birth: <input required type="date" name="dob" placeholder="yyyy-mm-dd"/><br/><br/>
<div id="ph">Phone: <input required type="tel" name="phone"/><br/><br/> </div>
<div>Address: <textarea required rows="4"  placeholder="Enter Address here"cols="50" name="address" form="registerForm">
</textarea><br/><br/></div>

<input type="submit" name="submitBtn" id="registerBtn" value="Register"/> 
</form>

<br>
<form id="goBack" action="Login.jsp">
<input type="submit" name="goBack" value="Cancel"/>
</form>
</body>
</html>