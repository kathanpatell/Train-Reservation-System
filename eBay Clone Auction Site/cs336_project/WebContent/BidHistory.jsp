<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bid History</title>
</head>
<body style="background-color:AntiqueWhite">

<h2>Get Bid History by Item ID</h2>

<form action="GetBidHistory.jsp">
  <label for="sortBy">Item ID:</label>
  <input type="text" id="idText" name="itemIdText"/>
  <br><br>
  <input type="submit" value="Get History">
</form>


</body>
</html>