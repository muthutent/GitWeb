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
   Description    : Displays the Project Details in brief
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
 <%@page import="com.cdc.util.CDCUtil"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="common.PaginationUtil"%>
<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="com.cdc.spring.model.SearchModel"%>
<%@page import="com.cdc.spring.model.dao.SearchDao"%>
<%@page import="com.cdc.spring.util.SearchUtil"%>
<%@page import="com.cdc.spring.bean.SearchBean"%>
<%@page import="com.cdc.spring.bean.UserBean"%>
<%@page import="java.util.Iterator"%>
<%@page import="common.utils.EncryptDecrypt"%>
<%@page import="common.SaveBean"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.*"%>
<%@page import="common.utils.JDBCUtil"%>
<%@page import="common.EJBClient"%>
<%@page import="briefproject.*"%>
<%@page import="com.cdc.util.ProjectUtil" %>
<%@page import="com.cdc.controller.DBController"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

UserBean userBean = null;
SearchBean searchBean = null;
SearchUtil searchUtil = null;
SearchDao searchDao = null;
ProjectUtil projectUtil = null;
SearchModel searchModel = null;
Map map = null;
PaginationUtil pageUtil = null;
ApplicationContext ac = null;
CDCUtil cdcUtil = null; 

ac = ApplicationConfig.getApplicationContext(request);
userBean = (UserBean) ac.getBean("userBean");
searchBean = (SearchBean) ac.getBean("searchBean");
map = (Map) session.getAttribute("cdcnews");
searchUtil = new SearchUtil();
searchModel = new SearchModel();
searchDao = new SearchDao();
cdcUtil = new CDCUtil();
projectUtil = new ProjectUtil();

int userviewjobwindow = 0;
String cKeyword = null;
String backval = null;

Integer ad_flag = null;
String polCountyFlag = null;
/* Iphone Browser session flag - 090711- to Hide POL icons */
String iPhoneSession = null;
/* New Script added for session timed out by Johnson -251010 */
String sessionLoginId = null;
// Added by Johnson for ITB validation-May9th2011
String itbSession = null;
String sessionAllRecords = null;
String refineProjectKeyword = null;
String refineContactKeyword = null;
String dmodeSession = null;
String ocrtextsession = null;
String ocrtextValue = null;
String sessionmode = null;
String lastkey_to_highlight = null;
String highlighter = null;
String sortPage = null;
String sortType = null;
String nkeysession = null;
String pageNum = null;
Map ptMap = null;
String bDate = null;
String trackTitle= null;
String CDCID= null;
String bidsInfo= null;
boolean qLinksFlag = false;
int perPage=0;
int jobscount = 0;
List myList = null;

Connection con = null;

Integer pages = (Integer) map.get("pages");
Integer start = (Integer) map.get("start");
Integer end = (Integer) map.get("end");
sessionmode = (String) map.get("sessionmode");
ocrtextsession = (String) map.get("ocrtextsession");
ocrtextValue = (String) map.get("ocrtextvalue");
pageUtil = (PaginationUtil) map.get("pageUtil");
polCountyFlag = userBean.getPolCounties();//(String)map.get("polCountyFlag");
nkeysession = (String)map.get("nkeysession");
dmodeSession = (String)map.get("dmodeSession");
sessionAllRecords = (String)map.get("sessionAllRecords");
iPhoneSession = userBean.getIsIPhone();//(String)map.get("iPhoneSession");
userviewjobwindow = userBean.getUserViewJobWindow();//(Integer)map.get("userviewjobwindow");
highlighter = (String)map.get("highlighter");
pageNum = (String)map.get("pageNum");

	//Gets Brief Project Bean
	BriefProject briefProject=null;
	 
	 briefProject = EJBClient.getBriefProjectEJBean();
	 
	 
	 
%>
<!-- SEARCH RESULT TABLE (BRIEF) -->
<table
	<%if ((sessionmode != null && sessionmode.equals("b")) || ocrtextsession.equals("true")
|| pages == 0) {%>
width="1020" <%}%> id="table-2">

