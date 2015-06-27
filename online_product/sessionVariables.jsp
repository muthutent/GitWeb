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
   Description    : Creates Session Variables to be used Through out the session
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<%@page import="java.util.* ,java.rmi.*,common.bean.*,javax.rmi.*,javax.naming.*,javax.ejb.*,content.*" %>
<%
response.setHeader("Cache-Control","no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader ("Expires", 0);
%> 
<%
Map map=null;
map = (java.util.Map) session.getAttribute("cdcnews");




   

if(map == null){
	map = new HashMap();
}
// Define Variables within a java.util.Map

map.put("todayDateStringEdition",null);
map.put("sqftUnit",null);
map.put("sqftFrom",null);
map.put("sqftTo",null);
map.put("bidfrom",null);
map.put("bidto",null);
map.put("costHighAmount",null);
map.put("costLowAmount",null);
map.put("stories_From",null);
map.put("stories_To",null);
map.put("CounName",null);
map.put("subsectionTest",null);
map.put("Construct",null);
map.put("jobs",null);
map.put("Planning",null);
map.put("Division",null);
map.put("stateTest",null);
map.put("sectionTest",null);
map.put("nkeytest",null);
map.put("Contract",null);
map.put("county",null);
map.put("Industry",null);
map.put("SubIndustry",null);
map.put("industryValue",null);
map.put("lastkey_to_highlight",null);
map.put("mquery",null);
map.put("test",null);
map.put("total",null);
map.put("nkey",null); 
map.put("dmode",null); 
map.put("pubListID",null); 
map.put("Contract",null); 
map.put("county",null); 
map.put("Industry",null); 
map.put("SubIndustry",null);
map.put("cIdList",null);
map.put("checDivi",null);
map.put("industryName",null);
map.put("subIndusName",null); 
map.put("subsectionTest",null); 
map.put("jobTy",null); 
map.put("subsec",null); 
map.put("jobid",null); 
map.put("test",null);
map.put("sortType",null);
map.put("sortVal",null);
map.put("allRecords",null);
map.put("planningStages",null);
map.put("pStages",null);
map.put("sqlQueryKeyword",null);
map.put("ckwordHighlight",null);
map.put("lastkey_to_highlight_bb",null);
map.put("kwordHighlight",null);

map.put("hotlistFlag",null);
map.put("initialsql",null);
map.put("mainquery",null);
map.put("sqlquery",null);
map.put("contentidlist",null);
map.put("statenamelist",null);
map.put("user_county_list_new",null);

map.put("subindustryValue",null);
map.put("jobType",null);
map.put("specialFlgList",null);
map.put("newDivList",null);
map.put("backButtonVal",null);
map.put("sortVal",null);
map.put("sortValType",null);
map.put("ad_kwords",null);
map.put("adKeyword",null);
map.put("ocrtext",null);
map.put("ocrsavedKeyword",null);
map.put("ocrStrCombined",null);
map.put("hotlistRunDate",null);
/*Advanced search enhancements 2013 August - Johnson*/
map.put("nominimum",null);
map.put("nomaximum",null);
map.put("includejobs",null);
map.put("jobsbidding",null);
map.put("bidday",null);
map.put("jobscancelled",null);
/*End of Advanced search enhancements 2013 August - Johnson*/
/*for multiple county new logic*/
map.put("countyids",null);	
//out.println("cIdList"+map.get("cIdList"));

		
//added by Selva
map.put("pageUtil",null);
map.put("refineSearchQuery", null);
map.put("mainSql", null);
map.put("fullList", null);
map.put("fullContentidList", null);
map.put("allKeywordQuery", null);
map.put("sqlSelectQuery", null);
map.put("refineProjectKeyword", null);
map.put("initialQuery", null);
map.put("ad_subsection", null);
map.put("keywordTempQuery", null);
map.put("ad_pubid", null);
map.put("ad_location", null);
map.put("splitOcrSearchName", null);
map.put("ad_section", null);

// Store the Map in the HttpSession
session.setAttribute("cdcnews",map);

%> 


	