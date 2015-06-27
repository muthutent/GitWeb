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
   Description    : Contains All the Variables used in the searchResults.jsp page
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
		/** Global Declaration */ 
		Connection con = null;
		UserBean userBean = null;
		SearchBean searchBean = null;
		SavedSearchBean savedSearchBean = null;
		SearchUtil searchUtil = null;
		SearchDao searchDao = null;
		SearchModel searchModel = null;
		Map map = null;

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
		String sortPage="bid_date";
		String sortType="asc";
		String nkeysession = null;
		String pageNum = null;
		Map ptMap = null;
		String bDate = null;
		String trackTitle= null;
		String CDCID= null;
		String bidsInfo= null;
		String searchModule = null; 
		
		boolean qLinksFlag = false;
		int perPage=0;	
		List myList = null;
		

		ApplicationContext ac = null;
		

		ac = ApplicationConfig.getApplicationContext(request);
	%>
	<%
	
		/***************** GLOBAL VARIABLE ASSIGNMENTS *******/
	
		
		if(con==null)	con = DBController.getDBConnection();
		userBean = (UserBean) ac.getBean("userBean");
		searchBean = (SearchBean) ac.getBean("searchBean");
		savedSearchBean = (SavedSearchBean) ac.getBean("savedSearchBean"); 
		map = (Map) session.getAttribute("cdcnews");
			
		/* ApplicationContext ac = null;
			ac = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
			try {
				ac = RequestContextUtils.getWebApplicationContext(request);
			} catch (IllegalStateException ise) {
				ac = WebApplicationContextUtils.getRequiredWebApplicationContext(request.getServletContext());
			} */
			
		searchUtil = new SearchUtil();
		searchModel = new SearchModel();
		searchDao = new SearchDao();
		
		 
		map = searchModel.init(request, map, userBean, searchBean,con);
		
		/* Iterator<Map.Entry> entries = map.entrySet().iterator();
		String keyset = "";
		while (entries.hasNext()) {
			Map.Entry<Integer, Integer> entry = entries.next();
			System.out.println("Key = " + entry.getKey() + ", Value = "	+ entry.getValue());
			keyset+=entry.getKey()+",";
		}
		System.out.println(keyset); */
		
		cKeyword = request.getParameter("ckeyword");
		backval = request.getParameter("backval");
		/************ MAP VALUES ASSIGNMENT ***************/
		userviewjobwindow = userBean.getUserViewJobWindow();//(String) map.get("userviewjobwindow");
		ad_flag = userBean.getAdFlag();//(Integer) map.get("ad_flag");
		polCountyFlag = userBean.getPolCounties(); //(String) map.get("polCounties");
		/* Iphone Browser session flag - 090711- to Hide POL icons */
		iPhoneSession = userBean.getIsIPhone();//(String) map.get("iPhone");
		/* New Script added for session timed out by Johnson -251010 */
		sessionLoginId = userBean.getLoginId(); //(String) map.get("login_id");
		// Added by Johnson for ITB validation-May9th2011
		//itbSession = (String) map.get("fea_ITB");
		if (userBean.getUserFeatures()!=null && userBean.getUserFeatures().contains("ITB")) {
			itbSession = "Y";
		}
		sessionAllRecords = (String) map.get("allRecords");
		refineProjectKeyword = request.getParameter("textsubkey");
		refineContactKeyword = request.getParameter("ctextsubkey");
		
		ocrtextsession = (String) map.get("ocrtext");
		ocrtextValue = (String) map.get("ocrtextvalue");
		sessionmode = (String) map.get("dmode");
		dmodeSession = (String) map.get("dmode");
		//sortPage = String.valueOf(map.get("sortVal"));
