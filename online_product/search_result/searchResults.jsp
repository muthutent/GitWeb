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
   Description    : Displays the Search Results
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<!--[if IE]>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<![endif]-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="cdc" uri="http://lm.cdcnews.com/mytags"%>
<%@ page language="java" %>
<%@page import="java.io.*"%>
<%@page import="java.util.regex.*"%>
<%@page import="java.util.*"%>
<%@page import="java.text.*"%>
<%@page import="javax.rmi.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.springframework.context.ApplicationContext"%>

<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="com.cdc.spring.bean.UserBean"%>
<%@page import="com.cdc.spring.bean.SearchBean"%>
<%@page import="com.cdc.spring.bean.SavedSearchBean"%>
<%@page import="com.cdc.spring.model.SearchModel"%>
<%@page import="com.cdc.spring.model.dao.SearchDao"%>
<%@page import="com.cdc.spring.util.SearchUtil"%>
<%@page import="com.cdc.controller.DBController"%>

<%@page import="common.*"%>
<%@page import="common.utils.*"%>
<%@page import="common.bean.*"%>
<%@page import="leadsconfig.*"%>

<%@page import="content.*"%>
<%@page import="datavalidation.*"%>

		
<%@page import="com.cdc.hotlist.HotlistManager"%>
<%@page import="com.cdc.hotlist.util.*"%>
<%@page import="com.cdc.service.*"%>
<%@page import="com.cdc.util.*"%>


<%-- <%@ page errorPage="testMail.jsp"%> --%> <!-- uncomment this line while moving to production -->

<%
	//double rand = Math.random();	// It's for the query string random value in css/script tag to over come brower caching. Added by Muthu on 05/23/13.
	
	
%>
<html>
<head>
<title>Construction Leads - CDCNews - Construction Data Company</title>
<meta name="Description"
	content="Receive up-to-date, continuous construction leads from CDCNews. Search construction leads by state or construction lead type and find new construction leads everyday.">
<meta name="Keywords"
	content="construction leads, construction lead, new construction leads.">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="1">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/sheet-jsp.css?v=4">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/colorbox.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/buttons.css">
<!--- Load a separate style Sheet for IE--->

<!--[if !IE]><!-->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/scrolltable.css?v=4">
<!--<![endif]-->
<!--[if IE]>
	<link rel="stylesheet" type="text/css" href="css/scrolltable.ie.css" />
<![endif]-->

