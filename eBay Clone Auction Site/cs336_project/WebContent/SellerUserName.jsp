<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search seller</title>
</head>
<body style="background-color:AntiqueWhite">
<h2>Enter user name of the seller to search</h2>

<form action="SearchSellerUserName.jsp">
  <label>Enter seller user name: </label>
  <input type="text" id="usernameText" name="userNameText" required><br><br>
  <input type="submit" name="UserName" value="Search Seller"/>
</form><br><br>

<form id="goBack" action="Seller.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>
</body>
</html>