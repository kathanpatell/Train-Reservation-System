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
<h2>Admin Options</h2>

<form id="adminFunc">
<label for="adminFunc">Sales Earning: </label>
<button type="submit" name="totalSales" formaction="TotalEarnings.jsp">Total Earnings</button>
</form>
<br>

<form id="salesGen">
<label for="salesGen">Sales Earning per: </label>
<button type="submit" name="totalSales" formaction="EarningPerItem.jsp">Item</button>
<button type="submit" name="totalSales" formaction="EarningPerType.jsp">Item Type</button>
<button type="submit" name="totalSales" formaction="EarningPerUser.jsp">User</button>
</form>
<br>

<form id="best">
<label for="best">Get: </label>
<button type="submit" name="totalSales" formaction="BestSelling.jsp">Best Selling Item</button>
<button type="submit" name="totalSales" formaction="BestBuyer.jsp">Best Buyer</button>
</form>
<br>

<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>
</body>
</html>