//		sortType = String.valueOf(map.get("sortType"));
		if (ocrtextsession == null)
			ocrtextsession = "";

		lastkey_to_highlight =
		String.valueOf(map.get("lastkey_to_highlight"));
		
		qLinksFlag =
		Boolean.valueOf(String.valueOf(map.get("qLinksFlag")));
		if (sessionLoginId == null || sessionLoginId.trim().equals("")) {
			String redirectURL = "http://cdcnews.com/";
			response.sendRedirect(redirectURL);
		}

		searchModule = searchBean.getSearchModule();
	%>

	<%
		PaginationUtil pageUtil = null;
		HotlistManager hManager = null;
		ArrayList projectIdList = null;
		CDCUtil cdcUtil = null;
		String sql = null;
		String mainSql = null;
		int start, end, tot = 0;

		pageUtil = (PaginationUtil) map.get("pageUtil");	
	
		if (backval != null && !backval.trim().equals("")) {
			String backButtonSearchQuery = null;
			sessionmode = dmodeSession;
			/* map = searchModel.getBackButtonSearchQuery(map);
			if (map.get("backButtonSearchQuery") != null)
				backButtonSearchQuery = map.get("backButtonSearchQuery").toString();

			System.out.println("backButtonSearchQuery : "+backButtonSearchQuery);
			tot = pageUtil.getResults(backButtonSearchQuery,sessionLoginId);
			map.put("pageUtil", pageUtil);
			session.setAttribute("total", new Integer(tot));
			map.put("total", new Integer(tot)); */
			
			sql = String.valueOf(map.get("InitialSql"));
			cdcUtil = new CDCUtil();
			String pids = cdcUtil.parseIntegerForSql(map.get("fullContentIdList"));	
			sql += " and c.id in ("+pids+")";
			sql+=" order by "+sortPage+" "+sortType+", entry_date desc";
			tot = pageUtil.getResults(sql,sessionLoginId);
			map.put("pageUtil", pageUtil);
			session.setAttribute("total", new Integer(tot));
			map.put("total", new Integer(tot));
			
			if (map.get("refineProjectKeyword") != null)
				map.put("refineProjectKeyword",null);
			if (map.get("refineContactKeyword") != null)
				map.put("refineContactKeyword",null);
			
			map.put("lastkey_to_highlight", map.get("highlighter"));
			
		}
		
		if (pageUtil == null) {
			hManager = new HotlistManager();
			projectIdList = new ArrayList();
			cdcUtil = new CDCUtil();
			
			map = searchModel.getInitialSql(request, map);
			sql = String.valueOf(map.get("InitialSql"));
			
			if(userBean.getLoginId().equals("jbosssat")){
				out.println("Query: "+searchBean.getSearchQuery());
			}
			
			String pids = cdcUtil.parseIntegerForSql( searchBean.getProjectIdList());	
			sql += " and c.id in ("+pids+")";
			pageUtil = new PaginationUtil();
			
			
			sql+=" order by "+sortPage+" "+sortType+", entry_date desc";
			//System.out.println("allKeywordQuery:"+allKeywordQuery);
			System.out.println("New Query: "+sql+" : "+sessionLoginId);
			//System.out.println("Old Query : "+sql1);
			
			
			tot=pageUtil.getResults(sql,sessionLoginId);
			map.put("pageUtil", pageUtil);
			session.setAttribute("total", new Integer(tot));
			map.put("total", new Integer(tot));
			
			/*THE FULL IDLIST FOR SPECIAL DROP DOWN SORING PASSING IN THE QUERY*/		
			map.put("fullContentids",pids);
			map.put("fullContentIdList",searchBean.getProjectIdList());

		} // End of Main IF. (pageUtil==null)	
		else if ((refineProjectKeyword != null
		&& !refineProjectKeyword.equals(""))
		|| (refineContactKeyword != null
		&& !refineContactKeyword.equals(""))) {
			map.put("refineProjectKeyword", refineProjectKeyword);
			map.put("refineContactKeyword", refineContactKeyword);

			ArrayList refineProjectIdList = null;
			String keyword = null;
			String keywordType = null;
			
			try{
			
				hManager = new HotlistManager();		
				cdcUtil = new CDCUtil();
				
				keyword =  refineProjectKeyword; 
				keywordType = "P";
				if(refineContactKeyword!=null && !refineContactKeyword.equals("")){
					keyword = refineContactKeyword;
					keywordType = "C";
				}

				refineProjectIdList  = hManager.getRefinedProjects((ArrayList)map.get("fullContentIdList"), keyword, keywordType,con);
				
				String pids = cdcUtil.parseIntegerForSql(refineProjectIdList);
				sql = String.valueOf(map.get("InitialSql"));
				
				sql += " and c.id in ("+pids+")";		
				
				
				sql+=" order by "+sortPage+" "+sortType+", entry_date desc";
				//System.out.println("allKeywordQuery:"+allKeywordQuery);
				System.out.println("ref Query: "+sql+" : "+sessionLoginId);
				
				
				tot=pageUtil.getResults(sql,sessionLoginId);
				map.put("pageUtil", pageUtil);
					
				session.setAttribute("total", new Integer(tot));
				map.put("total", new Integer(tot));
				map.put("lastkey_to_highlight",keyword);
				
				sessionmode = "d";
				
			}
			catch(Exception ex){
				System.out.println("Exception while refining the search result : "+ex);
			}
			
			
			
			
		}
		/*OCR KEYWORD SEARCH*/
		else if (request.getParameter("ocrtext") != null && !request.getParameter("ocrtext").trim().equals("")) {
			String ocrKeyword = request.getParameter("ocrtext");
			map.put("ocrKeyword", ocrKeyword);
			sessionmode = "b";
			String ocrSearchQuery = null;
			map = searchModel.getOCRInitialSql(map);
			map = searchModel.getOcrSearchQuery(map);
			if (map.get("ocrSearchQuery") != null)
				ocrSearchQuery = map.get("ocrSearchQuery").toString();
			tot = pageUtil.getResults(ocrSearchQuery, sessionLoginId);
			map.put("pageUtil", pageUtil);
			session.setAttribute("total", new Integer(tot));
			map.put("total", new Integer(tot));
		}
		// The DropDown sorting (view,track,screen,plans) goes through this. Added by Muthu on 03/12/13.
		else if (request.getParameter("sort") != null
		&& request.getParameter("sortType") != null
		&& (((String) request.getParameter("sort"))
				.equals("viewed")
				|| ((String) request.getParameter("sort"))
						.equals("tracked")
				|| ((String) request.getParameter("sort"))
						.equals("screened") || ((String) request
					.getParameter("sort"))
				.equals("plan_availability_status"))) {

				sortPage=request.getParameter("sort");
				sortType=request.getParameter("sortType");				
				
				map.put("sortVal",sortPage);
				map.put("sortType",sortType);			
				
				pageUtil = new PaginationUtil();

				String sortSplQuery = null;
			
				map = searchModel.getInitialSql(request, map);
				sql = String.valueOf(map.get("InitialSql"));
				System.out.println("spl sort InitialSql:"+sql);			
				sql += " and c.id in ("+(String)map.get("fullContentids")+")";			
				
				//Sets the sorting order.
				sql += " order by "+sortPage+"   "+sortType+", entry_date desc";		
				
			tot = pageUtil.getResults(sql, sessionLoginId);
			map.put("pageUtil", pageUtil);
			session.setAttribute("total", new Integer(tot));
			map.put("total", new Integer(tot));
		}
		 // When the per page value chagnes, puts the chunk in session. Added by Muthu on 10/21/13.
		  else if(request.getParameter("per_page")!=null && !request.getParameter("per_page").trim().equals("")){	
			  	perPage = Integer.parseInt(request.getParameter("per_page"));
				map.put("perPage",perPage);					
		  }
		// The Other Dropdown sorting (Newjobs,public,biddate,title,value,bidstage,city,county,state)  goes through this.
		else {
			if (request.getParameter("sort") != null) {			

				sortPage=request.getParameter("sort");
				sortType=request.getParameter("sortType");				
				map.put("sortVal",sortPage);
				map.put("sortType",sortType);				
				//Change the order of sorting. Added on 04/25/13. Updated o on 10/01/30.
				if(sortPage.equals("leads_entry_date")){
				if(sortType.equals("asc"))
				sortType="desc";
				else
				sortType="asc";							
				}
				
				sql = String.valueOf(map.get("InitialSql"));
				
				System.out.println("InitialSql:"+sql);
				sql += " and c.id in ("+(String)map.get("fullContentids")+")";			
				
				//Sets the sorting order.
				sql += " order by "+sortPage+"   "+sortType+", entry_date desc";				
				//System.out.println("SortQuery:"+sql);					

				//map.put("sqlQuery",sql);
				pageUtil = new PaginationUtil();
				
				tot=pageUtil.getResults(sql,sessionLoginId);
				map.put("pageUtil",pageUtil);
				session.setAttribute("total",new Integer(tot));
			   
			}

		} // End of Main IF. 

		if(map.get("refineProjectKeyword")!=null || map.get("refineContactKeyword")!=null)
		nkeysession = "S";
		
		highlighter = (String) map.get("lastkey_to_highlight");
		if(searchBean.getProjectKeyword()!=null && !searchBean.getProjectKeyword().trim().equals("")) {
			highlighter = searchBean.getProjectKeyword().trim();
		} else if(searchBean.getContactKeyword()!=null && !searchBean.getContactKeyword().trim().equals("")) {
			highlighter = searchBean.getContactKeyword().trim();
		}
		
		if(dmodeSession==null || dmodeSession.trim().equals("")){
			dmodeSession = searchBean.getDisplayMode();
		}
		if(sessionmode==null || sessionmode.trim().equals("")){
			sessionmode = searchBean.getDisplayMode();
		}
		int chunk = searchModel.getChunk(searchModule,sessionmode,ocrtextsession);
		
		if(map.get("perPage")!=null && !String.valueOf(map.get("perPage")).trim().equals("")){
		   chunk=(Integer)map.get("perPage");
		}
		
		int jobscount = 0;

		String frmPage = request.getParameter("next");

		// when using seo friendly url
		if(frmPage==null) {
			if(request.getAttribute("next")!=null)
				frmPage = String.valueOf(request.getAttribute("next"));
			else
				frmPage="";
		}
		
		start = searchUtil.getPageStart(frmPage, chunk);
		if (frmPage != null && !frmPage.trim().equals(""))
			pageNum = frmPage.replace(" ", "");
		if (pageNum == null)
			pageNum = "1";

		Integer totrec = (Integer) session.getAttribute("total");
		end = searchUtil.getPageEnd(pageNum, chunk, totrec);

		boolean nextflag = true;
		if (totrec != null
				&& end >= Integer.parseInt(String.valueOf(totrec)))
			nextflag = false;
		int pages = 0;
		int rpages = 0;

		pages = (Integer.parseInt(String.valueOf(totrec)) / chunk);
		rpages = (Integer.parseInt(String.valueOf(totrec)) % chunk);
		if (rpages > 0)
			pages = pages + 1;
			
		map.put("pages",pages);
		map.put("start",start);
		map.put("end",end);
		map.put("dmodeSession",dmodeSession);
		map.put("sessionmode",sessionmode);
		map.put("sessionAllRecords",sessionAllRecords);
		map.put("nkeysession",nkeysession);
		map.put("ocrtextsession",ocrtextsession);
		map.put("pageUtil",pageUtil);
		map.put("highlighter",highlighter);
		map.put("pageNum",pageNum);
		
		session.setAttribute("cdcnews", map);
		
		%>
		
</body>
</html>