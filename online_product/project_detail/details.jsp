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

<%@page import="java.util.regex.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.swing.text.DateFormatter" %>
<%@page import="java.text.*"%>
<%@page import="java.lang.StringBuffer"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.Connection"%>

<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="com.cdc.spring.bean.ContactBean"%>
<%@page import="com.cdc.spring.bean.UserBean"%>
<%@page import="com.cdc.spring.bean.SearchBean"%>
<%@page import="com.cdc.spring.bean.SavedSearchBean"%>
<%@page import="com.cdc.spring.model.SearchModel"%>
<%@page import="com.cdc.spring.model.dao.SearchDao"%>
<%@page import="com.cdc.spring.util.SearchUtil"%>
<%@page import="com.cdc.util.CDCUtil"%>
<%@page import="common.EJBClient"%>
<%@page import="common.SaveBean"%>
<%@page import="common.utils.*"%>
<%@page import="common.bean.*"%>
<%@page import="common.utils.JDBCUtil"%>
<%@page import="leadsconfig.*"%>
<%@page import="briefproject.*"%>
<%@page import="com.cdc.controller.DBController"%>
<%@page import="datavalidation.*"%>
<%@page import="org.springframework.context.ApplicationContext"%>

<%@ taglib prefix="cdc" uri="http://lm.cdcnews.com/mytags"%>

<%
	double rand = Math.random();	// It's for the query string random value in css/script tag to over come brower caching. Added by Muthu on 05/23/13.
	Connection con = null;
	DBController dbContlr = null;
	 if(con == null)
		 con = DBController.getDBConnection();
%>

<html>
<head>
<title>CDCNews details job display</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/sheet-jsp.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/colorbox.css">
<link rel="stylesheet" type="text/css" 	href="<%=request.getContextPath()%>/css/project_detail/details.css">
</head>
<BODY LEFTMARGIN="2" TOPMARGIN="2" RIGHTMARGIN="0" BOTTOMMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0">

<form name="mainform">
<table border="0" cellspacing="0" cellpadding="0" WIDTH="472"> 
  <TR> 
    <TD> <table border="0" align="right" cellpadding="0" cellspacing="0" >
        <tr> 
          <td> <table border="0" cellpadding="0" cellspacing="0" class="borders" >
