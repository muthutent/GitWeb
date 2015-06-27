
<%@page import="com.cdc.spring.bean.UserBean"%>
<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@ page language="java" import="common.utils.*, java.util.*,java.sql.*"%>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/sheet-jsp.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/colorbox.css">
<title>Import Address</title>
<style type="text/css">
div#top {
	position: fixed;
	width: 100%;
	background: white;
	border-bottom: 1px gray solid;
	left: 0;
	top: 0;
}
#top input {
float: right;
padding: 4px;
}
#clear{
clear: both;
padding-bottom: 20px;
}
.even {
background: #F0F5FB;
}

</style>
</head>
<%
	double rand = Math.random();
%>
<body>
	<div id="top">
		<input type="image" id="hidePopup" src="<%=request.getContextPath()%>/images/buttons/button_add.gif" onClick="addEmails()" />
	</div>
	<div id="clear"></div>
	<table class="black11px" border="1" style="border-collapse:collapse;">
		<thead class="lightblue12px">
			<tr>
				<td>All&nbsp;<input type="checkbox" id="checkAll" name="printalljobs" onClick="selectAll(this)"></td>
				<td>Contact Name</td>
				<td>Company Name</td>
				<td>Email Address</td>
			</tr>
		</thead>
		<tbody>
			<%
				try {
					UserBean userBean = null;
					ApplicationContext ac = null;
					ac = ApplicationConfig.getApplicationContext(request);
					userBean = (UserBean) ac.getBean("userBean");
					
					String sessionLoginId = userBean.getLoginId();
					AddressBookUtil abu = new AddressBookUtil();
					List addressBook = abu.getAddressBook(sessionLoginId);
					
					int count=0;
					Iterator abItr = addressBook.iterator();
					while(abItr.hasNext()){
					List ab = (List) abItr.next();
					
					String trClass="odd";
					if(count%2==0) trClass="even";

			%>
			<tr class="<%=trClass%>">
				<td><input type="checkbox" name="printjobs" value="ime<%=count%>" id="ime<%=count%>" class="ime<%=count%>"></td>
				
				
				<!--- Contact Name--->
				<td> <%
					if (ab.get(0) != null && !String.valueOf(ab.get(0)).trim().equals("") ) {
						out.println(ab.get(0));
					}
					%>
				
				</td>
				<!--- Company Name--->
				<td> <%
					if (ab.get(1) != null && !String.valueOf(ab.get(1)).trim().equals("")) {
						out.println(ab.get(1));
					}
					%>
				
				</td>
				
				<!--- Email --->
				<td> <%
					if (ab.get(2) != null && !String.valueOf(ab.get(2)).trim().equals("")) {
						out.println(ab.get(2)); %> <input type="hidden" name="emailId" value="<%=ab.get(2)%>"><%
					}
					else{
					%>
					<input type="hidden" name="emailId" value="">
					<%
					}
					%>
				
				</td>
			</tr>
			<%
				count++;
				} // End of while
			}
			catch(Exception ex){
				System.out.println("Exception in importAddress.jsp : "+ex.getMessage());
			}
			%>
			
		</tbody>
	</table>

</body>

<script>
/* We can use this variable in js files to get contextPath in js */
var contextPath = '<%=request.getContextPath()%>'; 
</script>

<script src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/Javascript_template.js"></script>
<script src="<%=request.getContextPath()%>/js/JSScripts/global.js?r=<%=rand%>" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/jquery.colorbox.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.widget.js"></script>
<script type="text/javascript"src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.position.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/jstorage.js"></script>

<script type="text/javascript">

//The Following Script will retain the checkbox state. Added by Muthu on 02/26/13	
		
$(document).ready(function(){

		
		//Iterate the cookie to set the Checkbox state. Added by Muthu on 02/26/13
		preserveJobsChkState();
		
	
		
	}); // END OF DOCUMENT READY FUNCITON.	

</script>
<script type="text/javascript">
	function checkAll() {

		var check = document.getElementsByName("printjobs");
		var checkAll = document.getElementById("checkAll");
		if (checkAll.checked == true) {
			for (var i = 0; i < check.length; i++) {
				check[i].checked = true;
			}
		} else {
			for (var i = 0; i < check.length; i++) {
				check[i].checked = false;
			}
		}

	}

	// addEmails function is to add all the selected email ids along with the email ids present in the TO field in Email Projects Details page 
	function addEmails() {
		var check = document.getElementsByName("printjobs");
		var email = document.getElementsByName("emailId");
		var presentEmails = parent.jQuery("#toAddress").val();
		var presentEmailsArray = presentEmails.split(",");
		var selectedEmails = "";
		for (var i = 0; i < check.length; i++) {
			if (check[i].checked == true) {
				if (email[i].value != null && email[i].value != "") {
					var present = false;
					for (var j = 0; j < presentEmailsArray.length; j++) {
						if(presentEmailsArray[j] == email[i].value) {
							present = true;
						}
					}
					if(present == false) {
						selectedEmails = selectedEmails + email[i].value + ',';
					}
				}
			} else {
				if (email[i].value != null && email[i].value != "") {
					for (var j = 0; j < presentEmailsArray.length; j++) {
						if(presentEmailsArray[j] == email[i].value) {
							if(j == presentEmailsArray.length-1) {
								presentEmails = presentEmails.replace(presentEmailsArray[j], "");
							} else {
								presentEmails = presentEmails.replace(presentEmailsArray[j]+",", "");
							}
						}
					}
				}
			}
		} //END of For loop
		
		if (presentEmails != null && presentEmails != "") {
			var semicolon = presentEmails.substr(presentEmails.length - 1);
			if (semicolon == ',') {
				selectedEmails = presentEmails + selectedEmails;
			} else {
				selectedEmails = presentEmails + "," + selectedEmails;
			}
		}
		
		/*for (var i = 0; i < check.length; i++) {
			if (check[i].checked == true) {
				if (email[i].value != null && email[i].value != "") {
					selectedEmails = selectedEmails + email[i].value + ',';
				}
			}
		}*/
		selectedEmails = selectedEmails.substring(0, selectedEmails.length - 1);
		parent.jQuery("#toAddress").val(selectedEmails); //Populates the value of TO field in Email Project Details page.

		parent.jQuery.colorbox.close();
	}
</script>
</html>