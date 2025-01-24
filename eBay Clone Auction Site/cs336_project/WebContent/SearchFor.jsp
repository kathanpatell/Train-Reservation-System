<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Search Filters</title>

<script>
function validateColor(){
	if(document.getElementById("colorBox").checked){
		document.getElementById("ColorText").disabled = false;
	}
	else{
		document.getElementById("ColorText").disabled = true;
	}
}

function validateModel(){
	if(document.getElementById("modelBox").checked){
		document.getElementById("ModelText").disabled = false;
	}
	else{
		document.getElementById("ModelText").disabled = true;
	}
}

function validateBrand(){
	if(document.getElementById("brandBox").checked){
		document.getElementById("BrandText").disabled = false;
	}
	else{
		document.getElementById("BrandText").disabled = true;
	}
}

function validateItem(){
	if(document.getElementById("itemBox").checked){
		document.getElementById("ItemText").disabled = false;
	}
	else{
		document.getElementById("ItemText").disabled = true;
	}
}

function validateTitle(){
	if(document.getElementById("titleBox").checked){
		document.getElementById("TitleText").disabled = false;
	}
	else{
		document.getElementById("TitleText").disabled = true;
	}
}

function checkAllBoxes(){
	if(!document.getElementById("titleBox").checked && !document.getElementById("itemBox").checked && !document.getElementById("brandBox").checked && !document.getElementById("modelBox").checked && !document.getElementById("colorBox").checked){
		alert("Select at least one search filter");
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

<h2>Select filter type and add values</h2>

<form action="SearchCriteria.jsp" onsubmit="return checkAllBoxes()">

  <input type="checkbox" id="colorBox" name="ColorBox" value="color" onClick="validateColor()">
  <label for="ColorBox">Color:</label>
  <input type="text" id="ColorText" name="colortext" disabled required/><br><br>
  
  <input type="checkbox" id="modelBox" name="ModelBox" value="model_num" onClick="validateModel()">
  <label for="ModelBox">Model Number: </label>
  <input type="text" id="ModelText" name="modeltext" disabled required/><br><br>
  
  <input type="checkbox" id="brandBox" name="BrandBox" value="brand" onClick="validateBrand()">
  <label for="BrandBox">Brand: </label>
  <input type="text" id="BrandText" name="brandtext" disabled required/><br><br>
  
  <input type="checkbox" id="itemBox" name="ItemBox" value="item_id" onClick="validateItem()">
  <label for="itemBox">Item ID: </label>
  <input type="text" id="ItemText" name="itemtext" disabled required/><br><br>
  
  <input type="checkbox" id="titleBox" name="TitleBox" value="title" onClick="validateTitle()">
  <label for="TitleBox">Title: </label>
  <input type="text" id="TitleText"  name="titletext" disabled required/><br>
  <br>
  
  <input type="submit" value="Apply Filter"><br><br>
</form>

<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
</form>

</body>
</html>