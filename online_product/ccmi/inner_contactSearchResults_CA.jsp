<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.cdc.hotlist.util.HotlistUtil"%>
<%@ page contentType="text/html; " language="java" import="java.sql.*,net.sf.json.JSONObject,com.cdc.spring.bean.*,com.cdc.spring.model.*,com.cdc.spring.model.dao.*,com.cdc.spring.util.*,
com.cdc.util.CDCUtil,com.cdc.controller.DBController,java.util.*,
common.utils.*,java.io.*,java.util.Date,java.util.regex.*,java.util.*,leadsconfig.*,java.text.*,java.util.Map ,java.lang.StringBuffer,java.net.URLEncoder,java.math.BigDecimal,javax.rmi.*,common.*,common.bean.*,javax.swing.text.DateFormatter,java.text.*,java.sql.*,java.util.Date" %>

<%!//getMainSearchResults
  public ArrayList getMainSearchResults(String stateNameList,String countyIdList,String sectionAbbList,String industryList,String subIndustryList,
  String bidDateTo,String bidDateFrom,String conTypeList,String bidType,String divisionIdList,String companyName,String selectedState,String filterColumnFlag,String loginId,String contactId,String showAllRecordsFlag,String userCountylist,Connection con) 
       {
	System.out.println(stateNameList+':'+countyIdList+':'+sectionAbbList+':'+industryList+':'+subIndustryList+':'+conTypeList+':'+bidType+':'+divisionIdList+':'+userCountylist+':'+companyName+':'+selectedState+':'+filterColumnFlag);
	
   
    //CallableStatement cstmt = null;
    ArrayList searchResultsList = null;
   // ResultSet rs = null;
	int id=0;
	String cdcId=null;
	String saveJobId=null;
    ArrayList searchResults = null;
	
	/*New Script added to get Login Id*/
	
	System.out.println("con1:"+con);
	
    try {
      /* if (con == null) {
        con = JDBCUtil.getConnection();
      }
      cstmt = con.prepareCall("{call CA_CONTACTS_LEVEL2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
      cstmt.setString(1,stateNameList);
      cstmt.setString(2,countyIdList);
      cstmt.setString(3,sectionAbbList);
      cstmt.setString(4,industryList);
      cstmt.setString(5,subIndustryList);
	  cstmt.setString(6,bidDateFrom);
      cstmt.setString(7,bidDateTo);
      cstmt.setString(8,conTypeList);
      cstmt.setString(9,bidType);
      cstmt.setString(10,divisionIdList);
	  cstmt.setString(11,companyName);
	  cstmt.setString(12,selectedState);
	  cstmt.setString(13,filterColumnFlag);
	  cstmt.setString(14,loginId);
	  cstmt.setString(15,contactId);
	  cstmt.setString(16,showAllRecordsFlag);
	  cstmt.setString(17,userCountylist);
	  //System.out.println(bidDateFrom+"bidDateTo"+bidDateTo+filterColumnFlag);
      rs = cstmt.executeQuery();


      while (rs.next()) {
        
        searchResults = new ArrayList();
        id=rs.getInt("ID");
		
		cdcId=rs.getString("CDC_ID");
		saveJobId=rs.getString("SAVEJOB_ID");        
		searchResults.add("<a href=\"javascript:call_details("+id+",'"+loginId+"','"+saveJobId+"')\">"+rs.getString("TITLE")+"</a>");
		searchResults.add(rs.getString("STATE_NAME"));
		searchResults.add(rs.getString("COUNTY_NAME"));
		searchResults.add(rs.getString("BID_DATE"));
		searchResults.add(rs.getString("bidtype"));
		searchResults.add(rs.getString("PROJECT_TYPE"));
		searchResults.add(rs.getString("CONSTRUCTION_TYPE"));
        
        

        searchResultsList.add(searchResults);

      } // while.
      cstmt.close(); */
      
      
      
    	String query = "CA_CONTACTS_LEVEL2(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
    	ArrayList<String> paramList = null;
		paramList = new ArrayList<>();
		if(stateNameList!=null&&!stateNameList.trim().equals("")){
			paramList.add("varchar|"+stateNameList);
		}else {
			paramList.add("varchar| ");
		}
		if(countyIdList!=null&&!countyIdList.trim().equals("")){
			paramList.add("varchar|"+countyIdList);
			}else {
				paramList.add("varchar| ");
			}
			if(sectionAbbList!=null&&!sectionAbbList.trim().equals("")){
				paramList.add("varchar|"+sectionAbbList);
			}else {
				paramList.add("varchar| ");
			}
			if(industryList!=null&&!industryList.trim().equals("")){
				paramList.add("varchar|"+industryList);
			}else {
				paramList.add("varchar| ");
			}
			if(subIndustryList!=null&&!subIndustryList.trim().equals("")){
				paramList.add("varchar|"+subIndustryList);
			}else {
				paramList.add("varchar| ");
			}
			if(bidDateFrom!=null&&!bidDateFrom.trim().equals("")){
				paramList.add("varchar|"+bidDateFrom);
			}else {
				paramList.add("varchar| ");
			}
			if(bidDateTo!=null&&!bidDateTo.trim().equals("")){
				paramList.add("varchar|"+bidDateTo);
			}else {
				paramList.add("varchar| ");
			}
			if(conTypeList!=null&&!conTypeList.trim().equals("")){
				paramList.add("varchar|"+conTypeList);
			}else {
				paramList.add("varchar| ");
			}
			if(bidType!=null&&!bidType.trim().equals("")){
				paramList.add("varchar|"+bidType);
			}else {
				paramList.add("varchar| ");
			}
			if(divisionIdList!=null&&!divisionIdList.trim().equals("")){
				paramList.add("varchar|"+divisionIdList);
			}else {
				paramList.add("varchar| ");
			}
			if(companyName!=null&&!companyName.trim().equals("")){
				paramList.add("varchar|"+companyName);
			}else {
				paramList.add("varchar| ");
			}
			if(selectedState!=null&&!selectedState.trim().equals("")){
				paramList.add("varchar|"+selectedState);
			}else {
				paramList.add("varchar| ");
			}
			  if(filterColumnFlag!=null&&!filterColumnFlag.trim().equals("")){
				paramList.add("varchar|"+filterColumnFlag);
			}else {
				paramList.add("varchar| ");
			}
			  
			if(loginId!=null&&!loginId.trim().equals("")){
				paramList.add("varchar|"+loginId);
			}else {
				paramList.add("varchar| ");
			}
			if(contactId!=null&&!contactId.trim().equals("")){
				paramList.add("varchar|"+contactId);
			}else {
				paramList.add("varchar| ");
			}
			if(showAllRecordsFlag!=null&&!showAllRecordsFlag.trim().equals("")){
				paramList.add("varchar|"+showAllRecordsFlag);
			}else {
				paramList.add("varchar| ");
			}
			if(userCountylist!=null&&!userCountylist.trim().equals("")){
				paramList.add("varchar|"+userCountylist);
			}else {
				paramList.add("varchar| ");
			}
			
			ArrayList resultList = null;
			DBController dbContlr = null;
	  		dbContlr = new DBController();
	  		System.out.println("con2:"+con);
	  		resultList = dbContlr.executeCallable(query, paramList, true,con);
	  		System.out.println("con3:"+con);
	  		Iterator resultListItr = null;
	  		Map resultListMap = null;
			HotlistUtil hotlistUtil = null;
			
			hotlistUtil =  new HotlistUtil();
	  		searchResultsList = new ArrayList<List>();
	        
	        resultListItr = resultList.iterator();
	        while (resultListItr.hasNext()) {
		        
	        	 resultListMap = (Map<?, ?>) resultListItr.next();
	             searchResults = new ArrayList();
		        id=(int)resultListMap.get("id");
				
				cdcId=(String)resultListMap.get("cdc_id");
				saveJobId=(String)resultListMap.get("savejob_id");        
				searchResults.add("<a href=\"javascript:call_details("+id+",'"+loginId+"','"+saveJobId+"')\">"+resultListMap.get("title")+"</a>");
				searchResults.add((String)resultListMap.get("state_name"));
		  		searchResults.add((String)resultListMap.get("county_name"));
		  		searchResults.add((String)resultListMap.get("bid_date"));
		  		searchResults.add((String)resultListMap.get("bidtype"));
		  		searchResults.add(hotlistUtil.clobToString((Clob)resultListMap.get("project_type")));
		  		searchResults.add((String)resultListMap.get("construction_type"));
		        
		        

		        searchResultsList.add(searchResults);

		      } // while.
			
    }
    catch (Exception se) {
      System.out.println("!exception3.1!SQL error in getMainSearchResults-inner_contactSearchResuls_CA.jsp " + se);
    }
    finally {
      /* try {
        if (rs != null) {
          rs.close();
        }
      }
      catch (SQLException se) {
        System.out.println("!exception3.2!SQL error in getMainSearchResults-inner_contactSearchResuls_CA.jsp" +
                           se);

      }
      finally {
        try {
          if (cstmt != null) {
            cstmt.close();
          }
          if (con != null) {
            con.close();
          }

        }
        catch (SQLException se) {
          System.out.println("!exception3.3!SQL error in getMainSearchResults-inner_contactSearchResuls_CA.jsp" +
                             se);

        } 
      }*/
      
    }
    return searchResultsList;
  } // getMainSearchResults.
  
   public String getMainSearchResultsList(String state_name,String county,String section_name,String industry_type,String sub_industry_type,String bidDateTo,
   String bidDateFrom,String constructType,String bidtype,String divisionName,String companyName,String selectedState,String filterColumnFlag,String loginId,String contactId,String showAllRecordsFlag,String userCountylist,Connection con) {
    JSONObject jsonObject = null;
	ArrayList mainList=null;
    try {
      jsonObject = new JSONObject();
	  mainList = new ArrayList();
	  mainList = getMainSearchResults(state_name,county,section_name,industry_type,sub_industry_type,bidDateTo,bidDateFrom,constructType,bidtype,divisionName,companyName,selectedState,filterColumnFlag,loginId,contactId,showAllRecordsFlag,userCountylist,con);
	  
      jsonObject.put("sEcho", "1");
      jsonObject.put("iTotalRecords",
                    String.valueOf(mainList.size()));
      jsonObject.put("iTotalDisplayRecords",
                     String.valueOf(mainList.size()));


      jsonObject.put("aaData",  mainList);
	  //System.out.println(state_name+"COMPANY NAME"+companyName+"SELECTED STATE"+selectedState+"FILTER COLUMN"+filterColumnFlag+"LOGINID"+loginId+"CONTACT ID"+contactId );
      //System.out.println(jsonObject.toString());
    }
    catch (Exception e) {
      e.printStackTrace();

    } 
	finally{
	
		
	}
    return jsonObject.toString();

  }
  
  
  
  
  
  %>

