<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.io.PrintWriter, java.util.*, java.text.*, java.util.Date, java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sort By</title>
</head>
<body style="background-color:AntiqueWhite">
<h2>Select a sorting option</h2>
<form action="Sort.jsp">
  <label for="sortBy">Sort by:</label>
  <select name="sortBy" id="sortByOptions">
    <option value="brand">Brand</option>
    <option value="title">Title</option>
    <option value="model_num">Model Number</option>
    <option value="item_id">Item ID</option>
    <option value="start">Start Date and time</option>
    <option value="end">End Date and time</option>
    <option value="color">Color</option>
    <option value="curr_value">Current Bidding Value</option>
  </select>
  <br><br>
  <input type="submit" value="Sort">
</form>
<br><br>
<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
</body>
</html>