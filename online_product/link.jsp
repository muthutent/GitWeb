 <%
/* 
	Copyright 2001-15 Creatus Inc.,
   	2328 Walsh Avenue, Suite G, Santa Clara, CA 95051, U.S.A.
 	 All rights reserved.

   This software is the confidential and proprietary information
   of Creatus Inc. ("Confidential Information").  You shall not disclose
   such Confidential Information and shall use it only in accordance
   the terms of the license agreement you entered into with
   Creatus Inc.

   Company        : Creatus Inc.
   Author         : Creatus
   Date Created   : 03/10/2015
   Last Modified  : 03/10/2015
   Modifier       : Selva 
   Description    :  
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<html>
<head>
<title>Keyword Search</title>
	<meta http-equiv="pragma" content="no-cache">
    	<meta http-equiv="cache-control" content="no-cache">
    	<meta http-equiv="expires" content="1">
    	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    	<meta http-equiv="description" content="This is my page">
    	 <link rel="stylesheet" type="text/css" href="css/sheet.css">
		 

		 <style type="text/css">


/* extra rules for even and odd rows */
.even {
	background:	#F0F5FB;
}

.odd {

}

</style>
	    <script type="text/javascript" src="JSScripts/sortabletable.js"></script>
<!-- add sort type for sorting NumberK types -->
<script type="text/javascript" src="JSScripts/numberksorttype.js"umberksorttype.js"></script>
<script type="text/javascript" src="JSScripts/uscurrencysorttype.js"></script>
		<script type="text/javascript" src="JSScripts/Javascript_template.js"></script>
        
       <link type="text/css" rel="StyleSheet" href="css/sortabletable.css"ortabletable.css" />
	   
	   <script language="JavaScript">