<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/css/sortabletable.css?r=4.1" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/themes/base/jquery.ui.all.css?r=4.1" />
<link type="text/css" rel="stylesheet"
	href="<%=request.getContextPath()%>/css/search_result/searchResults.css?r=4.3" />
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/Javascript_template.js"></script>
</head>
<body>
<div class="loading" style="position:absolute; width:100%; text-align:left; top:100px; margin-left:220px; z-index:1"><img src="<%=request.getContextPath()%>/images/loading/animated_loading_text_new.gif" width="310" height="57" border=0><br>
 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="<%=request.getContextPath()%>/images/loading/animated_loading.gif" width="220" height="19" border=0></div>
	
	<%@include file="searchResultsVariables.jsp"%>
	
	<!-- Refine search / Ocr search  -->
	<%
		if (map.get("total") != null
		&& Integer.parseInt(String.valueOf(map.get("total"))) > 0
		&& nkeysession == null) {
	%>
	<div id="top_static_header">
		<%
			}
		%>
		<!---*************************Start of Form*****************************--->
		<form target="_self" name="viewForm" method="post" id="viewForm"
			action="">
			
			<%
				if (map.get("total") != null && Integer.parseInt(String.valueOf(map.get("total"))) > 0
					&& nkeysession == null && ocrtextsession != null && !ocrtextsession.equals("true")) {
			%>
									
			<table id="viewForm-table1" class="marginLeft110">
				<tr>
					<td width="15">&nbsp;</td>
					<td valign="top"><table id="viewForm-table2" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td valign="top" width="380" class="rys-ocr-header">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
												<td id="action_rys" class="black12px"
												background="<%=request.getContextPath()%>/images/navigation/nav_spacer2.gif"><span
												id="action_rys_text">Hide</span>&nbsp;<span>Refine
													Your Search</span>
												</td>
										</tr>
									</table>
								</td>
								<td></td>
								<%
									if (polCountyFlag != null && polCountyFlag.equals("Y") && iPhoneSession != null && iPhoneSession.equals("N")) {
								%>
								<td class="rys-ocr-header">
									<table width="100%" border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td id="action_ocr" class="black12px"
												background="<%=request.getContextPath()%>/images/navigation/nav_spacer2.gif"><span
												id="action_ocr_text">Hide</span>&nbsp;<span>Plan
													Specification OCR Search</span></td>
										</tr>
									</table>

								</td>
								<%
									}
								%>
							</tr>
							<tr>
								<!-- REFINE SEARCH FORM -->
								<td bgcolor="EFF4FA" width="350">
									<div class="toggle-rys">
										<table id="toggle-rys-table1" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td width="1" height="41"></td>
												<td width="10">&nbsp;</td>
												<td class="black10px" width="350">Enter your keyword
													below to refine your search. Multiple keywords must be
													separated by commas and be a <b>MAXIMUM</b> of <b>250
														CHARACTERS.</b>
												</td>
												<td width="1"></td>
											</tr>
											<tr>
												<td width="1"></td>
												<td width="10"></td>
												<td><table width="374" border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td width="100" class="black10px">Projects Keyword:</td>
															<td width="70" class="paddingLeft7"><input
																type="text" name="textsubkey" maxlength="250"></td>
															<td class="black11px" align="center"><input
																type="hidden" name="subselect" value="subselect">
																<a
																href="#" onClick="javascript:callTextSearch()"><img
																	src="<%=request.getContextPath()%>/images/buttons/button_go.gif"
																	border="0" align="top"></a>&nbsp;&nbsp;</td>
														</tr>
													</table> <!--- End Search Keyword Form----></td>
												<td width="1"></td>
											</tr>
											<tr>
												<td width="1"></td>
												<td width="10">&nbsp;</td>
												<td><table border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td align="right" class="black10px">Contacts
																Keyword:</td>
															<td width="5">&nbsp;</td>
															<td><input type="text" name="ctextsubkey"
																maxlength="250"></td>
															<td width="5">&nbsp;</td>
															<td class="black11px"><input type="hidden"
																name="subselect" value="subselect"> <%
 	if (sessionAllRecords!=null && sessionAllRecords.equals("all")) {
 %> <input type="hidden" name="allRecords" value="all"> <%
 	}
 %> 
																&nbsp;&nbsp;</td>
														</tr>
													</table> <!--- End Search Keyword Form----></td>
												<td width="1" height="42"></td>
											</tr>
										</table>
									</div>
								</td>
								<td>&nbsp;</td>

								<!-- OCR SEARCH FORM -->
								<%
									if (polCountyFlag != null && polCountyFlag.equals("Y") && iPhoneSession != null && iPhoneSession.equals("N")) {
								%>
								<td bgcolor="EFF4FA" width="350">
									<div class="toggle-ocr">
										<table id="toggle-ocr-table1" border="0" cellpadding="0" cellspacing="0">
											<tr>
												<td width="1" height="30"></td>
												<td width="10">&nbsp;</td>
												<td class="black10px" WIDTH="350">Enter your keyword
													below to refine your search.<!--  Multiple keywords must be
													separated by commas. -->
												</td>
												<td width="1"></td>
											</tr>
											<tr>
												<td width="1"></td>
												<td width="10">&nbsp;</td>
												<td><table width="374" border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td width="75" class="black10px">Saved Search:</td>
															<td width="90"><select name="ocrtextselect"
																class="width140">
																	<option value="">--Select--</option>
																	<%
																		try {
																					map = searchModel.getSavedOcrNames(map);
																					String splitOcrSearchName[] =
																							(String[]) map.get("splitOcrSearchName");
																					if (splitOcrSearchName != null
																							&& splitOcrSearchName.length > 0) {
																						for (int i = 0; i < splitOcrSearchName.length; i++) {
																							String splitStr[] =
																									splitOcrSearchName[i].split("@");
																	%>
																	<option value="<%=splitStr[1]%>"
																		title="<%=splitStr[1]%>"><%=splitStr[0]%></option>
																	<%
																		}//End of for loop
																					} // End of splitOcrSearchName NULL check
																				} catch (Exception ex) {
																					System.out.println("ERROR: OCR Keywords parsing "
																							+ ex.toString());
																				}
																	%>
															</select></td>
															<td width="35"><a href="#" 
																onclick="javascript:deleteOCRKeyword()"> <img
																	src="<%=request.getContextPath()%>/images/buttons/button_delete_icn.gif"
																	width="25" height="26" border="0">
															</a></td>
															<td width="80" class="black11px"><a href="#" 
																onclick="javascript:callOCRTextSearch()"><img
																	src="<%=request.getContextPath()%>/images/buttons/button_search.gif"
																	width="70" height="17" border="0" align="top"></a>&nbsp;&nbsp;</td>
														</tr>
													</table> <!--- End Search Keyword Form----></td>
												<td width="1"></td>
											</tr>
											<tr>
												<td width="1"></td>
												<td width="10">&nbsp;</td>
												<td><table border="0" cellpadding="0" cellspacing="0">
														<tr>
															<td width="83" class="black10px">OCR Keyword:</td>
															<td width="195"><input name="ocrtext" type="text"
																value="" size="27" maxlength="50"></td>
															<td width="80" class="black11px" align="center"><a
																href="#" onClick="javascript:OCRSave()"><img
																	src="<%=request.getContextPath()%>/images/buttons/button_save_ocrs.gif"
																	width="70" height="18" border="0"></a></td>
														</tr>
													</table> <!--- End Search Keyword Form----></td>
												<td width="1" height="42"></td>
											</tr>
										</table>
									</div>
								</td>
								<%
									}
								%>
								<!-- END OCR FORM -->
							</tr>

						</table></td>
					<td></td>
					
				</tr>
			</table>
			<%
				}
			%>
		</form>
		<!--********* END REFINE / OCR FORM ******************-->

		 
		<!--Implemented the right Ad as requested by Terry on Spet 27th 2013 by Johnson--->
		<%
			if (searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch")) {
		%>
		<div class="rightSideAd">
			<!-- Commented old Ad and added new Ad as requested by Terry on 05/21/14 by Muthu -->
			<!--<a href="http://www.rentalhq.com" target="_blank"><img src="<%=request.getContextPath()%>/images/RentalHQ.JPG" border="0"></a>-->
			<!-- Commented old Ad and added new Ad as requested by Terry on 07/15/14 by Muthu -->
			<!--<a href="http://cdclb.cdcnews.com/media-kit-download" target="_blank"><img alt="Skyscraper-Ad" src="<%=request.getContextPath()%>/images/cdc_ad2.gif" border="0"></a>-->
			<a href="http://cdclb.cdcnews.com/GetMorecoverage_LM" target="_blank"><img
				alt="Skyscraper-Ad"
				src="<%=request.getContextPath()%>/images/skyscraper/CDC-News-2015-120-x-600.png"
				border="0"></a>
		</div>
		<%
			}

