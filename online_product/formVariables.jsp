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
 <!---The below div and the script added to show the loading bar. Added on 07-Aug-2012 by Muthu--->
<div style="position:absolute; width:100%; text-align:left; top:100px; margin-left:220px;"><img src="images/animated_loading_text_new.gif" width="310" height="57" border=0><br>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="images/animated_loading.gif" width="220" height="19" border=0></div>

<title>Form variables</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="jquery-ui-1.8.16.custom/jquery-1.7.1.min.js"></script>
<script language="javascript" type="text/javascript"><!---Added to show the loading bar. Created on 06-Aug-2012 by Muthu--->

	$(document).ready(function(){
	
		$("#imageholder").load('imageholder.cfm');
		
	});

			
		
</script>
</head>
<!---<script language="javascript" type="text/javascript">
			alert("Please wait while we process your request...Click OK to proceed!");
			loadInit();
</script>--->
<body>

<CFLOCK scope="SESSION" timeout="20" type="EXCLUSIVE">

<cfparam name="Session.nationalUser" default="">
<cfparam name="Session.fea_daysjobs" default="">
<cfparam name="Session.SectionList" default="">
<cfparam name="Session.SectionType" default="">
<cfparam name="session.subIndustryList" default="">
<cfparam name="session.SubIndustryIdList" default="">
<cfparam name="Session.catIndustryList" default="">
<cfparam name="Session.catSubIndustryType" default="">
<cfparam name="Session.BidStageList" default="">
<cfparam name="session.bb_state" default="">
<cfparam name="session.bb_county" default="">
<cfparam name="session.bb_editiondays" default="">
<cfparam name="session.bb_bidtype" default="">
<cfparam name="session.bb_subsection" default="">
<cfparam name="session.bb_division" default="">
<cfparam name="session.bb_keyword" default=""> 
<cfparam name="session.bb_ckeyword" default="">
<cfparam name="session.bb_planningStages" default="">
<cfparam name="session.bb_con_method" default="">
<cfparam name="session.bb_industry" default="">
<cfparam name="session.bb_sub_industry" default="">
<cfparam name="session.bb_biddatefrom" default="">
<cfparam name="session.bb_biddateto" default="">

<cfparam name="session.bb_costlow" default="">
<cfparam name="session.bb_costhigh" default="">
<cfparam name="session.bb_constType" default="">
<cfparam name="session.bb_sqrft_unit" default="">
<cfparam name="session.bb_sqrft_to" default="">
<cfparam name="session.bb_sqrft_from" default="">
<cfparam name="session.bb_stories_from" default="">
<cfparam name="session.bb_stories_to" default="">
<cfparam name="session.bb_d_mode" default="">
<cfparam name="session.bb_newjobs" default="">
<cfparam name="session.bb_biddateasap" default="">
<cfparam name="session.bb_allRecords" default="">
<cfparam name="session.bb_section" default="">
 <!---Advanced search enhancements 2013 August - Johnson--->
<cfparam name="session.bb_bidDay" default="">
<!---Advanced search enhancements 2013 August - Johnson--->
</CFLOCK>	
	<!--- Get application variable for this page, this prevent memory leak --->
<cflock scope="APPLICATION" timeout="16" type="READONLY">
	<cfset source = "#application.datasource#">
	<cfset uname = "#application.username#">
	<cfset pwd = "#application.password#">
</cflock>
<!--- End --->	
	



<form action="../../../jsp/searchResults.jsp" method="post" name="search_adv" >
<CFOUTPUT>



<cfif isDefined("form.state")>