<!--
function SubmitForm()
{
	document.mainform.action="savedSearchResults.jsp";
	document.mainform.method="post";
	document.mainform.target="_self";
	document.mainform.submit();
}
function call_PE(cid)
{
	var myhref= "online_product/plans_check.cfm?cdcid="+cid+"";
	
	//force close window itself by calling wait.html, because plans_check reloacated to iSqft page, access denied error occurs at next attempt//
					var mywindow4 = window.open('online_product/wait.html', 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	var mywindow4 = window.open(myhref, 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	mywindow4.moveTo(0,0);
	mywindow4.focus();

}


function call_CProjects(cid)
{
	var myhref= "online_product/plans_check_cprojects.cfm?cdcid="+cid+"";
	
	//force close window itself by calling wait.html, because plans_check reloacated to iSqft page, access denied error occurs at next attempt//
	var mywindow4 = window.open('online_product/wait.html', 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	var mywindow4 = window.open(myhref, 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	mywindow4.moveTo(0,0);
	mywindow4.focus();

}

function call_Ldi(cid)
{
					
					
					//alert("cid"+cid);
	var myhref= "online_product/plans_check_ldi.cfm?cdcid="+cid+"";
	
	//force close window itself by calling wait.html, because plans_check reloacated to iSqft page, access denied error occurs at next attempt//
	var mywindow4 = window.open('online_product/wait.html', 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	var mywindow4 = window.open(myhref, 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	mywindow4.moveTo(0,0);
	mywindow4.focus();

}

function call_Napco(cid)
{
	var myhref= "online_product/plans_check_napco.cfm?cdcid="+cid+"";
	
	//force close window itself by calling wait.html, because plans_check reloacated to iSqft page, access denied error occurs at next attempt//
	var mywindow4 = window.open('online_product/wait.html', 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	var mywindow4 = window.open(myhref, 'pewin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=700,height=500');
	mywindow4.moveTo(0,0);
	mywindow4.focus();

}

//-->
</script>	    <script>
	    	<!--
	    
			/*THIS FUNCTION IS FOR CALENDAR FUNCTIONALITY*/
			
			 function call_calendar(job_id,cdc_id,job_name,biddate,bids_details,title)
				{
					
					
					
					
					document.mainform.bidsdetails.value = bids_details; 
					document.mainform.biddate.value = biddate;
					document.mainform.save_job_id.value = job_id; 
					document.mainform.cdc_id.value = cdc_id; 
					document.mainform.title.value = title; 
					document.mainform.action="online_product/project_tracker/calendar_decide.cfm?actionfrom=project_tracker";
					document.mainform.method="post";
					
					//save job in new window
					
						var x = screen.width - 550;
						var y = screen.height - 750;
						var x1 = 530;
						var y1 = 610;
					//alert("bye")
						var mywin = window.open('', 'detailswin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+x1+',height='+y1+'');
						document.mainform.target="detailswin";
						mywin.moveTo(x,y)
						mywin.focus();
					 document.mainform.submit();
				}
				
				
				/*END*/
				
				
				
				/*THIS FUNCTION IS FOR SORTING OF THE VALUES*/
					
			//when button of previous or next is clicked
function sortResults(form,sortby,sortas)
{
	if(sortby == "amount") 
	{
		form.sortby.value = "c.estimated_amount_upper "+sortas+",c.estimated_amount_lower "+sortas;
	}
	else
	{
		form.sortby.value = "c."+sortby+" "+sortas;
	}
	form.CalPage.value = "1";
	form.action="savedSearchResults.jsp";
	form.target="_self";
	form.submit();
}
			
			
			
			/*This is the javascript for Project Tracker save job*/
			function call_savejob(cdcid, pub_id, sec_id, job_title, biddate, bids_details, prebid_mtg, plan_express,id)
{

		
	
	document.mainform.cdcid_savejob.value = cdcid;
	document.mainform.pubid_details.value = pub_id;
	document.mainform.secid_details.value = sec_id;
	document.mainform.job_title.value = job_title;
	document.mainform.biddate_savejob.value = biddate;
	document.mainform.bidsinfo_savejob.value = bids_details;
	document.mainform.prebiddate_savejob.value = prebid_mtg;

	//save job in new window
	
		var x = screen.width - 550;
		var y = screen.height - 750;
	
		var mywin = window.open('', 'sjobwin', 'personalbar=no,toolbar=no,status=yes,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=530,height=400');
		document.mainform.backbutton.value = 0
		document.mainform.target="sjobwin";
		mywin.moveTo(x,y)
		mywin.focus();

					document.mainform.action="online_product/project_tracker/save_job.cfm?cid="+id+"";
	document.mainform.method="post";
	document.mainform.submit();
	

}
			
			
				
			
			/*THIS FUNCTION IS USED FOR PRINTING AJOB */
			
	       	function print_window(id,pubid)
				{
				var mywindow3 = window.open("PrintJob.jsp?cid="+id+"&publid="+pubid, 'printwin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=no,menubar=no,alwaysRaised=yes,width=450,height=400');
				mywindow3.moveTo(0,0);
				mywindow3.focus();

				}
				
				
		   /*THIS FUNCTION IS USED FOR POP UP JAVASCRIPT FOR TIT*/		
	    	function call_details(contentid, flagPT,shortCDC,loginID,savejobid,savejobname)
	    	{
	    		
	    		
	    
	     		//centerlize the window
	    		var screenW = screen.width;
	    		var screenH = screen.height;
	    		var popupW = 520;
	    		var popupH = 460;
	    		var positionX = (screenW-popupW)/2;
	    		var positionY = (screenH-popupH)/2;
	       
	    	        //var mywin = window.open("/icnDetails.do?id="+contentid, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+'');
					var mywin = window.open("details.jsp?cid="+contentid+"&pe="+flagPT+"&cdc="+shortCDC+"&login="+loginID+"&sJobId="+savejobid+"&sJobName="+savejobname, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+',top='+positionY+',left='+positionX+'');
	    		//document.viewForm.target="detailswin";
	    		mywin.focus();
	     //		mywin.moveTo(positionX,positionY);
	    
	    	
	    	}
			/*THIS FUNCTION IS USED FOR POP UP JAVASCRIPT FOR TIT*/		
	    	function call_detailsNew(contentid, flagPT,shortCDC,loginID,savejobid,savejobname)
	    	{
	    		
	    		
	           
	     		//centerlize the window
	    		var screenW = screen.width;
	    		var screenH = screen.height;
	    		var popupW = 520;
	    		var popupH = 460;
	    		var positionX = (screenW-popupW)/2;
	    		var positionY = (screenH-popupH)/2;
	       
	    	        //var mywin = window.open("/icnDetails.do?id="+contentid, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+'');
				//	var mywin = window.open("details.jsp?cid="+contentid+"&pe="+flagPT+"&cdc="+shortCDC+"&login="+loginID, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+',top='+positionY+',left='+positionX+'');
	                //document.mainform.cid.value = contentid;
					/*document.mainform.pe.value = flagPT;
					document.mainform.cdc.value = shortCDC;
					document.mainform.login.value = loginID;		
					document.mainform.backbutton.value = 1;
					document.mainform.target="_self";*/
					document.mainform.action="details.jsp?cid="+contentid+"&pe="+flagPT+"&cdc="+shortCDC+"&login="+loginID+"+&backbutton="+'yes'+"&sJobId="+savejobid+"&sJobName="+savejobname;
					document.mainform.method="post";
					document.mainform.submit();
	    
	    	
	    	}
			function sortPages()
			{
			
			 document.sortFrm.action="savedSearchResults.jsp";
			 document.sortFrm.submit();
			
			
			
			
			
			}
			function validatePages(pages)
			{
			 var page=document.frmPage.next.value;
			 //	alert("Please enter the value between 1 and "+page); 
			   if  (!_CF_checknumber(frmPage.next.value)) 

             {

               alert("Please enter the numbers only")
               frmPage.next.select()
		       frmPage.next.focus()
               return false; 

             }
			 if(page=="")
			 {
				 alert("Enter any value between 1 and "+pages);
	    		 document.frmPage.next.focus();
				 return false;
						 
			 }
			 else if((page>pages) || (page<1))
			 {
			 
 				alert("Please enter the value between 1 and "+pages);
				document.frmPage.next.focus();
				return false;
				 
				
			 }
			    //	alert("Please enter the value between 1 and "+pages);
			 else
			 {
			 
			 document.frmPage.action="savedSearchResults.jsp";
			 document.frmPage.submit();
			 return true;
			 }
			
			}
			
			function checkprintboxes(singleboxflag)
{   
	var counter = document.getElementById("jobscount").value;
	//alert("yoe"+counter+document.getElementById("printalljobs").checked )
	if (counter == 1)
	{
		
		if (singleboxflag == 0)
		{
		//alert("single==0 counter==1");
			if (document.mainform.printalljobs.checked)
				document.mainform.printjobs[0].checked = true;
				
				
			else
				document.mainform.printjobs[0].checked = false;
		}
		else
		{
		//alert("single!=0 counter==1");
			if (document.mainform.printalljobs.checked==false)
				document.mainform.printalljobs.checked = true;
			else
				document.mainform.printalljobs.checked = false;
		}
	}
	else
	{
		if (singleboxflag == 0)
		{
		//alert("single==0 counter>1");
			if (document.mainform.printalljobs.checked)
			{
				for (var i = 0; i < counter; ++i)
				{
					//alert("inside"+i);
					document.mainform.printjobs[i].checked = true
				}
			}
			else
			{
				for (var i = 0; i < counter; ++i)
				{
					document.mainform.printjobs[i].checked = false
				}
			}
		}
		else
		{
		//alert("single!=0 counter>1");
			allflag = 0;
			for (var i = 0; i < counter; ++i)
			{
			//alert("Value of i"+i)
				if(!document.mainform.printjobs[i].checked)
				{
					allflag = 1;
					break;
				}
			}
			if (allflag == 1)
				document.mainform.printalljobs.checked = false
			else
				document.mainform.printalljobs.checked = true
		}
	}

}

function print_window_new()
{
	
	var screenW = screen.width;
	var screenH = screen.height;
	var popupW = 520;
	var popupH = 460;
	var positionX = (screenW-popupW)/2;
	var positionY = (screenH-popupH)/2;
	records = document.getElementById("jobscount").value;

	checkprintbox = 0;
	if (records == 1)
	{
		if (document.mainform.printjobs.checked)
		{
			checkprintbox = 1;
			//alert("inside if")
		}
	}
	else
	{
		for ( var i = 0; i < records; ++i)
		{
			if (document.mainform.printjobs[i].checked)
			{
				checkprintbox = 1;
				break;
			}
		}
	}
	if (checkprintbox == 0)
		alert ("Please at least check one box for print job!")
	else
	{
		var mywindow4 = window.open('', 'printwinnew', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=no,menubar=no,alwaysRaised=yes,width=450,height=400');
		document.mainform.action="Printbunchjobs.jsp";
		document.mainform.method="post";
		document.mainform.target="printwinnew";
		document.mainform.submit();
	}
}

function CheckAll(){ 
var counter=document.getElementById("jobscount").value;

 
  for ( i=0 ; i < counter ; i++ ){ 
 
   if (document.mainform.printalljobs.checked)
   {   
 	document.mainform.printjobs[i].checked=true; 
   } 
   else
   { 
    document.mainform.printjobs[i].checked=false; 
   } 
 }   
}

				function charInString (c, s)
				{   for (i = 0; i < s.length; i++)
					{   if (s.charAt(i) == c) return true;
					}
					return false
				}
				/*THESE FUNCTIONS ARE FOR KEYWORD TEXTBOX CHECK OR VALIDATION*/
				var whitespace = " \t\n\r"; 
				
				function stripInitialWhitespace(s)
				
				{   var i = 0;
				
					while ((i < s.length) && charInString (s.charAt(i), whitespace))
					   i++;
					
					return s.substring (i, s.length);
				}
				function stripFinalWhitespace(s)
				{   
					var i = s.length - 1;
					while ((i >= 0) && charInString (s.charAt(i), whitespace))
					   i--;
					return s.substring (0, i + 1);
				}


	 
				
				function callTextSearch()
				{
					
					//alert("call")
					var s = document.viewForm.textsubkey.value;
					s = s.toLowerCase();
					//alert("call3"+s)
					// Remove initial white spaces
					s = stripInitialWhitespace(s);
					
					// Remove final white spaces
					s =  stripFinalWhitespace(s);
					//alert("call"+s)
					if (s =="")
					{
						alert ("Please enter a keyword");
						document.viewForm.textsubkey.value = s;
						document.viewForm.textsubkey.focus();
						return;
					}
					else if (s == "and" || s == "or" || s == "not")
					{
						alert ("Please enter a proper keyword");
						document.viewForm.textsubkey.value = s;
						document.viewForm.textsubkey.focus();
						return;
					}
					else
					{
						document.viewForm.textsubkey.value = s;
						document.viewForm.action="savedSearchResults.jsp";
						document.viewForm.method="post";
						document.viewForm.target="_self";
						document.viewForm.submit();
					}
				}
				
				
				 function call_addbidder(cdcid)
			{
				
				document.mainform.cdcid_savejob.value = cdcid;
				document.mainform.action="/online_product/bidder/bidder_add.cfm";
				document.mainform.method="post";
				
					var x = screen.width - 550;
					var y = screen.height - 750;
				
				var mywin = window.open('', 'sjobwin', 'personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width=530,height=450');
				document.mainform.target="sjobwin";
				mywin.moveTo(x,y)
				mywin.focus();
				document.mainform.submit();
			}	

	    	//-->
	    
	</script>
	 
	  
<link href="sheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<font face='verdana,arial' size='1' >
</font>


<!---*************************Start of Form*****************************--->
<FORM target="_self" name="viewForm" action="savedSearchResults.jsp" method="post">
 <table border="0" cellpadding="0" cellspacing="0" width="760">
  <tr>
   <td width="15">&nbsp;</td>	
   <td valign="top">
     <table border="0" cellpadding="0" cellspacing="0" width="500" ALIGN="center">
	  <tr>
		<td valign="top">
		
			<table border="0" cellpadding="0" cellspacing="0">
				 <tr>
					<td><img src="images/refine_search.gif" width="118" height="22" border="0" alt="Refine your search"></td>
				</tr>		
			</table>
			  </td>	  
	</tr>
	<tr>
	 <td height="1"><img src="images/pixel_blue.gif" width="500" height="1" border="0"></td>
 	</tr>
 	<tr>
		<td bgcolor="EFF4FA" width="500">
			
			
			<table border="0" cellpadding="0" cellspacing="0">
			<tr>
			<td width="1"><img src="images/pixel_blue.gif" width="1" height="30" border="0"></td>
			<td width="10">&nbsp;</td>
			<td class="black11px" WIDTH="733">Enter your keyword below to refine your search. You may enter multiple keywords, use commas between each word.</td>
			<td width="1"><img src="images/pixel_blue.gif" width="1" height="30" border="0"></td>
			</tr>
			
			<tr>
			<td width="1"><img src="images/pixel_blue.gif" width="1" height="30" border="0"></td>
			<td width="10">&nbsp;</td>
			<td>
											
												
				<table border="0" cellpadding="0" cellspacing="0">
				<td align="right" class="black11px">Keyword:</td>
				<td width="5">&nbsp;</td>
				<td><input type="text" name="textsubkey" value=""></td>
				<td width="5">&nbsp;</td>
				<td class="black11px">
				<input type="hidden" name="subselect"  value="subselect">
				<a href="javascript:callTextSearch()"><img SRC="images/button_go.gif" border="0" ALIGN="texttop"></a>&nbsp;&nbsp;
				               </td>
				</table>	
							
			<!--- End Search Keyword Form---->
			</td>
			<td width="1"><img src="images/pixel_blue.gif" width="1" height="30" border="0"></td>
			</tr>
						
			</table>
			
			

			
		</td>
		</tr>
		<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0">
			<TR>
				<TD bgcolor="EFF4FA"><IMG SRC="images/corner_lb_bl.gif" WIDTH="15" HEIGHT="17" ALT="" BORDER="0"></TD>
				<TD VALIGN="bottom" bgcolor="EFF4FA"><IMG SRC="images/pixel_blue.gif" WIDTH="470" HEIGHT="1" ALT="" BORDER="0"></TD>
				<TD bgcolor="EFF4FA"><IMG SRC="images/corner_rb_bl.gif" WIDTH="15" HEIGHT="17" ALT="" BORDER="0"></TD>
			</TR>
            
	 		</table>
			
			<!---- Test---->
		</td>
		</tr>	
	</table>					
																	
					
			</FORM>
	


<!--****************************END******************-->


	
	<table  width="780" cellspacing="1" cellpadding="1" border="0">
			<tr>
			    <td align="center" CLASS="orange12px">
				johnsonAutolinkTest
 
				
				
					
				</td>
			</tr>
	</table>
   
  
  <table width="714"  cellpadding="0" cellspacing="0" >
		 <tr> 
		 <br>
           <TD width="65">
		   
		   </TD>
		   <td   align="center"  class="black11px"  >
		 
     		 <form name="frmPage" >
       		 <b>Go to Page:</b> 
       		 <input type="text" name="next"  size="5" >
        		<input name="button" type="image"  src="images/button_go.gif"  onClick="return validatePages(1);">
     		 </form>
		 </td>
		  
					</td>
      </tr>
	</table>
  
 
  <TABLE  width="783" border="0" cellpadding="1" cellspacing="0"   >
  <tr> 
   
    <td  align="right" > 
	
	   
  	
  </tr>
  
  <TR>
    <Td><br>	</Td>
  
  </TR>
  
  <tr > 
    <td   class="black11px"  colspan="11" >
	    
		 	<font color="black"><b>Current Page :</b>&nbsp;<i>1</i></font>&nbsp;<b>out of&nbsp;</font></b><i>1</i>&nbsp;<b>page(s)</b></font>&nbsp;&nbsp;&nbsp;&nbsp; <font color="black"><b>Current Jobs :</b><i> 1-1</i></font>&nbsp;<b>out of&nbsp;&nbsp</b><i>1</i></font><b>&nbsp;&nbsp;job(s)

     		 
		
     </td>
  </tr>
  
 
 
</TABLE>	
<FORM ACTION="" NAME="mainform" METHOD="post">			
<table width="785" border="0" cellpadding="0" cellspacing="0">
   
    <tr>
		 <td colspan="11" ><img src="images/pixel_blue.gif" width="100%" height="1" border="0"></td>	
		</tr>
   
</table>
			
<table width="785" border="0" cellpadding="0" cellspacing="0"  id="table-2"  >
 
  
  
	

 </tbody>  

  
	
</table>


   
  

  
		   <table border="0" cellspacing="0" cellpadding="0"  >
				   <tr>
					 <td width="140"> 
					 <table>
			  			<tr>
					     <td>








							  
				 		</td>
					  </tr>
					</table>
					   
					 </td>
					
					 <td width="217" >
					<input type="Checkbox" name="printalljobs" value="all" onClick="checkprintboxes(0)">
					 <a href="javascript:print_window_new()">
					  <img SRC="images/button_print_jobs_icn.gif" width="137" height="15" border="0" ALIGN="absbottom">
					 </a>
					</td>
				 </tr>
				 </table>
			
		 
		  	 
		<table border="0">
			<TR>
  				 <TD width="8" ></TD>
  					 <TD width="881">
							  
		  
		   



<table  border="0" align="center" cellpadding="0" cellspacing="4">
	
	<TR>
	  
		<TD>
			<table border="0" cellpadding="0" cellspacing="0" width="502">		
				
				<tr>								
					<td>
							
		
						<table border="0" cellpadding="0" cellspacing="0" class="borders"  >
						   <!--DISPLAY OF THE PROJECT TITLE-->
												 
          					  <tr class="row2"> 
							   
             					 <td height="20" colspan="6"  class="white12px"> 
								    
								   	<input type="Checkbox" name="printjobs" value="651374" onClick="checkprintboxes(1)">
									
									
								
               						 <b>PATH <b style=color:black;background-color:FFFF66>tunnels</b> IMPROVEMENT PROGRAM

									 </b>
              					</TD>
           					 </TR>
							 <TR> 
								  <td align="right">
							         
				 				</td>
								  <TD  class="black11px"  height="25" align="right">
								 
										<a href="javascript:call_savejob('NY T050700044','0','0','PATH TUNNELS IMPROVEMENT PROGRAM','2008-10-21 00:00:00.0','at 4:00 PM (To Owner)Attn Suchetha Premchan, Extended from October 14, 2008','12/12/2006','N');"><img src="images/button_pt_icn.gif" alt="Add to Project Tracker" width="23" height="20" border="0"></A>
										
								   </TD>
								  <td  ALIGN="right" class="black10px"  width="30" valign="bottom">
								    <a href="javascript:print_window(651374,0);"> 
									  <img src="images/button_print_icn.gif" border="0" >
									</a>
									
								   </TD>
								   
								  
								    
										<td   align="right" class="black10px"  valign="middle"  width="150">
									&nbsp;<a CLASS="a03" href="javascript:call_addbidder('NY T050700044');">
						            <STRONG>Project Info Request</STRONG></a>&nbsp;</td>
									
									<td   align="right" class="black10px"  valign="middle"  width="35">
									
									<a CLASS="a03" target="_blank" href="http://www.mapquest.com/maps/map.adp?searchtype=address&country=US&state=US&city='Multiple Cities'&address=''">
									
								    
									  <STRONG>Map</STRONG></a>&nbsp;
									
								 </td>
								  <td  class="black10px"  align="right" width="48"> 
								      
						              <img src="images/public.gif" width="55" height="15" border="0">
						              
							      </TD>
								 
								 
								  
							</TR>
			                
										 
							      
								     			   
			
							<!-- DISPLAY OF THE PROJECT CDCID-->
							<tr class="row2"> 
							  <td colspan="6" class="white10px"> 
								NY T050700044

							  </TD>
							</TR>
						<!-- THIS IS FOR SUBSECTION-->
			
							<tr> 

								<td    height="1" class="white10px"> </td>
							</tr>
							<tr class="row2"> 
							  <td colspan="6" class="white10px"> 
								AWAITING AWARDS

							  </TD>
							</TR>
			                <tr> 
								<td    height="1" class="white10px"> </td>
							</tr>
							 <tr class="row2"> 
							  <td colspan="6" class="white10px"> 
               						Alteration

              					</TD>
           					 </TR>
			
								<!-- THIS IS FOR TITLE-->
							<TR> 
							  <td colspan="6"  class="maroon10px"> 
								<b><font face='verdana,arial' size='1'>
PATH <b style=color:black;background-color:FFFF66>tunnels</b> IMPROVEMENT PROGRAM
</font></b>

							  </TD>
							</TR>
							<!--- IFB NUMBER--->
							
								
										<TR> 
										  <td colspan="6"  class="black10px" > 
										Contract No. 16554

										</TD>
									  </TR>
										
							  
							<TR> 
							  <td colspan="6" class="black10px">
							   <b><font face='verdana,arial' size='1'  class="maroon10px">
							   LOCATION:
</font></b> 
								Multiple Cities,
US
(Multiple Co.)


							  </TD>
							</TR>
			                <!-- THIS IS FOR ESTIMATED AMOUNT DETAILS-->
			
							<TR> 
							
					<td colspan="5" class="black10px">													 
							<b>ESTIMATED AMOUNT:</b> $250,000,000
 to $350,000,000


 
						 </TR>	  
						    <!-- THIS IS FOR CONTRACTING METHOD DETAILS-->
							<TR> 
							  <td colspan="6" class="black10px" > 
								<b><font face='verdana,arial' size='1' >
CONTRACTING METHOD:
Request for Qualifications
</font></b>

							  </TD>
							   
							</TR>
								 <!-- THIS IS FOR SUFFIX  DETAILS-->
			   
					   <TR> 
						 <TD colspan="6" class="black10px"> 
									<b><font face='verdana,arial' size='1' >
UPDATE:
</font></b>
<b>Owner Accepting Letters of Prequalification.

					   </TD>
					</TR>   
			
			
						<!--DISPLAY OF THE PROJECT BIDS DETAILS-->
			  
						<TR> 
						  <td colspan="5" class="black10px"> 
							<b><font face='verdana,arial' size='1' >
BIDS DUE:
</font></b>
<font face='verdana,arial' size='1' >
<B>
October 21, 2008
</B>
at 4:00 PM (To Owner)Attn Suchetha Premchan, Extended from October 14, 2008

						  </TD>
						  
					  </TR>
			
			    <!--THIS IS FOR FILED SUBBID AND ITS STATUS--> 
			  <TR>
			    <TD>
				   
				</TD>
			  
			  </TR>
			 
					<!-- THIS IS FOR START DATE DETAILS-->
					  
								
					    
			
					 <!-- THIS IS FOR  END DATE DETAILS-->
					  
						
					    
			
						 <!-- THIS IS FOR NO OF DAYS-->
						
						 
							
						  
						<!--DISPLAY FOR PROJECT COMPLETION DAYS-->
						 
							
						   
			
			  
			          
						 <tr >
							  <td colspan="10">
									 <b><font face='verdana,arial' size='1' >OWNER:</b> <a href="/online_product/list_contact_projects.cfm?contact_id=380841&contact_name=PANYNJ+%28Bid+Custodian%29" target="_self">PANYNJ (Bid Custodian)</a>
<br>
1 Madison Ave Fl 7, 
New York, 
NY
10010
<br>
(212)435-3905
FAX# (212)435-3959
</font><br>

								 
							 </td>
						</tr>
								   
			            
					   
						<TR> 
						  <td colspan="6" class="black10px"> 
						   
						
						   </TD>
						</TR>
					   
				<!--DETAILS TABLE-USE FIELD COLUMN NAME-DETAILS1-->
				  
			       <!-- THIS IS FOR SCOPE DETAILS--> 
						 






                     
						
               
                  
						
				
			 
			  
			  <!-- THIS IS FOR MIEQ DETAILS-->
			   <TR> 
		              <TD colspan="5" class="black10px"> 
        			        
              		</TD> 
			  </TR>
			  	 
			    <!--DISPLAY OF DIVISIONS-->
             <TR> 
              <TD colspan="5" class="black10px"> 
                <b>DIVISION:</b> <BR>
<b>
Div2
</b>
<font face='verdana,arial' size='1' >site construction, site improvements & amenities, utility services, water distribution

                <br> 
                
              </TD>
            </TR>		
			
			  
			  	 
			
			 <!-- THIS IS FOR SPECIAL CONDITION 1 DETAILS-->
			   
                		
              	
			  			  <!-- THIS IS FOR SPECIAL CONDITION 2 DETAILS-->
			     
                		
              
				<!--DISPLAY OF  NOTES---->
			  
        			        
								<TR> 
					              <TD colspan="6" class="black10px"> 
									<b><font face='verdana,arial' size='1' >
NOTES:
</b>
Furnish, install, testing, and commissioning a variety of systems as part of PATH tunnel improvement program, structural improvements in tunnel, installation, testing, and commissioning of water management systems.
</font>

								</TD> 
			  				</TR>
								
              
			
			 <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE1-->
			  
        	        
						<TR> 
				           <TD colspan="5" class="black10px">
							<b><font face='verdana,arial' size='1' >
CONTACT:
</font></b>
Suchetha Premchan with owner (212)435-3973 or email spremchan@panynj.gov

					  	</TD> 
					 </TR>
					   
              
			  
			   <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE2-->
			 
                
             
			  
			  
			   <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE3-->
			 
               	 
				
				<!--This is for PLANS-->
			<TR> 
              <TD colspan="5" class="black10px"> 
			  
                 <b>PLANS:</b> Owner or www.panynj.gov

              </TD> 
		 </TR>
			 
			 
		
		   
			
			<!-- THIS IS FOR PLAN DEPOSIT-->
			 <TR> 
        	      <TD colspan="5" class="black10px"> 
            	    
 No cost

              </TD> 
		  </TR>
			  
			  
			  <!-- THIS IS FOR MAILING FEE DEPOSIT-->
			  
                
              
			  
			  
			    <!-- THIS IS FOR BID BOND PERCT-->
			 
                
              
			  
			  
			  <!--Certified/Cashiers need to be incoporated here-->
			  
			 
                
					    
				   <TR> 
              		<TD colspan="5" class="black10px"> 
						
						</TD> 
					</TR>
					
              
			
			
			
			
			
			     <!-- THIS IS FOR BID BOND STD RANGE-->
			 
                
             
			
			
			 
			     <!-- THIS IS FOR PERF BOND -->
			 
                
              
			
			
			   <!-- THIS IS FOR PAYMENT BOND -->
			 
                
              </TD> 
			  </TR>
			
			
			  <!-- THIS IS FOR MAINTENANCE BOND -->
			 
                
             
			   <tr>
				  <td class="black10px" colspan="10">
				  
				Pre-bid Meeting: None Scheduled

				  
				  </td>
				
				</tr>
				 <!-- THIS IS FOR Plan Room Info List--> 
						 	
			  <!-- Print DBC Prequalification required-->
			 
                
					 <TR> 
              			<TD colspan="5" class="black10px"> 
				   
							
					
					</TD> 
			      </TR>
					
					
              
			    <!-- Print 100% set aside for small business-->
			
                
					  <TR> 
              			<TD colspan="5" class="black10px"> 
				      
							
					 </TD> 
			  </TR>
					
					
					
             
			  
			    <!-- Print WBE/MBE required-->
			 
                
					 <TR> 
              			<TD colspan="5" class="black10px"> 
				      
							
					</TD> 
			 	 </TR>
					
					
					
              
			  
			   <!-- Print prequalification required text-->
			  
                
				      <TR> 
              			<TD colspan="5" class="black10px">
							
					
					 </TD> 
			 	 </TR>
					
				
             
			  
			    <!-- Print pre-qualification due date-->
			  
                
              
			 <!-- This is MBE-->
			
                
             
			  
			  
			  <!-- This is other pre-qualifications-->
			 
                
             
			  
			  
			   <!-- This is WBE-->
			 
                
             
			  
			  
			     <!-- This is DBE-->
			 
                
              
			  
			  	     <!-- This is DVBE-->
			 
                
              
			  
			   	     <!-- This is HUB-->
			 
                
              
			    <!-- THIS IS FOR Industry DETAILS--> 
						    
						<TR> 
						  <td colspan="6" class="black10px"> 
						  <script language="JavaScript">
						    function PopInd(mainInd,flag)
							{
							 
							 //alert("hi");
							// var indType=flag;
							// alert(flag);
							 		var screenW = screen.width;
									var screenH = screen.height;
									var popupW = 520;
									var popupH = 460;
									var positionX = (screenW-popupW)/2;
									var positionY = (screenH-popupH)/2;
									if(flag=="industry")
									var mywin = window.open("online_product/list_industry_projects.cfm?industry="+mainInd, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+'');
									else
									var mywin = window.open("online_product/list_industry_projects.cfm?industrySub="+mainInd, 'detailswin', 'location=no,personalbar=no,toolbar=no,status=no,scrollbars=yes,resizable=yes,menubar=no,alwaysRaised=yes,width='+popupW+',height='+popupH+'');
									//document.viewForm.target="detailswin";
									mywin.focus();
									mywin.moveTo(positionX,positionY);
							
							 
							
							
							
							}
						  </script>
						   Industry Type: 
<a  href=javascript:PopInd('General/Civil+Joint+Projects','industry') target="_self">General/Civil Joint Projects</a>
<a  href=javascript:PopInd('Engineering','industry') target="_self">Engineering</a>
<br>
Industry Sub Type:
<a  href=javascript:PopInd('Tunnels','industrySub') target="_self"><b style=color:black;background-color:FFFF66>tunnels</b></a>
<a  href=javascript:PopInd('Marine+Work','industrySub') target="_self">Marine Work</a>

						  </TD>
						 </TR>
						
						
			  
			   <!---THIS IS FOR DISPLAY OF LOW BIDDERS LIST--->
			  
			   
					
				</td>
               </tr>
			      <!--THIS IS FOR DISPLAY OF  AWARDS-->
				  
			     <tr> 
                    <td class="black10px" colspan="10"> 
					       
 					</td>
              </tr>
			  
			   <!---THIS IS FOR DISPLAY OF SUB CONTRACTORS AWARDS LIST--->
				 <tr> 
                    <td class="black10px">
					  
					</td>
                  </tr>
			 <!--THIS IS FOR DISPLAY OF PLAN HOLDER'S -->
			   <tr> 
                    <td colspan="8"> 
					    <br><b><font face='verdana,arial' size='1' >PLAN HOLDER(S)</b><br>
<a href="/online_product/list_contact_projects.cfm?contact_id=405467&contact_name=Owner+not+compiling+list" target="_self"><b>
Owner not compiling list</b></a>
<br>

					 
					</td>
                  </tr>
				 
				   
            
           		 <TR> 
             		 <TD height="30" colspan="6"></TD>
            	</TR>
				 <TR class="borders"> 
              <TD colspan="6" ALIGN="center" class="black10px">
				  <table>
				  
				 		<tr> 
						<!---FIRST REPORTED DATE--->
                      <td class="black10px" ALIGN="center"> 
					  
                      
					    
						
	 
						First Reported May 7, 2008

					  
					  </td>
                   </tr>
				    <!--THIS IS FOR DISPLAY OF FINAL PUBLISH DATE-->
                    <TR>
						
						<TD class="black10px"  align="center" height="15">	
						
							
							
							
							
							
							Last Published Oct 10 2008

							
							
					
							

									
						</TD>			
					</TR>
								
			  <tr> 
                    <td class="black10px" ALIGN="center"> ©COPYRIGHT 2008, CONSTRUCTION 
                      DATA COMPANY, ALL RIGHTS RESERVED. This material may not 
                      be published, broadcast, rewritten or distributed. </td>
                  </tr>
                </table></td>
            </tr>
          </table>
		  <tr> 
    			<td colspan="8" ><img src="images/pixel_blue.gif" width="100%" height="1" border="0"></td>
  		 </tr>
		<tr>
		<td valign="top">
			<table border="0" cellpadding="0" cellspacing="0">
			<TR>
				<TD width="15" bgcolor="EFF4FA"><IMG SRC="images/corner_lb_bl.gif" WIDTH="15" HEIGHT="17" ALT="" BORDER="0"></TD>
				<TD width="472" VALIGN="bottom" bgcolor="EFF4FA"><IMG SRC="images/pixel_blue.gif" WIDTH="472" HEIGHT="1" ALT="" BORDER="0"></TD>
				<TD width="18" bgcolor="EFF4FA"><IMG SRC="images/corner_rb_bl.gif" WIDTH="15" HEIGHT="17" ALT="" BORDER="0"></TD>
			</TR>
	   	
		 </table>

</td></tr>
</table>
</TD>

</TR>
</table>	
 <br>
		
		 
		 <input type="hidden" id="jobscount" value="1">
		 

</table>
<table width="750" border="0">


 <tr>
   
   
	 
	 <td   align="right"><a href="javascript:print_window_new()"><img SRC="images/button_print_jobs_icn.gif" border="0" ALIGN="absbottom"></a></TD>
    <td  align="right" > 
      
	   
    
	</td>
	

</tr>
 </tr>

</table>

<!-- <table class="sort-table" id="table-1" cellspacing="0">
	<col />
	<col />
	<col style="text-align: right" />
	<col />
	<col />
	<thead>
		<tr>
			<td>String</td>
			<td title="CaseInsensitiveString">String</td>
			<td>Number</td>
			<td>Date</td>
			<td>No Sort</td>
		</tr>
	</thead>
	<tbody>
		<tr class="odd">
			<td>apple</td>
			<td>Strawberry</td>
			<td>45</td>
			<td>2001-03-13</td>
			<td>Item 0</td>
		</tr>
		<tr class="even">
			<td>Banana</td>
			<td>orange</td>
			<td>7698</td>
			<td>1789-07-14</td>
			<td>Item 1</td>
		</tr>
		<tr class="odd">
			<td>orange</td>
			<td>Banana</td>
			<td>4546</td>
			<td>1949-07-04</td>
			<td>Item 2</td>
		</tr>
		<tr class="even">
			<td>Strawberry</td>
			<td>apple</td>
			<td>987</td>
			<td>1975-08-19</td>
			<td>Item 3</td>
		</tr>
		<tr class="odd">
			<td>Pear</td>
			<td>blueberry</td>
			<td>98743</td>
			<td>2001-01-01</td>
			<td>Item 4</td>
		</tr>
		<tr class="even">
			<td>blueberry</td>
			<td>Pear</td>
			<td>4</td>
			<td>2001-04-18</td>
			<td>Item 5</td>
		</tr>
	</tbody>
</table> -->

    <script>
		//top.frames[0].location.href="online_product/bannerAds/topadbarwithad.cfm?adsfrom=ss"
		top.frames[0].location.href="online_product/topadbarwithad.cfm?adsfrom=ss"
	</script>
  


<script type="text/javascript">
//<![CDATA[

function addClassName(el, sClassName) {
	var s = el.className;
	var p = s.split(" ");
	var l = p.length;
	for (var i = 0; i < l; i++) {
		if (p[i] == sClassName)
			return;
	}
	p[p.length] = sClassName;
	el.className = p.join(" ").replace( /(^\s+)|(\s+$)/g, "" );
}

function removeClassName(el, sClassName) {
	var s = el.className;
	var p = s.split(" ");
	var np = [];
	var l = p.length;
	var j = 0;
	for (var i = 0; i < l; i++) {
		if (p[i] != sClassName)
			np[j++] = p[i];
	}
	el.className = np.join(" ").replace( /(^\s+)|(\s+$)/g, "" );
}

var st = new SortableTable(document.getElementById("table-2"),
	["String","Date", "String", "UsCurrency", "String","String","String"]);




// restore the class names
st.onsort = function () {
	var rows = st.tBody.rows;
	var l = rows.length;
	for (var i = 0; i < l; i++) {
		removeClassName(rows[i], i % 2 ? "odd" : "even");
		addClassName(rows[i], i % 2 ? "even" : "odd");
	}
};

//st.sort(0);
//]]>
</script>


<!--- fields used in save job --->
	<input type="hidden" name="job_title" value="">
	<input type="hidden" name="cdcid_savejob" value="">

	<!--- if bid date available, use it in calander --->
	<input type="hidden" name="biddate_savejob" value="">
	<input type="hidden" name="prebiddate_savejob" value="">

	<!--- if bid date details available, use it in calander notes --->
	<input type="hidden" name="bidsinfo_savejob" value="">
	
	<input type="hidden" name="pubid_details" value="">
	<input type="hidden" name="secid_details" value="">
	<input type="hidden" name="backbutton" value="">
	<input type="hidden" name="bidsdetails" value="">
	<input type="hidden" name="loginid" value="niranjan">
	
	
	<input type="hidden" name="save_job_id" value="">
    <input type="hidden" name="cdc_id" value="">
	<input type="hidden" name="title" value="">
	<input type="hidden" name="biddate" value="">

	
	
</form>
</body>
<script src="JSScripts/autolink_new.js" >
</script>
</html>