if(qLinksFlag==false && searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch")) { %>
<table  width="780" cellspacing="1" <%if(pages>0 && nkeysession==null){%> class="viewform-ssname-static" <%}else{%> class="marginLeft105" <%}%> cellpadding="1" border="0">
  <tr>
    <td align="center" CLASS="orange12px"><%out.println(searchBean.getSavedSearchName());%>
      <%
				    if(savedSearchBean.getHotlistLastRunDate()!=null && !savedSearchBean.getHotlistLastRunDate().equals("01/01/1900") && !savedSearchBean.getHotlistLastRunDate().equals("") && savedSearchBean.isHotlist())
					{
				       out.println("Last Searched on "+savedSearchBean.getHotlistLastRunDate());	
					
					}
				
				
				
				%>
    </td>
  </tr>
</table>

		<% }
			if (pages > 0) {
		%>
		<!-- *********************** GOTO & SORTING AREA ****************************-->
		<table id="goto-table1" class="goto-bg-header">
			<tr>
				<%
					if (ocrtextsession != null && ocrtextsession.equals("true")) {
				%>
				<td width="140"></td>
				<!-- Keeps the "Go to Page:" at the center in the OCR result page. -->
				<%
					}
				%>
				<!--******* GOTO ********-->
				<td align="center" class="black11px">
					<form name="frmPage" id="frmPage" method="post">
						<!-- margin:0,padding:0 removes extra space arround form tag.-->
						<b>Go to Page:</b> <input type="text" name="next" size="5">
						<!-- added below if by Selva, inorder to send allRecords value when clicking go button -->
						<%
							if(request.getParameter("allRecords") != null) {
						%>
						<input type="hidden" name="allRecords"
							value="<%=request.getParameter("allRecords")%>" />
						<%
							}
						%><input type="hidden" name="d_mode" value="<%=sessionmode%>" />
						<input name="button" type="image"
							src="<%=request.getContextPath()%>/images/buttons/button_go_new.gif"
							onClick="return validatePages(<%=pages%>);" class="verticalAlignMiddle">
					</form>
				</td>
				<!--******* END GOTO ********-->
				<!--*****  SORT DROPDOWN ******-->
				<%
					if (pages > 0 && sessionmode != null && sessionmode.equals("b") && ocrtextsession != null && !ocrtextsession.equals("true")
								&& nkeysession == null // Added By Selva
						) {
				%>
				<form name="sortFrm" id="sortFrm" method="post">
					<td align="center" class="black11px">
						<%
							String sVal = sortPage;
							String sValType = sortType;
							if ((String) map.get("sortVal") != null)
								sVal = (String) map.get("sortVal");
							if ((String) map.get("sortType") != null)
							sValType = (String) map.get("sortType");
						%> <strong>Sort Results By:</strong> 
						<select name="sort">
					<%
						Map sortResultsByMap = (Map)map.get("sortResultsByMap");
						Iterator<Map.Entry> entries = sortResultsByMap.entrySet().iterator();
						
						while (entries.hasNext()) {
							Map.Entry<String, String> entry = entries.next();
							String val = (String)entry.getKey();
							if(entry.getKey()!=null && entry.getKey().equals("new_jobs")) {
								val = "leads_entry_date";
							}
					%>
						<option value="<%=val%>" <%if (sVal.equals(val)) {%> selected="selected"<%}%>><%=entry.getValue()%></option>
					<%
						}
					%>
					</select>
					
					</td>
					<td align="left" class="black11px"><select
						name="sortType">
							<option value="asc" <%if (sValType.equals("asc")) {%> selected
								<%}%>>Ascending</option>
							<option value="desc" <%if (sValType.equals("desc")) {%> selected
								<%}%>>Descending</option>
					</select> <input name="button2" type="image"
						src="<%=request.getContextPath()%>/images/buttons/button_go_new.gif"
						onClick="return sortPages();" class="verticalAlignMiddle"></td>
				</form>
				<%
					} //End of SORT DROPDOWN Chdck
				%>
				<!--*****  END SORT DROPDOWN ******-->
			</tr>
		</table>
		<!-- *********************** END GOTO & SORTING AREA ****************************-->
		<%
			} // End pages>0
		%>

		<!--************  PAGINATION & ACTION BUTTONS AREA ************-->
		<table class="pagination-table1 
			<%if (sessionmode != null && sessionmode.equals("d")
					&& ocrtextsession != null && ocrtextsession.equals("false")) {%>
			 marginLeft45<%}%>">

			<!-- **** PREVIOUS/NEXT/BACK ******  -->
			<%
				if (pages > 0) {
			%>
			<tr>
				<td width="100">&nbsp;</td>
				<!-- BACK BUTTON -->
				<%
					if (pages > 0 && sessionmode != null && sessionmode.equals("d")) {
				%>
				<%
					if (Integer.parseInt(pageNum) == 1 && nkeysession == null
													&& qLinksFlag == false && ocrtextsession != null
													&& !ocrtextsession.equals("true")) {
				%>
				<td width="100">
				<%
				if(qLinksFlag==false && searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch")) {
					%>
					 <form method="post" action="<%=request.getContextPath()%>/online-product/saved-search/saved-search-decide">
						<input type="hidden" name="action" value="edit">
						<input id="back-button" type="submit" value=""/>
						</form>
					
					<%
					
				} 
				//condition to not to show back button in sps results in detail mode
				else if(searchBean.getSearchModule() == null || !searchBean.getSearchModule().trim().equalsIgnoreCase("SPS")) {
					%>
				<form name="goBackForm">
				<input type="hidden" name="flag" value="1" />
				<a 
					onclick="javascript:go_back(document.goBackForm)"
					href="#"><img 
						src="<%=request.getContextPath()%>/images/buttons/button_back.gif"
						border="0"></a></form></td>
				<%
						}
					}
				%>

				<%
					}
				%>
				
	<% if(searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch") && (sessionmode.equals("b")==true || ocrtextsession.equals("true"))) {%>
				
				<!-- Jobs Per Page added as requested by Terry. Added by Muthu on 10/21/13 -->
	<td class="black11px paddingLeft10" colspan="2" align="left">
	
		<form name="PerPageFrm">	
	<b>Jobs Per Page:</b> <select name="per_page" onChange="return changeChunk('ss');">
						<option value="10" <%if(chunk==10){%> 
								selected<%}%>>10</option>
						<option value="25" <%if(chunk==25){%> 
						selected<%}%>>25</option>
						<option value="50" <%if(chunk==50){%> 
						selected<%}%>>50</option>
						<option value="100" <%if(chunk==100){%> 
						selected<%}%>>100</option>
				  </select>
	   </form>
				   
				</td>
	   <%} //End of brief page check for per page. %>

				<!-- COUNT DISPLAY -->
				<td class="black11px" colspan="11" align="center">
				<font color="black"><b>Current Page :</b>&nbsp;<i>
					<%out.println(pageNum);%>
					</i><font>&nbsp;<b>out of&nbsp;</b></font><i>
					<%out.println(pages);%>
					</i>&nbsp;<b>page(s)</b></font>&nbsp;&nbsp;&nbsp;&nbsp; <font color="black"><b>Current Jobs :</b><i>
					<%out.println((start + 1));%>
					-
					<%out.println(end);%>
					</i></font>&nbsp;<b>out of&nbsp;&nbsp;</b><i>
					<%out.println(session.getAttribute("total"));%>
					</i>&nbsp;&nbsp;job(s)
				</td>

				<!-- PREVIOUS / BUTTON ONLY IF DETAIL MODE -->
				<%
					if(pages>0 &&  ((sessionmode!=null && sessionmode.equals("d")) || (nkeysession!=null) ) && (ocrtextsession!=null && ocrtextsession.equals("false")) ) {
				%>

				<!-- PREVIOUS -->
				<td align="left">
					<%
						if (Integer.parseInt(pageNum) > 1) {
					%> 

					<!-- form for previous button added by selva: inorder to not to show the query string in the url -->
					<form method="post"
						action="<%=request.getContextPath()%>/online-product/search-results/previous">
						<input type="hidden" name="next"
							value="<%=Integer.parseInt(pageNum) - 1%>">
						<%
							if(request.getParameter("allRecords") != null) {
						%>
						<input type="hidden" name="allRecords"
							value="<%=request.getParameter("allRecords")%>" />
						<%
							}
						%>
						<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
						<input id="previous-button" type="submit" value=""/>
					</form> <%
 	}
 %>
				</td>

				<!-- NEXT -->
				<td align="left">
					<%
						if (nextflag == true) {
					%> 

					<!-- form for next button added by selva: inorder to not to show the query string in the url -->
					<form method="post"
						action="<%=request.getContextPath()%>/online-product/search-results/next">
						<input type="hidden" name="next"
							value="<%=Integer.parseInt(pageNum) + 1%>">
						<%
							if(request.getParameter("allRecords") != null) {
						%>
						<input type="hidden" name="allRecords"
							value="<%=request.getParameter("allRecords")%>" />
						<%
							}
						%>
						<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
						<input id="next-button" type="submit" value=""/>
					</form> <%
 	}
 %>
				</td>
				<%
					}
				%>
				<!-- END PREVIOUS / BUTTON ONLY IF DETAIL MODE -->
			</tr>
			<%
				}
			%>
			<!-- **** END PREVIOUS/NEXT/BACK ******  -->

			<!-- ***** ACTION BUTTONS / PREVIOUS / NEXT  -->
			<tr>
				<%
					if ((pages > 0 && sessionmode != null && sessionmode.equals("b") && nkeysession == null)
											|| (pages > 0 && ocrtextsession != null && ocrtextsession
													.equals("true"))) {
				%>
				<td width="182" class="padding0-64"></td>

				<!-- BACK -->
				<td>
					<%
						if (Integer.parseInt(pageNum) == 1 && (nkeysession == null)
															&& qLinksFlag == false
															&& !ocrtextsession.equals("true")) {
							if(qLinksFlag==false && searchBean.getSearchModule()!=null && searchBean.getSearchModule().trim().equalsIgnoreCase("SavedSearch")) {
					%>
					 <form method="post" action="<%=request.getContextPath()%>/online-product/saved-search/saved-search-decide">
						<input type="hidden" name="action" value="edit">
						<input id="back-button" type="submit" value=""/>
						</form>
					
					<%
					
							} else {
								//condition to not to show back button in sps results in breif mode
								if(searchBean.getSearchModule() == null || !searchBean.getSearchModule().trim().equalsIgnoreCase("SPS")) {
					%>
					
					 <form name="goBackForm">
					 <input type="hidden" name="flag" value="1" /><a 
					onclick="javascript:go_back(document.goBackForm)"
					href="#"><img
						src="<%=request.getContextPath()%>/images/buttons/button_back.gif"
						border="0"></a></form>
						
						 <%
								}
							}
 	}
 %>
				</td>

				<!-- BACK IF OCR PAGE -->
				<%
					if (ocrtextsession.equals("true")) {
				%>
				<td>
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
					</td>
				<%
					}
				%>

				<!-- ACTION BUTTONS -->
				<td width="140"><a href="javascript:print_window_new()"><img
						src="<%=request.getContextPath()%>/images/buttons/button_print_jobs_icn.gif"
						alt="PRINT SELECTED JOBS" border="0" align="bottom"></a></td>
				<td width="140"><a href="javascript:printBriefReport()"><img
						src="<%=request.getContextPath()%>/images/buttons/PBR_button.png"
						alt="PRINT BRIEF REPORT" width="137" height="15" border="0"
						align="bottom"></a></td>
				<td width="140"><a
					<%if (userviewjobwindow == 0) {%>
					href="javascript:view_sel_jobs_self('<%=sessionLoginId%>','<%=sessionmode%>','<%=sessionAllRecords%>','s','<%=pageNum%>')"
					<%} else {%> href="javascript:view_sel_jobs('<%=sessionLoginId%>')"
					<%}%>><img
						src="<%=request.getContextPath()%>/images/buttons/VSJ_button.png"
						alt="VIEW SELECTED JOBS" width="137" height="15" border="0"
						align="bottom"></a></td>
				<td width="140"><a
					href="javascript:screen_sel_jobs('<%=sessionLoginId%>')"><img
						src="<%=request.getContextPath()%>/images/buttons/SSJ_button.png"
						alt="SCREEN SELECTED JOBS" width="137" height="15" border="0"
						align="bottom"></a></td>
				<!-- HIDE VAID BUTTON IN OCR PAGE -->
				<%
					if (!ocrtextsession.equals("true")) {
				%>
				<td width="140"><a href="javascript:view_all_detail()">
						<img
						src="<%=request.getContextPath()%>/images/buttons/VAID_button.png"
						width="137" alt="VIEW ALL IN DETAIL" height="15" border="0"
						align="bottom">
				</a></td>
				<%
					}
				%>

				<!-- PREVIOUS / NEXT -->
				<%
					if (pages > 0) {
				%>

				<!-- PREVIOUS -->
				<td align="left">
					<%
						if (Integer.parseInt(pageNum) > 1) {
					%> <!-- form for previous button added by selva: inorder to not to show the query string in the url -->
					<form method="post"
						action="<%=request.getContextPath()%>/online-product/search-results/previous">
						<input type="hidden" name="next"
							value="<%=Integer.parseInt(pageNum) - 1%>">
						<%
							if(request.getParameter("allRecords") != null) {
						%>
						<input type="hidden" name="allRecords"
							value="<%=request.getParameter("allRecords")%>" />
						<%
							}
						%>
						<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
						<input id="previous-button" type="submit" value="" />
					</form> 
					<%
 					}
				 	%>
				</td>

				<!-- NEXT -->
				<td align="left">
					<%
						if (nextflag == true) {
					%> <!-- form for next button added by selva: inorder to not to show the query string in the url -->
					<form method="post"
						action="<%=request.getContextPath()%>/online-product/search-results/next">
						<input type="hidden" name="next"
							value="<%=Integer.parseInt(pageNum) + 1%>">
						<%
							if(request.getParameter("allRecords") != null) {
						%>
						<input type="hidden" name="allRecords"
							value="<%=request.getParameter("allRecords")%>" />
						<%
							}
						%>
						<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
						<input id="next-button" type="submit" value="" />
					</form> 
					<%
					}
 					%>
				</td>
				<%
					}
				%>
				<!-- END PREVIOUS / NEXT -->

				<%
					} //END OF ACTION BUTTONS CHECK
				%>

			</tr>
			<!-- ***** END ACTION BUTTONS / PREVIOUS / NEXT  -->

			<!-- NOTE -->
			<%
				int totrecords = 0;
						String allRecordsFlag = null;
						if (pages > 0) {
							allRecordsFlag = (String) map.get("allRecords");
							totrecords = Integer.parseInt(String.valueOf(totrec));
							if (!((allRecordsFlag!=null && allRecordsFlag.equals("all")) || totrecords > 1000
									|| nkeysession != null) && totrecords >= 1000) {
			%>
			<tr>
				<td>&nbsp;</td>
				<td class="red10px" colspan="11"><b>NOTE: To view more than
						1000 jobs, click the "Show All (removes 1000 limit)" box before
						running the search.</b></td>
			</tr>

			<%
				}
			%>
			<!-- END NOTE -->
			<%
				} //END OF pages>0 CHECK FOR NOTE
			%>

			<tr>
				<td></td>
			</tr>

		</table>
		<!--************  END PAGINATION & ACTION BUTTONS AREA ************-->

		<%
			if (map.get("total") != null
					&& Integer.parseInt(String.valueOf(map.get("total"))) > 0
					&& nkeysession == null) {
		%>
	</div>
	<!-- END top_static_header div -->
	<%
		}
	%>

	<!-- Wrap in the div if page contains Result. -->
	<%
		if (map.get("total") != null
		&& Integer.parseInt(String.valueOf(map.get("total"))) > 0) {
	%>
	<div class="<%if (nkeysession == null) {%> full_table <%}%>
		<%if (!((allRecordsFlag!=null && allRecordsFlag.equals("all")) || totrecords > 1000
						|| nkeysession != null) && totrecords >= 1000) {%>
		 marginTopMinus16 <%}%>">
		<%
			}
		%>

		<!--*************************** MAIN FORM ***********************************-->
		<form name="mainform" method="post">

			<!-- SEARCH JPG -->
			<table width="995" class="borderSpacing0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="182" align="left"><img
						src="<%=request.getContextPath()%>/images/search_result/search_results.gif"
						width="117" height="22" border="0" alt="Search Results"
						class="verticalAlignBottom" /></td>
				</tr>
			</table>

			<!-- SEARCH RESULT TABLE (BRIEF) -->
			
			<%out.println(searchModel.getProjectsBreifView(request)); %>
			
			<!-- Gray action buttons at bottom of Brief result -->
			<%
				if(pages>0 &&  ((sessionmode != null && sessionmode.equals("b")) || ocrtextsession.equals("true"))
						&& nkeysession == null // Added by Selva
						){
			%>
			<table class="grayaction-table1">
				<tr>
					<td width="150" class="padding0-58"></td>
					<td>
						<%
							//condition to not to show back button in sps results in breif mode
							if(Integer.parseInt(pageNum)==1 && (nkeysession==null) &&  qLinksFlag==false && !ocrtextsession.equals("true") && (searchBean.getSearchModule() == null || !searchBean.getSearchModule().trim().equalsIgnoreCase("SPS"))){
						%><!-- onclick="window.history.back();" -->
						<input type="hidden" name="flag" value="1" /><a 
					href="#" onClick="javascript:go_back(document.mainform)"><img
							src="<%=request.getContextPath()%>/images/buttons/button_back.gif"
							border="0"></a> <%
 	}
 %>
					</td>
					<%
						if(ocrtextsession.equals("true")){
					%>
					<td>
						<form method="post"
						action="<%=request.getContextPath()%>/online-product/search-results">
						<input type="hidden" name="backval"
							value="Y">
							<input type="hidden" name="allRecords"
							value="<%=sessionAllRecords%>">
							<input id="back-button" type="submit" value=""/>
						</form>
					</td>
					<%
						}
					%>
					<td width="140"><a href="javascript:print_window_new()"><img
							src="<%=request.getContextPath()%>/images/buttons/button_print_jobs_icn.gif"
							alt="PRINT SELECTED JOBS" border="0" align="bottom"></a></td>
					<td width="140"><a href="javascript:printBriefReport()"><img
							src="<%=request.getContextPath()%>/images/buttons/PBR_button.png"
							alt="PRINT BRIEF REPORT" width="137" height="15" border="0"
							align="bottom"></a></td>
					<td width="140"><a
						<%if(userviewjobwindow == 0){%>
						href="javascript:view_sel_jobs_self('<%=sessionLoginId%>','<%=sessionmode%>','<%=sessionAllRecords%>','s','<%=pageNum%>')"
						<%}else{%> href="javascript:view_sel_jobs('<%=sessionLoginId%>')"
						<%}%>><img
							src="<%=request.getContextPath()%>/images/buttons/VSJ_button.png"
							alt="VIEW SELECTED JOBS" width="137" height="15" border="0"
							align="bottom"></a></td>
					<td width="140"><a
						href="javascript:screen_sel_jobs('<%=sessionLoginId%>')"><img
							src="<%=request.getContextPath()%>/images/buttons/SSJ_button.png"
							alt="SCREEN SELECTED JOBS" width="137" height="15" border="0"
							align="bottom"></a></td>
					<%
						if(!ocrtextsession.equals("true")){
					%>
					<td width="140"><a href="javascript:view_all_detail()"><img
							src="<%=request.getContextPath()%>/images/buttons/VAID_button.png"
							width="137" alt="VIEW ALL IN DETAIL" height="15" border="0"
							align="bottom"></a></td>
					<%
						}
					%>

					<!-- PREVIOUS BUTTON -->
					<%
						if(pages>0){
					%>
					<td align="left">
					<%
						if (Integer.parseInt(pageNum) > 1) {
					%> <%
								if(nextflag==false){
								%> 
								<input type="hidden" name="next">
							<%
								}
								if(request.getParameter("allRecords") != null) {
							%>
							<input type="hidden" name="allRecords"
								value="<%=request.getParameter("allRecords")%>" />
							<%
								}
							%>
							<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
							
							<a href="#" onClick="javascript:SubmitForm(<%=Integer.parseInt(pageNum) - 1%>,'p')">
							<img src="<%=request.getContextPath()%>/images/buttons/button_previous.gif"></a>
					<%
 					}
				 	%>
					</td>

					<!-- NEXT BUTTON -->
					<td align="left">
					<%
						if (nextflag == true) {
					%> <input type="hidden" name="next">
							<%
								if(request.getParameter("allRecords") != null) {
							%>
							<input type="hidden" name="allRecords"
								value="<%=request.getParameter("allRecords")%>" />
							<%
								}
							%>
							<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
							<a href="#" onClick="javascript:SubmitForm(<%=Integer.parseInt(pageNum) + 1%>,'n')">
							<img src="<%=request.getContextPath()%>/images/buttons/button_next.gif"></a>
					<%
					}
 					%>
					</td>

					<%
						} //End of Pre/Next button
					%>
				</tr>
			</table>
			<%
				}
			%>
			<!-- End of Gray action buttons at bottom of Brief result -->

			<%
				if((pages>0 &&  sessionmode != null && sessionmode.equals("b") && nkeysession==null) || (pages>0 && ocrtextsession.equals("true")))
				{
			%>
			<input type="hidden" id="jobscount" value="<%=jobscount%>">
			<%
				}
			%>


			<!-- ****************************************************************************** 
			DETAIL SEARCH RESULT
