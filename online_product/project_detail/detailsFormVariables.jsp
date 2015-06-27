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
<%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>detailsFormVariables</title>
</head>
<body>
<%!		 
		String keyword=null;
		String cKeyword=null;
		String title=null;
		Map map=null;
		String id=null;
		String planExpressFlag=null;
		String sJobName=null;
		String subSection=null;
		String state_id=null;
		String plansAvailable=null;
		//ApplicationConfig applicationConfig=null;
		SearchUtil searchUtil = null;
		SearchDao searchDao = null;
		SearchModel searchModel = null;
		UserBean userBean = null;
		ContactBean contactBean = null;
		CDCUtil cdcUtil = null;
		String userView=null;
		BriefProject briefProject=null;
		EncryptDecrypt enc=null;
		int sJobId=0;
	 	String shortCDCID=null;
		String loginId=null;
		ServletContext context=null;
		String sessionLoginId=null;
		String itbSession=null;
		int userviewjobwindow=0;
		String iPhone=null;
		ArrayList contentList=null;
		Iterator contentIterator=null;
		Iterator itr = null;
		Iterator itrOwner = null;
		Iterator itrBidder = null;
		Iterator itrAwards = null;
		Iterator itrLowBidder = null;
		Iterator itrSubAwards = null;
		Iterator itrIndustry = null;
		Iterator itrSubIndustry = null;
		Iterator itrPlanRoomInfo = null;
		common.bean.ContentBean cbean=null;
		ArrayList scope_title_list=null;
		ArrayList division_name_list =null;
		ArrayList ownersList=null;
		ArrayList planHoldersList=null;
		ArrayList awardsList=null;
		ArrayList lowBiddersList=null;
		ArrayList subAwardsList =null;
		ArrayList industryList=null;
		ArrayList planRoomInfoList=null;
		SaveBean sBean = null;
		String ocrWord = null;
		String excludeFlag = null;
		String cdcId = null;
		String countyID = null;
		String ocrtextsession = null;
		String leads_id = null;
		String encryptedID = null;
		String polCountyFlag = null;
		String strCountyId = null;
		String biddateValue=null;
		String trackTitle=null; 
		String biddate = null;
		String backbutton = null;
		String lastEntry  = null;
		String firstReportedDate = null;
		String biDate = null;
		String bidsInfo = null;
		String pTitle  = null;
		String bidStages_bidder = null;
		String sub_sec = null;
		String countyMultiple = null;
		String stateMultiple = null;
		String amount_lower = null;
		String amount_upper = null;
		StringBuffer statusBuf = null;
		String status = null;
		String convertedDate = null;
		Locale usLocale = null;
		SimpleDateFormat sdf = null;
		Date tempdate = null;
		String newBiddate = null;
		String bidsopened_date = null;
		String openingDateText = null;
		String  duedate = null;
		String biddate_text = null;
		String subbidDueDate = "";
		StringTokenizer strtok = null;
		String token = null;
		String filedsubbid_date=null;
		String filedsubbid_text=null;
		String printDate=null;
		String fmt_filedsubbid_date  = null;
		String fmt_print_date = null;
		String dateLabel = null;
		String formattedStrtDt= null;
		String formattedEndDt= null;
		ArrayList indexList= null;
		String ownerKeyWords= null;
		String last_owner_title= null;
		String  newLine= null;
		common.bean.ExtractContact currentContact= null;
		String contactType= null;
		String company_name = null;
		String formattedZip= null;
		String formattedTel= null;
		BigDecimal phone_int = null;
		String formattedTelNo = null;
		String formattedFaxNo= null;
		Iterator listitr= null;
		common.bean.ExtractContact contactOthers= null;
		String contactTypeOthers = null;
		String companyNameOthers = null;
		StringBuffer sqft_story_text= null;
		String story_string = null;
		String scopeStr=null;
		String scopeStrList=null;
		ExtractScopeOfWorkData scopeData= null;
		HashMap hashmap = null;
		ArrayList al= null;
		Iterator itr3= null;
		String divList=null;
		String s= null;
		ArrayList al1= null;
		String divStr= null;
		String plansTitle= null;
		String plansText= null;
		String plansAvailDate= null;
		String amount= null;
		String mailingFee= null;
		String certCashFlag= null;
		String printDatee= null;
		String formattedPrintDate= null;
		String formattedPrebidMDate= null;
		String was_willbe = null;
		String printableDate = null;
		String dbcPreQualFlag= null;
		String smallBusinessFlag= null;
		String WbeMbeFlag= null;
		String preQualFlag= null;
		String cd= null;
		HashMap indMap= null;
		HashMap subIndMap= null;
		String mainInd=null;
		String subInd=null;
		StringTokenizer stInd= null;
		String Industry= null;
		String subIndustry= null;
		String prev_contacttype = null;
		common.bean.ExtractContact contactlowBidders= null;
		String lowbid_amount = null;
		BigDecimal amt = null;
		String fax_no = null;
		Long fax_no_int = null;
		String tel_no = null;
		Long tel_no_int = null;
		common.bean.ExtractContact contactAwards=null;
		String privateDisclaimer=null;
		String generalcontKeyWords=null;
        common.bean.ExtractContact contactPlanHolders =null;
		common.bean.ExtractContact contactPlanHoldersOthers =null;
		String contactAddedDate  =null;
		String lastEnteredDate =null;
		String addedDate =null;
		String lastentryDate = null;
		String webPublishyDate  =null;
%>
</body>
</html>
