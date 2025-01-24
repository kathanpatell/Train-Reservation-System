<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Edit Account</title>

<script>
function validateUser(){
	if(document.getElementById("usernameBox").checked){
		document.getElementById("userNameText").disabled = false;
	}
	else{
		document.getElementById("userNameText").disabled = true;
	}
}

function validatePass(){
	if(document.getElementById("passBox").checked){
		document.getElementById("passText").disabled = false;
	}
	else{
		document.getElementById("passText").disabled = true;
	}
}

function validateName(){
	if(document.getElementById("nameBox").checked){
		document.getElementById("NameText").disabled = false;
	}
	else{
		document.getElementById("NameText").disabled = true;
	}
}

function validateEmail(){
	if(document.getElementById("emailBox").checked){
		document.getElementById("EmailText").disabled = false;
	}
	else{
		document.getElementById("EmailText").disabled = true;
	}
}


function checkAllBoxes(){
	if(!document.getElementById("usernameBox").checked && !document.getElementById("passBox").checked && !document.getElementById("nameBox").checked && !document.getElementById("emailBox").checked){
		alert("Select at least one item to update");
		return false;
	}
	return true;
	/*document.getElementById("titleBox").checked
	document.getElementById("itemBox").checked
	document.getElementById("brandBox").checked
	document.getElementById("modelBox").checked
	document.getElementById("colorBox").checked*/
}
</script>
</head>
<body style="background-color:AntiqueWhite">

<h2>Update Page</h2>

<form action="EditAccountProcess.jsp" onsubmit="return checkAllBoxes()">

  <input type="checkbox" id="usernameBox" name="UserNameBox" value="username" onClick="validateUser()">
  <label for="UserBox">Username:</label>
  <input type="text" id="userNameText" name="usertext" disabled required/><br><br>
  
  <input type="checkbox" id="passBox" name="PasswordBox" value="password" onClick="validatePass()">
  <label for="passBox">Password: </label>
  <input type="text" id="passText" name="passtext" disabled required/><br><br>
  
  <input type="checkbox" id="nameBox" name="NameBox" value="name" onClick="validateName()">
  <label for="nameBox">Name: </label>
  <input type="text" id="NameText" name="nametext" disabled required/><br><br>
  
  <input type="checkbox" id="emailBox" name="EmailBox" value="email" onClick="validateEmail()">
  <label for="emailBox">Email: </label>
  <input type="text" id="EmailText" name="emailtext" disabled required/><br><br>
  
  <br>
  
  <input type="submit" value="Update"><br><br>
</form>

<br><br>
<form id="goBack" action="CustomerRepHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>