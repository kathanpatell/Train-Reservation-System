<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>

<style>
h1 {text-align: center;}
form {text-align: center;}
#pw{text-align: center;}
#person_type{display: inline;}
#ADMIN{text-align: center;}
#user{text-align: center;}
</style>


<meta charset="ISO-8859-1">
<title>Questions</title>
</head>
<body style="background-color:AntiqueWhite">
	
<h1>Submit a new question:</h1>

<form action="QuestionsHandle.jsp" method="post">
	<div>Question: <textarea required rows="4"  placeholder="Enter your question"cols="50" name="question">
	</textarea><br/><br/></div>
	<input type="submit" value="Submit">					
</form>	

<br><br>

<form id="loginForm" action="Login.jsp"></form>

<form id="goBack" action="FAQ.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
<br>

<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>