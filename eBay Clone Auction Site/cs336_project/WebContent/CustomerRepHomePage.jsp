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
<h2>Customer Representative Options</h2>

<form>
<label for="createAcc">New Account: </label>
<input type="submit" name="submitBtn" value="Register" formaction="CustomerRepCreate.jsp"/>
</form>
<br>

<form>
<label for="createAcc">Reply to Questions: </label>
<input type="submit" name="submitBtn" value="Questions" formaction="SelectQuestionToReply.jsp"/>
</form>
<br>

<form>
<label for="createAcc">Manage Account: </label>
<input type="submit" name="submitBtn" value="Edit Account" formaction="EditAccount.jsp"/>
<input type="submit" name="submitBtn" value="Delete Account" formaction="DeleteAccount.jsp"/>
</form>
<br>

<form>
<label for="createAcc">Remove: </label>
<input type="submit" name="submitBtn" value="Bids" formaction="RemoveBids.jsp"/>
<input type="submit" name="submitBtn" value="Auctions" formaction="RemoveAuction.jsp"/>
</form>
<br>

<form id="loginForm" action="Login.jsp">
<input type="submit" name="submitBtn" value="Logout"/>
</form>

</body>
</html>