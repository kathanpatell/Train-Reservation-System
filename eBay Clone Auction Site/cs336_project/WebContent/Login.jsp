<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction Page Login</title>

<style>
h1 {text-align: center;}
form {text-align: center;}
#pw{text-align: center;}
#person_type{display: inline;}
#ADMIN{text-align: center;}
#user{text-align: center;}
</style>

<script>
function formFunction() {
  document.getElementById("loginForm").submit();
}

function resetFields(){
	document.getElementById("User").checked = false;
}

function disableRegister(){
	document.getElementById("registerBtn").disabled = true;
}

function enableRegister(){
	document.getElementById("registerBtn").disabled = false;
}

function goTo(){
	window.location = "LoginProcess.jsp";
}

function validLogin(){
	if (document.form.email.value == ""){
	alert ( "Please enter username." );
	//document.loginform.email.focus();
	return false;
	}
	if (document.form.password.value == ""){
	alert ( "Please enter password." );
	//document.userform.password.focus();
	return false;
	}
	if(document.getElementById("User").checked == false && document.getElementById("Admin").checked == false && document.getElementById("CustomerRep").checked == false){
		alert("Please select a role.");
		return false;
	}
}
</script>

</head>

<body style="background-color:AntiqueWhite">

		<h1>Welcome to the Auction Page!</h1>
		
	<br>
		<%  
			String profile_msg=(String)request.getAttribute("profile_msg");  
			if(profile_msg!=null){  
				out.print(profile_msg);
			}  
			String login_msg=(String)request.getAttribute("login_msg");  
			if(login_msg!=null){  
				out.print(login_msg);  
			}  
 		%>  
 	<br/>  
 	
<form name="form" action="LoginProcess.jsp" id="loginForm"  method="post" onsubmit="return validLogin();">  
Username: <input type="text" name="user"/><br/><br/>  
<div id="pw">Password: <input type="password" name="password"/><br/><br/> </div>

<ul id="person_type" >
  <li>
  	<div id="user"><input type="radio" id="User" name="role" value="user" onclick="enableRegister()" >
	<label for="User">User</label></div><br>
  </li>

  <li>
    <div id="CRep"><input type="radio" id="CustomerRep" name="role" value="customerRep" onclick="disableRegister()">
	<label for="CustomerRep">Customer Representative</label></div><br>
  </li>
  
  <li>
    <div id="ADMIN"><input type="radio" id="Admin" name="role" value="admin" onclick="disableRegister()">
	<label for="Admin">Admin</label></div><br>
  </li>
</ul>  
<input type="submit" name="submitBtn" value="Login"/>
<input type="submit" name="submitBtn" id="registerBtn" value="Register"/> 
<!-- <input type="reset" value="Reset" onclick="enableRegister()"/> -->
</form>  


<br><br><br><br><br><br><br>
<div id="footer"><p>Group 52 - Priya Parikh, Ryan Davis, Malav Doshi, Kathan Patel </p></div>




</body>
</html>