<%@include file="detailsFormVariables.jsp" %>
<%
	
	 id=request.getParameter("pid"); // cid is changed to pid, since JSF uses 'cid' as conversatio Id. So if you use cid as request parameter,
											//it will give 'No conversation found to restore for id' error.
	 planExpressFlag=request.getParameter("pe");
	 sJobId=0;
	 shortCDCID=request.getParameter("cdc");
	 loginId=request.getParameter("login");
 
	   if(request.getParameter("sJobName")!=null)
	  {
	   sJobName=request.getParameter("sJobName");
	  
	  }
	//Session Creation 
	 map = (java.util.Map)session.getAttribute("cdcnews");
	//Added by Selva
	 searchUtil = new SearchUtil();	 
	 searchModel = new SearchModel();
	 searchDao = new SearchDao();
	 cdcUtil = new CDCUtil();
	 dbContlr = new DBController();
	
	ApplicationContext ac = null;
	

	ac = ApplicationConfig.getApplicationContext(request);
	 userBean = (UserBean) ac.getBean("userBean");
	 contactBean = (ContactBean) ac.getBean("contactBean");
	 sessionLoginId=userBean.getLoginId();
	 //Added by Johnson for ITB validation-May9th2011
	 itbSession = null;
	 if (userBean.getUserFeatures().contains("ITB")) {
		itbSession = "Y";
	}
	 userviewjobwindow = userBean.getUserViewJobWindow(); //(String) map.get("userviewjobwindow");
	 userView="blank";
	 if(request.getParameter("popup")!=null && request.getParameter("popup").trim().equalsIgnoreCase("no") && userviewjobwindow == 0)
		userView="_self";
	 /*Iphone Browser session flag - 090711- to Hide POL icons*/
	 iPhone= userBean.getIsIPhone();//(String)map.get("iPhone");	 
	  
	 briefProject = EJBClient.getBriefProjectEJBean();
	   
	 contentList=searchModel.getContentList(id);
	   
	 if(contentList!=null)
	 {
	 contentIterator = contentList.iterator();
	 while(contentIterator.hasNext())
	 {
		System.out.println("INSIDE LOOP details jsp");
		cbean=(common.bean.ContentBean)contentIterator.next();
	  	scope_title_list = (ArrayList)cbean.getProjectScopeOfWorkTitle();
		division_name_list = (ArrayList)cbean.getDivision_name_list();
		ownersList = cbean.getOwners();
		planHoldersList = cbean.getPlanHolders();
		awardsList = cbean.getAwards();
		lowBiddersList = cbean.getLowBidders();
		subAwardsList = cbean.getSubAwards();
		industryList=cbean.getIndustryList();
		planRoomInfoList=cbean.getplanRoomInfoList();
		enc=new EncryptDecrypt();
			if(map.get("lastkey_to_highlight")!=null)
			{
	 			keyword=(String)map.get("lastkey_to_highlight");				
			}
			else if(map.get("highlighter")!=null) 
			{
				keyword = (String)map.get("highlighter");
			}
			else
			{
				 keyword="hello";
			}
			
			if(map.get("ckwordHighlight")!=null)
			{
			  cKeyword=(String)map.get("ckwordHighlight");
			}
			else
			{
			 cKeyword="hello";
			}

ocrWord=request.getParameter("ocrtextValue");

if(request.getParameter("excludeflag")!=null)
{
  excludeFlag=request.getParameter("excludeflag");
  cdcId=request.getParameter("cdc_id");
  if(excludeFlag!=null  && excludeFlag.equals("Y"))
  {
  
   	searchDao.excludeProject(sessionLoginId,cdcId,con);
	  
  }
  else if(excludeFlag!=null  && excludeFlag.equals("N"))
  {

	  searchDao.deleteExcludeProject(sessionLoginId,cdcId,con);

  }
}

%> 
<input type="hidden" name="ocrtextValue" value="<%=ocrWord%>">


              <!--DISPLAY OF THE PROJECT TITLE-->
              <tr class="row2"> 
                <td height="20" colspan="10" class="white12px"> <b>
                  <%
					 out.println(searchUtil.keywordHighlight(cbean.getTitle(),keyword));
				  %>
                  </b> 
				</TD>
				 <td class="white10px" colspan="10">
				 </td>
               </TR>
              <TR> 
			    <%
					title=cbean.getTitle();
					countyID=String.valueOf(cbean.getCountyID());
                    state_id=String.valueOf(cbean.getStateID()); 
					ocrtextsession=(String)map.get("ocrtext");
				    leads_id=String.valueOf(cbean.getLeadsID());
				    encryptedID=enc.encryptedString(leads_id);
				    polCountyFlag=userBean.getPolCounties();//(String)map.get("polCounties");
				   //POL COVERAGE CHECK FOR EACH PROJECT COUNTY ID
				    strCountyId=countyID.toString();
					//out.println (strCountyId);
					boolean polCoverageFlag = false;
					if(userBean.getPolCountyIdList()!=null && userBean.getPolCountyIdList().size() > 0)
						polCoverageFlag = searchUtil.pcheckPOLCoverage(strCountyId,cdcUtil.getCommaSeparatedString(userBean.getPolCountyIdList()));
				   if(ocrtextsession!=null && !ocrtextsession.equals(""))
				  {
				  	if(ocrtextsession.equals("true") && polCoverageFlag==true){%>
						<td class="black11px"  ><a CLASS="a03" href="javascript:call_viewSpec('<%=encryptedID%>','<%=leads_id%>','<%=countyID%>')">View Spec</A></td>
		  	   	 <%}}%>	
				  <%
				  plansAvailable=cbean.getPlanAvailStatus();
				 /*Iphone Browser session flag - 090711- to Hide POL icons*/
					if(iPhone!=null && iPhone.equals("Y"))
					{
						plansAvailable=null;
					}
				 %>
				  	  <%
						if(plansAvailable!=null && plansAvailable.equals("A") && polCountyFlag!=null && polCountyFlag.equals("Y") && polCoverageFlag==true)
						{%>
							<td width="25" class="black11px" align="center"><a CLASS="a03" href="javascript:call_plansOnline('A','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=cbean.getStateID()%>')"><img src="<%=request.getContextPath()%>/images/pol/plans-available-new1.png" title="Plans Available" width="37" height="28" BORDER="0" ALIGN="absmiddle"></a></td>
						<%}
						else if(plansAvailable!=null &&  plansAvailable.equals("I") && polCountyFlag!=null && polCountyFlag.equals("Y")&& polCoverageFlag==true )
						{%>
							<td width="25" class="black11px" align="center"><a CLASS="a03" href="javascript:call_plansOnline('A','<%=countyID%>','<%=encryptedID%>','1','<%=leads_id%>','<%=cbean.getStateID()%>')"><img src="<%=request.getContextPath()%>/images/pol/plans-addendum-available-new.png" title="Plans Available Info" width="37" height="28" BORDER="0" ALIGN="absmiddle"></a></td>
						<%}
					   else if(plansAvailable!=null && plansAvailable.equals("U") && polCountyFlag!=null && polCountyFlag.equals("Y")&& polCoverageFlag==true)
					   {%>
					   
					   <td width="25" class="black11px" align="center"><a CLASS="a03" href="javascript:call_plansOnline('U','<%=countyID%>','<%=encryptedID%>','C','<%=leads_id%>','<%=cbean.getStateID()%>')"><!--<img src="images/plansUnavailable.gif" title="Plans UnAvailable" width="35" height="32" BORDER="0" ALIGN="absmiddle">--></a></td>
					  <% }
					  else if(plansAvailable!=null && plansAvailable.equals("S") && polCountyFlag!=null && polCountyFlag.equals("Y")&& polCoverageFlag==true){
					  %>
					 <td width="25" class="black11px" align="center"><a CLASS="a03" href="javascript:call_plansOnline('S','<%=countyID%>','<%=encryptedID%>','C','<%=leads_id%>','<%=cbean.getStateID()%>')"><img src="<%=request.getContextPath()%>/images/pol/click-for-plan-status.png" title="Plans Status" width="35" height="32" BORDER="0" ALIGN="absmiddle"></a></td>
					  <%}
					  else if(plansAvailable!=null && plansAvailable.equals("N") && polCountyFlag!=null && polCountyFlag.equals("Y")&& polCoverageFlag==true){
					  %>
					  <td width="25" class="black11px" align="center"><!--<IMG SRC="<%=request.getContextPath()%>/jsp/images/plansNoLongerAvailable.gif" title="Plans No Longer Available" width="35" height="32" BORDER="0" ALIGN="absmiddle"></td>
					  <%}%>	
				<!---ITB Icon--->	
						<%if(itbSession!=null && !itbSession.equals("") && itbSession.equals("Y")){%>		
		<td width="25" class="black11px" align="center" ><a href="javascript:call_ITB('<%=leads_id%>','<%=loginId%>');"><img src="<%=request.getContextPath()%>/images/buttons/button_invitetobid.gif" width="95" height="17" BORDER="0" ></a>		</td>
		<%}%>
		<td width="20" ></td>
		<!---end of ITB Icon--->
               <TD  class="black11px"  height="25" align="right">
                  <%
								   trackTitle=cbean.getTitle().replaceAll("[^a-zA-Z0-9\\s]+","");
								   //trackTitle=cbean.getTitle().replaceAll("\"","");
								    biddate=cbean.getbidDate();
								    if(biddate!=null)
									 {
									    biddateValue=biddate;
									 }
									 else
									 {
									   biddateValue="01-01-00";
									  }
								   if(cbean.getId()!=0)
								   {
								    %>
                				  <%
									  if(request.getParameter("backbutton")!=null)
									  {
									    backbutton=request.getParameter("backbutton");
									    if(backbutton.equals("yes")==true){
								 %>
								<a  class='a03' href="
								<%if(request.getParameter("pmode")!=null){%>
						 javascript:backButton_SubmitForm('<%=(String)request.getParameter("pmode")%>','<%=(String)request.getParameter("pallrec")%>','<%=(String)request.getParameter("pagefrom")%>','<%=(String)request.getParameter("pagenum")%>');
					<%}else{%>
					 javascript:goBackHistory();
					<%}%> " CLASS="a03">	 
                 	<IMG SRC="<%=request.getContextPath()%>/images/buttons/button_back.gif" WIDTH="57" HEIGHT="17" ALT="Go back to Search Results" BORDER="0"></a>&nbsp; 
                  <%}
									 }%>
                  <%
								    
								   }
								    %>
                  <%
				  	//Adds New jobs designation. Added on  02/20/13. Updated on 09/27/13 per Terry Suggestion.
				  	if(userBean.getLastEntry()!=null)
				  	lastEntry = String.valueOf(userBean.getLastEntry());//(String)map.get("lastentry");
					lastEntry = ValidateDate.getDateFromDBDate(lastEntry);
					firstReportedDate = ValidateDate.getDateFromDBDate(cbean.getLeadsEntryDate()); 
					if(ValidateDate.compareDates(firstReportedDate,lastEntry)==1 || ValidateDate.compareDates(firstReportedDate,lastEntry)==0)	// 2-LT;1-GT;0-EQ					
						out.println("<b>NEW</b>");	
					//Shows DE-blue icon. Added by Muthu on 01/07/2013.
					if(searchDao.isDEenabled(sessionLoginId,cbean.getCDCID(),con))
		 			 {
		 		 %>
		  			<img src="<%=request.getContextPath()%>/images/saved_search/Navigation_Blue_Up.gif" alt="DE-Blue icon" border="0">
         		 <%
		  			}
				%>
                 <%
				 					 
								   biDate="1900/01/01";
								   if(cbean.getbidDate()!=null)
								   {
								     biDate=cbean.getbidDate();
								   }
								   bidsInfo=cbean.getBidsDetails();
								   //Implemented on Oct 13th 2011 by Johnson 
								   if(bidsInfo!=null)
								   {
									bidsInfo=bidsInfo.replaceAll("\"","");
									bidsInfo=bidsInfo.replaceAll("'","");
								   }
								   //Added by Muthu on 02/26/13 to get the Project Tracker status for Individual projects.
								    try{
								    
									sBean = new SaveBean();								
									 				
									sBean =  searchModel.getPTBeanDisplay(cbean.getCDCID(), loginId,con);   					
									 					
									sJobId = sBean.getJobId();
									sJobName = sBean.getJobName(); 
									}catch(Exception ex){
										System.out.println("Exception occured in retrieving the PT Info"+ex);
									}   		  
									
								    if(sJobId==0)
										{
									%>
                  <a id="pt_<%=cbean.getId()%>" href="javascript:call_savejob('<%=cbean.getCDCID()%>','<%=cbean.getpublicationID()%>','<%=cbean.getsectionID()%>','<%=trackTitle%>','<%=biDate%>','<%=bidsInfo%>','<%=cbean.getPrebidDate()%>','N','<%=cbean.getId()%>');"><img src="<%=request.getContextPath()%>/images/buttons/button_pt_icn.gif" alt="Add to Project Tracker" width="23" height="20" border="0"></A> 
				  <A class="displayNone visibilityHidden" id="cal_<%=cbean.getId()%>" href="javascript:call_calendar(<%=sJobId%>,'<%=cbean.getId()%>','<%=sJobName%>','<%=biDate%>','',' ','')"><img src="<%=request.getContextPath()%>/images/calendar/calendar.gif" border="0" alt="Calendar"></A> 
				  
                  <%
										
										}
										else{
										
										%>
                  <a href="javascript:call_savejob('<%=cbean.getCDCID()%>','<%=cbean.getpublicationID()%>','<%=cbean.getsectionID()%>','<%=trackTitle%>','<%=biDate%>','<%=bidsInfo%>','<%=cbean.getPrebidDate()%>','N','<%=cbean.getId()%>');"><img src="<%=request.getContextPath()%>/images/project_tracker/pt.gif" alt="Add to Project Tracker" width="25" height="12" border="0"></A> 
                  <A href="javascript:call_calendar(<%=sJobId%>,'<%=cbean.getId()%>','<%=sJobName%>','<%=biDate%>','',' ','')"><img src="<%=request.getContextPath()%>/images/calendar/calendar.gif" border="0" alt="Calendar"></A> 
                  <%
										
										}
										pTitle = cbean.getTitle().replaceAll("\"","\\\"");
										pTitle = pTitle.replaceAll("'","\\\\'");										
								  %>
				 </TD>
				 <TD width="30" ALIGN="right"><!-- Following link added by Gowtham on 05 March 2013 to email details of the project-->
				  <a href="javascript:call_sendProjectDetails('<%=cbean.getId()%>','<%=cbean.getCDCID()%>','<%=pTitle%>')">
					<img src="<%=request.getContextPath()%>/images/email_detail/email_big.gif" title="Email this Project" alt="Email Project" border="0"></A> 
				</TD>
				<td  id="s_<%=cbean.getId()%>" ALIGN="right" class="black10px"   width="30" valign="middle"> 
				<%
				  //exclude projects - new feature added by Johnson on May16th 2011
				  boolean projectExcludeExists=false;
				  projectExcludeExists=searchDao.checkExcludeProjectExists(sessionLoginId,cbean.getCDCID(),con);
				  		  
				  %>
				  
				   <%if(projectExcludeExists==true){%>
				   <a  id="<%=cbean.getCDCID()%>" class="<%=sessionLoginId%>"  class="cursorPointer"><img 
				   src="<%=request.getContextPath()%>/images/search_result/ps-screened.gif" onClick="doScreen(this)" alt="Project Screened" class="screened" title="Project Screened" ></a><%}else{%>
				   <a id="<%=cbean.getCDCID()%>" class="<%=sessionLoginId%>" class="cursorPointer"><img 
				   src="<%=request.getContextPath()%>/images/search_result/ps-screen.gif" onClick="doScreen(this)" alt="Project Screener" class="screen" title="Project Screener"><%}%></a>
				</td>
                <td  ALIGN="right" class="black10px"  width="30" valign="middle"> 
				
                  <a href="javascript:print_window(<%=cbean.getId()%>,<%=cbean.getpublicationID()%>);"> 
                  <img src="<%=request.getContextPath()%>/images/buttons/button_print_icn.gif" border="0" > </a> </TD>
                <%
									bidStages_bidder=ApplicationConfig.BIDSTAGES_BIDDER;
								    if(bidStages_bidder!=null&&bidStages_bidder.toUpperCase().indexOf(cbean.getSubSection().trim())>=0)
					 				{
					 					%>
                <td    align="right" class="black10px"  valign="middle"  width="133"> 
                  &nbsp;<a CLASS="a03" href="javascript:call_addbidder('<%=cbean.getCDCID()%>');"> 
                  <STRONG>Project Info Request</STRONG></a>&nbsp;</td>
                <%	
										
					 				}
					              
									%>
                <td   align="right" class="black10px"  valign="middle"  width="35"> 
                  <a CLASS="a03" target="_blank" href="http://www.mapquest.com/maps/map.adp?searchtype=address&country=US&state=<%=cbean.getStateName()%>&city=<%=cbean.getCity()%>&address=<%=cbean.getStreetAdd()%>"> 
                  <STRONG>Map</STRONG></a>&nbsp; </td>
                <td  class="black10px"  align="right" width="48"> 
                  <%
									
									if(cbean.getjobType().equals("Private"))
									 {%>
                  <img src="<%=request.getContextPath()%>/images/search_result/private.gif" width="44" height="11" border="0"> 
                  <%}else {%>
                  <img src="<%=request.getContextPath()%>/images/search_result/public.gif" width="55" height="15" border="0"> 
                  <%}%>
                </TD>
              </TR>
              <%if(request.getParameter("pe")!=null){%>
              <%if(planExpressFlag!=null && planExpressFlag.equals("C")){%>
              <TR> 
                <TD CLASS="lightblue12px" bgcolor="ffffff"  NOWRAP  colspan="10"> 
                  <a CLASS="a03" href="javascript:call_CProjects('<%=shortCDCID%>')"> 
                  <IMG SRC="<%=request.getContextPath()%>/images/pol/plans_cprojects_icon.gif" ALT="View plans on Cprojects." BORDER="0" ALIGN="absmiddle"> 
                  Plans Online</a> </td>
              </tr>
              <%}else if(planExpressFlag!=null && planExpressFlag.equals("Y")){%>
              <TR> 
                <TD CLASS="lightblue12px" bgcolor="ffffff"  NOWRAP colspan="10"> 
                  <a CLASS="a03" href="javascript:call_PE('<%=shortCDCID%>')"> 
                  <IMG SRC="<%=request.getContextPath()%>/images/pol/plans_icon.gif" ALT="View plans on Aeplans." BORDER="0" ALIGN="absmiddle" WIDTH="20" HEIGHT="23"></a> 
                </TD>
              </TR>
              <%} else if(planExpressFlag!=null && planExpressFlag.equals("L")){%>
              <TR> 
                <TD CLASS="lightblue12px" bgcolor="ffffff" NOWRAP colspan="10"> 
                  <a CLASS="a03" href="javascript:call_Ldi('<%=shortCDCID%>')"> 
                  <IMG SRC="<%=request.getContextPath()%>/images/pol/plans_LDI_icon.gif" ALT="Now featuring plans online at no extra cost!" width="25" height="25" BORDER="0" ALIGN="absmiddle"> 
                  Plans Online</a> </TD>
              </TR>
              <%} 
						   
						    				else if(loginId!=null && loginId.equals("hailing") && planExpressFlag != null && planExpressFlag.trim().equals("A")){%>
              <TR> 
                <TD CLASS="lightblue12px" bgcolor="ffffff"  NOWRAP colspan="10"> 
                  <a CLASS="a03" href="javascript:call_Napco('<%=shortCDCID%>')"> 
                  <IMG SRC="<%=request.getContextPath()%>/images/pol/plans_napco.gif" ALT="View plans on Napco!" BORDER="0" ALIGN="absmiddle"></a> 
                </TD>
              </TR>
              <%}}%>
              <!-- DISPLAY OF THE PROJECT CDCID-->
              <tr class="row2"> 
                <td colspan="10" class="white10px"> 
                  <%
								if( cbean.getCDCID() != null )
								{
                                   String testString=searchUtil.keywordHighlight(cbean.getStateName(),keyword);
									out.println(searchUtil.keywordHighlight(cbean.getCDCID(),keyword));
									//out.println(testString);
									
									
								}
									
								%>
                </TD>
              </TR>
              <!-- THIS IS FOR SUBSECTION-->
              <tr> 
                <td    height="1" class="white10px"> </td>
              </tr>
              <tr class="row2"> 
                <td colspan="10" class="white10px"> 
                  <%
								if( cbean.getSubSection() != null ){
								 sub_sec=cbean.getSubSection();
								 
								 if (sub_sec.equals("PLANNING NEWS"))
								  {
								   subSection="PLANNING";
								  }
								 else if (sub_sec.equals("CONTRACTS AWARDED"))
								  {
								   subSection="AWARD";
								  }
								  else if(sub_sec.equals("PROJECTS"))
								  {
								   subSection="BIDDING";
								   } 
								   else if(sub_sec.equals("BID RESULTS"))
								  {
								   subSection="LOW BID";
								  } 
								   else if(sub_sec.equals("CONTRACTS AWARDED"))
								  {
								   subSection="AWARD";
								   } 
								   else if(sub_sec.equals("BIDS REQUESTED"))
								  {
								   subSection="SUB BIDS";
								  } 
								   else if(sub_sec.equals("AWAITING AWARDS"))
								  {
								   subSection="AWAITING AWARDS";
								  } 
								   else if(sub_sec.equals("DELAYED/HOLD"))
								  {
								   subSection="POSTPONED";
								  } 
								  else
								  {
								   subSection=sub_sec;
								  }
								out.println(searchUtil.keywordHighlight(subSection,keyword));
								}
								%>
                </TD>
              </TR>
              <tr> 
                <td    height="1" class="white10px"> </td>
              </tr>
              <tr class="row2"> 
                <td colspan="10" class="white10px"> 
                  <%
											if(cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
											{
											 out.println(searchUtil.keywordHighlight("New Construction",keyword));
											}
											if(cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
											{
											  out.println(searchUtil.keywordHighlight("Renovation",keyword));
											}
											if (cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
											{
											  out.println(searchUtil.keywordHighlight("Alteration",keyword));
											}
											if (cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
											{
											  out.println(searchUtil.keywordHighlight("Addition",keyword));
											}
											
				 %>
                </TD>
              </TR>
              <!-- THIS IS FOR TITLE-->
              <TR> 
                <td colspan="10"  class="maroon10px"> 
                  <%
										out.println("<b><font face='verdana,arial' size='1'>");
										out.println(searchUtil.keywordHighlight(cbean.getTitle(),keyword));
										out.println("</font></b>");											
				%>
                </TD>
              </TR>
              <!--- IFB NUMBER--->
              <%
										if(cbean.getTitle3()!=null)
										{%>
              <TR> 
                <td colspan="10"  class="black10px" > 
                  <%
				  	out.println(searchUtil.keywordHighlight(cbean.getTitle3(),keyword));
				  %>
                </TD>
              </TR>
              <%} %>
              <TR> 
                <td colspan="10" class="black10px"> <b><font face='verdana,arial' size='1'  class="maroon10px"> 
                  <%out.println(searchUtil.keywordHighlight("LOCATION:",keyword));%>
                  </font></b> 
                  <%
									countyMultiple=cbean.getCountyMultiple();
									stateMultiple=cbean.getStateMultiple();
									out.println(searchUtil.keywordHighlight(cbean.getCity().trim(),keyword) + ",");
									if(stateMultiple!=null && stateMultiple.equals("Y"))
							 		{
									   out.print("US");
								    }
									else
									{
									  out.println(searchUtil.keywordHighlight(cbean.getStateName().trim(),keyword));
									} 
									if(countyMultiple!=null && countyMultiple.equals("Y"))
							 		{
									   out.print("(Multiple Co.)");
								    }
									else
									{
									  out.println("(" + searchUtil.keywordHighlight(cbean.getCounty().trim(),keyword) +" Co.)");
									} 
									out.println(searchUtil.keywordHighlight(cbean.getStreetAdd().trim(),keyword));
									
								%>
                </TD>
              </TR>
              <!-- THIS IS FOR ESTIMATED AMOUNT DETAILS-->
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%				
														if (cbean.getEstimatedAmountLower() != 0 )
															 {
																 if (cbean.getEstimatedAmountLower() != 0 )
																 {
																	amount_lower=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountLower());
																	 out.println("<b>"+searchUtil.keywordHighlight("ESTIMATED AMOUNT:",keyword) +"</b> " + "$" +ValidateNumber.formatAmountString(amount_lower));
																	  if (cbean.getEstimatedAmountUpper() != 0 )
																	 {
																		amount_upper=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountUpper());
																		 out.println(" to " + "$" +ValidateNumber.formatAmountString(amount_upper));
																	 }
																	 out.println("\n");
																  }
															 }
															 else if (cbean.getEstimatedAmountUpper() != 0 )
															 {
																 if (cbean.getEstimatedAmountLower() != 0)
																 {
																	 amount_lower=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountLower());
																	 out.println("<b>"+searchUtil.keywordHighlight("ESTIMATED AMOUNT:",keyword) +"</b> " + "$" +ValidateNumber.formatAmountString(amount_lower));
											
																	 if (cbean.getEstimatedAmountUpper() != 0 )
																	 {
																		 amount_upper=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountUpper());
																		 out.println(" to " + "$" +ValidateNumber.formatAmountString(amount_upper));
																	 }
																	 out.println("\n");
																 }
																%>
                </TD>
                <%}%>
              </TR>
              <!-- THIS IS FOR CONTRACTING METHOD DETAILS-->
              <TR> 
                <td colspan="10" class="black10px" > 
                  <%
								if( cbean.getConMethod() != null){
								out.println("<b><font face='verdana,arial' size='1' >");
								out.println(searchUtil.keywordHighlight("CONTRACTING METHOD:",keyword));
							    out.println(searchUtil.keywordHighlight(cbean.getConMethod(),keyword));
								 out.println("</font></b>");
								}
								
													
					
								%>
                </TD>
              </TR>
              <!-- THIS IS FOR SUFFIX  DETAILS-->
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%
										statusBuf = new StringBuffer();

										 if (cbean.getPrefix() != null &&
											!cbean.getPrefix().trim().equals(""))
										 {
											 statusBuf.append(cbean.getPrefix().trim());
										 }
								
										 if (cbean.getPrefixText() != null &&
											!cbean.getPrefixText().trim().equals(""))
										 {
											 if (statusBuf.length() > 0)
												 statusBuf.append(" ");
								
											 statusBuf.append(cbean.getPrefixText().trim());
										 }
								
										 if (statusBuf.length() > 0
											 && (cbean.getSuffix() != null && !cbean.getSuffix().trim().equals("")
												 || cbean.getSuffixText() != null && !cbean.getSuffixText().trim().equals("")))
										 {
											 statusBuf.append(".");
										 }
								
										 if (cbean.getSuffix() != null &&
											!cbean.getSuffix().trim().equals(""))
										 {
											 if (statusBuf.length() > 0)
												 statusBuf.append(" ");
								
											 statusBuf.append(cbean.getSuffix().trim());
										 }
								
										 if (cbean.getSuffixText() != null &&
											!cbean.getSuffixText().trim().equals(""))
										 {
											 if (statusBuf.length() > 0)
												 statusBuf.append(" ");
								
											statusBuf.append(cbean.getSuffixText().trim());
										 }
								
										 // Add a period at the end
										 if (statusBuf.length() > 0 &&
											 ! statusBuf.substring(statusBuf.length()-1, statusBuf.length()).equals("."))
										 {
											 statusBuf.append(".");
										 }
								
										 status = statusBuf.toString();
								
										 if (status != null && !status.trim().equals(""))
										 {
											 if(cbean.getPublishDate() != null)
											 {
											 out.println("<b><font face='verdana,arial' size='1' >");
											 out.println(searchUtil.keywordHighlight("UPDATE:",keyword));
										     out.println("</font></b>");
											 out.println("<b>"+searchUtil.keywordHighlight(status.trim(),keyword));
											 }
											 
											 else
											 {
											 out.println("<b><font face='verdana,arial' size='1' >");
											 out.println(searchUtil.keywordHighlight("STATUS:",keyword));
											 out.println("</font></b>");
											 out.println("<b>"+searchUtil.keywordHighlight(status.trim(),keyword));
											 
											 }
											 
										 }
									%>
                </TD>
              </TR>
              <!--DISPLAY OF THE PROJECT BIDS DETAILS-->
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%
							
							if( cbean.getBidsDetails() != null && cbean.getBidsDetails().equals("")==false
							 && (cbean.getSubSection().equals("PROJECTS") || cbean.getSubSection().equals("AWAITING AWARDS")))
							{
								out.println("<b><font face='verdana,arial' size='1' >");
							    out.println(searchUtil.keywordHighlight("BIDS DUE:",keyword));
								out.println("</font></b>");
								
								if(cbean.getbidDate()!=null)
								{
								out.println("<font face='verdana,arial' size='1' >");
								usLocale=new Locale("EN","us");
			     		        sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				                tempdate=sdf.parse(cbean.getbidDate());
				                sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			    convertedDate=sdf.format(tempdate);
								out.println("<B>");
						        out.println(searchUtil.keywordHighlight(""+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(convertedDate)),keyword)+"");
								out.println("</B>");
							    }
								out.println(searchUtil.keywordHighlight(cbean.getBidsDetails(),keyword)+"</font><br>");
							}
								if(cbean.getSubSection()!=null && cbean.getSubSection().equals("BID RESULTS"))
								{
								      bidsopened_date=cbean.getbidsOpenDate();
									  newBiddate=cbean.getNewBidDate();
									 if (bidsopened_date != null)
										  bidsopened_date = bidsopened_date.trim();
						
									  if (newBiddate != null)
										  newBiddate = newBiddate.trim();
						
										out.println("<b><font face='verdana,arial' size='1' >");
									  if (bidsopened_date != null && !bidsopened_date.equals(""))
									  {
										   out.println(searchUtil.keywordHighlight("BIDS OPENED:",keyword)
											  + ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(bidsopened_date))+"<br>");
									 }
									  else if (newBiddate != null && !newBiddate.equals(""))
									  {
										  out.println(searchUtil.keywordHighlight("BIDS OPENED:",keyword)
											  + ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(newBiddate))+"<br>");
										}
									  out.println("</font></b>");
									  }
							//Opening Date as per Rick's request -added by Johnson(01/13/2011)	
							 bidsopened_date=cbean.getbidsOpenDate();
							 openingDateText=cbean.getbidsOpenDateText();
							 
							 if(cbean.getSubSection()!=null && cbean.getSubSection().equals("PROJECTS"))
							{
							 
							 if (bidsopened_date != null)
								 bidsopened_date = bidsopened_date.trim();
					
							 if (openingDateText != null)
								 openingDateText = openingDateText.trim();
					
							 if (bidsopened_date != null && !bidsopened_date.equals(""))
							 {
								 out.println("<b><font face='verdana,arial' size='1' >");
								 out.println("BIDS OPENED: "
									 + ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(bidsopened_date)));
					
								 if (openingDateText != null && !openingDateText.equals(""))
								 {
									 out.println(" " + openingDateText);
								 }
								 out.println("</font></b>");
								 
							 }
							 
							} 
							/*This is for printing the values for SUB BIDS*/
								
								subbidDueDate = "";
								if(cbean.getSubSection()!=null && cbean.getSubSection().equals("BIDS REQUESTED"))
								{
								 duedate=cbean.getNewBidDate();
								 biddate_text=cbean.getBidsDetails();
								if (duedate != null)
             							duedate = duedate.trim();

									 if (biddate_text != null)
										 biddate_text = biddate_text.trim();
							
									 if (duedate != null && !duedate.equals(""))
									 {
										 subbidDueDate = ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(duedate)) + " ";
									 }
							
									 if (biddate_text != null && !biddate_text.equals(""))
									 {
										 strtok = new StringTokenizer(biddate_text);
										 int ctr = 0;
										 while (strtok.hasMoreTokens())
										 {
											 token = strtok.nextToken();
											 // Print "As Soon As Possible" only if the first element is ASAP
											 if (token.toUpperCase().equals("ASAP") && ctr == 0)
											 {
												 if (duedate != null && !duedate.equals(""))
												 	subbidDueDate += "As Soon As Possible ";
												 else
													 subbidDueDate = "As Soon As Possible ";
												 subbidDueDate+= " ";
											 }
											 else
											 {
												 subbidDueDate+= token + " ";
											 }
											 ctr++;
										 }
									 }
							
									 if (subbidDueDate!=null && !subbidDueDate.equals(""))
									 {
										 out.println("<b><font face='verdana,arial' size='1' >");
										 out.println(searchUtil.keywordHighlight("SUB BIDS DUE: ",keyword)+subbidDueDate + "<br>");
										 out.println("</font></b>");
									 }
								
								}
							%>
                </TD>
              </TR>
              <!--THIS IS FOR FILED SUBBID AND ITS STATUS-->
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%
				         
                  	filedsubbid_date = "";
					 filedsubbid_text = "";
					 printDate = "";
					 
					 if (cbean.getfiledSubbidDate() != null)
						 filedsubbid_date = cbean.getfiledSubbidDate().trim();
						
			
					 if (cbean.getfiledSubbidText() != null)
						 filedsubbid_text = cbean.getfiledSubbidText().trim();
						
			
					 if (cbean.getPublishDate() != null)
						 printDate = cbean.getPublishDate().trim();
						
			
					 if (filedsubbid_date != null && !filedsubbid_date.equals(""))
					 {
						 fmt_filedsubbid_date = ValidateDate.getDateFromDBDate(filedsubbid_date);
						 fmt_print_date = ValidateDate.getDateString(printDate);
						             
						 if (ValidateDate.compareDates(fmt_filedsubbid_date,fmt_print_date) == 2)
						 {
							 dateLabel = "<b><font face='verdana,arial' size='1' >FILED SUB-BIDS WERE DUE: </b></font>";
						 }
						 else
						 {
							 dateLabel = "<b><font face='verdana,arial' size='1' >FILED SUB-BIDS DUE:</b></font> ";
						 }
			
						 out.println("<font face='verdana,arial' size='1' >"+searchUtil.keywordHighlight(dateLabel,keyword)+"</font>");
						 out.println("<font face='verdana,arial' size='1' >"+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(filedsubbid_date))+"</font>");
			
						 if (filedsubbid_text != null && !filedsubbid_text.equals(""))
						 {
							 out.println("<font face='verdana,arial' size='1' > "+searchUtil.keywordHighlight(filedsubbid_text,keyword)+"</font>");
						 }
			        }
					 else if (filedsubbid_text != null && !filedsubbid_text.equals(""))
					 {
						 out.println("<b><font face='verdana,arial' size='1' >"+ searchUtil.keywordHighlight("FILED SUB-BIDS DUE:",keyword)+"</b></font>");
						 out.println("<font face='verdana,arial' size='1' >"+searchUtil.keywordHighlight(filedsubbid_text,keyword)+"</font>");
					 }
				%>
                </TD>
              </TR>
              <!-- THIS IS FOR START DATE DETAILS-->
              <%
								if(cbean.getEstimatedStartDate()!=null && !cbean.getEstimatedStartDate().equals(""))
								{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <% 
								 
								 out.println("<b><font face='verdana,arial' size='1' >");
								 out.println(searchUtil.keywordHighlight("Start Date:  ",keyword));
								 out.println("</font></b>");
								 formattedStrtDt=ValidateDate.formatPrintableDate(cbean.getEstimatedStartDate());
								 if (formattedStrtDt != null)
								 {
								  out.println(formattedStrtDt);
								 }
								 else
								 {
								  out.println(cbean.getEstimatedStartDate());
								 }
								%>
                </TD>
              </TR>
              <%}%>
              <!-- THIS IS FOR  END DATE DETAILS-->
              <%
						if(cbean.getEstimatedEndDate()!=null && cbean.getEstimatedEndDate().equals("")==false)
						{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size = '1' >");
						 out.println(searchUtil.keywordHighlight("End Date:  ",keyword));
						 out.println("</font></b>");
						  formattedEndDt=ValidateDate.formatPrintableDate(cbean.getEstimatedEndDate());
								 if (formattedEndDt != null)
								 {
								  out.println(formattedEndDt);
								 }
								 else
								 {
								  out.println(cbean.getEstimatedEndDate());
								 }
						%>
                </TD>
              </TR>
              <%}%>
              <!-- THIS IS FOR NO OF DAYS-->
              <%
							if( cbean.getCompletionDays() != null && cbean.getCompletionDays().equals("")==false){
							%>
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println(searchUtil.keywordHighlight("No of Days:  ",keyword));
							out.println("</font></b>");
							out.println(searchUtil.keywordHighlight((cbean.getCompletionDays()),keyword));%>
                </TD>
              </TR>
              <%}	%>
              <!--DISPLAY FOR PROJECT COMPLETION DAYS-->
              <%
							if( cbean.getProjCompletion() != null && cbean.getProjCompletion().equals("")==false){
							%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println(searchUtil.keywordHighlight("% Comp:  ",keyword));
							out.println("</font></b>");
							 out.println(searchUtil.keywordHighlight((cbean.getProjCompletion()),keyword));
							%>
                </TD>
              </TR>
              <%}%>
              <tr > 
                <td colspan="10" class="black10px"> 
                  <%
				  
				  						
									  if (cbean.getOwners()!=null)
									 {
										 // The indexList list keeps track of the indexes of the contacts that have been
										 // printed in the loop.
										  indexList = new ArrayList();
										 int i = 0;
										 // Search for "OWNER" in the list.
										 ownerKeyWords = "OWNER";
										 boolean found_owner = false;
										 boolean allOwners = true;
										 last_owner_title = "";
										 newLine="\n";
										 itrOwner = ownersList.iterator();

										 while (itrOwner.hasNext())
										 {
											 currentContact = (common.bean.ExtractContact)itrOwner.next();
											 contactType = currentContact.getContactTypeText().trim();
											if (ownerKeyWords.equalsIgnoreCase(contactType))
											 {
												 // Owner found. Remember the index, print it to files and break loop.
												 indexList.add(new Integer(i));
												  // For printing company name, check if there's any semi-colon. If there is any,
												 // parse it and print text on the right of semicolon to the left of company name.
												 company_name="";
												 if(currentContact.getCompanyName()!=null)
													 company_name = currentContact.getCompanyName().trim();
													 
												 int name_length = company_name.length();
												 int semicolon_index = company_name.indexOf(";");
												 if (semicolon_index != -1)
												 {
													 company_name = company_name.substring(semicolon_index+1,name_length)
																	 + " "
																	 + company_name.substring(0, semicolon_index);
												 }

												 company_name = company_name.replace(':','.');
												 // Project Contact Link
												 out.println
													 ("<b>"+searchUtil.keywordHighlight(contactType.toUpperCase().trim(),cKeyword)+":</b> ");
													 
												 if(company_name!=null && company_name.trim().length()>0){	 
													 out.println("<a class='a03' href=javascript:PopContacts(\'"+currentContact.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"') >"
													 +searchUtil.keywordHighlight(company_name.trim(),cKeyword)+"</a>");
													 }													 
													 boolean print_newline = false;
													 out.println("<br>");
												 if (currentContact.getAddress1() != null && !currentContact.getAddress1().equals(""))
												 {
													 out.println(searchUtil.keywordHighlight((currentContact.getAddress1()),cKeyword)+", ");
													 print_newline = true;
													 
												 }
												 if (currentContact.getCity() != null && !currentContact.getCity().equals(""))
												 {
													 out.println(searchUtil.keywordHighlight(currentContact.getCity().trim(),cKeyword)+", ");
													// out.println(currentContact.getCity()+",");
													 print_newline = true;
												 }
												
												 if ((currentContact.getAddress1() != null && !currentContact.getAddress1().equals("")) || (currentContact.getCity() != null && !currentContact.getCity().equals("")))
												 {
													 out.println(searchUtil.keywordHighlight(currentContact.getStateCode().trim(),cKeyword));
													 print_newline = true;
												 }
												 if (currentContact.getZip() != null && !currentContact.getZip().trim().equals(""))
												 {

													 // New Zip Code Formatting Logic
													 formattedZip = ValidateNumber.formatZipCode(currentContact.getZip().trim());
													 if (formattedZip != null)
													 {
														 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword));
														 print_newline = true;
													 }
												 }
												//temp comment
												/* */if (print_newline)
												 {
													 out.println("<br>");

												 }

											   if (currentContact.getTelephone1() != null && !currentContact.getTelephone1().trim().equals(""))
												 {
													 formattedTel = searchUtil.removeSpecialChars(currentContact.getTelephone1().trim());
													 phone_int=null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 	System.out.println("ERROR while formatting Telephone1: "+e);
													 }

													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println(searchUtil.keywordHighlight(formattedTel,cKeyword));
													 }
													 else
													 {
														 out.println(currentContact.getTelephone1().trim());
													 }
												 }

												  // Print telephone 2 if telephone 1 is missing.
												 if (currentContact.getTelephone1() == null &&
													 currentContact.getTelephone2() != null &&
													 !currentContact.getTelephone2().trim().equals(""))
												 {
													 formattedTel = searchUtil.removeSpecialChars(currentContact.getTelephone2().trim());
													 phone_int=null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 	System.out.println("ERROR while formatting Telephone2: "+e);
													 }

													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println(searchUtil.keywordHighlight(formattedTel,cKeyword)+"");
													 }
													 else
													 {
														 out.println(searchUtil.keywordHighlight(currentContact.getTelephone2().trim(),keyword)+" ");
													 }
												 }
												  if (currentContact.getFax1() != null && !currentContact.getFax1().trim().equals(""))
												 {
													 formattedTel = searchUtil.removeSpecialChars(currentContact.getFax1().trim());
													 phone_int=null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 	System.out.println("ERROR while formatting Fax1: "+e);
													 }

													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println("FAX# "+searchUtil.keywordHighlight(formattedTel,cKeyword));
													 }
													 else
													 {
														 out.println("FAX# "+searchUtil.keywordHighlight(currentContact.getFax1().trim(),cKeyword)+" ");
													 }
													 
													 
													 
													 
												 }
												 	//CONTACT PERSON DETAILS
												    if(currentContact.getContactPersonName()!=null && !currentContact.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(currentContact.getContactPersonEmail()!=null && !currentContact.getContactPersonEmail().equals("") && currentContact.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=currentContact.getContactPersonEmail()%>"><%=currentContact.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(currentContact.getContactPersonName()!=null && !currentContact.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+currentContact.getContactPersonName().trim()+"</b>");
													 }
													 if(currentContact.getContactPersonPhone()!=null && !currentContact.getContactPersonPhone().trim().equals(""))
													 {
													   formattedTelNo = searchUtil.removeSpecialChars(currentContact.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println("Phone#:"+formattedTelNo);
													   
													 }
													 if(currentContact.getContactPersonFax()!=null && !currentContact.getContactPersonFax().trim().equals(""))
													 {
													   formattedFaxNo = searchUtil.removeSpecialChars(currentContact.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   out.println("Fax#:"+formattedFaxNo);
													  }
													  if (print_newline)
													 out.println("<br>");

											   }
											 // Index counter
											 i++;
             }
										 // If allOwners flag is true, print rest of the owners.
										 if (allOwners)
										 {

											 // Print remainint Owner type contacts in the list. indexList now
											 // contains indexes of the contacts that haven't been printed yet.
											 if (indexList.size() < ownersList.size())
											 {
											   outerloop:for (int ownerCounter=0; ownerCounter < ownersList.size(); ownerCounter++)
											   {
												 listitr = indexList.iterator();
													while (listitr.hasNext())
													 {
														 if (ownerCounter == ((Integer)listitr.next()).intValue())
															 continue outerloop;
													 }
												  // If it reaches here, owner is not printed. Print it now.
													contactOthers = (common.bean.ExtractContact)ownersList.get(ownerCounter);
													 contactTypeOthers="";
													 if(contactOthers.getContactTypeText()!=null)
													 	contactTypeOthers = contactOthers.getContactTypeText().trim();

													 /*// For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.*/
													 companyNameOthers="";
													 if(contactOthers.getCompanyName()!=null)
														 companyNameOthers = contactOthers.getCompanyName().trim();
														 
													 int nameLengthothers = companyNameOthers.length();
													 int semicolonIndexOthers = companyNameOthers.indexOf(";");
													  if (semicolonIndexOthers != -1)
													 {
														 companyNameOthers = companyNameOthers.substring(semicolonIndexOthers+1,nameLengthothers)
																		 + " "
																		 + companyNameOthers.substring(0, semicolonIndexOthers);

													 }

													 companyNameOthers = companyNameOthers.replace(':','.');

													 // out.println(contactType.toUpperCase()+": "+company_name+newLine);
													 // Project Contact Link
													 if(contactTypeOthers!=null && contactTypeOthers.trim().length()>0)
														 out.println("<b>"+searchUtil.keywordHighlight(contactTypeOthers.toUpperCase(),cKeyword)+":</b> ");													 
													 if(companyNameOthers!=null && companyNameOthers.trim().length()>0){
														 out.println("<a class='a03' href=javascript:PopContacts(\'"+contactOthers.getContactID()+"\','"
														 	 + URLEncoder.encode(companyNameOthers.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"')>"
														 +searchUtil.keywordHighlight(companyNameOthers,cKeyword)+"</a>");
														 }
													out.println("<br>");

														  boolean print_newline = false;
													 if (contactOthers.getAddress1() != null && !contactOthers.getAddress1().equals("") )
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getAddress1().trim(),cKeyword)+", ");
														 print_newline = true;
													 }

													 if (contactOthers.getCity() != null && !contactOthers.getCity().equals(""))
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getCity().trim(),cKeyword)+", ");
														 print_newline = true;
													 }

													 if ((contactOthers.getAddress1() != null && !contactOthers.getAddress1().equals("") ) || (contactOthers.getCity() != null && !contactOthers.getCity().equals("")))
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getStateCode().trim(),cKeyword)+", ");
														 print_newline = true;
													 }

													 if (contactOthers.getZip() != null && !contactOthers.getZip().trim().equals(""))
													 {
														 formattedZip = ValidateNumber.formatZipCode(contactOthers.getZip().trim());
														 if (formattedZip != null)
														 {
															 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword));
															 print_newline = true;
														 }
													 }
													  if (print_newline)
													 {
														 out.println("<br>");
													 }
													  if (contactOthers.getTelephone1() != null && !contactOthers.getTelephone1().trim().equals(""))
													 {
														 formattedTel = searchUtil.removeSpecialChars(contactOthers.getTelephone1().trim());
														 phone_int=null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 	System.out.println("ERROR while formatting Telephone1 Other Contacts: "+e);
														 }

														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println(searchUtil.keywordHighlight(formattedTel,cKeyword)+"");
														 }
														 else
														 {
															 out.println(searchUtil.keywordHighlight(contactOthers.getTelephone1().trim(),cKeyword)+" ");
														 }
													 }
													   // Print telephone2 if telephone1 is missing
													 if (contactOthers.getTelephone1() == null &&
														 contactOthers.getTelephone2() != null &&
														 !contactOthers.getTelephone2().trim().equals(""))
													 {
														 formattedTel = searchUtil.removeSpecialChars(contactOthers.getTelephone2().trim());
														 phone_int=null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 	System.out.println("ERROR while formatting Telephone2 Other Contacts: "+e);
														 }

														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println(searchUtil.keywordHighlight(formattedTel,cKeyword)+"");
														 }
														 else
														 {
															 out.println(searchUtil.keywordHighlight(contactOthers.getTelephone2().trim(),cKeyword));
														 }
													 }
													if (contactOthers.getFax1() != null && !contactOthers.getFax1().trim().equals(""))
													 {
														 formattedTel = searchUtil.removeSpecialChars(contactOthers.getFax1().trim());
														 phone_int = null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 	System.out.println("ERROR while formatting Fax1 Other Contacts: "+e);
														 }

														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);

														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(formattedTel,cKeyword));
														 }
														 else
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(contactOthers.getFax1().trim(),cKeyword));
														 }
													 }
                                                       
												    //CONTACT PERSON DETAILS
												    if(contactOthers.getContactPersonName()!=null && !contactOthers.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(contactOthers.getContactPersonEmail()!=null  && !contactOthers.getContactPersonEmail().equals("") && contactOthers.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=contactOthers.getContactPersonEmail()%>"><%=contactOthers.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactOthers.getContactPersonName()!=null && !contactOthers.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactOthers.getContactPersonName().trim()+"</b>");
													 }
													 if(contactOthers.getContactPersonPhone()!=null && !contactOthers.getContactPersonPhone().trim().equals(""))
													 {
													   String formattedTelNo = searchUtil.removeSpecialChars(contactOthers.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+formattedTelNo);
													   
													 }
													 if(contactOthers.getContactPersonFax()!=null && !contactOthers.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactOthers.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+formattedFaxNo);
													   
													 }
                                                       
													  if (print_newline)
														 out.println("<br>");

												 }
											 }
										 }
									 }

								
								  
								   %>
                </td>
              </tr>
              <%
						boolean boolean_size = false;
						if( (cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
						|| (cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
						|| (cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
						|| (cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
						){%>
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%
								//out.println("SIZE : ");
								boolean_size=true;
							}
							
							sqft_story_text = new StringBuffer();
								int counter=0;
							if((cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y")) && 
								(cbean.getSqrftDetailsNew() != null || cbean.getDistributedAcresNew() != null 
								|| cbean.getParkingSpaceNew() != null || cbean.getStoriesNew()>0
								|| cbean.getSqrftNew()>0 ))
							{
								//out.println();
								
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			                     
								 sqft_story_text.append("<b class='colorBlack'>"+"New Construction"+","+"</b>");
				                 //out.println("<b>"+"New Construction,"+"</b>");
								if(cbean.getSqrftNew()>0)
								 {
								   sqft_story_text.append(" " + ValidateNumber.formatAmountString(String.valueOf(cbean.getSqrftNew())));
								   
								 }
								if(cbean.getSqrftUnitNew()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftUnitNew().trim());
									 counter++;
								 }				 
								if(cbean.getSqrftDetailsNew()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftDetailsNew().trim());
									 counter++;
								 }
								 
								 
								 
								if(cbean.getStoriesNew()>0)
								 {
									 String story_string = String.valueOf(cbean.getStoriesNew());
									 
								 
									int stories = Integer.parseInt(story_string);
									if( stories > 0)
									{
			
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one story");
												break;
											case 2:
												sqft_story_text.append(" two stories");
												break;
											case 3:
												sqft_story_text.append(" three stories");
												break;
											case 4:
												sqft_story_text.append(" four stories");
												break;
											case 5:
												sqft_story_text.append(" five stories");
												break;
											case 6:
												sqft_story_text.append(" six stories");
												break;
											case 7:
												sqft_story_text.append(" seven stories");
												break;
											case 8:
												sqft_story_text.append(" eight stories");
												break;
											case 9:
												sqft_story_text.append(" nine stories");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" stories");
										}
										counter++;
									}
			
			
							  
								   
							 }
							 //out.println("sqft_story_text"+sqft_story_text);
												
								if (cbean.getDistributedAcresNew() !=null)
								{
								   if(counter>0)
									   sqft_story_text.append(",");
									sqft_story_text.append(" "+
												   cbean.getDistributedAcresNew()+
												   " disturbed acres");
									counter++;
			
								}
								
								if (cbean.getParkingSpaceNew() !=null)
								{
								 if(counter>0)
										sqft_story_text.append(",");
										sqft_story_text.append(" "+
												cbean.getParkingSpaceNew()+
												" parking spaces");
									 counter++;
			
			
								}
								
								
									   //sqft_story_text.append(temp_sqft.getSFText().trim()+ ",");
								 if (cbean.getAboveGradeNew()!=null)
								 {
									 story_string =String.valueOf(cbean.getAboveGradeNew().trim());
									 int stories = Integer.parseInt(story_string);
									 if( stories > 0)
									{
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one above grade");
												break;
											case 2:

												sqft_story_text.append(" two above grade");
												break;
											case 3:
												sqft_story_text.append(
													" three above grade");
												break;
											case 4:
												sqft_story_text.append(
													" four above grade");
												break;
											case 5:
												sqft_story_text.append(
													" five above grade");
												break;
											case 6:
												sqft_story_text.append(" six above grade");
												break;
											case 7:
												sqft_story_text.append(
													" seven above grade");
												break;
											case 8:
												sqft_story_text.append(
													" eight above grade");
												break;
											case 9:
												sqft_story_text.append(
													" nine above grade");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" above grade");
										}
										counter++;
									}
								 }
								
								 if (cbean.getBelowGradeNew() != null )
								{
									String story_string = String.valueOf(cbean.getBelowGradeNew().trim());
									
									
			
									int stories = Integer.parseInt(story_string);
									if( stories > 0)
								   {
			
									   if (counter > 0)
										   sqft_story_text.append(", ");
										   switch (stories) {
											   case 1:
												   sqft_story_text.append(
													   " one below grade");
												   break;
											   case 2:
												   sqft_story_text.append(
													   " two below grade");
												   break;
											   case 3:
												   sqft_story_text.append(
													   " three below grade");
												   break;
											   case 4:
												   sqft_story_text.append(
													   " four below grade");
												   break;
											   case 5:
												   sqft_story_text.append(
													   " five below grade");
												   break;
											   case 6:
												   sqft_story_text.append(
													   " six below grade");
												   break;
											   case 7:
												   sqft_story_text.append(
													   " seven below grade");
												   break;
											   case 8:
												   sqft_story_text.append(
													   " eight below grade");
												   break;
											   case 9:
												   sqft_story_text.append(
													   " nine below grade");
												   break;
											   default:
												   sqft_story_text.append(" " +
													   story_string.trim() +
													   " below grade");
										   }
										   counter++;
								   }
								}
			
							
								
							}
			
							/*****************************RENOVATION********************************/
							if((cbean.getConst_ren() != null &&	cbean.getConst_ren().equals("Y")) && 
								(cbean.getSqrftDetailsRen() != null || cbean.getDistributedAcresRen() != null 
								|| cbean.getParkingSpaceRen() != null || cbean.getStoriesRen()>0 
								|| cbean.getSqrftRen()>0))
							{
								//StringBuffer sqft_story_text = new StringBuffer();
								//int counter=0;
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b class='colorBlack'>"+"Renovation,"+"</b>");
								// out.println("<b>"+"Renovation,"+"</b>");
								
								if(cbean.getSqrftRen()>0)
								 {
										  
			
									 sqft_story_text.append(" " +
															ValidateNumber.
															formatAmountString(String.valueOf(cbean.getSqrftRen())));
								   
								 }
								
								
								if(cbean.getSqrftUnitRen()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftUnitRen().trim());
									 counter++;
								 }				 
								
								if(cbean.getSqrftDetailsRen()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftDetailsRen().trim());
									 counter++;
								 }
								 
								 
								if(cbean.getStoriesRen()>0)
								 {
									 story_string = String.valueOf(cbean.getStoriesRen());
									 int stories = Integer.parseInt(story_string);
									if( stories > 0)
									{
			
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one story");
												break;
											case 2:
												sqft_story_text.append(" two stories");
												break;
											case 3:
												sqft_story_text.append(" three stories");
												break;
											case 4:
												sqft_story_text.append(" four stories");
												break;
											case 5:
												sqft_story_text.append(" five stories");
												break;
											case 6:
												sqft_story_text.append(" six stories");
												break;
											case 7:
												sqft_story_text.append(" seven stories");
												break;
											case 8:
												sqft_story_text.append(" eight stories");
												break;
											case 9:
												sqft_story_text.append(" nine stories");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" stories");
										}
										counter++;
									}
			
			
							   
								 
								
								   
							 }
							 //out.println("sqft_story_text"+sqft_story_text);
												
								if (cbean.getDistributedAcresRen() !=null)
								{
								   if(counter>0)
									   sqft_story_text.append(",");
									sqft_story_text.append(" "+
												   cbean.getDistributedAcresRen()+
												   " disturbed acres");
									counter++;
			
								}
								
								if (cbean.getParkingSpaceRen() !=null)
								{
								 if(counter>0)
										sqft_story_text.append(",");
										sqft_story_text.append(" "+
												cbean.getParkingSpaceRen()+
												" parking spaces");
									 counter++;
			
			
								}
								
								
								
								
							}
							/************************************ALTERATION*****************************************************/
							
							if((cbean.getConst_alt() != null &&	cbean.getConst_alt().equals("Y")) && 
								(cbean.getSqrftDetailsAlt() != null || cbean.getDistributedAcresAlt() != null 
								|| cbean.getParkingSpaceAlt() != null || cbean.getStoriesAlt()>0 
								|| cbean.getSqrftAlt()>0))
							{
								out.println();
							//	StringBuffer sqft_story_text = new StringBuffer();
							  //  int counter=0;
							 
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b class='colorBlack'>"+"Alteration,"+"</b>");
								  //out.println("<b>"+"Alteration,"+"</b>");
								
								if(cbean.getSqrftAlt()>0)
								 {
									sqft_story_text.append(" " +
															ValidateNumber.
															formatAmountString(String.valueOf(cbean.getSqrftAlt())));
								 }
								
								
								if(cbean.getSqrftUnitAlt()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftUnitAlt().trim());
									 counter++;
								 }				 
								
								 if(cbean.getSqrftDetailsAlt()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftDetailsAlt().trim());
									 counter++;
								 }
								 
								 
								if(cbean.getStoriesAlt()>0)
								 {
									 story_string = String.valueOf(cbean.getStoriesAlt());
									 int stories = Integer.parseInt(story_string);
									if( stories > 0)
									{
			
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one story");
												break;
											case 2:
												sqft_story_text.append(" two stories");
												break;
											case 3:
												sqft_story_text.append(" three stories");
												break;
											case 4:
												sqft_story_text.append(" four stories");
												break;
											case 5:
												sqft_story_text.append(" five stories");
												break;
											case 6:
												sqft_story_text.append(" six stories");
												break;
											case 7:
												sqft_story_text.append(" seven stories");
												break;
											case 8:
												sqft_story_text.append(" eight stories");
												break;
											case 9:
												sqft_story_text.append(" nine stories");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" stories");
										}
										counter++;
									}
			
			
							   
								
								   
							 }
							 //out.println("sqft_story_text"+sqft_story_text);
												
								if (cbean.getDistributedAcresAlt() !=null)
								{
								   if(counter>0)
									   sqft_story_text.append(",");
									sqft_story_text.append(" "+
												   cbean.getDistributedAcresAlt()+
												   " disturbed acres");
									counter++;
			
								}
								
								if (cbean.getParkingSpaceAlt() !=null)
								{
								 if(counter>0)
										sqft_story_text.append(",");
										sqft_story_text.append(" "+
												cbean.getParkingSpaceAlt()+
												" parking spaces");
									 counter++;
			
			
								}
								/*  if (sqft_story_text.length() > 0)
								{
									
									out.println(sqft_story_text.toString()+"<br>");
								}
								*/
								
							}
							if((cbean.getConst_add() != null &&	cbean.getConst_add().equals("Y")) && 
								(cbean.getSqrftDetailsAdd() != null || cbean.getDistributedAcresAdd() != null 
								|| cbean.getParkingSpaceAdd() != null || cbean.getStoriesAdd()>0 
								|| cbean.getSqrftAdd()>0))
							{

							//	StringBuffer sqft_story_text = new StringBuffer();
							 //   int counter=0;
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b class='colorBlack'>"+"Addition"+ ",</b>");
								//out.println("<b>"+"Addition,"+"</b>");
								
								if(cbean.getSqrftAdd()>0)
								 {
										  
			
									 sqft_story_text.append(" " +
															ValidateNumber.
															formatAmountString(String.valueOf(cbean.getSqrftAdd())));
								   
								 }
								
								
								if(cbean.getSqrftUnitAdd()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftUnitAdd().trim());
									 counter++;
								 }				 
								
								  if(cbean.getSqrftDetailsAdd()!=null)
								 {
									 if (counter > 0)
											sqft_story_text.append(", ");
									 sqft_story_text.append(" " + cbean.getSqrftDetailsAdd().trim());
									 counter++;
								 }
								 
								 
								if(cbean.getStoriesAdd()>0)
								 {
									 story_string = String.valueOf(cbean.getStoriesAdd());
									 
								   
									int stories = Integer.parseInt(story_string);
									if( stories > 0)
									{
			
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one story");
												break;
											case 2:
												sqft_story_text.append(" two stories");
												break;
											case 3:
												sqft_story_text.append(" three stories");
												break;
											case 4:
												sqft_story_text.append(" four stories");
												break;
											case 5:
												sqft_story_text.append(" five stories");

												break;
											case 6:
												sqft_story_text.append(" six stories");
												break;
											case 7:
												sqft_story_text.append(" seven stories");
												break;
											case 8:
												sqft_story_text.append(" eight stories");
												break;
											case 9:
												sqft_story_text.append(" nine stories");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" stories");
										}
										counter++;
									}
			
			
								
								   
							 }
							 //out.println("sqft_story_text"+sqft_story_text);
												
								if (cbean.getDistributedAcresAdd() !=null)
								{
								   if(counter>0)
									   sqft_story_text.append(",");
									sqft_story_text.append(" "+
												   cbean.getDistributedAcresAdd()+
												   " disturbed acres");
									counter++;
			
								}
								
								if (cbean.getParkingSpaceAdd() !=null)
								{
								 if(counter>0)
										sqft_story_text.append(",");
										sqft_story_text.append(" "+
												cbean.getParkingSpaceAdd()+
												" parking spaces");
									 counter++;
			
			
								}
								
								
									   //sqft_story_text.append(temp_sqft.getSFText().trim()+ ",");
								 if (cbean.getAboveGradeAdd()!=null)
								 {
									 story_string =String.valueOf(cbean.getAboveGradeAdd().trim());
									
									 
									   
									 int stories = Integer.parseInt(story_string);
									 if( stories > 0)
									{
			
										if (counter > 0)
											sqft_story_text.append(", ");
			
										switch (stories) {
											case 1:
												sqft_story_text.append(" one above grade");
												break;
											case 2:
												sqft_story_text.append(" two above grade");
												break;
											case 3:
												sqft_story_text.append(
													" three above grade");
												break;
											case 4:
												sqft_story_text.append(
													" four above grade");
												break;
											case 5:
												sqft_story_text.append(
													" five above grade");
												break;
											case 6:
												sqft_story_text.append(" six above grade");
												break;
											case 7:
												sqft_story_text.append(
													" seven above grade");
												break;
											case 8:
												sqft_story_text.append(
													" eight above grade");
												break;
											case 9:
												sqft_story_text.append(
													" nine above grade");
												break;
											default:
												sqft_story_text.append(" " +
													story_string.trim() +
													" above grade");
										}
										counter++;
									}
								 }
								
								 if (cbean.getBelowGradeAdd() != null )
								{
									story_string = String.valueOf(cbean.getBelowGradeAdd().trim());
									
									if (story_string.indexOf(" over") >= 0)
										story_string = story_string.substring(5,
											story_string.length());
			
									int stories = Integer.parseInt(story_string);
									if( stories > 0)
								   {
			
									   if (counter > 0)
										   sqft_story_text.append(", ");
										   switch (stories) {
											   case 1:
												   sqft_story_text.append(
													   " one below grade");
												   break;
											   case 2:
												   sqft_story_text.append(
													   " two below grade");
												   break;
											   case 3:
												   sqft_story_text.append(
													   " three below grade");
												   break;
											   case 4:
												   sqft_story_text.append(
													   " four below grade");
												   break;
											   case 5:
												   sqft_story_text.append(
													   " five below grade");
												   break;
											   case 6:
												   sqft_story_text.append(
													   " six below grade");
												   break;
											   case 7:
												   sqft_story_text.append(
													   " seven below grade");
												   break;
											   case 8:
												   sqft_story_text.append(
													   " eight below grade");
												   break;
											   case 9:
												   sqft_story_text.append(
													   " nine below grade");
												   break;
											   default:
												   sqft_story_text.append(" " +
													   story_string.trim() +
													   " below grade");
										   }
										   counter++;
								   }
								}
			
							
								
							}
							 /*  if (sqft_story_text.length() > 0)
								{
									
									//out.println("SIZE :"+searchUtil.keywordHighlight(sqft_story_text.toString(),keyword)+"<br>");
									out.println("SIZE:"+sqft_story_text.toString()+"<br>");
								}*/
									 if(sqft_story_text.length() > 0 && sqft_story_text.indexOf(keyword)>0)
									{
									  out.println("<b>"+ searchUtil.keywordHighlight("SIZE: ",keyword)+"</b>"+searchUtil.keywordHighlight(sqft_story_text.toString(),keyword)+"<br>");
									}
									else if(sqft_story_text.length() > 0)
									{
									 out.println("<b>"+ searchUtil.keywordHighlight("SIZE: ",keyword)+"</b>"+searchUtil.keywordHighlight(sqft_story_text.toString(),keyword)+"<br>");
									}			
								if(boolean_size){
									//out.println(cbean.getTotalSqrft() + " " + cbean.getTotalSqrft());
									//out.println("Stories"+cbean.getTotalStories()+"SqftUnitTotal"+cbean.getSqrftTotalunit()+"Sqft Total:"+cbean.getTotalSqrft());
								%>
                </TD>
              </TR>
              <% }%>
              <!--DETAILS TABLE-USE FIELD COLUMN NAME-DETAILS1-->
              <%  
					if(	((String)cbean.getDetail1()) != null && cbean.getDetail1().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%
									out.println("<b><font face='verdana,arial' size='1' >");
									out.println(searchUtil.keywordHighlight("USE:",keyword));
									out.println("</font></b>");
									if (cbean.getNationalChain() != null && cbean.getNationalChain().equals("Y"))
             						{
                 						out.println(searchUtil.keywordHighlight("National Chain.",keyword));
										//out.println("National Chain.");
             						}
									out.println(searchUtil.keywordHighlight(cbean.getDetail1(),keyword));
								%>
                </TD>
              </TR>
              <%	}
				%>
              <!-- THIS IS FOR SCOPE DETAILS-->
              <%
						 			 
							if( (scope_title_list != null) && (scope_title_list.size()>0) ){%>
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%
								out.println("<b>"+searchUtil.keywordHighlight("SCOPE: ",keyword)+"</b>");
								itr = scope_title_list.iterator();
								boolean b = false;
								int countScope=0;
								int scopeListSize=scope_title_list.size();
								while(itr.hasNext())
								{
								 	scopeData=(ExtractScopeOfWorkData)itr.next();
									scopeStr=scopeData.getScopeOfWorkTitle();
									
									if(countScope==0)
									{
									  scopeStrList=scopeStr;
									 }
									else
									{
									  scopeStrList=scopeStrList+", "+scopeStr;
									  }
								   countScope++;
								 
								}
								out.println(searchUtil.keywordHighlight(scopeStrList,keyword));
							%>
                </TD>
              </TR>
              <% } 
			   else if(cbean.getDetail2() != null && cbean.getDetail2().equals("")==false)
			  {%>
              <TR> 
                <td colspan="5" class="black10px"> 
                  <%
					out.println("<b>"+searchUtil.keywordHighlight("SCOPE: ",keyword)+"</b>");
					out.println(searchUtil.keywordHighlight(cbean.getDetail2().trim(),keyword));
				  %>
                </TD>
              </TR>			  
			  <% }
				
