<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

<script>
function mySearch() {
    var keyword, filter, dl, dt, a, val
    keyword = document.getElementById("keywords")
    filter = keyword.value.toUpperCase()
    dl = document.getElementById("mylist")
    dt = dl.getElementsByTagName("dt")
    for (var i = 0; i < dt.length; i++) {
        a = dt[i].getElementsByTagName("a")[0]
        val = a.textContent || a.innerText
        if (val.toUpperCase().indexOf(filter) > -1) {
            dt[i].style.display = ""
        } else {
            dt[i].style.display = "none"
        }
    }
}
</script>

<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="background-color:AntiqueWhite">
<h1>FREQUENTLY ASKED QUESTIONS</h1>
<p style="color:black;font-size:18px;">1.What is the difference between manual and automatic bids?</p> 
<p style="color:black;font-size:18px;">Answer: Manual bids do not have a fixed increment while automatic bids will have automatic increment and also a hidden upper limit.</p> 
<p style="color:black;font-size:18px;">2.What is an upper limit?</p>
<p style="color:black;font-size:18px;">Answer: An upper limit is a fixed value which is unknown to the user at which the automatic increment stops.</p>  
<p style="color:black;font-size:18px;">3.How do filters work?</p>
<p style="color:black;font-size:18px;">Answer:  User/buyer can select the filter that is the products or other specifications that they are looking for, this is to create a much better and convenient user experience. The user should therefore select at least one filter.</p>  
<p style="color:black;font-size:18px;">4.How fast do questions get answered?</p>
<p style="color:black;font-size:18px;">Answer:  Each question is looked at by a customer representative, to provide the most precise answers, the customer representatives work their best to answer your questions as fast as they can.</p>
<form id="goBack" action="UserHomePage.jsp">
<input type="submit" name="goBack" value="Go Back"/>
<p style="color:black;font-size:18px;">Have more questions? Ask our customer representatives!</p>
<button type="submit" name="Questions" formaction="Questions.jsp">Ask a question</button>
</form>  
<br>

<div id="keywordsdiv">

<input type="text" id="keywords"  placeholder="Search using Keywords" onkeyup="mySearch()" size =155>
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</div>
<div id = "faq" >
<dl id="mylist">
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 1-Can I cancel my purchase? <br>-Yes you can cancel your purchase.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a>2-How to make a bid? <br>-You can use our web-site to make a bid, you can either select an automatic or a manual bid.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 3-What is the difference between an automatic and manual bids? <br>Manual bids do not have a fixed increment while automatic bids will have automatic increment and also a hidden upper limit</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 4- Are there any discounts?<br>-Since this is an auction, there are no discounts, the user pays what he feels is worth for the product.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 5-Can I see the purchases made by other users? <br>-No, that information is confidential to the admin and the parties involved in the transaction.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 6-What is an upper limit? <br>-An upper limit is a fixed value which is unknown to the user at which the automatic increment stops.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 7-How can I contact customer representative? <br>-You can contact customer representative by sending a question using the website.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 8-How do filters work? <br>- User/buyer can select the filter that is the products or other specifications that they are looking for, this is to create a much better and convenient user experience. The user should therefore select at least one filter.</a></dt>
<dt style ="  padding-top: 10px; padding-bottom:10px" ><a> 9-How fast do questions get answered? <br>-Each question is looked at by a customer representative, to provide the most precise answers, the customer representatives work their best to answer your questions as fast as they can.</a></dt>


</dl>

</div>



</body>
</html>