<!-- HEAD -->
<%
if ((pages > 0 && sessionmode != null && sessionmode.equals("b") && nkeysession == null)
						|| (pages > 0 && ocrtextsession.equals("true"))) {
%>
<thead>
	<tr>
		<td width="10" class="lightblue10px border-bottom"
			_sorttype="None"><br> <label for="chkall">All</label><br>
			<input type="Checkbox" id="chkall" onClick="selectAll(this)"
name="printalljobs" value="all"></td>
<td width="50" align="center"
	class="link border-bottom cursorPointer"><u>New/<br> Jobs
</u></td>
<td width="70" align="center"
	class="link border-bottom cursorPointer"><u>Public/<br> Private
</u></td>
<td width="70" class="link border-bottom cursorPointer"><u>Bid
		Date/<br> Status
</u></td>
<td width="280"
	class="link border-bottom cursorPointer" align="left"><u>Title</u></td>
<td width="20" class="link border-bottom cursorPointer"><u>Value</u></td>
<td width="80" align="center"
	class="link border-bottom cursorPointer"><u>Bid Stage</u></td>
<td width="80" align="center"
	class="link border-bottom cursorPointer"><u>City</u></td>
<td width="105" class="link border-bottom cursorPointer"><u>County/<br>
		Independent City
</u>&nbsp;</td>
<td width="55" class="link border-bottom cursorPointer"><u>State</u>&nbsp;</td>
<%
if (polCountyFlag != null && polCountyFlag.equals("Y")) {
%>
<td width="60" class="link border-bottom lightblue10px cursorPointer"
	><u>e-plans </u></td>
<%
} else {
%>
<td width="1" class="border-bottom"></td>
<%
}
%>
<%
if (ocrtextsession.equals("true") && polCountyFlag != null && polCountyFlag.equals("Y")) {
%>
<td width="1" class="lightblue10px border-bottom">&nbsp;Spec</td>
<%
} else {
%>
<td width="1" class="border-bottom"></td>
<%
}
%>
<td width="1" class="border-bottom"><img src="<%=request.getContextPath()%>/images/pixel_blue.gif"
			width="1" height="50" border="0"></td>
		<td width="60" align="left"
			class="link border-bottom lightblue10px cursorPointer"><u>View/<br>Viewed
		</u></td>
		<td width="40" align="center"
			class="link border-bottom lightblue10px cursorPointer"><u>PT</u></td>
		<td width="33" align="center"
			class="link border-bottom lightblue10px cursorPointer"><u>PS</u></td>
		<td width="20" align="center" class="lightblue10px border-bottom">Print</td>
		<td width="1" class="border-bottom">&nbsp;</td>

	</tr>
</thead>
<%
}
%>

<!-- NO RESULTS -->
<%
if (pages <= 0) {
%>
<tr>
	<td class="black12px" align="center">
	
	Sorry No Records Found.<br> For Assistance 
	<a href="http://lm.cdcnews.com/general/offices_editorial.html"
target="_blank">Click Here </a><br> Or Call 800-652-0008<br>
		<%
if (nkeysession != null) {
%> 
<form method="post"
action="<%=request.getContextPath()%>/online-product/search-results">
<input type="hidden" name="backval"
	value="Y">
	<input type="hidden" name="d_mode"
	value="<%=dmodeSession%>">
<input type="hidden" name="allRecords"
value="<%=sessionAllRecords%>">
	<input id="back-button" type="submit" value="" />
</form>
	 <%
} else if(ocrtextsession!=null && ocrtextsession.equals("true")){
	%>
	<!-- below back button is shown while doing ocr search and no results found -->
	<input type="hidden" name="backval" value="Y">
	<input type="hidden" name="d_mode" value="<%=dmodeSession%>">
	<input type="hidden" name="allRecords" value="<%=sessionAllRecords%>">
	<a href="javascript:SubmitForm2('<%=dmodeSession%>','<%=sessionAllRecords%>')">
	<img src="<%=request.getContextPath()%>/images/buttons/button_back.gif" />
	</a>
	 <%
} else if(searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch")) {
	%>
		<input type="hidden" name="action" value="edit">
		<a href="javascript:ss_decide('edit')">
		<img src="<%=request.getContextPath()%>/images/buttons/button_back.gif">
		</a>
	<%
} else if(searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SPS")) {
		%>
		<a href="<%=request.getContextPath()%>/online-product/home?home=yes&flag=1"><img src="<%=request.getContextPath()%>/images/buttons/button_back.gif"
	border="0"></a>
		<%
} else {
%> 
	<a href="javascript:go_back(document.mainform)"><img src="<%=request.getContextPath()%>/images/buttons/button_back.gif"
	border="0"></a> <%
}
%>
	</td>
</tr>
<%
}
%>
<!-- END NO RESULTS -->

