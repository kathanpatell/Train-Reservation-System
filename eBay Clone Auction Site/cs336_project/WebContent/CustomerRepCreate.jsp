<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register New Customer Representative</title>
</head>
<body style="background-color:AntiqueWhite">

<h2>Create New Customer Representative</h2>
<form name="form" action="CustomerRepAccCreate.jsp" id="registerForm"  method="post" onsubmit="return validRegister();">  
Username: <input required type="text" name="user"/><br/><br/>  
<div id="pw">Password: <input required type="text" name="password"/><br/><br/> </div>
<div id="na">Name: <input required type="text" name="name"/><br/><br/> </div>
<div id="em">Email: <input required type="email" name="email"/><br/><br/> </div>

<input type="submit" name="submitBtn" id="registerBtn" value="Register"/> 
</form>

<br>
<form id="goBack" action="CustomerRepHomePage.jsp">
<input type="submit" name="goBack" value="Cancel"/>
</form>
</body>
</html>