<cfset session.bb_state="#form.state#">
<cfset state="'"&replace(#form.state#,",","','","all")&"'">
<input type="hidden" name="state" value="#state#">
</cfif>
<cfif isDefined("form.county")>
<input type="hidden" name="county" value="#form.county#">
<cfset session.bb_county="#form.county#">
</cfif>
<cfif isDefined("form.editiondays")>
<input type="hidden" name="editiondays" value="#form.editiondays#">
<cfset session.bb_editiondays="#form.editiondays#">
</cfif>

<cfif isDefined("form.section")>
<cfset section="'"&replace(#form.section#,",","','","all")&"'">
 <input type="hidden" name="section" value="#section#">
 
 <cfset session.bb_section="#form.section#">

</cfif>
<cfif isDefined("form.subsection")>
<cfset subsection="'"&replace(#form.subsection#,",","','","all")&"'">
<input type="hidden" name="subsection" value="#subsection#">
<cfset session.bb_subsection="#form.subsection#">
</cfif>
<cfif isDefined("form.bidtype")>
<cfset bidtype="'"&replace(#form.bidtype#,",","%','","all")&"%'">
<input type="hidden" name="bidtype" value="#bidtype#">
<cfset session.bb_bidtype="#form.bidtype#">
</cfif>
<cfif isDefined("form.division")>
<cfset division="'"&replace(#form.division#,",","','","all")&"'">
<input type="hidden" name="division" value="#division#">
<cfset session.bb_division="#form.division#">

</cfif>
<cfif isDefined("form.keyword")>
<input type="hidden" name="keyword" value="#form.keyword#">
<cfset session.bb_keyword="#form.keyword#">
</cfif>
<cfif isDefined("form.planningStages")>
<input type="hidden" name="planningStages" value="#form.planningStages#">
<cfset session.bb_planningStages="#form.planningStages#">
</cfif>
<cfif isDefined("form.con_method")>
<input type="hidden" name="con_method" value="#form.con_method#">
<cfset session.bb_con_method="#form.con_method#">
</cfif>
<cfif isDefined("form.industry")>
<input type="hidden" name="industry" value="#form.industry#">
<cfset session.bb_industry="#form.industry#">

</cfif>
<cfif isDefined("form.sub_industry")>
<input type="hidden" name="sub_industry" value="#form.sub_industry#">
<cfset session.bb_sub_industry="#form.sub_industry#">

</cfif>
<cfif isDefined("form.biddatefrom")>
<input type="hidden" name="biddatefrom" value="#form.biddatefrom#">
<cfset session.bb_biddatefrom="#form.biddatefrom#">
</cfif>
<cfif isDefined("form.biddateto")>
<input type="hidden" name="biddateto" value="#form.biddateto#">
<cfset session.bb_biddateto="#form.biddateto#">
</cfif>
<cfif isDefined("form.costlow")>
<input type="hidden" name="costlow" value="#form.costlow#">
<cfset session.bb_costlow="#form.costlow#">
</cfif>
<cfif isDefined("form.costhigh")>
<input type="hidden" name="costhigh" value="#form.costhigh#">
<cfset session.bb_costhigh="#form.costhigh#">
</cfif>
<cfif isDefined("form.constType")>
<input type="hidden" name="constType" value="#form.constType#">
<cfset session.bb_constType="#form.constType#">
</cfif>
<cfif isDefined("form.sqrft_unit")>
<input type="hidden" name="sqrft_unit" value="#form.sqrft_unit#">
<cfset session.bb_sqrft_unit="#form.sqrft_unit#">
</cfif>
<cfif isDefined("form.sqrft_from")>
<input type="hidden" name="sqrft_from" value="#form.sqrft_from#">
<cfset session.bb_sqrft_from="#form.sqrft_from#">

</cfif>
<cfif isDefined("form.sqrft_to")>
<input type="hidden" name="sqrft_to" value="#form.sqrft_to#">
<cfset session.bb_sqrft_to="#form.sqrft_to#">
</cfif>
<cfif isDefined("form.stories_from")>
<input type="hidden" name="stories_from" value="#form.stories_from#">
<cfset session.bb_stories_from="#form.stories_from#">
</cfif>
<cfif isDefined("form.stories_to")>
<input type="hidden" name="stories_to" value="#form.stories_to#">
<cfset session.bb_stories_to="#form.stories_to#">
</cfif>
<cfif isDefined("form.d_mode")>
<input type="hidden" name="d_mode" value="#form.d_mode#">
<cfset session.bb_d_mode="#form.d_mode#">
</cfif>
<cfif isDefined("form.newjobs")>
<input type="hidden" name="newjobs" value="#form.newjobs#">
<cfset session.bb_newjobs="#form.newjobs#">
</cfif>
<cfif isDefined("form.biddateasap")>
<input type="hidden" name="biddateasap" value="#form.biddateasap#">
<cfset session.bb_biddateasap="#form.biddateasap#">
</cfif>



 


<cfif isDefined("form.allRecords")>
<input type="hidden" name="allRecords" value="#form.allRecords#">
<cfset session.bb_allRecords="#form.allRecords#">
</cfif>

<cfif isDefined("form.ckeyword")>
<input type="hidden" name="ckeyword" value="#form.ckeyword#">
<cfset session.bb_ckeyword="#form.ckeyword#">
</cfif>

<cfif isDefined("form.search_name")>
<!--- 09/27/2002 to display search name in results page --->
<input type="hidden" name="search_name" value="#search_name#">
</cfif>
 <cfif isDefined("form.search_module")>
<!--- 09/27/2013 to display ad in results page right side--->
<input type="hidden" name="search_module" value="#form.search_module#">
</cfif>
   <cfif isDefined("form.bidday")>
<input type="hidden" name="bidday" value="#form.bidday#">
<cfset session.bb_bidDay="#form.bidday#">
</cfif>
<cfif session.nationalUser eq "Y" OR session.subIndustryList neq "" OR session.catIndustryList NEQ "">
   			<cfoutput>
			   <INPUT type="hidden" value="#session.catIndustryList#" name="Ind_Type_List">
			   <INPUT type="hidden" value="#session.subIndustryList#" name="Sub_Ind_Type_List">
				
  		  </cfoutput>
							
  </cfif>
</CFOUTPUT>


		

		<!---<div style="position:absolute; left: 455px; top: 218px; width: 394px; height: 113px;">
		<img src="images/animated_loading.gif" id="load" style="position:absolute; left: 82px; top: 65px;" /><img src="images/animated_loading_text.gif" style="position:absolute; left: 49px; top: 9px;"> </div>--->
		<div  style="position:absolute; width:100%; text-align:left; top:100px; margin-left:220px;" id="imageholder"></div>
		
</form>

<!---<script language="javascript" type="text/javascript">

	 var ld=(document.all);
	  var ns4=document.layers;
	 var ns6=document.getElementById&&!document.all;
	 var ie4=document.all;
	  if (ns4)
	 	ld=document.loading;
	 else if (ns6)
	 	ld=document.getElementById("loading").style;
	 else if (ie4)
	 	ld=document.all.loading.style;
	  function loadInit()
	 {
	 if(ns4){ld.visibility="hidden";}
	 else if (ns6||ie4) ld.display="none";
	 }
 	</script>--->
	


<script type="text/javascript" language="javascript">
		document.search_adv.submit();
</script>

	
</body>
</html>