<%
if (pageUtil != null)
	myList = pageUtil.getPages(start, end);
%>
<!-- ********************** BRIEF RESULT ******************* -->
<%
if (pages > 0 && sessionmode != null && sessionmode.equals("b") && myList!=null && (nkeysession == null
						|| (ocrtextsession != null && ocrtextsession.equals("true")))) {
%>
<tbody>
	<%
Iterator iterator = myList.iterator();
common.BriefBean ex = null;

String currRow = "odd";
String projbidDate = null;
String projTitle = null;
String projAmount = null;
String projcountyName = null;
String projstateName = null;
String projsubSection = null;
String plansAvailable = null;
String leads_id = null;
String sJobName = null;
String sJobCDCId = null;
//String loginId=(String)map.get("login_id");
String loginId = userBean.getLoginId();
String encryptedID = null;
String firstReportedDate = null;
String entryDate = null;
String city = null;
String jobType = null;
String newUpdated = null;
String sub_sec = null;
String title1 = null;
String projCounty=null;
String amount=null;
String bidDate=null;
String stateName=null;
String subSection=null;
String subSectionAbb=null;
String planExpressFlag=null;
String stateMultiple=null;
String countyMultiple=null;
String countyID =null;
int sJobId = 0;
EncryptDecrypt enc = null;
int z=0;

con = DBController.getDBConnection();
while (iterator.hasNext()) {
	ex = (common.BriefBean) iterator.next();
	sub_sec = ex.getBidStage();
	title1 = ex.getTitle();
	projCounty = ex.getCounty();
	amount = ex.getEstimatedAmountLower().toString();
	bidDate = ex.getbiddate();
	stateName = ex.getStateName();
	planExpressFlag = ex.getPlanExpress();
	stateMultiple = ex.getStateMultiple();
	countyMultiple = ex.getCountyMultiple();
	countyID = String.valueOf(ex.getCountyID());		  
	//Gets the leads_entry_date to show "New" designation. Added on 02/20/13 Muthu.
	firstReportedDate = ex.getLeadsEntryDate();
	entryDate = ex.getEntryDate();
	city = ex.getCity();
	jobType = ex.getJobType();
	newUpdated = ex.getNewUpdate();

	plansAvailable = ex.getPlanAvailStatus();
	/*Iphone Browser session flag - 090711- to Hide POL icons*/
	if (iPhoneSession != null && iPhoneSession.equals("Y"))
		plansAvailable = null;

	leads_id = String.valueOf(ex.getLeadsID());
	enc = new EncryptDecrypt();
	int id = ex.getContentID();
	encryptedID = enc.encryptedString(leads_id);

	SaveBean sBean = ex.getSaveJobID();
	if (sBean != null) {
		sJobId = sBean.getJobId();
		sJobName = sBean.getJobName();
		sJobCDCId = sBean.getCDCID();
	}

	if ((jobscount % 2) == 0)
		currRow = "odd";
	else
		currRow = "even";
	
	//Get subsection
	subSection = sub_sec;
	//Gets subsection abb.
	subSectionAbb = projectUtil.setSubsection(sub_sec);
%>
<tr class="<%=currRow%>">

<!-- CheckBox -->
<td><input type="Checkbox" name="printjobs" value="<%=id%>"
id="<%=ex.getShortCDCID()%>" class="<%=sJobId%>"></td>

<!-- NEW JOBS -->
<td align="center" class="black10px"><b> <%
//Adds New jobs designation. Added on  02/20/13.
 			String lastEntry = null;
 			if (userBean.getLastEntry() != null)
 				lastEntry = String.valueOf(userBean.getLastEntry());
 			out.println(searchUtil.getNewJobsFlagDisplay(lastEntry,
 					firstReportedDate));
%>
</b></td>

<!-- JOB TYPE -->
<td align="center" class="black10px">
	<%
if (jobType != null && jobType.equalsIgnoreCase("Private")) {%>
<b class="privateFontColor">PRIVATE</b>
<% } else { %>
<b class="publicFontColor">PUBLIC</b>
<% }%>

</td>

<!-- BID DATE -->
<td class="black10px">
	<%
String cdcID = ex.getCDCID();
String bidDetails = ex.getBidsDetails();
out.println(searchModel.getBidDateDisplay(bidDate,	subSection, bidDetails));
%>
</td>

<!-- TITLE AND DE ICON -->
<td class="black10px padding3-0-3-0"
	align="left"><a
	<%if (userviewjobwindow == 0) {%>
href="javascript:call_detailsNew(<%=id%>,'<%=planExpressFlag%>','<%=ex.getShortCDCID()%>','<%=loginId%>',<%=sJobId%>,'<%=sJobName%>','<%=dmodeSession%>','<%=sessionAllRecords%>','s','<%=pageNum%>');"
<%} else {%>
href="javascript:call_details(<%=id%>,'<%=planExpressFlag%>','<%=ex.getShortCDCID()%>','<%=loginId%>',<%=sJobId%>,'<%=sJobName%>');"
<%}%>> <%
//Shows DE-blue icon. Added by Muthu on 01/02/2013.
 			if (searchDao.isDEenabled(loginId, ex.getShortCDCID(),con)) {
%> <img src="<%=request.getContextPath()%>/images/saved_search/Navigation_Blue_Up.gif"
alt="DE-Blue icon" border="0"> <%
}
 			out.print(searchUtil
 					.keywordHighlight(title1, highlighter));
%>
</a></td>

<!-- VALUE -->
<%
String value = searchUtil.getValueDisplay(amount);
if(value!=null && value.trim().equals("0")){
%>
	<td class="white10px" align="left">0</td>
	<%
} else {
	%>
	<td class="black10px" align="left">
	<%out.println(value);%>
	</td>
	<%
}
%>

<!-- BID STAGE -->
<td align="center" class="black10px">
	<%
out.print(searchUtil.keywordHighlight(subSectionAbb,
				highlighter));
%>
</td>

<!-- CITY -->
<td align="center" class="black10px">
	<%
if (city != null)
			out.println(city.trim());
%>
</td>

<!-- COUNTY -->
<td align="center" class="black10px">
	<%
out.print(searchUtil.getCountyDisplay(countyMultiple,
				projCounty, highlighter));
%>
</td>

<!-- STATE -->
<td align="center" class="black10px">
	<%
out.print(searchUtil.getSateDisplay(stateMultiple,
				stateName, highlighter));
%>
</td>

<!-- E-PLANS -->
<td class="black11px" align="center">
	<%//POL COVERAGE CHECK FOR EACH PROJECT COUNTY ID
boolean polCoverageFlag = false;
if(userBean.getPolCountyIdList()!=null && userBean.getPolCountyIdList().size() > 0)
	polCoverageFlag = searchUtil.pcheckPOLCoverage(countyID,cdcUtil.getCommaSeparatedString(userBean.getPolCountyIdList()));

if (plansAvailable != null
		&& (plansAvailable.equals("plans Aa") || plansAvailable
				.equals("A")) && polCountyFlag != null && polCountyFlag.equals("Y")
		&& polCoverageFlag == true) {%>
<a class="a03" href="javascript:call_plansOnline('A','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=ex.getStateID()%>')">
<img src="<%=request.getContextPath()%>/images/pol/plans-available-new1.png"
title="Plans Available" alt="plans Aa" width="37" height="28"
border="0" align="middle"></a>
<%} else if (plansAvailable != null
&& (plansAvailable.equals("plans Ad") || plansAvailable
		.equals("I")) && polCountyFlag != null && polCountyFlag.equals("Y")
&& polCoverageFlag == true) {%>
<a class="a03" href="javascript:call_plansOnline('A','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=ex.getStateID()%>')">
<img src="<%=request.getContextPath()%>/images/pol/plans-addendum-available-new.png"
title="Plans Available Info" alt="plans Ad" width="37"
height="28" border="0" align="middle"></a><%
} else if (plansAvailable != null
 					&& plansAvailable.equals("U")
 					&& polCountyFlag != null && polCountyFlag.equals("Y")
 					&& polCoverageFlag == true) {
%> <a class="a03" href="javascript:call_plansOnline('U','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=ex.getStateID()%>')"></a>

<%
} else if (plansAvailable != null
	&& (plansAvailable.equals("plans Check") || plansAvailable
			.equals("S")) && polCountyFlag != null && polCountyFlag.equals("Y")
	&& polCoverageFlag == true) {
%> <a class="a03" href="javascript:call_plansOnline('S','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=ex.getStateID()%>')">
<img src="<%=request.getContextPath()%>/images/pol/click-for-plan-status.png"
title="Plans Status" alt="plans Check" width="35" height="28"
border="0" align="middle"></a><%
} else if (plansAvailable != null
 					&& (plansAvailable.equals("plans No") || plansAvailable
 							.equals("N")) && polCountyFlag != null && polCountyFlag.equals("Y")
 					&& polCoverageFlag == true) {
%> &nbsp;<!--<IMG src="/images/plansNoLongerAvailable.gif" title="Plans No Longer Available" width="37" height="28" BORDER="0" align="absmiddle">-->
<% 
} else { 
%> &nbsp; <%
}
%></td>

<!-- SPEC -->
<td class="black11px" align="center">
	<%
if (ocrtextsession.equals("true")
	&& polCountyFlag != null && polCountyFlag.equals("Y")
	&& polCoverageFlag == true) {
%> <a CLASS="a03"
href="javascript:call_viewSpec('<%=encryptedID%>','<%=leads_id%>','<%=countyID%>','<%=ocrtextValue%>')">View
Spec</A> <%
}
%>
</td>

<!-- SEPARATOR IMAGE -->
<td class="blueLineBorder">&nbsp;
</td>

<!-- VIEW/VIEWED -->
<td id="v_<%=id%>" align="center" class="black10px"><a
<%if (userviewjobwindow == 0) {%>
 href="javascript:call_detailsNew(<%=id%>,'<%=planExpressFlag%>','<%=ex.getShortCDCID()%>','<%=loginId%>',<%=sJobId%>,'<%=sJobName%>','<%=dmodeSession%>','<%=sessionAllRecords%>','s','<%=pageNum%>');"
<%
} else {
%> href="javascript:call_details(<%=id%>,'<%=planExpressFlag%>','<%=ex.getShortCDCID()%>','<%=loginId%>',<%=sJobId%>,'<%=sJobName%>');"
<%
}
%>> <%
if (searchDao.isProjectViewed(loginId,
 					ex.getShortCDCID(),con)) {
%> <img src="<%=request.getContextPath()%>/images/search_result/LM-VIEWED-Icon-9pt.png" class="viewed" alt="Viewed Details" width="30" height="22" border="0"> 
<%
} else {
%> <img src="<%=request.getContextPath()%>/images/buttons/button_view_icn.gif" alt="View Details" class="view" width="18" height="22" border="0"> <%
}
%>
</a></td>

<!-- PROJECT TRAKCER -->
<td align="center" class="black10px">
	<%
ptMap = searchUtil.getPTDisplay(ex.getTitle(), ex.getbiddate(), ex.getBidsDetails());
	 bDate = String.valueOf(ptMap.get("bidDate"));
	 trackTitle = String.valueOf(ptMap.get("trackTitle"));
	 CDCID = ex.getCDCID();
	 bidsInfo = String.valueOf(ptMap.get("bidsInfo"));
	// When userviewjobwindow is '0' the trac icon is not changed to 'tracked' in brief table.
	// So added below code to get updated status from DB using EJB.
	try{
		
		if (request.getParameter("backSubmit") != null) {
			//Added by Muthu on 02/26/13 to get the Project Tracker status for Individual projects.							  							
			sBean = searchModel.getPTBeanDisplay(CDCID, loginId, con);
			sJobId = sBean.getJobId();
			sJobName = sBean.getJobName();
		}
		
	}
	catch(Exception e){
		System.out.println("Error Calling the function searchUtil.getPTBeanDisplay() with connection object");
	}
	//Added By sathish to get the PT Details from EJBClient
	/* System.out.println("Before JOB");
	sBean = briefProject.getSaveJobID(CDCID, loginId,null);
		 System.out.println("After JOB");
	sJobId = sBean.getJobId();
	sJobName = sBean.getJobName();*/
	
	if (sJobId == 0) {
%> <a id="pt_<%=ex.getContentID()%>"
href="javascript:call_savejob('<%=ex.getCDCID()%>','<%=ex.getpublicationID()%>','<%=ex.getsectionID()%>','<%=trackTitle%>','<%=bDate%>','<%=bidsInfo%>','<%=ex.getPreBidMtgDate()%>','N',<%=ex.getContentID()%>);"> 
<img src="<%=request.getContextPath()%>/images/buttons/button_pt_icn.gif" alt="PT Add" title="Add to Project Tracker" width="23" height="20" border="0">
</a> <a class="displayNone visibilityHidden"
	id="cal_<%=ex.getContentID()%>"
href="javascript:call_calendar(<%=sJobId%>,'<%=ex.getCDCID()%>','<%=trackTitle%>','<%=bDate%>','',' ','')">
<img src="<%=request.getContextPath()%>/images/calendar/calendar.gif" border="0">
</a> <% 
} else {
%> <a href="javascript:call_savejob('<%=ex.getCDCID()%>','<%=ex.getpublicationID()%>','<%=ex.getsectionID()%>','<%=trackTitle%>','<%=bDate%>','<%=bidsInfo%>','<%=ex.getPreBidMtgDate()%>','N',<%=ex.getContentID()%>);">
<img src="<%=request.getContextPath()%>/images/project_tracker/pt.gif" class="paddingTop3" alt="Added" title="Saved to Project Tracker" width="25" height="12" border="0">
</a> <a
	href="javascript:call_calendar(<%=sJobId%>,'<%=ex.getCDCID()%>','<%=sJobName%>','<%=bDate%>','',' ','')">
<img src="<%=request.getContextPath()%>/images/calendar/calendar.gif" border="0">
</a> <% 
}
%>
</td>

<!-- SCREEN/SCREENED -->
<td id="s_<%=id%>" align="center" class="black10px"
valign="middle">
<%
	//exclude projects - new feature added by Johnson on May16th 2011
boolean projectExcludeExists = false;
projectExcludeExists =	searchDao.checkExcludeProjectExists(loginId,ex.getCDCID(),con);
%> <%
if (projectExcludeExists == true) {
%> <a id="<%=ex.getCDCID()%>" class="<%=loginId%>">
<img src="<%=request.getContextPath()%>/images/search_result/ps-screened.gif" onClick="doScreen(this)" alt="Project Screened" class="screened">
</a> <%
} else {
%> <a id="<%=ex.getCDCID()%>" class="<%=loginId%>"> 
<img src="<%=request.getContextPath()%>/images/search_result/ps-screen.gif" onClick="doScreen(this)" alt="Project Screener" class="screen">
</a> <%
}
%>
</td>

<!-- PRINT -->
<td align="center" class="black10px"><a
	href="javascript:print_window('<%=ex.getContentID()%>','<%=ex.getpublicationID()%>');">
<img src="<%=request.getContextPath()%>/images/buttons/button_print_icn.gif" border="0">
	</a></td>
	<td></td>
</tr>
<%
	jobscount = jobscount + 1;
	sJobId = 0;
	z++;
	} //End of While
} //End of Brief root IF
%>
 
 <%
	//Close Data Base Connection
	DBController.releaseDBConnection(con);		  
%>
	</tbody>
</table>
</body>
</html>