<%
	
	String state_name=null;
	String section_name=null;
	String divisionName=null;
	String industry_type=null;
	String constructType=null;
	String sub_industry_type=null;
	String county=null;
	String bidtype=null;
	SearchBean searchBean = null;
	CDCUtil cdcUtil = null;
	SearchUtil searchUtil = null;
	UserBean userBean = null;
	String sessionLoginId = null;
	ApplicationContext ac = null;
	Connection con = null;
	
	
	ac = ApplicationConfig.getApplicationContext(request);
	userBean = (UserBean) ac.getBean("userBean");
	searchUtil = new SearchUtil();
	cdcUtil = new CDCUtil();
	searchBean = (SearchBean) ac.getBean("searchBean");
	
	sessionLoginId = userBean.getLoginId();
	String selectedState=request.getParameter("selectedState");
	String filterColumnFlag=request.getParameter("filterColumnFlag");
	
	if(searchBean.getStateList()!=null && searchBean.getStateList().size()>0)
		state_name=cdcUtil.getCommaSeparatedString(searchBean.getStateList());//request.getParameter("state");
		if(searchBean.getSectionList()!=null && searchBean.getSectionList().size()>0)
		section_name=cdcUtil.getCommaSeparatedString(searchBean.getSectionList());//request.getParameter("section");
		if(searchBean.getDivisionList()!=null && searchBean.getDivisionList().size()>0)
		divisionName=cdcUtil.getCommaSeparatedString(searchBean.getDivisionList());//request.getParameter("division");
		
		if(searchBean.getIndustryList()!=null && searchBean.getIndustryList().size()>0)
			industry_type = cdcUtil.getCommaSeparatedString(searchBean.getIndustryList());
			if(searchBean.getSubIndustryList()!=null && searchBean.getSubIndustryList().size()>0)
			sub_industry_type = cdcUtil.getCommaSeparatedString(searchBean.getSubIndustryList());
			if (industry_type != null && industry_type.trim().equalsIgnoreCase("Select All")) {
				industry_type = null;
				sub_industry_type = null;
			} else {
				industry_type = "";
				if (searchBean.getIndustryList() != null) {
					for (String industry : searchBean.getIndustryList()) {
						industry_type += industry + ",";
					}
				}
				industry_type = searchUtil.removeLastCharacter(industry_type, ",");

				// Getting Subindustries w.r.t selected industries
				if (sub_industry_type != null && sub_industry_type.trim().equalsIgnoreCase("Select All Sub Type")) {
					String[] indArr = industry_type.split(",");
					sub_industry_type = "";
					for (int i = 0; i < userBean.getIndustrySubIdNameList().size(); i++) {
						SearchBean seb = userBean.getIndustrySubIdNameList().get(i);
						String[] arr = seb.getSubIndustryParentIdName().split("\\|");

						if (arr != null) {
							for (int j = 0; j < indArr.length; j++) {
								String[] s = indArr[j].split("\\|");
								if (arr[0] != null && arr[0].equals(s[0])) {
									sub_industry_type += arr[1] + ",";
								}
							}
						}
					}
				} else {
					sub_industry_type = "";
					if (searchBean.getSubIndustryList() != null) {
						for (String subInd : searchBean.getSubIndustryList()) {
							sub_industry_type += subInd + ",";
						}
					}
					sub_industry_type = searchUtil.removeLastCharacter(sub_industry_type, ",");
				}
			}
			
			if(industry_type!=null)
				industry_type = searchUtil.getIndustryValues(industry_type);
			
			if(sub_industry_type!=null)
				sub_industry_type =  searchUtil.getIndustryValues(sub_industry_type);
			
			
	if(sub_industry_type!=null && !sub_industry_type.equals(""))
	{
		// Replaces '@' to '&' symbol added for over coming query string problem. Added on 08/20/13
		sub_industry_type = sub_industry_type.replaceAll("@","&");
	}
	else
	{
		sub_industry_type=null;
	}
	
	if(searchBean.getConstTypeList()!=null && searchBean.getConstTypeList().size()>0)
		constructType=cdcUtil.getCommaSeparatedString(searchBean.getConstTypeList());//request.getParameter("constType");
		if(searchBean.getCountyList()!=null && searchBean.getCountyList().size()>0)
		county=searchUtil.getSelectedCountyIds(searchBean.getCountyList());//request.getParameter("county");
		if(searchBean.getBidTypeList()!=null && searchBean.getBidTypeList().size()>0)
		bidtype=cdcUtil.getCommaSeparatedString(searchBean.getBidTypeList());//request.getParameter("bidtype");
	
	/********************** BID DATE FROM AND TO***********************/
	
	String bidDateFrom=null;
	/* if(request.getParameter("biddatefrom")!=null)
	{ */
		bidDateFrom=searchUtil.getDateStringMMddyyyy(searchBean.getBidDateFrom());//request.getParameter("biddatefrom");
	/* } */
	
	String bidDateTo=null;
	/* if(request.getParameter("biddateto")!=null)
	
	 { */
		bidDateTo=searchUtil.getDateStringMMddyyyy(searchBean.getBidDateTo());//request.getParameter("biddateto");
		
	 /* } */	
	String companyName=null;
	
	if(searchBean.getCompanyName()!=null)
	
	 {
		companyName=searchBean.getCompanyName();//request.getParameter("companyName");
		
	 }
	  String contactId=null;
	if(request.getParameter("contactId")!=null)
	
	 {
		contactId=request.getParameter("contactId");
		
	 }
		 String showAllRecordsFlag="no";
	if(searchBean.getShowAll())
	
	 {
		showAllRecordsFlag="all";
		
	 }
	
	String userCountylist=null;
  	if(userBean.getUserCountyList()!=null && userBean.getUserCountyList().size()>0)
 	 {
   		userCountylist=cdcUtil.getCommaSeparatedString(userBean.getUserCountyList());
    
  	}
	
	try{
		// Getting DB Connection
		con = DBController.getDBConnection();
	
	 //System.out.println("companyName"+companyName+"selectedState"+selectedState+"contactId");
	 out.println(getMainSearchResultsList(state_name,county,section_name,industry_type,sub_industry_type,bidDateTo,bidDateFrom, constructType, bidtype, divisionName,companyName,selectedState, filterColumnFlag,sessionLoginId,contactId,showAllRecordsFlag,userCountylist,con));
	
	}
	catch(Exception ex){
		System.out.println("Exception while getting inner contact search result for ccmi : "+ex);
	}
	finally{
		//Close Data Base Connection
    	DBController.releaseDBConnection(con);
	}
		
		
	 %>
