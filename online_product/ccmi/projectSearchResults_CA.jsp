<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="org.springframework.web.servlet.support.RequestContextUtils"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.springframework.web.context.request.RequestContextHolder"%>
<%@page import="org.springframework.web.context.request.RequestAttributes"%>
<%@ page contentType="text/html; " language="java" import="java.sql.*,common.utils.*,net.sf.json.JSONObject, java.util.*,com.cdc.spring.bean.*,com.cdc.spring.model.*,com.cdc.spring.model.dao.*,com.cdc.spring.util.*,
com.cdc.util.CDCUtil,com.cdc.controller.DBController,common.utils.*,java.io.*,java.util.Date,java.util.regex.*,java.util.*,leadsconfig.*,java.text.*,java.util.Map ,java.lang.StringBuffer,java.net.URLEncoder,java.math.BigDecimal,javax.rmi.*,common.*,common.bean.*,javax.swing.text.DateFormatter,java.text.*,java.sql.*,java.util.Date" %>

<%!
 /**
   * This method removes any $ signs and commas (,) from the given string
   * and returns the filtered string.
   * @param String str containing amount
   * @return String amount, with $ and , filtered
   * @exception null
   */
  public String filterAmountField(String str) {
    char[] amtchars = str.toCharArray();
    char[] newchars = new char[amtchars.length];
    String filteredString = null;

    int j = 0;
    for (int i = 0; i < amtchars.length; i++) {
      if ( (amtchars[i] != '$') && (amtchars[i] != ',')) {
        newchars[j] = amtchars[i];
        j++;
      }
    }

    if (newchars.length > 0) {
      filteredString = (new String(newchars)).trim();
    }
    return filteredString;

  }

/**
   * This method formats given string to US amount
   * @param String amount
   * @return String formatted_amount
   * @exception null
   */
  public String formatAmountString(String s) {
    // First, filter any commas, any dollar signs etc.
    String amtString = filterAmountField(s);
    String formattedString = null;
    if (s != null) {
      try {
        // Convert the string to double
        double amt = Double.parseDouble(amtString);
        // Create US Number formatter
        Locale usLocale = new Locale("EN", "us");
        NumberFormat usNumberFormatter = NumberFormat.getInstance(usLocale);
        formattedString = usNumberFormatter.format(amt);

      }
      catch (Exception e) {
        // If anything goes wrong, return null string.
        return null;
      }
    }

    return formattedString;

  }