%>
              <!-- THIS IS FOR MIEQ DETAILS-->
              <TR > 
                <TD colspan="10" class="black10px"> 
                  <%  
								
								if(	((String)cbean.getMIEQText()) != null && cbean.getMIEQText().equals("")==false)
									{
										
										
										out.println("<table width='100%' class='MIEQ_tableLayout'><tr><td><pre   class='MIEQ_Details' width='70%'><B>"+searchUtil.keywordHighlight("MIEQ:",keyword)+" </B>"+searchUtil.keywordHighlight(cbean.getMIEQText().trim(),keyword)+"</pre></td></tr></table>");
																	
									}
							%>
                </TD>
              </TR>
              <!--DISPLAY OF DIVISIONS-->
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%
			
				
				if(cbean.getHashmap() != null){
				out.println("<b>"+searchUtil.keywordHighlight("DIVISION:",keyword)+"</b> <BR>");
					hashmap = (HashMap)cbean.getHashmap();				
					al = new ArrayList((Set)hashmap.keySet());
					Collections.sort(al);
					itr3 = al.iterator();
					boolean b = false;
					while(itr3.hasNext()){					
							s = (String)itr3.next();
							out.println("<b>");
							out.println(searchUtil.keywordHighlight("Div"+Integer.parseInt(s),keyword));							
							out.println("</b>");
							 	al1 = (ArrayList)hashmap.get(s);
								int countDiv=0;
								int ListSize=al1.size();
							    	Iterator itr2 = al1.iterator();									
							    	while(itr2.hasNext()){
									divStr=((String)itr2.next()).trim();
							 
										 if(countDiv==0)
											{
											  divList=divStr;
											 }
											else
											{
											  divList=divList+", "+divStr.trim();
											}
										   countDiv++;
									}//while
									out.println("<font face='verdana,arial' size='1' >"+searchUtil.keywordHighlight(divList,keyword).trim().toLowerCase()+"</font>");					
							%>
                  <br> 
                  <%
			
				b=false;
						}					
					
				}//if
				
			
			%>
                </TD>
              </TR>
              <!-- THIS IS FOR SPECIAL CONDITION 1 DETAILS-->
              <%  
								if(	((String)cbean.getSpecialConditions1()) != null && cbean.getSpecialConditions1().equals("")==false)
								{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
									out.println(searchUtil.keywordHighlight("Spec Cond:",keyword));
									out.println("</font></b>");
									out.println(searchUtil.keywordHighlight(cbean.getSpecialConditions1(),keyword));%>
                </TD>
              </TR>
              <%}
					  %>
              <!-- THIS IS FOR SPECIAL CONDITION 2 DETAILS-->
              <%  
							if(((String)cbean.getSpecialConditions2()) != null && cbean.getSpecialConditions2().equals("")==false)
							{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
								out.println(searchUtil.keywordHighlight("Spec Cond:",keyword));
								out.println("</font></b>");
								out.println(searchUtil.keywordHighlight(cbean.getSpecialConditions2(),keyword));%>
                </TD>
              </TR>
              <%}
					  %>
              <!--DISPLAY OF  NOTES---->
              <%  
								if(	((String)cbean.getDetail3()) != null && cbean.getDetail3().trim().equals("")==false)
								{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%String details3=cbean.getDetail3();
									out.println("<pre width='70%' cols='300' WRAP class='displayNotes'><b><font face='verdana,arial' size='1' >");
									out.println(searchUtil.keywordHighlight("NOTES:",keyword));
									out.println("</font></b>");
									out.println(searchUtil.keywordHighlight(details3,keyword)+"</pre>");
						
									%>
                </TD>
              </TR>
              <%}
							%>
              <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE1-->
              <%
						if(	((String)cbean.getDetailTitle1()) != null && cbean.getDetailTitle1().equals("")==false)
						{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println(searchUtil.keywordHighlight("CONTACT:",keyword));
							out.println("</font></b>");
							out.println(searchUtil.keywordHighlight(cbean.getDetailTitle1(),keyword));%>
                </TD>
              </TR>
              <% }
						
					%>
              <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE2-->
              <%
					if(	((String)cbean.getDetailTitle2()) != null && cbean.getDetailTitle2().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
						out.println(searchUtil.keywordHighlight("CONTACT:",keyword));
						out.println("</font></b>");
						out.println(searchUtil.keywordHighlight(cbean.getDetailTitle2(),keyword));%>
                </TD>
              </TR>
              <%}
				%>
              <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE3-->
              <%
					if(	((String)cbean.getDetailTitle3()) != null && cbean.getDetailTitle3().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
						out.println(searchUtil.keywordHighlight("CONTACT:",keyword));
						out.println("</font></b>");
						out.println(searchUtil.keywordHighlight(cbean.getDetailTitle3(),keyword));%>
                </TD>
              </TR>
              <%}
				%>
              <!--This is for PLANS-->
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%  
					
					 plansTitle=cbean.getplansAvailableTitle();
					 plansText=cbean.getplansAvailableFrom();
					 
					 if ((plansTitle!= null && !plansTitle.trim().equals("")) && (plansText!= null && !plansText.trim().equals("")))
					 {
					  out.println(" <b>"+searchUtil.keywordHighlight(plansTitle,keyword)+":</b> "+searchUtil.keywordHighlight(plansText,keyword));
					  
					 } 
					
					 if (cbean.getplansAvailableDate() != null)
             		{
						plansAvailDate=ValidateDate.getDateStringMMDDYY(cbean.getplansAvailableDate());			
						if (ValidateDate.checkFromToDate(plansAvailDate,ValidateDate.getTodayDateMMDDYY()) == false)
              				{
			                     out.println(",available on or about  " +ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cbean.getplansAvailableDate())));
              			    }
			         }
					
				%>
                </TD>
              </TR>
              <!-- THIS IS FOR PLAN DEPOSIT-->
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <% 
					    amount= Double.toString(cbean.getplanDeposit());
						
  						if(cbean.getplanDeposit()>0)
							{
								out.println("<font face='verdana,arial' size='1' >");
								out.println(searchUtil.keywordHighlight("PLAN DEP:",keyword)+" $"+ValidateNumber.formatAmountStringWithDecimal(amount,2, 2));
								out.println("</font>");
							}
								 // Print refundable text
                 			if (cbean.getRefundText() != null && !cbean.getRefundText().trim().equals(leadsconfig.LeadsConfig.REFUND_TEXT1))
                 			{
                    		 out.println(searchUtil.keywordHighlight(cbean.getRefundText().trim(),keyword));
                 			}
							  // Print refundable details
                 			if (cbean.getRefundDetails() != null
                    		 && !cbean.getRefundDetails().trim().equals(""))
                 			{
                    			 out.println(" " + searchUtil.keywordHighlight(cbean.getRefundDetails().trim(),keyword));
                 			}
                 
				  %>
                </TD>
              </TR>
              <!-- THIS IS FOR MAILING FEE DEPOSIT-->
              <% 
				    mailingFee= Double.toString(cbean.getmailingFee());
					if(cbean.getmailingFee()>0)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(searchUtil.keywordHighlight("MAILING FEE:",keyword)+"$"+searchUtil.keywordHighlight(ValidateNumber.formatAmountStringWithDecimal(mailingFee,2,2),keyword));
					
					out.println("</font>");%>
                </TD>
              </TR>
              <%	}
				%>
              <!-- THIS IS FOR BID BOND PERCT-->
              <% 
				   if(cbean.getbidBondPerct() != null && cbean.getbidBondPerct().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
						if (ValidateNumber.isNumber(cbean.getbidBondPerct().trim()))
            			 {
                			 out.println(searchUtil.keywordHighlight("BID BOND: ",keyword)+searchUtil.keywordHighlight(cbean.getbidBondPerct(),keyword)+"%");
             			 }
						 else
						 {
						 
						  out.println(searchUtil.keywordHighlight("BID BOND: ",keyword)+searchUtil.keywordHighlight(cbean.getbidBondPerct(),keyword));
						 }

						
					
						out.println("</font>");%>
                </TD>
              </TR>
              <%}
				
				%>
              <!--Certified/Cashiers need to be incoporated here-->
              <% 
				    if(cbean.getCertCashFlag()!=null)
					{
                     	certCashFlag=cbean.getCertCashFlag();
						
						%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%if(certCashFlag !=null && certCashFlag.trim().equals("Y"))
						{
							out.println("<font face='verdana,arial' size='1' >");
							out.println(searchUtil.keywordHighlight("Certified/Cashiers Check",keyword));
					 		out.println("</font>");
						}%>
                </TD>
              </TR>
              <%}	
				%>
              <!-- THIS IS FOR BID BOND STD RANGE-->
              <% 
				 if(cbean.getbidBondStdRange() != null && cbean.getbidBondStdRange().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(searchUtil.keywordHighlight(cbean.getbidBondStdRange(),keyword));
					
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- THIS IS FOR PERF BOND -->
              <% 
				  if(cbean.getperfBondText() != null && cbean.getperfBondText().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(searchUtil.keywordHighlight("PERF. BOND:",keyword)+searchUtil.keywordHighlight(cbean.getperfBondText(),keyword));
 
					 if (cbean.getperfBondText().indexOf("$") == -1)
             		{
                 		out.println("%" + "<br>");
             		}
             		else
             		{
                		 out.println("<br>");
             		}	
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- THIS IS FOR PAYMENT BOND -->
              <% 
				   if(cbean.getpayBondPerct() != null && cbean.getpayBondPerct().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
							out.println(searchUtil.keywordHighlight("PAYMENT BOND:"+cbean.getpayBondPerct(),keyword)+"%");
					
							out.println("</font>");%>
                  <%	}
				%>
                </TD>
              </TR>
              <!-- THIS IS FOR MAINTENANCE BOND -->
              <% 
				    
  
				   
					if(cbean.getmaintBondPerct() != null && cbean.getmaintBondPerct().equals("")==false)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(searchUtil.keywordHighlight("MAINT. BOND:"+cbean.getmaintBondPerct(),keyword)+"%");
					
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <tr> 
                <td class="black10px" colspan="10"> 
                  <%  
								 if((cbean.getPrebidDate()!=null && !cbean.getPrebidDate().trim().equals(""))
					  || (cbean.getPrebidMeetText()!=null && !cbean.getPrebidMeetText().trim().equals("")))
					  {
						 
						 if(cbean.getPrebidDate()!=null && !cbean.getPrebidDate().trim().equals(""))
						 {
						  out.println("<B>");
						  out.println("A");
						 
						 }
						 else
						 {
						  out.println("<B>");
						 }
						 if(cbean.getmandatoryMeetFlag()!=null && cbean.getmandatoryMeetFlag().trim().equals("Y"))
						 {
						 	out.println(searchUtil.keywordHighlight("Mandatory",keyword));
						 }
						if(cbean.getsitePrebidFlag()!=null && cbean.getsitePrebidFlag().trim().equals("S"))
						 {
						   out.println(searchUtil.keywordHighlight("Site Visit",keyword));
						 }
						 else if(cbean.getsitePrebidFlag()!=null && cbean.getsitePrebidFlag().trim().equals("P"))
						 {
						    out.println(searchUtil.keywordHighlight("Pre-bid Meeting",keyword));
						 }
						 else if(cbean.getsitePrebidFlag()!=null && cbean.getsitePrebidFlag().trim().equals("J"))
						 {
						   out.println(searchUtil.keywordHighlight("Job Walk",keyword));
						 }
						if(cbean.getPrebidDate() != null &&
										 ! cbean.getPrebidDate().equals(""))
						  {
								 // Convert printdate in MM/DD/YYYY format
								 printDatee=ValidateDate.getTodayDate();
								 formattedPrintDate = (printDatee);
								  if (formattedPrintDate != null)
								 {
								 	 formattedPrebidMDate = ValidateDate.getDateFromDBDate(cbean.getPrebidDate());
									
									 if (formattedPrebidMDate != null)
									 {
									 	int ret_val = ValidateDate.compareDates(formattedPrintDate,formattedPrebidMDate);
										
										 if (ret_val == 0 || ret_val == 2)
											 was_willbe = "will be held ";
										 else if (ret_val == 1)
											 was_willbe = "was held ";
				
										 printableDate = ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cbean.getPrebidDate()));
										 if (was_willbe != null)
										 {
											 out.println(searchUtil.keywordHighlight(was_willbe+"on " +printableDate+" ",keyword));
										 }
									 }
								 }
							} // End of if(currentProject.getPrebidMeetDate() != null ...)
							 if(cbean.getPrebidMeetText()!=null)
							 out.println(searchUtil.keywordHighlight(cbean.getPrebidMeetText().trim(),keyword)+" ");
							 out.println("</B>");
						
						 }
							 else
						 {
							 if (cbean.getprebidMeetDetails() != null &&
								 !cbean.getprebidMeetDetails().trim().equals("N"))
							 {
								 if (cbean.getprebidMeetDetails().trim().equals("T"))
								 {
									 //out.println("Pre-bid Meeting: To Be Announced");
									 out.println(searchUtil.keywordHighlight("Pre-bid Meeting: To Be Announced",keyword));
								 }
								 else if (cbean.getprebidMeetDetails().trim().equals("U"))
								 {
									 //out.println("Pre-bid Meeting: Unobtainable at Press Time");
									 out.println(searchUtil.keywordHighlight("Pre-bid Meeting: Unobtainable at Press Time",keyword));
									 
								 }
								 else if (cbean.getprebidMeetDetails().trim().equals("S"))
								 {
									// out.println("Pre-bid Meeting: None Scheduled");
									 out.println(searchUtil.keywordHighlight("Pre-bid Meeting: None Scheduled",keyword));
								 }
								 
							 }
						 }
						 
	 
	 
	  %>
                </td>
              </tr>
              <!-- THIS IS FOR Plan Room Info List-->
              <%
						 			 
						if( (planRoomInfoList != null) && (planRoomInfoList.size()>0) ){%>
              <TR> 
                <td colspan="10"  class="maroon10px" > 
                  <%
							itrPlanRoomInfo = planRoomInfoList.iterator();
								
								while(itrPlanRoomInfo.hasNext())
								{
								 PlanRoomBean pBean=(PlanRoomBean)itrPlanRoomInfo.next();
									out.println("<b>"+searchUtil.keywordHighlight(pBean.getPlanroomDescription(),keyword));
									if(pBean.getPlanBinnumber()!=null)
									out.println(searchUtil.keywordHighlight("Plan Bin Number :"+pBean.getPlanBinnumber(),keyword));
									
								}
							%>
                </TD>
              </TR>
              <% }%>
              <!-- Print DBC Prequalification required-->
              <% 
				    
                     if(cbean.getdbcPreQualFlag()!=null)
					{
                     	dbcPreQualFlag=cbean.getdbcPreQualFlag();%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%if(dbcPreQualFlag.trim().equals("Y")==true)
						{
				   			out.println("<font face='verdana,arial' size='1' >");
                         	out.println(searchUtil.keywordHighlight("D.B.C. Pre-qualification required",keyword));
							out.println("</font>");
						}%>
                </TD>
              </TR>
              <%}%>
              <!-- Print 100% set aside for small business-->
              <% 
				   
                     if(cbean.getSmallBusinessFlag()!=null)
					{
                     	smallBusinessFlag=cbean.getSmallBusinessFlag();%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%if(smallBusinessFlag.trim().equals("Y")==true)
						{
				   			out.println("<font face='verdana,arial' size='1' >");
                            out.println(searchUtil.keywordHighlight("100% Set Aside for Small Business",keyword));
							out.println("</font>");
						}%>
                </TD>
              </TR>
              <%}
				%>
              <!-- Print WBE/MBE required-->
              <% 
				   
                     if(cbean.getWbeMbeFlag()!=null)
					{
                     	WbeMbeFlag=cbean.getWbeMbeFlag();%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%if(WbeMbeFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' >");
                            out.println(searchUtil.keywordHighlight("WBE/MBE Required",keyword));
							out.println("</font>");
						}%>
                </TD>
              </TR>
              <%}
				%>
              <!-- Print prequalification required text-->
              <% 
				   
                     if(cbean.getpreQualFlag()!=null)
					{
                     	 preQualFlag=cbean.getpreQualFlag();
					 %>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%if(preQualFlag!=null && preQualFlag.trim().equals("Y")==true)
						{
				   			out.println("<font face='verdana,arial' size='1' >");
                          	out.println(searchUtil.keywordHighlight("<b>"+"Pre-qualification Required"+"</b>",keyword));
							out.println("</font>");
						}%>
                </TD>
              </TR>
              <%	}
				%>
              <!-- Print pre-qualification due date-->
              <% 
				   
                     if(cbean.getpreQualDate()!=null)
					{%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%Locale usLocale=new Locale("EN","us");
     		     		 sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				 		 tempdate=sdf.parse(cbean.getpreQualDate());
				 		cd=sdf.format(tempdate);
				 		out.println("<b><font face='verdana,arial' size='1' >");
				 		out.println("<b> "+searchUtil.keywordHighlight("Pre-qualification due:"+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd)),keyword)+"</b>");
						out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is MBE-->
              <%  
					if(	((String)cbean.getMBE()) != null && cbean.getMBE().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getMBE()+searchUtil.keywordHighlight("% MBE",keyword));
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is other pre-qualifications-->
              <%  
					if(	((String)cbean.getOtherPreQual()) != null && cbean.getOtherPreQual().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
					out.println(searchUtil.keywordHighlight(cbean.getOtherPreQual(),keyword));
					out.println("</b></font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is WBE-->
              <%  
					if(	((String)cbean.getWBE()) != null && cbean.getWBE().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					//out.println(searchUtil.keywordHighlight(cbean.getWBE(),keyword)+ "%" + " WBE");
					out.println(cbean.getWBE()+searchUtil.keywordHighlight("% WBE",keyword));
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is DBE-->
              <%  
					if(	((String)cbean.getDBE()) != null && cbean.getDBE().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%	out.println("<font face='verdana,arial' size='1' >");
					//out.println(searchUtil.keywordHighlight(cbean.getDBE(),keyword)+ "%" + " DBE");
					out.println(cbean.getDBE()+searchUtil.keywordHighlight("% DBE",keyword));
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is DVBE-->
              <%  
					if(	((String)cbean.getDVBE()) != null && cbean.getDVBE().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getDVBE()+searchUtil.keywordHighlight("% DVBE",keyword));
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is HUB-->
              <%  
					if(	((String)cbean.getHUB()) != null && cbean.getHUB().equals("")==false){%>
              <TR> 
                <TD colspan="10" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getHUB()+searchUtil.keywordHighlight("% HUB",keyword));
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- THIS IS FOR Industry DETAILS-->
              <%
							if( (industryList != null) && (industryList.size()>0) ){%>
              <TR> 
                <td colspan="10" class="black10px"> 
                  <%
								
								out.println(searchUtil.keywordHighlight("Industry Type: ",keyword));
								itrIndustry = industryList.iterator();
								indMap=new HashMap();
								subIndMap=new HashMap();
								IndustryBean ibean=null;
								while(itrIndustry.hasNext())
								{
									ibean=(IndustryBean)itrIndustry.next();
									indMap.put(ibean.getIndustry(),ibean.getIndustry());
									//out.println("sub indus"+ibean.getSubIndustry());
									subIndMap.put(ibean.getSubIndustry(),ibean.getSubIndustry());  
									mainInd=indMap.keySet().toString().replace('[',' ').replace(']',' ');
									subInd=subIndMap.keySet().toString().replace('[',' ').replace(']',' ');
								}
								stInd = new StringTokenizer(mainInd,",");
								while (stInd.hasMoreTokens()) {
  								 Industry=stInd.nextToken();
  								 if(request.getParameter("popup")!=null && request.getParameter("popup").trim().equalsIgnoreCase("no") && userBean.getUserViewJobWindow()==0){
  									 %>
  									  <a class='a03' href="<%=request.getContextPath()%>/online-product/search-results/industry-project-list?industry=<%=Industry.trim().replaceAll(" ", "+")%>&popup=no&jsp=yes" target="_self"><%=searchUtil.keywordHighlight(Industry.trim(),keyword)%></a>
  									 <%
  								 } else {
  									 %> 
  									  <a class='a03' href="javascript:PopupIndustryProjects('industry', '<%=Industry.trim().replaceAll(" ", "+")%>')" target="_self"><%=searchUtil.keywordHighlight(Industry.trim(),keyword)%></a>
  									 <%
  								 }
								} 
								out.println("<br>");
								out.println("Industry Sub Type:");
								StringTokenizer st = new StringTokenizer(subInd,",");
								while (st.hasMoreTokens()) {
  								 subIndustry=st.nextToken();
  								 
  								if(request.getParameter("popup")!=null && request.getParameter("popup").trim().equalsIgnoreCase("no") && userBean.getUserViewJobWindow()==0){
 									 %>
 									  <a class='a03' href="<%=request.getContextPath()%>/online-product/search-results/industry-project-list?industrySub=<%=subIndustry.trim().replaceAll(" ", "+")%>&popup=no&jsp=yes" target="_self"><%=searchUtil.keywordHighlight(subIndustry.trim(),keyword)%></a>
 									 <%
 								 } else {
 									 %> 
 									   <a class='a03' href="javascript:PopupIndustryProjects('industrySub', '<%=subIndustry.trim().replaceAll(" ", "+")%>')" target="_self"><%=searchUtil.keywordHighlight(subIndustry.trim(),keyword)%></a>
 									 <%
 								 }
  								
								} 
							%>
                </TD>
              </TR>
              <% }%>
            <!---THIS IS FOR DISPLAY OF LOW BIDDERS LIST--->
                      <% 
					              if (lowBiddersList != null && lowBiddersList.size() > 0)
									 {%>
                      <tr> 
                        <td  class="black10px" colspan="10" > 
                          <% if (lowBiddersList.size() > 1)
										 {
											 out.println("<b>"+searchUtil.keywordHighlight("Apparent Low Bidders:",cKeyword)+"</b>"+"<br>");
										 }
										 else
										 {
											 out.println("<b>"+searchUtil.keywordHighlight("Apparent Low Bidder:",cKeyword)+"</b>"+"<br>");
										 }
										  // header keeps track of any titles that need to be printed for a group of low bidders
										int lowbidder_count = 0;  // keeps count of low bidders to print numbers
										 boolean printDetails = true; // Decides whether to print details for low-bidder or not.
										 itrLowBidder = lowBiddersList.iterator();
										 while (itrLowBidder.hasNext())
										 {
											 lowbidder_count++;
							
											 contactlowBidders = (common.bean.ExtractContact) itrLowBidder.next();
											 if (prev_contacttype == null && contactlowBidders.getContactTypeText() != null
													 && !contactlowBidders.getContactTypeText().trim().equals(""))
											 {
												 prev_contacttype = contactlowBidders.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactlowBidders.getContactTypeText().trim(),cKeyword)+"</b>"+"<br> ");
												 // Print details for this contact now.
												 printDetails = true;
												 lowbidder_count = 1;    // Reset counter.
											 }
											 // check if header has changed
											 else if (prev_contacttype != null && contactlowBidders.getContactTypeText() != null
													 && !contactlowBidders.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
											 {
												 prev_contacttype = contactlowBidders.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactlowBidders.getContactTypeText().trim(),cKeyword)+"</b>"+"<br> ");
												 // Print details for this contact now.
												 printDetails = true;
												 lowbidder_count = 1;    // Reset counter.
											 }
											   // Now print the contact and bidding amount
												 if (contactlowBidders.getCompanyName() != null && !contactlowBidders.getCompanyName().trim().equals(""))
												 {
													 // For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.
													 company_name = contactlowBidders.getCompanyName().trim();
													 int name_length = company_name.length();
													 int semicolon_index = company_name.indexOf(";");
													 if (semicolon_index != -1)
													 {
														 company_name = company_name.substring(semicolon_index+1,name_length)
																		 + " "
																		 + company_name.substring(0, semicolon_index);
													 }
								
													 //fHH.getWebFileWriter().write(lowbidder_count+". "+company_name);
													 // Project Contact Link
													  out.println("<b>"+lowbidder_count+". "
														 +"</b><a class='a03' href=javascript:PopContacts(\'"+contactlowBidders.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"') >"
														 +searchUtil.keywordHighlight(company_name,cKeyword)+"</a>");
								
								
													 amt = contactlowBidders.getLowBidAmount();
													
													 if (amt != null)
														 //lowbid_amount = ValidateNumber.formatAmountString(amt.toString());
														 lowbid_amount = ValidateNumber.formatAmountStringWithDecimal(amt.toString(),2,2);
								
													 if ( lowbid_amount != null)
													 {
														  out.println("  $"+lowbid_amount);
													 }
													  out.println("<br>");
												 }

											     // Print details if printDetails flag is true.
												 if (printDetails)
												 {
													 printDetails = false;
													 boolean print_newline = false;
													 if (contactlowBidders.getFax1() != null && !contactlowBidders.getFax1().trim().equals(""))
													 {
														 fax_no = searchUtil.removeSpecialChars(contactlowBidders.getFax1().trim());
								
														 try
														 {
															 fax_no_int = new Long(fax_no);
														 }
														 catch (Exception e)
														 {
														 }
								
														 fax_no = ValidateNumber.formatPhoneNumber(fax_no);
								
														 if (fax_no != null && fax_no_int != null && fax_no_int.intValue() != 0)
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(fax_no,keyword));
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(contactlowBidders.getFax1().trim(),cKeyword));
															 print_newline = true;
														 }
								
													 }
													  if (contactlowBidders.getAddress1() != null && !contactlowBidders.getAddress1().trim().equals(""))
														 {
															 String commaStr="";
															 if (fax_no != null && fax_no_int != null
																				&& fax_no_int.intValue() != 0) {
																 commaStr=",";
															 }
															 out.println(commaStr+searchUtil.keywordHighlight(contactlowBidders.getAddress1().trim(),keyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getCity() != null && !contactlowBidders.getCity().trim().equals(""))
														 {
															 out.println(searchUtil.keywordHighlight(contactlowBidders.getCity().trim(),cKeyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getAddress1() != null || contactlowBidders.getCity() != null)
														 {
															 out.println(searchUtil.keywordHighlight(contactlowBidders.getStateCode().trim(),cKeyword));
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getZip() != null && !contactlowBidders.getZip().trim().equals(""))
														 {
															 formattedZip = ValidateNumber.formatZipCode(contactlowBidders.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,keyword));
																 print_newline = true;
															 }
														 }
														 
														 if (contactlowBidders.getTelephone1() != null && !contactlowBidders.getTelephone1().trim().equals(""))
														 {
															 tel_no = searchUtil.removeSpecialChars(contactlowBidders.getTelephone1().trim());
									
															 try
															 {
																 tel_no_int = new Long(tel_no);
															 }
															 catch (Exception e)
															 {
															 }
															 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
									
															 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
															 {
																 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(searchUtil.keywordHighlight(contactlowBidders.getTelephone1().trim(),cKeyword));
																 print_newline = true;
															 }
									
														 }
														 // If telephone1 is missing, print telephone2
														 if (contactlowBidders.getTelephone1() == null &&
														 contactlowBidders.getTelephone2() != null &&
														 !contactlowBidders.getTelephone2().trim().equals(""))
														 {
															 tel_no = searchUtil.removeSpecialChars(contactlowBidders.getTelephone2().trim());
									
															 try
															 {
																 tel_no_int = new Long(tel_no);
															 }
															 catch (Exception e)
															 {
															 }
															 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
									
															 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
															 {
																 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(searchUtil.keywordHighlight(contactlowBidders.getTelephone2().trim(),cKeyword));
																 print_newline = true;
															 }
									
														 }
														  //CONTACT PERSON DETAILS
												    if(contactlowBidders.getContactPersonName()!=null && !contactlowBidders.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(contactlowBidders.getContactPersonEmail()!=null && !contactlowBidders.getContactPersonEmail().equals("") && contactlowBidders.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=contactlowBidders.getContactPersonEmail()%>"><%=contactlowBidders.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactlowBidders.getContactPersonName()!=null && !contactlowBidders.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactlowBidders.getContactPersonName().trim()+"</b>");
													 }
													 if(contactlowBidders.getContactPersonPhone()!=null && !contactlowBidders.getContactPersonPhone().trim().equals(""))
													 {
													   formattedTelNo = searchUtil.removeSpecialChars(contactlowBidders.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+formattedTelNo);
													   
													 }
													 if(contactlowBidders.getContactPersonFax()!=null && !contactlowBidders.getContactPersonFax().trim().equals(""))
													 {
													   formattedFaxNo = searchUtil.removeSpecialChars(contactlowBidders.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+formattedFaxNo);
													   
													 }
														     if (print_newline)
															 {
																 out.println("<br>");
															 }
												 }//end of if Print details if printDetails flag is true.

										 }//END OF MAIN WHILE	 
										 
									  }//END OF MAIN IF					
									
				  %>
                        </td>
                      </tr>
              <!--THIS IS FOR DISPLAY OF  AWARDS-->
              <tr> 
                <td class="black10px" colspan="10"> 
                  <%
						   		if (awardsList != null && awardsList.size() > 0)
         						{
					            	   if (awardsList.size() > 1)
             							{
							                 
											 out.println("<b>"+searchUtil.keywordHighlight("Awards: ",cKeyword)+"</b>"+"<br>");
             							}
             						  else
             							{
							                  out.println("<b>"+searchUtil.keywordHighlight("Award: ",cKeyword)+"</b>"+"<br>");
											  
             							}
									      // header keeps track of any titles that need to be printed for a group of awards contacts
										
										 int award_count = 0;  // keeps count of low bidders to print numbers
										 boolean printDetails = true; // Decides whether to print details for low-bidder or not.
										 itrAwards = awardsList.iterator();
										 while (itrAwards.hasNext())
										 {
											 award_count++;
							
											 contactAwards = (common.bean.ExtractContact) itrAwards.next();
											 if (prev_contacttype == null && contactAwards.getContactTypeText() != null
													 && !contactAwards.getContactTypeText().trim().equals(""))
											 {
												 prev_contacttype = contactAwards.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactAwards.getContactTypeText().trim(),cKeyword)+"</b>"+"<br>");
												 // Print details for this contact now.
												 printDetails = true;
												 award_count = 1;    // Reset award count to 1
											 }
											  // check if header has changed
											 else if (prev_contacttype != null && contactAwards.getContactTypeText() != null
													 && !contactAwards.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
											 {
												 prev_contacttype = contactAwards.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactAwards.getContactTypeText().trim(),cKeyword)+"</b>"+"<br>");
												 // Print details for this contact now.
												 printDetails = true;
												 award_count = 1;    // Reset award count to 1
											 }
											 
											   // Now print the contact
												 if (contactAwards.getCompanyName() != null && !contactAwards.getCompanyName().trim().equals(""))
												 {
													 // For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.
													  company_name = contactAwards.getCompanyName().trim();
													 int name_length = company_name.length();
													 int semicolon_index = company_name.indexOf(";");
													 if (semicolon_index != -1)
													 {
														 company_name = company_name.substring(semicolon_index+1,name_length)
																		 + " "
																		 + company_name.substring(0, semicolon_index);
													 }
								
													 // fHH.getWebFileWriter().write(award_count+". "+company_name);
													 // fHH.getWebFileWriter().write(newLine);
													 out.println(award_count+"</b>. "
														 +"<a class='a03' href=javascript:PopContacts(\'"+contactAwards.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"')>"
														 +company_name+"</a>");
								
													 amt = contactAwards.getLowBidAmount();
													 if (amt != null)
														 //lowbid_amount = ValidateNumber.formatAmountString(amt.toString());
														 lowbid_amount = ValidateNumber.formatAmountStringWithDecimal(amt.toString(),2,2);
								
													 if ( lowbid_amount != null)
													 {
														 out.println("  $"+lowbid_amount);
													 }
								
													 out.println("<br>");
								
												 }//end of print the contact	
												 
												 // Print details if printDetails flag is true.
													 if (printDetails)
													 {
														 if (award_count > 2)
															 printDetails = false;
															 boolean print_newline = false;
														 if (contactAwards.getFax1() != null && !contactAwards.getFax1().trim().equals(""))
														 {
															 fax_no = searchUtil.removeSpecialChars(contactAwards.getFax1().trim());
									
															 try
															 {
																 fax_no_int = new Long(fax_no);
															 }
															 catch (Exception e)
															 {
															 }
									
															 fax_no = ValidateNumber.formatPhoneNumber(fax_no);
									
															 if (fax_no != null && fax_no_int != null && fax_no_int.intValue() != 0)
															 {
																 out.println("FAX# "+searchUtil.keywordHighlight(fax_no,cKeyword));
																 print_newline = true;
															 }
															 else
															 {
																 out.println("FAX# "+searchUtil.keywordHighlight(contactAwards.getFax1().trim(),cKeyword));
																 print_newline = true;
															 }
														 }
														 if (contactAwards.getAddress1() != null && !contactAwards.getAddress1().trim().equals(""))
														 {
															 out.println(", "+searchUtil.keywordHighlight(contactAwards.getAddress1().trim(),cKeyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactAwards.getCity() != null && !contactAwards.getCity().trim().equals(""))
														 {
															 out.println(searchUtil.keywordHighlight(contactAwards.getCity().trim(),cKeyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactAwards.getAddress1() != null || contactAwards.getCity() != null)
														 {
															 out.println(searchUtil.keywordHighlight(contactAwards.getStateCode().trim(),cKeyword));
															 print_newline = true;
														 }
									
														 if (contactAwards.getZip() != null && !contactAwards.getZip().trim().equals(""))
														 {
															 formattedZip = ValidateNumber.formatZipCode(contactAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword));
																 print_newline = true;
															 }
														 }
														if (contactAwards.getTelephone1() != null && !contactAwards.getTelephone1().trim().equals(""))
															 {
																 tel_no = searchUtil.removeSpecialChars(contactAwards.getTelephone1().trim());
										
																 try
																 {
																	 tel_no_int = new Long(tel_no);
																 }
																 catch (Exception e)
																 {
																 }
																 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
										
																 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
																 {
																	 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																	 print_newline = true;
																 }
																 else
																 {
																	 out.println(searchUtil.keywordHighlight(contactAwards.getTelephone1().trim(),keyword));
																	 print_newline = true;
																 }
																   // If telephone1 is missing, print telephone2
																 if (contactAwards.getTelephone1() == null &&
																 contactAwards.getTelephone2() != null &&
																 !contactAwards.getTelephone2().trim().equals(""))
																 {
																	 tel_no = searchUtil.removeSpecialChars(contactAwards.getTelephone2().trim());
											
																	 try
																	 {
																		 tel_no_int = new Long(tel_no);
																	 }
																	 catch (Exception e)
																	 {
																	 }
																	 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
											
																	 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
																	 {
																		 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																		 print_newline = true;
																	 }
																	 else
																	 {
																		 out.println(searchUtil.keywordHighlight(contactAwards.getTelephone2().trim(),keyword));
																		 print_newline = true;
																	 }
											
											
																 }
																 //CONTACT PERSON DETAILS
												    if(contactAwards.getContactPersonName()!=null && !contactAwards.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(contactAwards.getContactPersonEmail()!=null && !contactAwards.getContactPersonEmail().equals("") && contactAwards.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=contactAwards.getContactPersonEmail()%>"><%=contactAwards.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactAwards.getContactPersonName()!=null && !contactAwards.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactAwards.getContactPersonName().trim()+"</b>");
													 }
													 if(contactAwards.getContactPersonPhone()!=null && !contactAwards.getContactPersonPhone().trim().equals(""))
													 {
													    formattedTelNo = searchUtil.removeSpecialChars(contactAwards.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+formattedTelNo);
													   
													 }
													 if(contactAwards.getContactPersonFax()!=null && !contactAwards.getContactPersonFax().trim().equals(""))
													 {
													    formattedFaxNo = searchUtil.removeSpecialChars(contactAwards.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+formattedFaxNo);
													   
																 }
																 if (print_newline)
																 {
																	 out.println("<br>");
																 }

										
															 }
														 
													}//end of if( Print details if printDetails flag is true).	 
																			 
																			 
										}//end of main while loop	 	
										
										
							   }//Main If
						%>
                </td>
              </tr>
              <!---THIS IS FOR DISPLAY OF SUB CONTRACTORS AWARDS LIST--->
              <tr> 
                <td class="black10px" colspan="10"> 
                  <%
					                if (subAwardsList != null && subAwardsList.size() > 0)
									 {
										 if (subAwardsList.size() > 1)
										 {
											 
											  out.println("<b>"+searchUtil.keywordHighlight("Subcontractor Awards:",cKeyword)+"</b>"+"<br>");
										 }
										 else
										 {
											out.println("<b>"+searchUtil.keywordHighlight("Subcontractor Award:",cKeyword)+"</b>"+"<br>");
											
										 }
										  // header keeps track of any titles that need to be printed for a group of low bidders
										
										 int subawards_count = 0;  // keeps count of low bidders to print numbers
										 boolean printDetails = true; // Decides whether to print details for low-bidder or not.
										 itrSubAwards = subAwardsList.iterator();
										 while (itrSubAwards.hasNext())
										 {
											 subawards_count++;
							
											 common.bean.ExtractContact contactsubAwards = (common.bean.ExtractContact) itrSubAwards.next();
											 if (prev_contacttype == null && contactsubAwards.getContactTypeText() != null
													 && !contactsubAwards.getContactTypeText().trim().equals(""))
											 {
												 prev_contacttype = contactsubAwards.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactsubAwards.getContactTypeText().trim(),cKeyword)+"</b>"+"<br> ");
												 // Print details for this contact now.
												 printDetails = true;
												 subawards_count = 1;    // Reset counter.
											 }
											 // check if header has changed
											 else if (prev_contacttype != null && contactsubAwards.getContactTypeText() != null
													 && !contactsubAwards.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
											 {
												 prev_contacttype = contactsubAwards.getContactTypeText().trim();
												 // print header
												 out.println("<b>"+searchUtil.keywordHighlight(contactsubAwards.getContactTypeText().trim(),cKeyword)+"</b>"+"<br>");
												 // Print details for this contact now.
												 printDetails = true;
												 subawards_count = 1;    // Reset counter.
											 }
											   // Now print the contact and bidding amount
												 if (contactsubAwards.getCompanyName() != null && !contactsubAwards.getCompanyName().trim().equals(""))
												 {
													 // For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.
													 company_name = contactsubAwards.getCompanyName().trim();
													 int name_length = company_name.length();
													 int semicolon_index = company_name.indexOf(";");
													 if (semicolon_index != -1)
													 {
														 company_name = company_name.substring(semicolon_index+1,name_length)
																		 + " "
																		 + company_name.substring(0, semicolon_index);
													 }
								
													 //fHH.getWebFileWriter().write(subawards_count+". "+company_name);
													 // Project Contact Link
													  out.println("<b> "
														 +"</b><a class='a03' href=javascript:PopContacts(\'"+contactsubAwards.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"') >"
														 +searchUtil.keywordHighlight(company_name,cKeyword)+"</a>");
								
								
													 amt = contactsubAwards.getLowBidAmount();
													 lowbid_amount = null;
													 if (amt != null)
														 //lowbid_amount = ValidateNumber.formatAmountString(amt.toString());
														 lowbid_amount = ValidateNumber.formatAmountStringWithDecimal(amt.toString(),2,2);
								
													 if ( lowbid_amount != null)
													 {
														  out.println("  $"+lowbid_amount);
													 }
													  out.println("<br>");
												 }

											     // Print details if printDetails flag is true.
												 if (printDetails)
												 {
													 printDetails = false;
													 fax_no = null;
													 fax_no_int = null;
													 boolean print_newline = false;
													 if (contactsubAwards.getFax1() != null && !contactsubAwards.getFax1().trim().equals(""))
													 {
														 fax_no = searchUtil.removeSpecialChars(contactsubAwards.getFax1().trim());
								
														 try
														 {
															 fax_no_int = new Long(fax_no);
														 }
														 catch (Exception e)
														 {
														 }
								
														 fax_no = ValidateNumber.formatPhoneNumber(fax_no);
								
														 if (fax_no != null && fax_no_int != null && fax_no_int.intValue() != 0)
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(fax_no,cKeyword));
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+searchUtil.keywordHighlight(contactsubAwards.getFax1().trim(),cKeyword));
															 print_newline = true;
														 }
								
													 }
													  if (contactsubAwards.getAddress1() != null && !contactsubAwards.getAddress1().trim().equals(""))
														 {
															 String commaStr="";
															 if (fax_no != null && fax_no_int != null
																				&& fax_no_int.intValue() != 0) {
																 commaStr=", ";
															 }
															 out.println(commaStr+searchUtil.keywordHighlight(contactsubAwards.getAddress1().trim(),cKeyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getCity() != null && !contactsubAwards.getCity().trim().equals(""))
														 {
															 out.println(searchUtil.keywordHighlight(contactsubAwards.getCity().trim(),cKeyword)+", ");
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getAddress1() != null || contactsubAwards.getCity() != null)
														 {
															 out.println(searchUtil.keywordHighlight(contactsubAwards.getStateCode().trim(),cKeyword));
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getZip() != null && !contactsubAwards.getZip().trim().equals(""))
														 {
															 formattedZip = ValidateNumber.formatZipCode(contactsubAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword) );
																 print_newline = true;
															 }
														 }
														   tel_no = null;
														  tel_no_int = null;
														 if (contactsubAwards.getTelephone1() != null && !contactsubAwards.getTelephone1().trim().equals(""))
														 {
															 tel_no = searchUtil.removeSpecialChars(contactsubAwards.getTelephone1().trim());
									
															 try
															 {
																 tel_no_int = new Long(tel_no);
															 }
															 catch (Exception e)
															 {
															 }
															 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
									
															 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
															 {
																 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(searchUtil.keywordHighlight(contactsubAwards.getTelephone1().trim(),cKeyword));
																 print_newline = true;
															 }
									
														 }
														 // If telephone1 is missing, print telephone2
														 if (contactsubAwards.getTelephone1() == null &&
														 contactsubAwards.getTelephone2() != null &&
														 !contactsubAwards.getTelephone2().trim().equals(""))
														 {
															 tel_no = searchUtil.removeSpecialChars(contactsubAwards.getTelephone2().trim());
									
															 try
															 {
																 tel_no_int = new Long(tel_no);
															 }
															 catch (Exception e)
															 {
															 }
															 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
									
															 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
															 {
																 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(searchUtil.keywordHighlight(contactsubAwards.getTelephone2().trim(),cKeyword));
																 print_newline = true;
															 }
									
									
														 }
														  //CONTACT PERSON DETAILS
												    if(contactsubAwards.getContactPersonName()!=null && !contactsubAwards.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(contactsubAwards.getContactPersonEmail()!=null && !contactsubAwards.getContactPersonEmail().equals("") && contactsubAwards.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=contactsubAwards.getContactPersonEmail()%>"><%=contactsubAwards.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactsubAwards.getContactPersonName()!=null && !contactsubAwards.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactsubAwards.getContactPersonName().trim()+"</b>");
													 }
													 if(contactsubAwards.getContactPersonPhone()!=null && !contactsubAwards.getContactPersonPhone().trim().equals(""))
													 {
													    formattedTelNo = searchUtil.removeSpecialChars(contactsubAwards.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+formattedTelNo);
													   
													 }
													 if(contactsubAwards.getContactPersonFax()!=null && !contactsubAwards.getContactPersonFax().trim().equals(""))
													 {
													    formattedFaxNo = searchUtil.removeSpecialChars(contactsubAwards.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+formattedFaxNo);
													   
														 }
														     if (print_newline)
															 {
																 out.println("<br>");
															 }


								                
												 }//end of if Print details if printDetails flag is true.

											 
											 
											 
										 }//END OF MAIN WHILE	 
										 
										 
										 
				                    }//END OF MAIN IF					
									
					  %>
                </td>
              </tr>
              <!--THIS IS FOR DISPLAY OF PLAN HOLDER'S -->
              <tr> 
                <td colspan="10" class="black10px"> 
                  <%
						  privateDisclaimer = 
						 "The bidders list we are publishing may be "+
                         "incomplete. If you have been invited to bid on this "+
                         "project and would like to be listed, please contact "+
                         "our publication.";
						  String publicDisclaimer = 
						 "The plan holders list that we are publishing may be "+
                         "incomplete. If you are a plan holder or potential "+
                         "bidder for this project and would like to be listed "+
                         "below, please contact our publication.";
						
						
					if(subSection.equals("BIDDING") ||   subSection.equals("PLANNING") || 
						   subSection.equals("SUB BIDS") ||   subSection.equals("AWAITING AWARDS"))
				 	{	
						 
						if (cbean.getBiddersListDisclmr() !=null)
         				{
			             	String biddersListDisclmr=cbean.getBiddersListDisclmr();
					 
				      
						if(biddersListDisclmr!=null && biddersListDisclmr.trim().equals("Y")==true)
						 {
						   out.println("<font face='verdana' size='1' >"+searchUtil.keywordHighlight(privateDisclaimer,cKeyword)+"</font>");
						 }   
         				
						
						
				        else if (biddersListDisclmr!=null && biddersListDisclmr.trim().equals("P")==true)
         				{
			             out.println("<font face='verdana' size='1' >"+searchUtil.keywordHighlight(publicDisclaimer,cKeyword)+"</font>");
         				}
					  }
					}  
					 
					   if (planHoldersList != null && planHoldersList.size() > 0 && !subSection.equals("AWARD"))
						 {
							 // The indexList list keeps track of the indexes of the contacts that have been
							 // printed in the loop.
							 indexList = new ArrayList();
							
							 int i = 0;
				
							 // Search for "GENERAL CONTRACTOR" in the list. Print first.
							 generalcontKeyWords = "<b><font face='verdana,arial' size='1' >GENERAL CONSTRUCTION</b></font>";
				               
							 
				
							 // header keeps track of any titles that need to be printed for a group of planholders
							 // Print GENERAL CONTRACTOR first.
							 prev_contacttype = null;
							 itrBidder = planHoldersList.iterator();
							 while (itrBidder.hasNext())
							 {
								 contactPlanHolders = (common.bean.ExtractContact) itrBidder.next();
								  contactType = contactPlanHolders.getContactTypeText().trim();
								 
								
								 if (generalcontKeyWords.equalsIgnoreCase(contactType))
									 {
										 // GENERAL CONTRACTOR found. Remember the index, print it to files.
										 indexList.add(new Integer(i));
					
										 if (prev_contacttype == null && contactPlanHolders.getContactTypeText() != null
												 && !contactPlanHolders.getContactTypeText().trim().equals(""))
										 {
											 prev_contacttype = contactPlanHolders.getContactTypeText().trim();
											 // print header
											 out.println("<br>"+"<b>"+searchUtil.keywordHighlight(contactPlanHolders.getContactTypeText().trim().toUpperCase(),cKeyword)
												 +"</b>"+"<br>");
										 }		 
										 // check if header has changed
										 else if (prev_contacttype != null && contactPlanHolders.getContactTypeText() != null
												 && !contactPlanHolders.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
										 {
											 prev_contacttype = contactPlanHolders.getContactTypeText().trim();
										  // print header
										 	out.println("<b>"+searchUtil.keywordHighlight(contactPlanHolders.getContactTypeText().trim().toUpperCase(),cKeyword)
												 +"</b>"+"<br>");
										  }
										  // Now print the contact
										 if (contactPlanHolders.getCompanyName() != null && !contactPlanHolders.getCompanyName().trim().equals(""))
										 {
											 // For printing company name, check if there's any semi-colon. If there is any,
											 // parse it and print text on the right of semicolon to the left of company name.
											  company_name = contactPlanHolders.getCompanyName().trim();
											 int name_length = company_name.length();
											 int semicolon_index = company_name.indexOf(";");
											 if (semicolon_index != -1)
											 {
												 company_name = company_name.substring(semicolon_index+1,name_length)
																 + " "
																 + company_name.substring(0, semicolon_index);
											 }
											
					
											 // Check if this is a new bidder. If yes, print a plus sign.
											 boolean printPlusSign = false;
											 
											 if(cbean.getLastEnteredDate() != null)
											 {
											 	contactAddedDate = contactPlanHolders.getAddedDate();
												lastEnteredDate = cbean.getLastEnteredDate();
												
												// If added date is greater, print a plus sign
												if(ValidateDate.compareDates(contactAddedDate, lastEnteredDate)
												== 1 && cbean.getUpdatedFlag().equals("U"))
												{
													printPlusSign = true;
												}
											 }
											  //out.println(contactAddedDate+lastEnteredDate);
											 /*if (cbean.getentryDate() != null)
											 {
												 addedDate = ValidateDate.getDateFromDBDate(contactPlanHolders.getAddedDate());
												 webPublishyDate = ValidateDate.getDateFromDBDate(cbean.getentryDate());
					
												 // If added date is greater, print a plus sign
												 if (ValidateDate.compareDates(addedDate, webPublishyDate)
													 == 0 && cbean.getUpdatedFlag().equals("U") )
												 {
													 printPlusSign = true;
													
												 }
												
											 }*/
					
											 //fHH.getWebFileWriter().write("<b>"+company_name+"</b>");
											 
											 // Project Contact Link change
											 out.println("<b><font face='verdana,arial' size='1' ><a class='a03' href=javascript:PopContacts(\'"+contactPlanHolders.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"') >"
												 +"</b>");
					
											 /*if (printPlusSign)
												 out.println ("+");
					
											 out.println(searchUtil.keywordHighlight(company_name,keyword)+"</b>"+"</a>");*/
					                         if (printPlusSign)
												 out.println ("+");
					
											 out.println(searchUtil.keywordHighlight(company_name,keyword)+"</b>"+"</a>");
					                         if (contactPlanHolders.getAddress1() != null && !contactPlanHolders.getAddress1().trim().equals(""))
											 {
												 out.println("<br>"+"&nbsp;&nbsp;"+searchUtil.keywordHighlight(contactPlanHolders.getAddress1().trim(),cKeyword));
											 }
						
											 if (contactPlanHolders.getCity() != null && !contactPlanHolders.getCity().trim().equals(""))
											 {
												 out.println(searchUtil.keywordHighlight(contactPlanHolders.getCity().trim(),cKeyword)+", ");
											 }
						
											 if (contactPlanHolders.getCity() != null || contactPlanHolders.getAddress1() != null)
											 {
												out.println(searchUtil.keywordHighlight(contactPlanHolders.getStateCode().trim(),cKeyword));
											 }
						
											 if (contactPlanHolders.getZip() != null && !contactPlanHolders.getZip().trim().equals(""))
											 {
												  formattedZip = ValidateNumber.formatZipCode(contactPlanHolders.getZip().trim());
												 if (formattedZip != null)
													 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword) );
											 }	 
											 
																 
												tel_no = null;
												tel_no_int = null;
												if (contactPlanHolders.getTelephone1() != null && !contactPlanHolders.getTelephone1().trim().equals(""))
												 {
													 tel_no = searchUtil.removeSpecialChars(contactPlanHolders.getTelephone1().trim());
							
													 try
													 {
														 tel_no_int = new Long(tel_no);
													 }
													 catch (Exception e)
													 {
													 	System.out.println("ERROR while formatting Telephone1 PlansHolders: "+e);
													 }
													 
													  tel_no = ValidateNumber.formatPhoneNumber(tel_no);

														 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
														 {
															 out.println(searchUtil.keywordHighlight(tel_no,cKeyword) );
														 }
														 else
														 {
															 out.println(searchUtil.keywordHighlight(contactPlanHolders.getTelephone1().trim(),cKeyword) );
														 }

												}//end of if	 
													 // If telephone1 is missing, print telephone2
											 if (contactPlanHolders.getTelephone1() == null &&
												 contactPlanHolders.getTelephone2() != null &&
												 !contactPlanHolders.getTelephone2().trim().equals(""))
											 {
												 tel_no = searchUtil.removeSpecialChars(contactPlanHolders.getTelephone2().trim());
						
												 try
												 {
													 tel_no_int = new Long(tel_no);
												 }
												 catch (Exception e)
												 {
												 	System.out.println("ERROR while formatting Telephone2 PlansHolders: "+e);
												 }
						
												 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
						
												 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
												 {
													 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
												 }
												 else
												 {
													 out.println(searchUtil.keywordHighlight(contactPlanHolders.getTelephone2().trim(),cKeyword));
												 }
						
											 }//end of if

											 out.println("</font><br>");
										 }
										 // Index counter
										 i++;
									 }
								}	 
									  // Print the rest of Plan Holders.
										 if (indexList.size() < planHoldersList.size())
										 {
											 prev_contacttype = null;
											 outerloop: for (int planHoldersCounter=0; planHoldersCounter < planHoldersList.size(); planHoldersCounter++)
											 {
												 listitr = indexList.iterator();
												 while (listitr.hasNext())
												 {
													 if (planHoldersCounter == ((Integer)listitr.next()).intValue())
														 continue outerloop;
												 }
												 // When the code reach here, will print the rest of Plan Holders.
												  contactPlanHoldersOthers = (common.bean.ExtractContact)planHoldersList.get(planHoldersCounter);
												 
												 
												 // Check ContactTypeText and replace with Plan Holder(s).
												 if (contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase("PlanHolder") ||
													 contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase("PlanHolders") ||
													 contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase("Plan Holder") ||
													 contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase("Plan Holders") ||
													 contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase("PLAN HOLDERS(S)"))
												 {
													 contactPlanHoldersOthers.setContactTypeText("PLAN HOLDER(S)");
												 }
												  if (prev_contacttype == null && contactPlanHoldersOthers.getContactTypeText() != null
														 && !contactPlanHoldersOthers.getContactTypeText().trim().equals(""))
												 {
													 prev_contacttype = contactPlanHoldersOthers.getContactTypeText().trim();
													 // print header
													 out.println("<br>"+"<b><font face='verdana,arial' size='1' >"+searchUtil.keywordHighlight(contactPlanHoldersOthers.getContactTypeText().trim().toUpperCase(),cKeyword)
														 +"</font></b>"+"<br>");
												 }
												 // check if header has changed
												 else if (prev_contacttype != null && contactPlanHoldersOthers.getContactTypeText() != null
														 && !contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
												 {
													 prev_contacttype = contactPlanHoldersOthers.getContactTypeText().trim();
													 
													 // print header
													 out.println("<br>"+"<b><font face='verdana,arial' size='1' >"+searchUtil.keywordHighlight(contactPlanHoldersOthers.getContactTypeText().trim().toUpperCase(),cKeyword)
														 +"</font></b>"+"<br>");
												 }
																		// Now print the contact
											 if (contactPlanHoldersOthers.getCompanyName() != null && !contactPlanHoldersOthers.getCompanyName().trim().equals(""))
											 {
												 // For printing company name, check if there's any semi-colon. If there is any,
												 // parse it and print text on the right of semicolon to the left of company name.
												 company_name = contactPlanHoldersOthers.getCompanyName().trim();
												 int name_length = company_name.length();
												 int semicolon_index = company_name.indexOf(";");
												 if (semicolon_index != -1)
												 {
													 company_name = company_name.substring(semicolon_index+1,name_length)
																	 + " "
																	 + company_name.substring(0, semicolon_index);
												 }
						
												 // Check if this is a new bidder. If yes, print a plus sign.
												 boolean printPlusSign = false;
												
												 if (cbean.getLastEnteredDate() != null)
												 {
													  addedDate = ValidateDate.getDateFromDBDate(contactPlanHoldersOthers.getAddedDate());
													  lastentryDate =ValidateDate.getDateFromDBDate(cbean.getLastEnteredDate());
													 //out.println(addedDate+lastentryDate);
													 // If added date is greater than last entered date, print a plus sign
													 if (ValidateDate.compareDates(addedDate, lastentryDate)
														 == 1 && cbean.getUpdatedFlag().equals("U"))
													 {
														 printPlusSign = true;
														// out.println(addedDate+webPublishyDate+ValidateDate.compareDates(addedDate, webPublishyDate));
														 
													 }
													 
													
												 }
						
												 //fHH.getWebFileWriter().write("<b>"+company_name+"</b>");
												 // Project Contact Link change
												 out.println("<a class='a03' href=javascript:PopContacts(\'"+contactPlanHoldersOthers.getContactID()+"\','"
														 	 + URLEncoder.encode(company_name.replaceAll("[^a-zA-Z0-9\\s]+",""))+"','"+userView+"') >"
													 +"<b>");
						
												 if (printPlusSign)
													 out.println("+");
						
												 out.println(searchUtil.keywordHighlight(company_name,cKeyword)+"</b>"+"</a>");
						
											 }
											 
											      fax_no = null;
												  fax_no_int = null;
												 if (contactPlanHoldersOthers.getFax1() != null && !contactPlanHoldersOthers.getFax1().trim().equals(""))
												 {
													 fax_no = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getFax1().trim());
							
													 try
													 {
														 fax_no_int = new Long(fax_no);
													 }
													 catch (Exception e)
													 {
													 }
							
													 fax_no = ValidateNumber.formatPhoneNumber(fax_no);
							
													 if (fax_no != null && fax_no_int != null && fax_no_int.intValue() != 0)
													 {
														 out.println(" FAX# "+searchUtil.keywordHighlight(fax_no,cKeyword)+"<BR>");
													 }
													 else
													 {
														 out.println(" FAX# "+searchUtil.keywordHighlight(contactPlanHoldersOthers.getFax1().trim(),keyword)+"<BR>");
													 }
							
												 }
												 
												    if (contactPlanHoldersOthers.getAddress1() != null && !contactPlanHoldersOthers.getAddress1().trim().equals(""))
													 {
														 out.println("&nbsp;"+searchUtil.keywordHighlight(contactPlanHoldersOthers.getAddress1().trim(),cKeyword));
													 }
								
													 if (contactPlanHoldersOthers.getCity() != null && !contactPlanHoldersOthers.getCity().trim().equals(""))
													 {
														 out.println(searchUtil.keywordHighlight(contactPlanHoldersOthers.getCity().trim(),cKeyword)+", ");
													 }
								
													 if (contactPlanHoldersOthers.getCity() != null || contactPlanHoldersOthers.getAddress1() != null)
													 {
														 out.println(searchUtil.keywordHighlight(contactPlanHoldersOthers.getStateCode().trim(),cKeyword));
													 }
								
													 if (contactPlanHoldersOthers.getZip() != null && !contactPlanHoldersOthers.getZip().trim().equals(""))
													 {
														  formattedZip = ValidateNumber.formatZipCode(contactPlanHoldersOthers.getZip().trim());
														 if (formattedZip != null)
															 out.println(searchUtil.keywordHighlight(formattedZip,keyword));
													 }
                                                      tel_no = null;
													  tel_no_int = null;
													 if (contactPlanHoldersOthers.getTelephone1() != null && !contactPlanHoldersOthers.getTelephone1().trim().equals(""))
													 {
														 tel_no = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getTelephone1().trim());
								
														 try
														 {
															 tel_no_int = new Long(tel_no);
														 }
														 catch (Exception e)
														 {
														 	System.out.println("ERROR while formatting Telephone1 PlansHolders Others: "+e);
														 }
								
														 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
								
														 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
														 {
															 out.println(searchUtil.keywordHighlight(tel_no,keyword));
														 }
														 else
														 {
															 out.println(searchUtil.keywordHighlight(contactPlanHoldersOthers.getTelephone1().trim(),cKeyword));
														 }
								
													 }
													 
													  // If telephone1 is missing, print telephone2
											 if (contactPlanHoldersOthers.getTelephone1() == null &&
												 contactPlanHoldersOthers.getTelephone2() != null &&
												 !contactPlanHoldersOthers.getTelephone2().trim().equals(""))
											 {
												 tel_no = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getTelephone2().trim());
						
												 try
												 {
													 tel_no_int = new Long(tel_no);
												 }
												 catch (Exception e)
												 {
												 	System.out.println("ERROR while formatting Telephone2 PlansHolders Others: "+e);
												 }
						
												 tel_no = ValidateNumber.formatPhoneNumber(tel_no);
						
												 if (tel_no != null && tel_no_int != null && tel_no_int.intValue() != 0)
												 {
													 out.println(searchUtil.keywordHighlight(tel_no,cKeyword));
												 }
												 else
												 {
													 out.println(searchUtil.keywordHighlight(contactPlanHoldersOthers.getTelephone2().trim(),cKeyword));
												 }
												
						
											 }
												//CONTACT PERSON DETAILS
												    if(contactPlanHoldersOthers.getContactPersonName()!=null && !contactPlanHoldersOthers.getContactPersonName().trim().equals(""))
													 {
													   out.println("<br><b>Contact:</b> ");
													 }
													 if(contactPlanHoldersOthers.getContactPersonEmail()!=null && !contactPlanHoldersOthers.getContactPersonEmail().equals("") && contactPlanHoldersOthers.getContactPersonName()!=null)
													 {
													   %>
													   <a class="a03" href="mailto:<%=contactPlanHoldersOthers.getContactPersonEmail()%>"><%=contactPlanHoldersOthers.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactPlanHoldersOthers.getContactPersonName()!=null 
													 			&& !contactPlanHoldersOthers.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactPlanHoldersOthers.getContactPersonName().trim()+"</b>");
													 }
													 if(contactPlanHoldersOthers.getContactPersonPhone()!=null 
													 		&& !contactPlanHoldersOthers.getContactPersonPhone().trim().equals(""))
													 {
													    formattedTelNo = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+formattedTelNo);
													   
													 }
													 if(contactPlanHoldersOthers.getContactPersonFax()!=null && !contactPlanHoldersOthers.getContactPersonFax().trim().equals(""))
													 {
													    formattedFaxNo = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+formattedFaxNo);
						
											 }

                                              out.println("<br>");
																		 
															
									 } // End of outerloop.
								 } // End of checking the rest of planholders.
							 } // End of checking planholderslist.
							
						%>
                </td>
              </tr>
              <TR> 
                <TD height="30" colspan="10"></TD>
              </TR>
              <TR class="borders"> 
                <TD colspan="10" ALIGN="center" class="black10px"> <table>
                    <!--THIS IS FOR DISPLAY FOR FIRST REPORTED DATE-->
                    <tr> 
                      <td class="black10px" ALIGN="center"> 
                        
                        <%
	                       
							 if(cbean.getLeadsEntryDate()!=null)
							  {
							   usLocale=new Locale("EN","us");
			     		       sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				               tempdate=sdf.parse(cbean.getLeadsEntryDate());
				               sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			   convertedDate=sdf.format(tempdate);
							 out.println("<font face='verdana,arial' size='1' >");
								out.println(searchUtil.keywordHighlight("First Reported ",keyword)+searchUtil.keywordHighlight(ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(convertedDate)),keyword)+"</font>");
							  }
					 %>
                      </td>
                    </tr>
                    <!--THIS IS FOR DISPLAY OF FINAL PUBLISH DATE-->
                    <TR> 
                      <TD class="black10px"  align="center" height="15"> 
                        <%
						 if(cbean.getFinalPublishDate()!=null)
							  {
							   usLocale=new Locale("EN","us");
			     		       sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				               tempdate=sdf.parse(cbean.getFinalPublishDate());
				               sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			   convertedDate=sdf.format(tempdate);
							   out.println("<font face='verdana,arial' size='1' >");
								out.println(searchUtil.keywordHighlight("Final Published ",keyword)+searchUtil.keywordHighlight(ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate)),keyword)+"</font>");
							  }
							   else 
							  {
							    
								usLocale=new Locale("EN","us");
			     		        sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				                tempdate=sdf.parse(cbean.getentryDate());
				                sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			    convertedDate=sdf.format(tempdate);
								if(cbean.getUpdatedFlag().equals("N"))
								{
							    	out.println(searchUtil.keywordHighlight("First Published ",keyword)+searchUtil.keywordHighlight(ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate).toLowerCase()),keyword));
								} 	
							    else
								{
								   out.println(searchUtil.keywordHighlight("Last Published ",keyword)+searchUtil.keywordHighlight(ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate).toLowerCase()),keyword));
								   //  out.println(convertedDate);
								


								}
							  
							  }
						
							
							%>
                      </TD>
                    </TR>
                    
                  </table></TD>
              </TR>
              <%}
	 } %>
              <tr> 
                <td class="black10px" ALIGN="center" colspan="10"> ©COPYRIGHT <%out.print(ValidateDate.getCurrentYear());%>, CONSTRUCTION DATA COMPANY, ALL RIGHTS RESERVED. This material 
                  may not be published, broadcast, rewritten or distributed. </td>
              </tr>
            </table></td>
        </tr>
        <tr> 
          <td colspan="10" ><img src="<%=request.getContextPath()%>/images/pixel_blue.gif" width="100%" height="1" border="0"></td>
        </tr>
        
      </table>
      </TD></TR></table>
	 <!-- colorbox to send project by mail. -->
	 <cdc:email />
      <!--- fields used in save job --->	  
      <input type="hidden" name="job_title" value=""> <input type="hidden" name="cdcid_savejob" value=""> 
	  <!--- Added by Muthu on 04/17/13 to get the html element--->
	  <input type="hidden" name="savejob_pid" value="">
      <!--- if bid date available, use it in calander --->
      <input type="hidden" name="biddate_savejob" value=""> <input type="hidden" name="prebiddate_savejob" value=""> 
      <!--- if bid date details available, use it in calander notes --->
      <input type="hidden" name="bidsinfo_savejob" value=""> <input type="hidden" name="pubid_details" value=""> 
      <input type="hidden" name="secid_details" value=""> <input type="hidden" name="backbutton" value=""> 
      <!--- variables for email calendar --->
      <input type="hidden" name="save_job_id" value=""> <input type="hidden" name="cdc_id" value=""> 
      <input type="hidden" name="title" value=""> <input type="hidden" name="biddate" value=""> 
      <input type="hidden" name="bidsdetails" value=""> <input type="hidden" name="job_name" value=""> 
      <input type="hidden" name="loginid" value="<%=userBean.getLoginId()%>"> 
</form>

<jsp:include page="/online-product/project-hit" flush="true">
   <jsp:param name="cdc_id" value="<%=shortCDCID%>" />
   <jsp:param name="plansflag" value="<%=plansAvailable%>" />
   <jsp:param name="state_id" value="<%=state_id%>" />
   <jsp:param name="flag" value="d" />
</jsp:include> 
 <%
	//Close Data Base Connection
	DBController.releaseDBConnection(con);		  
%>
</body>
<script>
/* We can use this variable in js files to get contextPath in js */
var contextPath = '<%=request.getContextPath()%>'; 
</script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/themes/base/jquery.ui.all.css" />
<script src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/jquery-1.11.3.min.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/js/JSScripts/autolink_new.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/JSON2.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/jquery.colorbox.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.core.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.widget.js"></script>
<script type="text/javascript"src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.position.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/ui/jquery.ui.autocomplete.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/Javascript_template.js"></script>
<script src="<%=request.getContextPath()%>/js/JSScripts/global.js?v=4.3" type="text/javascript"></script>
<script type="text/javascript"	src="<%=request.getContextPath()%>/js/JSScripts/jstorage.js"></script>



</html>
