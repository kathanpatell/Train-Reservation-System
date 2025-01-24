<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction</title>
</head>
<body style="background-color:AntiqueWhite">
<h1>Welcome to the AUCTION application!</h1>
<h2>Please select whether you'd like to proceed as a buyer or seller.</h2>

<form id="userType">
<label for="usertType">Select user type: </label>
<button type="submit" name="buyerBtn" formaction="Buyer.jsp">Buyer</button>
<button type="submit" name="sellerBtn" formaction="Seller.jsp">Seller</button>
</form>
<br>
<form id="searchFunctions">
<label for="searchFunctions">Search Functions: </label>
<button type="submit" name="allSearch" formaction="SearchAll.jsp">Search All</button>
<button type="submit" name="searchBy" formaction="SearchBy.jsp">Sort Filters</button>
<button type="submit" name="searchFor" formaction="SearchFor.jsp">Search Filters</button>
</form>
<br>
<form id="userFunctions">
<label for="userFunctions">User Functions: </label>
<button type="submit" name="bidHistory" formaction="BidHistory.jsp">Bid History</button>
</form>

<br>
<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>
</body>
</html>