//getMainSearchResults
  public ArrayList getMainSearchResults(String stateNameList,String countyIdList,String sectionAbbList,String industryList,String subIndustryList,
  String bidDateTo,String bidDateFrom,String conTypeList,String bidType,String divisionIdList,String loginId,String userCountylist,Connection con) 
       {
	System.out.println(stateNameList+':'+countyIdList+':'+sectionAbbList+':'+industryList+':'+subIndustryList+':'+conTypeList+':'+bidType+':'+divisionIdList+':'+userCountylist+':'+bidDateFrom+':'+bidDateTo);
    ArrayList<List> searchResultsList = null;
    ArrayList<String> searchResults = null;
    DBController dbContlr = null;
    try {
    	
  
	  String query = "CA_Projects(?,?,?,?,?,?,?,?,?,?,?,?)";
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
		if(loginId!=null&&!loginId.trim().equals("")){
			paramList.add("varchar|"+loginId);
		}else {
			paramList.add("varchar| ");
		}
		if(userCountylist!=null&&!userCountylist.trim().equals("")){
			paramList.add("varchar|"+userCountylist);
		}else {
			paramList.add("varchar| ");
		}
		
		ArrayList resultList = null;
		
  		dbContlr = new DBController();

		resultList = dbContlr.executeCallable(query, paramList, true,con);

		
		Iterator resultListItr = null;
		Map resultListMap = null;

      searchResultsList = new ArrayList<List>();
      
      resultListItr = resultList.iterator();
      while (resultListItr.hasNext()) {

    	  resultListMap = (Map<?, ?>) resultListItr.next();
          searchResults = new ArrayList();
          
          
          
          //searchResults.add("<img src=\"../../images/ccmi/details_open.png\">");
          searchResults.add((String)resultListMap.get("state_name"));
          searchResults.add(resultListMap.get("total_projects_bid")+
                            "<img id=1 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"  valign=\"middle\">");
  		//System.out.println("average_project_value"+formatAmountString(resultListMap.get("average_project_value")));
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("average_project_value")).toString()));
  		
         searchResults.add(resultListMap.get("public") +
                            "<img id=3 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"  valign=\"middle\" >");
          searchResults.add(resultListMap.get("private") +
                            "<img id=4 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"  valign=\"middle\">");
          searchResults.add(resultListMap.get("general_building") + "<img id=5 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"  valign=\"middle\" >");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_general_building")).toString()));
          searchResults.add(resultListMap.get("engineering") +
                            "<img id=7 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"   valign=\"middle\">");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_engineering")).toString()));
          searchResults.add(resultListMap.get("speciality_trades") +
                            "<img id=9 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"   valign=\"middle\"> ");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_speciality_trades")).toString()));
          searchResults.add(resultListMap.get("new_construction") +
                            "<img id=11 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"  valign=\"middle\">");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_new_construction")).toString()));
          searchResults.add(resultListMap.get("additions") +
                            "<img id=13 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"   valign=\"middle\">");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_additions")).toString()));
          searchResults.add(resultListMap.get("renovation_alteration") +
                            "<img id=15 src=\"../../images/ccmi/details_open.png\" style=\"cursor:pointer\"   valign=\"middle\">");
          searchResults.add("$"+formatAmountString(((BigDecimal)resultListMap.get("avg_value_renovation_alteration")).toString()));
          

          searchResultsList.add(searchResults);

        } // while.
    }
    catch (Exception se) {
      System.out.println("!exception3.1!SQL error in getMainSearchResults " + se);
      se.printStackTrace();
    }
    finally {

    }
    return searchResultsList;
  } // getMainSearchResults.
  
   public String getMainSearchResultsList(String state_name,String county,String section_name,String industry_type,String sub_industry_type,String bidDateTo,
   String bidDateFrom,String constructType,String bidtype,String divisionName,String loginId,String userCountylist,Connection con) {
    JSONObject jsonObject = null;
	ArrayList mainList = null;
    try {
      jsonObject = new JSONObject();
	  mainList = new ArrayList();
	  mainList = getMainSearchResults(state_name,county,section_name,industry_type,sub_industry_type,bidDateTo,bidDateFrom,constructType,bidtype,divisionName,loginId, userCountylist,con );
	  
      jsonObject.put("sEcho", "1");
      jsonObject.put("iTotalRecords",
                    String.valueOf(mainList.size()));
      jsonObject.put("iTotalDisplayRecords",
                     String.valueOf(mainList.size()));


      jsonObject.put("aaData",  mainList);
      System.out.println("jsonObject:"+jsonObject.toString());
    }
    catch (Exception e) {
      e.printStackTrace();

    }
    return jsonObject.toString();

  }
  
  
  
  
  
  %>

<%

	Connection con = null;
	
	try {
	String state_name=null;
	String section_name=null;
	String divisionName=null;
	
	String industry_type=null;
	String sub_industry_type=null;
	String constructType=null;
	String county=null;
	String bidtype=null;
	String sessionLoginId = null;
	
	SearchBean searchBean = null;
	CDCUtil cdcUtil = null;
	SearchUtil searchUtil = null;
	UserBean userBean = null;
	ApplicationContext ac = null;
	
	ac = ApplicationConfig.getApplicationContext(request);
	userBean = (UserBean) ac.getBean("userBean");
	searchBean = (SearchBean) ac.getBean("searchBean");
	searchUtil = new SearchUtil();
	cdcUtil = new CDCUtil();
	
	sessionLoginId = userBean.getLoginId();
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
	
	/* if(request.getParameter("industry")!=null)
	{
		industry_type=request.getParameter("industry");
	}
	else
	{
		industry_type=null;
	} */
	//System.out.println("industry_type"+industry_type);
	if(sub_industry_type!=null && !sub_industry_type.equals(""))
	{
		//sub_industry_type=request.getParameter("sub_industry");
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
	/* Map map=null;
    map = (java.util.Map) session.getAttribute("cdcnews"); */
	String userCountylist=null;
  	/* if(map != null && (String)map.get("user_county_list")!=null)
 	 {
   		userCountylist=(String)map.get("user_county_list");
    
  	} */
  	if(userBean.getUserCountyList()!=null && userBean.getUserCountyList().size()>0)
  	userCountylist = cdcUtil.getCommaSeparatedString(userBean.getUserCountyList());

	
	// Getting DB Connection
	con = DBController.getDBConnection();
		
	 out.println(getMainSearchResultsList(state_name,county, section_name,industry_type,sub_industry_type,bidDateTo,bidDateFrom, constructType, bidtype, divisionName,sessionLoginId,userCountylist,con));
 }catch(Exception ex) {
		System.out.println("Exception at projectSearchREsults_CA.jsp ");
		ex.printStackTrace();
}
finally{
		//Close Data Base Connection
    	DBController.releaseDBConnection(con);
	}
	
%>