*********************************************************************************** -->
			<%
			if(((sessionmode != null && sessionmode.equals("d")) || (nkeysession!=null)) && ocrtextsession.equals("false"))
				{
					String IDList=null;
					int count=0;
					int sJobId=0;
					String sJobName=null;
					String sJobCDCId=null;
					Iterator iteratorList = null; 
					if (pageUtil != null)
						myList = pageUtil.getPages(start, end);
					if(myList != null)
						iteratorList = myList.iterator();
					String planExpressFlag=null;
					String shortCDCID=null;
					//String loginId=(String)map.get("login_id");
					String loginId = userBean.getLoginId(); // Added by Selva
					common.BriefBean exBean=null;
					SaveBean sBean=null;
					if(pages>0){
			%>

			<!-- Gray action buttons at TOP of Detail result -->
			<table class="ss-details-buttons" cellpadding="0" cellspacing="0">
				<tr>

					<!-- Back Submit Button -->
					<td width="140">
						<table <%if(nkeysession!=null){%> class="marginTopMinus35" <%}%>>
							<tr>
								<td>
									<%
										if(nkeysession!=null && Integer.parseInt(pageNum)==1){
									%> &nbsp;
						
						<input type="hidden" name="backval" value="Y">
						<input type="hidden" name="allRecords" value="<%=sessionAllRecords%>">
						<a href="#" onClick="javascript:SubmitForm2('<%=dmodeSession%>','<%=sessionAllRecords%>')">
						<img src="<%=request.getContextPath()%>/images/buttons/button_back.gif" />
						</a>
								<%
 	}
 %>
								</td>
							</tr>
						</table>
					</td>

					<!-- PRINT SELECTED JOBS BUTTON -->
					<td id="psj-td"><input type="Checkbox" name="printalljobs"
						onClick="selectAll(this)" value="all"> <a
						href="javascript:print_window_new()"> <img
							src="<%=request.getContextPath()%>/images/buttons/button_print_jobs_icn.gif"
							alt="PRINT SELECTED JOBS">
					</a></td>

					<!-- SCREEN SELECTED JOBS BUTTON -->
					<td id="ssj-td"><a
						href="javascript:screen_sel_jobs('<%=sessionLoginId%>');"> <img
							src="<%=request.getContextPath()%>/images/buttons/SSJ_button.png"
							alt="SCREEN SELECTED JOBS">
					</a></td>

					<!-- VIEW ALL IN BRIEF BUTTON (NOT FOR OCR RESULT ) -->
					<%
						if(map.get("total")!=null && Integer.parseInt(String.valueOf(map.get("total")))>0 && nkeysession==null) {
					%>
					<td id="view-all-breif"><a
						href="javascript:view_all_brief()"> <img
							src="<%=request.getContextPath()%>/images/buttons/VAIB_button.png"
							alt="view all in brief">
					</a></td>
					<%
						}
					%>

				</tr>
			</table>
			<!-- End of  Gray action buttons at TOP of Detail result -->

			<br>
			<div id="detail-container" class="ss-details-scroll">
				<%
					}
							
							
						while(iteratorList != null && iteratorList.hasNext())
						{
							exBean=(common.BriefBean)iteratorList.next();

							if(count==0)
							{
								IDList=String.valueOf(exBean.getContentID());
							}
							else
							{
								IDList=IDList+","+String.valueOf(exBean.getContentID());
							
							}
							count++;
							
						} // END OF WHILE (iteratorList)
						%>

				<!-- ROOT TABLE------------------------1  -->
				<table>
					<tr>
						<td width="8"></td>
						<td width="881">
							<%
										//ArrayList contentList = null;
										//contentList = searchModel.getContentList(IDList);
										String detailContent = searchModel.getProjectDetailByProjectId(IDList, request);
										if(detailContent!=null)
										out.println(detailContent);
							%>
						</td>
					</tr>
				</table>
				<!-- END ROOT TABLE------------------------1  -->
			</div>

			<!--- Action gray buttons at the bottom of detail mode. Added as per requested on 05/31/13--->
			<%
				if(pages>0){
			%>
			<table class="gray-buttons-bottom">
				<tr>
					<%
						//condition to not to show back button in sps results in detail mode
						if(Integer.parseInt(pageNum)==1 && nkeysession==null &&  qLinksFlag==false && !ocrtextsession.equals("true") 
						&& (searchBean.getSearchModule() == null || !searchBean.getSearchModule().trim().equalsIgnoreCase("SPS"))){
					%>
					<td width="55"><!-- onclick="window.history.back();" -->
					<input type="hidden" name="flag" value="1" /><a 
					href="#" onClick="javascript:go_back(document.mainform)"><img
							src="<%=request.getContextPath()%>/images/buttons/button_back.gif"></a></td>

					<%
						}
					%>
					<td><table>
							<tr>
								<td>
									<%
										if(nkeysession!=null && Integer.parseInt(pageNum)==1){
									%> &nbsp; 
						<input type="hidden" name="backval" value="Y">
						<input type="hidden" name="allRecords" value="<%=sessionAllRecords%>">
						<a href="#" onClick="javascript:SubmitForm2('<%=dmodeSession%>','<%=sessionAllRecords%>')"><img
							src="<%=request.getContextPath()%>/images/buttons/button_back.gif"></a>
									<%
										}
									%>
								</td>
							</tr>
						</table></td>
					<td valign="top"><a href="javascript:print_window_new()">
							<img
							src="<%=request.getContextPath()%>/images/buttons/button_print_jobs_icn.gif"
							alt="PRINT SELECTED JOBS" width="137" height="15">
					</a></td>
					<td valign="top"><a
						href="javascript:screen_sel_jobs('<%=sessionLoginId%>');"><img
							src="<%=request.getContextPath()%>/images/buttons/SSJ_button.png"
							alt="SCREEN SELECTED JOBS" width="137" height="15"></a></td>
					<%
						if(map.get("total")!=null && Integer.parseInt(String.valueOf(map.get("total")))>0 && nkeysession==null) {
					%>
					<td width="210" valign="top"><a
						href="javascript:view_all_brief()"> <img
							src="<%=request.getContextPath()%>/images/buttons/VAIB_button.png"
							alt="view all in brief" width="137" height="15">
					</a></td>
					<%
						}
					%>

					<%
						if(pages>0 &&  ((sessionmode != null && sessionmode.equals("d"))||(nkeysession!=null))){
					%>
					<td class="previous-next">
						<%
							if(Integer.parseInt(pageNum)>1)
													{
						%> <%
								if(nextflag==false){
								%> 
								<input type="hidden" name="next">
							<%
								}
								if(request.getParameter("allRecords") != null) {
							%>
							<input type="hidden" name="allRecords"
								value="<%=request.getParameter("allRecords")%>" />
							<%
								}
							%>
							<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
							
							<a href="#" onClick="javascript:SubmitForm(<%=Integer.parseInt(pageNum) - 1%>,'p')">
							<img src="<%=request.getContextPath()%>/images/buttons/button_previous.gif"></a>
					<%
 	}
 %>
					</td>
					<td class="previous-next">
						<%
							if(nextflag==true)
												   {
						%> <input type="hidden" name="next">
							<%
								if(request.getParameter("allRecords") != null) {
							%>
							<input type="hidden" name="allRecords"
								value="<%=request.getParameter("allRecords")%>" />
							<%
								}
							%>
							<input type="hidden" name="d_mode"	value="<%=sessionmode%>">
							<a href="#" onClick="javascript:SubmitForm(<%=Integer.parseInt(pageNum) + 1%>,'n')">
							<img src="<%=request.getContextPath()%>/images/buttons/button_next.gif"></a>
					<%
 	}
 %>
					</td>
					<%
						}
					%>
				</tr>
			</table>
			<%
				}
			%>
			<!--- END OF BOTTOM GRAY ACTION BUTTONS--->

			<input type="hidden" id="jobscount" value="<%=count%>">
			
			<!-- colorbox to send project by mail. -->
			<cdc:email />
			
			<!--- fields used in save job --->
			<%
				} // END OF DETAILE CHECK - DETAILE MODE********************************************
			%>

			<%
				String pubListID=(String)map.get("pubListID");
				//out.println("pubListID"+pubListID);
				String ad_section=(String)map.get("sectionName");
				String ad_subsection=(String)map.get("subsectionTest");
				String sessionIdList=(String)map.get("cIdList");

				String ad_kwords=(String)map.get("adKeyword");

				int ad_flagValue = ad_flag.intValue();


				//commented by Johnson on 020210 because the pub ids list was not passed for single project search
				  //if(sessionIdList==null)
				 // {
				    
					
					map.put("ad_location","online_product");
					map.put("ad_pubid",pubListID);
					map.put("ad_section",ad_section);
					map.put("ad_subsection",ad_subsection); 
					map.put("ad_kwords",ad_kwords); 
					
					
				 // }
				//end of comment-020210 by Johnson
				  
				if(ad_flagValue==1)
				{
			%>
			<script>
  
//		top.frames[0].location.href="../../online_product/bannerAds/topadbarwithad.cfm?adsfrom=ss"
//		top.frames[0].location.href="../../online_product/topadbarwithad.cfm?adsfrom=ss"
	</script>

			<%
				}
			%>

			<!--- fields used in save job --->
			<input type="hidden" name="job_title" value=""> <input
				type="hidden" name="cdcid_savejob" value="">
			<!--- Added by Muthu on 04/17/13 to get the html element--->
			<input type="hidden" name="savejob_pid" value="">
			<!--- if bid date available, use it in calander --->
			<input type="hidden" name="biddate_savejob" value=""> <input
				type="hidden" name="prebiddate_savejob" value="">
			<!--- if bid date details available, use it in calander notes --->
			<input type="hidden" name="bidsinfo_savejob" value=""> <input
				type="hidden" name="pubid_details" value=""> <input
				type="hidden" name="secid_details" value=""> <input
				type="hidden" name="backbutton" value=""> <input
				type="hidden" name="bidsdetails" value=""> <input
				type="hidden" name="loginid" value="<%=userBean.getLoginId()%>">
			<input type="hidden" name="save_job_id" value=""> <input
				type="hidden" name="cdc_id" value=""> <input type="hidden"
				name="title" value=""> <input type="hidden" name="biddate"
				value=""> <input type="hidden" name="ocrtextValue"
				value="<%=ocrtextValue%>"> <input type="hidden"
				name="pidlist" value="">
			<!--- hidden field to store the selected project ids from localstorage variable  in js to get in printbunchjob.jsp page. Added by Muthu on 05/22/13--->

		</form>
		<!--***************** END MAIN FORM *********************-->

		<%
			if(map.get("total")!=null && Integer.parseInt(String.valueOf(map.get("total")))>0 ){
		%>
	</div>
	<!--full_table div ends-->
	<%
		}
	%>
