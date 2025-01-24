<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Auction</title>

</head>
<body style="background-color:AntiqueWhite">
<h1>Registration</h1>


<form name="itemInfo" action="CreateAuctionProcess.jsp" id="auctionForm"  method="post" >  
<b>Item Specifications</b>
<br>
<div id="title">Item Name: <input required type="text" name="title" placeholder="a short name for the item"/></div>
Item Type:
<select id="electronicType" name="electronicType">
    <option value="phone" value="phone">Phone</option>
    <option value="tv" value="tv">Television</option>
    <option value="headphones" value="headphones">Headphones</option>
</select>

<div id="model">Model Number: <input required type="text" name="model_num" placeholder="look at company's website to find the model number"/></div>
<div id="brand">Brand/Company:<input required type="text" name="brand"/></div>
<div id="color">Color:<input required type="text" name="color"/></div>

<br>If your item is a <b>phone:</b><br>
<div id="storage">Storage Capacity (GB): <input type="number" name="storage" min="0"/><br/><br/></div>
<div id="carrier">Phone Carrier: <input type="text" name="carrier" placeholder="ex: AT&T, Verizon, etc"/></div>


<br>If your item is a <b>television:</b><br>
<div id="screen">Screen Size: <input type="text" name="screen" placeholder="must be in the form: length x width"/></div>
<div id="resolution">Resolution: <input type="text" name="resolution" placeholder="must be in the form: pixels x pixels"/><br/><br/></div>

<br>If your item is <b>headphones:</b><br>
Connectivity Type:
<div>
<div><input type="radio" id=wired name="connectivity" value="wired"/>
  <label for="wired">Wired</label></div>
<div><input type="radio" id=wireless name="connectivity" value="wireless"/>  
<label for="wireless">Wireless</label></div>

<br>Is it noise cancelling?
<div>
<div><input type="radio" id=cancelling name="noiseCancelling" value="Yes"/>
<label for="cancelling">Yes</label></div>
<div><input type="radio" id=notCancelling name="noiseCancelling" value="No"/>
<label for="notCancelling">No</label></div>

<br><b>Auction Specifications</b><br>
Auction Start Date & Time:<input required type="datetime-local" name="start" placeholder="yyyy-MM-dd HH:mm:ss"/>
<div id="end">Auction End Date & Time:<input required type="datetime-local" name="end" placeholder="yyyy-MM-dd HH:mm:ss"/></div>
<div id="initial">Starting Price: <input required type="number" step="0.01" min="0.01" name="initial"/> </div>
<div id="reserve">Secret Minimum Price (optional): <input type="number" step="0.01" min="0.01" name="reserve"/> </div>
<div id="inc">Minimum Bid Increment: <input required type="number" step="0.01" min="0.01" name="inc"/> </div>
</textarea><br/><br/></div>

<input type="submit" name="submitAuction" id="AuctionBtn" value="Create Auction"/> 
</form>
<br>
<br>
<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>