<%
	//Close Data Base Connection
	DBController.releaseDBConnection(con);		  
%>
</body>

<script>
/* We can use this variable in js files to get contextPath in js */
var contextPath = '<%=request.getContextPath()%>'; 
</script>

<!-- Scripts to be loaded in the order at the page end. -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/jquery-1.7.1.min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/global.js?v=5.0"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/sortabletable.js?v=4.1"></script>
<!-- add sort type for sorting NumberK types -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/numberksorttype.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/uscurrencysorttype.js"></script>

<!-- Scripts to be loaded in the order at the page end. -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/JSON2.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/jstorage.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/search_result/searchResults.js"></script>

<script type="text/javascript">
	
<!--The Following Script will retain the checkbox state. Added by Muthu on 02/26/13-->	
		
$(document).ready(function(){

	loadInit();		
	
	// Deletes all the checkbox state cookies at first
	deleteJobsCookies();	
	
	//Iterate the cookie to set the Checkbox state. Added by Muthu on 02/26/13
	preserveJobsChkState();
	

	//Stores the checbox state in a cookie when the checkbox clicked. 
	//captureJobsChkState();		
	
	// Deletes the emailId checkbox state cookies at first;
	deleteEmailIdCookies();
	
	
}); // END OF DOCUMENT READY FUNCITON.	
	
</script> 
<!-- Scripts to be loaded in the order at the page end. -->
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/jquery.printElement.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/jquery.colorbox.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/autolink_new.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/JSScripts/gtracker.js"></script>


</html>