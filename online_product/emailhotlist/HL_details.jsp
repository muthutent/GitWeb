<%@page import="common.EJBClient"%>
<%@page import="briefproject.BriefProject"%>
<%@page import="com.cdc.spring.config.ApplicationConfig"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.cdc.util.CDCUtil"%>
<%@page import="com.cdc.spring.bean.UserBean"%>
<%@page import="com.cdc.spring.model.SearchModel"%>
<%@page import="com.cdc.spring.model.dao.SearchDao"%>
<%@page import="com.cdc.spring.util.SearchUtil"%>
<%@ page import="common.utils.*,java.util.regex.*,java.util.*,datavalidation.*,common.SaveBean,leadsconfig.*,java.util.Map,java.lang.StringBuffer,java.math.BigDecimal,java.net.URLEncoder,java.util.Date,javax.swing.text.DateFormatter,java.text.*,java.rmi.*,common.bean.*,javax.rmi.*,javax.naming.*,javax.ejb.*,content.*,java.sql.*,polcontent.*"%>
<%@ taglib prefix="cdc" uri="http://lm.cdcnews.com/mytags"%>
<html>
<head>
<title>CDCNews details job display</title>
<link href="<%=request.getContextPath()%>/css/sheet-jsp.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/colorbox.css">
</head>
<BODY LEFTMARGIN="2" TOPMARGIN="2" RIGHTMARGIN="0" BOTTOMMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0"  >
<form name="mainform" >

<%!

	/**
	 * Wraps content with HTML Anchor tag.
	 * @param href
	 * @param content
	 * @param type
	 * @return output
	**/
	public String wrapWithAnchor(String href,String content,String type){

		String output=null; output="";
		try{
			if(href==null || content==null)
				return output;

			if(type==null || type.trim().equals("") || type.trim().equalsIgnoreCase("http"))
				output = "<a href='"+href+"'>"+content+"</a>";
			else if(type.trim().equalsIgnoreCase("tel"))
				output = "<a href='tel:"+href+"'>"+content+"</a>";
			else if(type.trim().equalsIgnoreCase("mailto"))
				output = "<a href='mailto:"+href+"'>"+content+"</a>";
			else
				output = "<a href='"+href+"'>"+content+"</a>";
		}
		catch(Exception ex){
			System.out.println("Exception while wrapping with Tel: "+ex);
		}

		return output;
	}
	
   /*  public String getDecryptedDate(String encText)
	    {
	        String toDay = "";
	        char toDatec;
	        byte[] bytes = new byte[1];
	        String toDates = "";

	        for(int loop = 1; loop < 5; loop++)
	        {
	            toDatec = encText.charAt(loop);
	            toDates = "" + toDatec;
	            loop++;
	            toDatec = encText.charAt(loop);
	            toDates = toDates + toDatec;
	            bytes[0] = (byte) Integer.parseInt(toDates);
	            toDay = toDay + (new String(bytes));
	        }

	        toDay = toDay + "/";
	        toDates = "";

	        for(int loop = encText.indexOf("F")+2; loop < encText.indexOf("F")+6; loop++)
	        {
	            toDatec = encText.charAt(loop);
	            toDates = "" + toDatec;
	            loop++;
	            toDatec = encText.charAt(loop);
	            toDates = toDates + toDatec;
	            bytes[0] = (byte) Integer.parseInt(toDates);
	            toDay = toDay + (new String(bytes));
	        }
	        toDay = toDay + "/";
	        toDates = "";

	        for(int loop = encText.indexOf("x")+1; loop < encText.indexOf("x")+5; loop++)
	        {
	            toDatec = encText.charAt(loop);
	            toDates = "" + toDatec;
	            loop++;
	            toDatec = encText.charAt(loop);
	            toDates = toDates + toDatec;
	            bytes[0] = (byte) Integer.parseInt(toDates);
	            toDay = toDay + (new String(bytes));
	        }
			
			//System.out.println("DATE :"+toDay);
	        return toDay;
    } */

   /*   public String decryptString(String encProjectIDs)
	 {
	 		String[] projIds =encProjectIDs.split(",");
	 		int size = projIds.length;
	 		String encProjectID = null;
	 		String finalString = "";
	 		for(int i=0;i<size;i++)
	 		{
	 			encProjectID = (String) projIds[i];
	 	  		  long lPID=0;
	 	  		  DateFormat dateFormat = new SimpleDateFormat("yy/MM/dd");
	 	          Date today=new Date("12/07/04");
	 	          String theDate = dateFormat.format(today);
	 	          //#################DECRYPTION STARTS HERE
	 	          String decToday = getDecryptedDate(encProjectID);
	 	          //if(theDate.compareTo(decToday) == 0)
	 	          //{
	 	              String projID = encProjectID.substring(encProjectID.indexOf("c") + 1,encProjectID.indexOf("F"));
	 	              lPID = Long.parseLong(projID);
	 	              lPID = ((lPID / 119) / 99)/(Integer.parseInt(decToday.substring(decToday.lastIndexOf("/")+1))) ;
	 				 // System.out.println("asdasda"+Long.toString(lPID));
	 	              if(i+1 < size)
	 	  	        	finalString += lPID+",";
	 	  	        else
	 	  	        	finalString += lPID;
	 			  //}
	 		}
	    // return Long.toString(lPID);
	 		 return finalString;
	} */
	
	/**
      *  Removes special characters from phone numbers and zip codes
      */
     /* public String searchUtil.removeSpecialChars(String str)
     {
         if (str == null)
             return str;

         char [] chars = str.toCharArray();
         String cleanString = "";
         for (int i=0; i<chars.length; i++)
         {
             if (chars[i] == ' ' || chars[i] == '(' || chars[i] == ')' || chars[i] == '.' || chars[i] == '-')
                 continue;
             cleanString = cleanString + chars[i];
         }

         return cleanString;
     } */
	 
	  public Connection getEmailCon() 
	  {
		String url="";
		String userName="";
		String password="";
		String driverName="";
		Connection returnstmt = null;
		try
		{
			  userName   = "sa";
			  password   = "H0tl1st!";
			  url        = "jdbc:jtds:sqlserver://192.168.22.53:1433/CDC";
			  driverName = "net.sourceforge.jtds.jdbc.Driver";
			  //System.out.println("driverName: "+driverName);
			  Class.forName(driverName);
			  returnstmt = DriverManager.getConnection(url,userName,password);
		}
		catch(ClassNotFoundException cnfe)
		{
		   System.out.println("Class not found");
		   return returnstmt;
		}
		catch(SQLException sqle)
		{
		  System.out.println("SQL Exception");
		  sqle.printStackTrace();
		  return returnstmt;
		}
   		return returnstmt;
        }
		
		
		//check exclude project if exists and display checked in check box - new feature added by Johnson on May16th2011
  /* public static boolean checkExcludeProjectExists(String loginId, String cdc_id

                                        ) 
       {
    CallableStatement cstmt = null;
    ResultSet rs = null;
    Connection con = null;
    boolean exists = false;
    String sql = null;
	//System.out.println(loginId+cdc_id);


    try {

      if (con == null) {
        con = JDBCUtil.getConnection();
      }
      cstmt = con.prepareCall(
          "{call SSP_CHECK_EXCLUDE_PROJECT_EXISTS(?,?)}");

     //loginId
      cstmt.setString(1, loginId);
      //cdc_id
      cstmt.setString(2, cdc_id);
      
	  rs=cstmt.executeQuery();
	  while(rs.next())
	  {
	  	exists=true;
	  }
	  
      
    }
    catch (Exception e) {
      exists = false;
      System.out.println("ERROR IN checkExcludeProjectExists"+e.toString());
      e.printStackTrace();

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
      catch (SQLException sqle) {
        System.out.println("SQLERROR IN checkExcludeProjectExists"+sqle.toString());
        sqle.printStackTrace();
        exists = false;

      }
      return exists;
    }

  }  */// End of checkExcludeProjectExists()
   
   
   
   /* public String searchUtil.keywordHighlight(String originalTxt,String Keyword)
	    {
	      String[] kword=null;
		  try
		  {
		  	kword = new String[]{};
		  // System.out.println("keyword2"+Keyword);
			  if(Keyword!=null)
	      kword=Keyword.split("[\\,]+");
		  StringBuffer sb = null;
		  Pattern p=null;
		 
		   Matcher m =null;
	      for(int i=0;i<kword.length;i++)
	      {
		    kword[i]=kword[i].trim().replaceAll("\\*","");
		    p = Pattern.compile("\\b"+kword[i].trim()+"\\b",Pattern.CASE_INSENSITIVE);
		 //  p = Pattern.compile("<b>"+kword[i].trim()+"<b>",Pattern.CASE_INSENSITIVE);
            m = p.matcher(originalTxt);
			
			sb=new StringBuffer();
		    
		   while (m.find()) {
          if (kword[i].equalsIgnoreCase("and") || kword[i].equalsIgnoreCase("or") ||
            kword[i].equalsIgnoreCase("not") || kword[i].equalsIgnoreCase(""))
		    {
			 // System.out.println("keyword1"+kword[i]+originalTxt);
			// System.out.println("else");
			}
			else
			{		
				m.appendReplacement(sb, "<b style=color:black;background-color:FFFF66>"+kword[i].trim()+"</b>");
				//System.out.println("keyword2"+kword[i]+originalTxt);
				//System.out.println("key");
			    
            }
		   
			   } //End of While
		    
		  m.appendTail(sb);
		  originalTxt=sb.toString();
			  } // End of For Loop
	     }
		 catch(Exception ex){
		 	System.out.println("Exception in searchUtil.keywordHighlight : "+ex.getMessage());
		 }
	    return originalTxt;
	    
	    }   */ 
%>	
<%

SearchUtil searchUtil = null;
SearchDao searchDao = null;
SearchModel searchModel = null;
UserBean userBean = null;
CDCUtil cdcUtil = null;
ApplicationContext ac = null;
EncryptDecrypt enc = null;
BriefProject briefProject=null;

searchUtil = new SearchUtil();	 
 searchModel = new SearchModel();
 searchDao = new SearchDao();
 ac = ApplicationConfig.getApplicationContext(request);
 userBean = (UserBean) ac.getBean("userBean");
 cdcUtil = new CDCUtil();
 enc = new EncryptDecrypt();
 briefProject = EJBClient.getBriefProjectEJBean();
 
String pid = null; pid="";
if(request.getParameter("pid")!=null && !request.getParameter("pid").trim().equals(""))
	pid=request.getParameter("pid");
	
//if(map==null || String.valueOf(map.get("login_id")).trim().equals(""))
	if(userBean.getLoginId()==null || userBean.getLoginId().trim().equals(""))
	response.sendRedirect("/online-product/login-hotlist?pid="+pid);
	
	
	
 //Added by Johnson for ITB validation-May9th2011
 String itbSession=null;
 if (userBean.getUserFeatures().contains("ITB")) {
		itbSession = "Y";
}

String userviewjobwindow = "";
String userView=null; userView="blank";

	
 /*Iphone Browser session flag - 090711- to Hide POL icons*/
	String iPhone=userBean.getIsIPhone();//(String)map.get("iPhone");
 
	 String id=request.getParameter("pid");
	 String loginId = userBean.getLoginId();//(String)map.get("login_id");
	 
     //#################DECRYPTION STARTS HERE      
	
	/* Connection con =null;
	 PreparedStatement stmt = null;
	 ResultSet rs = null; */
	 String encProjectIDs = null;
	 String fName = null;
	String lName = null;
	String companyName = null;
	String ssName = null;
	String runDate = null;
	try
	{
		 /*con =   getEmailCon();
		 stmt = con.prepareStatement("select savedsearch_projectIds from productpush_projectids where productpush_projectids_id = ?");
		 stmt.setInt(1,Integer.parseInt(id));
		 rs = stmt.executeQuery();
		 while(rs.next())
		 {
			encProjectIDs = rs.getString(1);
		 }
		 
		 stmt = null;
		 rs = null;
		 String getDataQuery = "SELECT s.first_name,s.last_name,s.company_name,e.login_id,e.saved_search_name,p.date_entered FROM subscriber s,emailhotlist e,product_push p WHERE  e.hotlist_id = (select saved_search_id from product_push where productpush_projectids_id = (select productpush_projectids_id from productpush_projectids where productpush_projectids_id = ?))	and e.login_id = s.login_id and p.productpush_projectids_id = ?";
		 stmt = con.prepareStatement(getDataQuery);
		stmt.setInt(1,Integer.parseInt(id));
		stmt.setInt(2,Integer.parseInt(id));
		rs = stmt.executeQuery();
		
		while(rs.next())
		{
			fName = rs.getString(1);
			lName = rs.getString(2);
			companyName = rs.getString(3);
			ssName = rs.getString(5);
			runDate = rs.getString(6);
		}
		*/
		encProjectIDs = id;
	 }
	 catch(Exception ex)
	 {
	 	out.println(ex.getMessage());
	 }
	 
	 %>
<!-- Logo -->
<table>
		<tr>
		<td align="left">
			<img src="http://lm.cdcnews.com/images/construction_data/CDC_Logo_240x77.png" border="0" />
		</td>	
	
		</tr>
</table>	
<!-- End LOGO -->
<!-- Root table -->	
<table border="0" cellspacing="0" cellpadding="0" width="750" align="center" style="margin: -35px 0px 0px 8px;"> 

<%
	if(encProjectIDs == null || encProjectIDs.equals(""))
	 {
	 out.println("NO RECORDS FOUND");
	 return;
	 }
	 
     String decProjectIDs = enc.decryptString(encProjectIDs);
	 //String decProjectIDs = encProjectIDs;
	 //out.println(decProjectIDs);
	 /*String[] idsplit = decToday.split(",");
	 int i = 0;
	 while(i < idsplit.length)
	 {
	 out.println(idsplit[i]+"\n");
	 i++;
	 }*/	 
	 
     /*map = (java.util.Map) session.getAttribute("cdcnews");
	 appMap=(java.util.Map) application.getAttribute("cdcnews");
	 Content contentID=null;
	
	 Properties cProp = new Properties();
	 cProp.put(Context.INITIAL_CONTEXT_FACTORY,"jrun.naming.JRunContextFactory");
	 cProp.put(Context.PROVIDER_URL,"localhost:2902");
	 Context contentCtx = new InitialContext(cProp);
	 Object contentObj = contentCtx.lookup("ContentEJBean");
	 ContentHome contentHome = (ContentHome)PortableRemoteObject.narrow(contentObj,ContentHome.class);
	 contentID = contentHome.create();
	 ArrayList contentList=contentID.getContentList(decProjectIDs,"bid_date asc");
	 
	 Iterator contentIterator = contentList.iterator();*/
	
	//Modified on 23 jan 2014 to use leads id instead of content id
	 
	 ArrayList contentList=searchModel.getContentList(decProjectIDs);
	 
	 Iterator contentIterator = contentList.iterator();	 
	 while(contentIterator.hasNext())
	 {
	  common.bean.ContentBean cbean=(common.bean.ContentBean)contentIterator.next();
	
	Iterator itr = null;
	Iterator itrOwner = null;
	Iterator itrBidder = null;
	Iterator itrAwards = null;
	Iterator itrLowBidder = null;
	Iterator itrSubAwards = null;
	Iterator itrIndustry = null;
	Iterator itrSubIndustry = null;
	Iterator itrPlanRoomInfo = null;
	ArrayList scope_title_list = (ArrayList)cbean.getProjectScopeOfWorkTitle();
	ArrayList division_name_list = (ArrayList)cbean.getDivision_name_list();
	ArrayList ownersList = cbean.getOwners();
	ArrayList planHoldersList = cbean.getPlanHolders();
	ArrayList awardsList = cbean.getAwards();
	ArrayList lowBiddersList = cbean.getLowBidders();
	ArrayList subAwardsList = cbean.getSubAwards();
	ArrayList industryList=cbean.getIndustryList();
	ArrayList planRoomInfoList=cbean.getplanRoomInfoList();
	
	String cKeyword = "";
	String keyword = "";
		
	/*if(map.get("lastkey_to_highlight")!=null)
	{
	 keyword=(String)map.get("lastkey_to_highlight");
	}*/
		
%>
<%!

 
	 
	 
	  


///###################
/******************************THIS IS A METHOD FOR KEYWORD HIGHLIGHTER******************************/


	/*public String String originalTxt,String Keyword)
	    {
	      String[] kword=null;
	      kword=Keyword.split("\\,");
		  StringBuffer sb = null;
		  Pattern p=null;
		   Matcher m =null;
	      for(int i=0;i<kword.length;i++)
	      {
	       
		    
		    kword[i]=kword[i].trim().replaceAll("\\*","");
		    p = Pattern.compile(kword[i].trim()+"\\b",Pattern.CASE_INSENSITIVE);
            m = p.matcher(originalTxt);
			sb=new StringBuffer();
		    
		   while (m.find()) {
     		m.appendReplacement(sb, "<b style=color:black;background-color:FFFF66>"+kword[i].trim()+"</b>");
           }
		    
		  m.appendTail(sb);
		  originalTxt=sb.toString();
		  }
	     
	    return originalTxt;
	    
	    }
		
		*/
         

%>
<TR>
	 <!-- Track -->
	<td class="black11px"  height="25" align="right" > 
	<table border="0" cellspacing="0" cellpadding="0" width="472" align="right" > 
	<tr>
	<td width="390">&nbsp;</td>
	<td>
                  <%
								   int sJobId=0;
	 								String sJobName=null;
								   String trackTitle=null; 
								   trackTitle=cbean.getTitle().replaceAll("'","");
								   trackTitle=cbean.getTitle().replaceAll("\"","");
								   String biddate=cbean.getbidDate();			  
								   
								    String biDate="1900/01/01";
								   if(cbean.getbidDate()!=null)
								   {
								     biDate=cbean.getbidDate();
								   }
								   String bidsInfo=cbean.getBidsDetails();
								   //Implemented on Oct 13th 2011 by Johnson 
								   if(bidsInfo!=null)
								   {
									bidsInfo=bidsInfo.replaceAll("\"","");
									bidsInfo=bidsInfo.replaceAll("'","");
								   }
								  
								  		//Added by Muthu on 02/26/13 to get the Project Tracker status for Individual projects.
										SaveBean sBean = null;
										sBean = new SaveBean();
										sBean = briefProject.getSaveJobID(cbean.getCDCID(), loginId, null);
										  
										sJobId = sBean.getJobId();
										sJobName = sBean.getJobName();
								  
								       if(sJobId==0)
										{
										
										
										
										%>
                  <a id="pt_<%=cbean.getId()%>" href="javascript:call_savejob('<%=cbean.getCDCID()%>','<%=cbean.getpublicationID()%>','<%=cbean.getsectionID()%>','<%=trackTitle%>','<%=biDate%>','<%=bidsInfo%>','<%=cbean.getPrebidDate()%>','N','<%=cbean.getId()%>');"><img src="/jsp/images/button_pt_icn.gif" alt="Add to Project Tracker" width="23" height="20" border="0"></A> 
				  <A style=" display:none; visibility:hidden" id="cal_<%=cbean.getId()%>" href="javascript:call_calendar(<%=sJobId%>,'<%=cbean.getId()%>','<%=sJobName%>','<%=biDate%>','',' ','')"><img src="/jsp/images/calendar.gif" border="0" alt="Calendar"></A> 
				  
                  <%
										
										}
										else{
										
										%>
                  <a href="javascript:call_savejob('<%=cbean.getCDCID()%>','<%=cbean.getpublicationID()%>','<%=cbean.getsectionID()%>','<%=trackTitle%>','<%=biDate%>','<%=bidsInfo%>','<%=cbean.getPrebidDate()%>','N','<%=cbean.getId()%>');"><img src="/jsp/images/pt.gif" alt="Add to Project Tracker" width="25" height="12" border="0"></A> 
                  <A href="javascript:call_calendar(<%=sJobId%>,'<%=cbean.getId()%>','<%=sJobName%>','<%=biDate%>','',' ','')"><img src="/jsp/images/calendar.gif" border="0" alt="Calendar"></A> 
                  <%
										
										}
										String pTitle = cbean.getTitle().replaceAll("\"","\\\"");
										pTitle = pTitle.replaceAll("'","\\\\'");										
								  %>
                </td>
				
				
				<!-- End of Track -->	
				
				<!-- Email -->
				<TD ALIGN="right"><!-- Following link added by Gowtham on 05 March 2013 to email details of the project-->
				  <a href="javascript:call_sendProjectDetails('<%=cbean.getId()%>','<%=cbean.getCDCID()%>','<%=pTitle%>')">
					<img src="/jsp/images/email_big.gif" title="Email this Project" alt="Email Project" border="0"></A> 
				</TD>
				<!-- End Email -->
				
				<!-- Screen -->
				<td  id="s_<%=cbean.getId()%>" ALIGN="right" class="black10px"   width="30" valign="middle"> 
				<%
				  //exclude projects - new feature added by Johnson on May16th 2011
				  boolean projectExcludeExists=false;
				  projectExcludeExists=searchDao.checkExcludeProjectExists(loginId,cbean.getCDCID());
				  
				 
				  
				  %>
				  
				   <%if(projectExcludeExists==true){%>
				   <a  id="<%=cbean.getCDCID()%>" class="<%=loginId%>"  style="cursor:pointer"><img 
				   src="../images/ps-screened.gif" onClick="doScreen(this)" alt="Project Screened" class="screened" title="Project Screened" ></a><%}else{%>
				   <a id="<%=cbean.getCDCID()%>" class="<%=loginId%>" style="cursor:pointer"><img 
				   src="../images/ps-screen.gif" onClick="doScreen(this)" alt="Project Screener" class="screen" title="Project Screener"><%}%></a>
				</td>
				<!-- End Screen -->
				</tr>
				</table>
				</td>
</TR>
<tr>
<td>
<table border="0" cellspacing="0" cellpadding="0" width="472" align="left" style="margin-bottom:10px;max-width:750px;min-width:750px;border:1px solid #333;border-spacing: 5px;"> 
  <TR> 
    <TD> 
	<table border="0" align="right" cellpadding="0" cellspacing="0" >
        <tr> 
          <td>
				<table cellspacing="0" class="" style="min-width:750px;max-width:750px;">
				
			<!--<tr height="10">
			<td>
			</td>
			</tr>-->
              <!--DISPLAY OF THE PROJECT TITLE-->
              <TR> 
			  	<%
					//Display New And Updated flag
					String flag = null;
					if(cbean.getUpdatedFlag() == null || cbean.getUpdatedFlag().equals("N"))
						flag = "NEW";
					else
						flag = "UPDATED";
				%>
                <TD height="20" colspan="6"> <b>
				<div style="float:left;max-width:690px;">
				<font size="1" face="verdana">
                  <%
											out.println(cbean.getTitle());
									%>
				</div>
				<div style="float:right;">
					  <%
							out.println(flag);
					%>
				  </font>
				  </div>					
                  </b> </TD>
              </TR>
			              				       
             
              <!-- THIS IS FOR SUBSECTION-->
              <tr> 
                <td    height="1" class="white10px"> </td>
              </tr>
			 <TR> 
                <td colspan="6"> 
				<font size="1" face="verdana"><b>LOCATION: </b>
                  <%
									String countyMultiple=cbean.getCountyMultiple();
									String stateMultiple=cbean.getStateMultiple();
									out.println(cbean.getCity().trim() + ",");
									
									
									if(stateMultiple.equals("Y"))
							 		{
									   out.print("US");
								    }
									else
									{
									  out.println(cbean.getStateName().trim());
									} 
									
									
									if(countyMultiple.equals("Y"))
							 		{
									   out.print("(Multiple Co.)");
								    }
									else
									{
									  out.println("(" + cbean.getCounty().trim() +" Co.)");
									} 
									
									
									out.println(cbean.getStreetAdd().trim());
									
								%>
				</font>
                </TD>
			  
              <tr> 
                <td colspan="6">
				<b><font size="1" face="verdana"> 
                  <%
								
								String subSection=null;
								if( cbean.getSubSection() != null ){
								 String sub_sec=cbean.getSubSection();
								 
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
								   //out.println("i m award"+subSection);
								  
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
								
								
									out.println(subSection);
								}
								//out.println(cbean.getSub_section() );
								%>
				</font></b>
                </TD>
              </TR>
			   <!-- DISPLAY OF THE PROJECT CDCID-->
              <tr> 
                <td colspan="6"> 
				<b><font size="1" face="verdana">
                  <%
								if( cbean.getCDCID() != null )
								{
                                   String testString=cbean.getStateName();
									out.println(cbean.getCDCID());
									//out.println(testString);
									
									
								}
									
								%>
				</font></b>
                </TD>
              </TR>
			  <tr> 
                <td colspan="6"> 
				<b><font size="1" face="verdana">
                  <%
											if(cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
											{
											 
											  out.println("New Construction");
											
											}
											if(cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
											{
											
											 
											  out.println("Renovation");
											
											}
											if (cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
											{
											
											 
											   out.println("Alteration");
											}
											if (cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
											{
											 
											 out.println("Addition");
											}
											
											
										%>
				</font></b>
                </TD>
              </TR>
			  <tr>
			  <td colspan="6"  class="black10px" > 
			  <b>
			  	<%
			  	if(cbean.getjobType().equals("Private"))
				{
					out.println("Private");
				}
				else
				{
					out.println("Public");
				}
				%>
				</b>
			  </td>
			  </tr>
              <tr> 
                <td    height="1" class="white10px"> </td>
              </tr>
              
              <!--- IFB NUMBER--->
              <%
										if(cbean.getTitle3()!=null)
										{%>
              <TR> 
                <td colspan="6"  class="black10px" > 
                  <%
										out.println(cbean.getTitle3());
										
										
										%>
                </TD>
              </TR>
              <%} 
											
								%>
              
              </TR>
              <!-- THIS IS FOR ESTIMATED AMOUNT DETAILS-->
              <TR> 
                <td colspan="6" class="black10px"> 
                  <%				
														if (cbean.getEstimatedAmountLower() != 0 )
															 {
																 if (cbean.getEstimatedAmountLower() != 0 )
																 {
																	 String amount_lower=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountLower());
																	 out.println("<b>"+"ESTIMATED AMOUNT:" +"</b> " + "$" +ValidateNumber.formatAmountString(amount_lower));
											
																	 if (cbean.getEstimatedAmountUpper() != 0 )
																	 {
																		 String amount_upper=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountUpper());

																		 out.println(" to " + "$" +ValidateNumber.formatAmountString(amount_upper));
																	 }
																	 out.println("\n");
																	
																 }
															 }
															 else if (cbean.getEstimatedAmountUpper() != 0 )
															 {
																 if (cbean.getEstimatedAmountLower() != 0)
																 {
																	 String amount_lower=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountLower());
																	 out.println("<b>"+"ESTIMATED AMOUNT:" +"</b> " + "$" +ValidateNumber.formatAmountString(amount_lower));
											
																	 if (cbean.getEstimatedAmountUpper() != 0 )
																	 {
																		 String amount_upper=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountUpper());
																		 out.println(" to " + "$" +ValidateNumber.formatAmountString(amount_upper));
																	 }
																	 out.println("\n");
																 }
																 
						
										                   
								                     
					
								%>
                
                <%}%>
				</TD>
              </TR>
              <!-- THIS IS FOR CONTRACTING METHOD DETAILS-->
              <TR> 
                <td colspan="6" class="black10px" > 
                  <%
								if( cbean.getConMethod() != null){
								out.println("<b><font face='verdana,arial' size='1' >");
								out.println("CONTRACTING METHOD:");
							    out.println(cbean.getConMethod());
								 out.println("</font></b>");
								}
								
													
					
								%>
                </TD>
              </TR>
              <!-- THIS IS FOR SUFFIX  DETAILS-->
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%
										StringBuffer statusBuf = new StringBuffer();

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
								
										 String status = statusBuf.toString();
								
										 if (status != null && !status.trim().equals(""))
										 {
											 
											 
											 if(cbean.getPublishDate() != null)
											 {
											 out.println("<b><font face='verdana,arial' size='1' >");
											 out.println("UPDATE:");
										     out.println("</font></b>");
											 out.println("<b>"+status.trim());
											 
											 
											 }
											 
											 else
											 {
											 out.println("<b><font face='verdana,arial' size='1' >");
											 out.println("STATUS:");
											 out.println("</font></b>");
											 out.println("<b>"+status.trim());
											 
											 }
											 
										 }
									%>
                </TD>
              </TR>
              <!--DISPLAY OF THE PROJECT BIDS DETAILS-->
              <TR> 
                <td colspan="6" class="black10px"> 
                  <%
							
							if( cbean.getBidsDetails() != null && cbean.getBidsDetails().equals("")==false
							 && (cbean.getSubSection().equals("PROJECTS") || cbean.getSubSection().equals("AWAITING AWARDS")))
							{
								out.println("<b><font face='verdana,arial' size='1' >");
							    out.println("BIDS DUE:");
								out.println("</font></b>");
								
								if(cbean.getbidDate()!=null)
								{
								out.println("<font face='verdana,arial' size='1' >");
								Locale usLocale=new Locale("EN","us");
			     		        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				                Date tempdate=sdf.parse(cbean.getbidDate());
				                sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			    String convertedDate=sdf.format(tempdate);
								out.println("<B>");
						        
								out.println(""+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(convertedDate))+"");
								out.println("</B>");
							    }
								out.println(cbean.getBidsDetails()+"</font>");
								
							}
							/*	String bid_date=cbean.getbidDate();
								String new_bid_date=cbean.getNewBidDate();
								String publish_date=cbean.getentryDate();
								String biddate_text=cbean.getBidsDetails();
								
							if (new_bid_date != null && !new_bid_date.equals("") && !new_bid_date.equals(bid_date)
											 && publish_date != null)
								 {
									
									 String fmt_bid_date = ValidateDate.getDateFromDBDate(bid_date);
									 String fmt_new_bid_date = ValidateDate.getDateFromDBDate(new_bid_date);
									 out.println("<b>BID DATE CHANGED TO:<b> ");
									 out.println(ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(new_bid_date)));
					
									 if (biddate_text != null && !biddate_text.equals(""))
									 {
										 out.println(" " + biddate_text);
									 }
					
								   
								
					
									 out.println(" " + "<br>");
					
								 }
								  else // Bid date hasn't changed
								 {
								   if(new_bid_date != null && !new_bid_date.equals(""))
									 {
									 out.println("<b>BIDS DUE:</b> ");
									 out.println("<b>"+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(new_bid_date))+"</b>");
					
									 if (biddate_text != null && !biddate_text.equals(""))
									 {
										 out.println(" " + biddate_text);
									 }
					
									 // Print other set asides text next, if any.
								
					
									 out.println("<br>");
								  }
								}  */
								
								
								if(cbean.getSubSection().equals("BID RESULTS"))
								{
								    String bidsopened_date=cbean.getbidsOpenDate();
									  String newBiddate=cbean.getNewBidDate();
						
						
									  if (bidsopened_date != null)
										  bidsopened_date = bidsopened_date.trim();
						
									  if (newBiddate != null)
										  newBiddate = newBiddate.trim();
						
										out.println("<b><font face='verdana,arial' size='1' >");
									  if (bidsopened_date != null && !bidsopened_date.equals(""))
									  {
										  
										  out.println("BIDS OPENED:"
											  + ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(bidsopened_date))+"<br>");
						
									  }
									  else if (newBiddate != null && !newBiddate.equals(""))
									  {
										  out.println("BIDS OPENED:"
											  + ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(newBiddate))+"<br>");
						
									  }
									  out.println("</font></b>");
									  //out.println("<font face='verdana,arial' size='1' >");
								
								
								}
								
								
								/*This is for printing the values for SUB BIDS*/
								
								if(cbean.getSubSection().equals("BIDS REQUESTED"))
								{
								 
								 
								
								 String  duedate=cbean.getNewBidDate();
								 String biddate_text=cbean.getBidsDetails();
								
								 
								 		if (duedate != null)
             							duedate = duedate.trim();

									 if (biddate_text != null)
										 biddate_text = biddate_text.trim();
							
									 String subbidDueDate = "";
									 if (duedate != null && !duedate.equals(""))
									 {
										 subbidDueDate = ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(duedate)) + " ";
									 }
							
									 if (biddate_text != null && !biddate_text.equals(""))
									 {
										 StringTokenizer strtok = new StringTokenizer(biddate_text);
										 int ctr = 0;
										 while (strtok.hasMoreTokens())
										 {
											 String token = strtok.nextToken();
											 // Print "As Soon As Possible" only if the first element is ASAP
											 if (token.toUpperCase().equals("ASAP") && ctr == 0)
											 {
												 subbidDueDate+= "As Soon As Possible ";
												 subbidDueDate+= " ";
											 }
											 else
											 {
												 subbidDueDate+= token + " ";
											 }
											 ctr++;
										 }
									 }
							
									 if (!subbidDueDate.equals(""))
									 {
										 out.println("<b><font face='verdana,arial' size='1' >");
										 out.println("SUB BIDS DUE: "+subbidDueDate + "<br>");
										 out.println("</font></b>");
									 }
								
								}
								
				
							%>
                </TD>
              </TR>
              <!--THIS IS FOR FILED SUBBID AND ITS STATUS-->
              <TR> 
                <TD> 
                  <%
				   String filedsubbid_date=null;
			       String filedsubbid_text=null;
			       String printDate=null;
         
					 if (cbean.getfiledSubbidDate() != null)
						 filedsubbid_date = cbean.getfiledSubbidDate().trim();
						
			
					 if (cbean.getfiledSubbidText() != null)
						 filedsubbid_text = cbean.getfiledSubbidText().trim();
						
			
					 if (cbean.getPublishDate() != null)
						 printDate = cbean.getPublishDate().trim();
						
			
					 if (filedsubbid_date != null && !filedsubbid_date.equals(""))
					 {
						 String fmt_filedsubbid_date = ValidateDate.getDateFromDBDate(filedsubbid_date);
						 String fmt_print_date = ValidateDate.getDateString(printDate);
						 String dateLabel = null;
			            
						 if (ValidateDate.compareDates(fmt_filedsubbid_date,fmt_print_date) == 2)
						 {
							 dateLabel = "<b><font face='verdana,arial' size='1' >FILED SUB-BIDS WERE DUE: </b></font>";
						 }
						 else
						 {
							 dateLabel = "<b><font face='verdana,arial' size='1' >FILED SUB-BIDS DUE:</b></font> ";
						 }
			
						 out.println("<font face='verdana,arial' size='1' >"+dateLabel+"</font>");
						 out.println("<font face='verdana,arial' size='1' >"+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(filedsubbid_date))+"</font>");
			
						 if (filedsubbid_text != null && !filedsubbid_text.equals(""))
						 {
							 out.println("<font face='verdana,arial' size='1' > "+filedsubbid_text+"</font>");
						 }
			      
						 
					 }
					 else if (filedsubbid_text != null && !filedsubbid_text.equals(""))
					 {
						 out.println("<b><font face='verdana,arial' size='1' >"+ "FILED SUB-BIDS DUE:"+"</b></font>");
						 out.println("<font face='verdana,arial' size='1' >"+filedsubbid_text+"</font>");
					 }
				%>
                </TD>
              </TR>
              <!-- THIS IS FOR START DATE DETAILS-->
              <%
								if(cbean.getEstimatedStartDate()!=null && !cbean.getEstimatedStartDate().equals(""))
								{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <% 
								 
								 out.println("<b><font face='verdana,arial' size='1' >");
								 out.println("Start Date:  ");
								 out.println("</font></b>");
								 String formattedStrtDt=ValidateDate.formatPrintableDate(cbean.getEstimatedStartDate());
								 if (formattedStrtDt != null)
								 {
								  out.println(formattedStrtDt);
								 }
								 else
								 {
								  out.println(cbean.getEstimatedStartDate());
								 }
								 
								// out.println(ValidateDate.formatPrintableDate(cbean.getEstimatedStartDate()));
								
								
								%>
                </TD>
              </TR>
              <%}%>
              <!-- THIS IS FOR  END DATE DETAILS-->
              <%
						if(cbean.getEstimatedEndDate()!=null && cbean.getEstimatedEndDate().equals("")==false)
						{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size = '1' >");
						 out.println("End Date:  ");
						 out.println("</font></b>");
						  String formattedEndDt=ValidateDate.formatPrintableDate(cbean.getEstimatedEndDate());
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
                <td colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println("No of Days:  ");
							out.println("</font></b>");
							out.println((cbean.getCompletionDays()));%>
                </TD>
              </TR>
              <%}
							
												
				
							%>
              <!--DISPLAY FOR PROJECT COMPLETION DAYS-->
              <%
							
							
							if( cbean.getProjCompletion() != null && cbean.getProjCompletion().equals("")==false){
							%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println("% Comp:  ");
							out.println("</font></b>");
							
							 out.println((cbean.getProjCompletion()));
							%>
                </TD>
              </TR>
              <%}
							
											
				
							%>
			
			<!-- Owners -->
			 <tr > 
                <td colspan="10" class="black10px"> 
                  <%
				  
				  						
									       if (cbean.getOwners()!=null)
									 {
										 // The indexList list keeps track of the indexes of the contacts that have been
										 // printed in the loop.
										 ArrayList indexList = new ArrayList();

										 int i = 0;

										 // Search for "OWNER" in the list.
										 String ownerKeyWords = "OWNER";
										 boolean found_owner = false;
										 boolean allOwners = true;
										 String last_owner_title = "";
										 String  newLine="\n";

										 itrOwner = ownersList.iterator();

										 while (itrOwner.hasNext())
										 {
											 common.bean.ExtractContact currentContact = (common.bean.ExtractContact)itrOwner.next();
											 String contactType = currentContact.getContactTypeText().trim();
															 //if (ownerKeyWords.toUpperCase().indexOf(contactType.toUpperCase()) >= 0)
											if (ownerKeyWords.equalsIgnoreCase(contactType))
											 {
												 // Owner found. Remember the index, print it to files and break loop.
												 indexList.add(new Integer(i));



												 // For printing company name, check if there's any semi-colon. If there is any,
												 // parse it and print text on the right of semicolon to the left of company name.
												 String company_name = null;
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

												 //out.println(contactType.toUpperCase()+": "+company_name+newLine);
												 // Project Contact Link
												 out.println("<b>"+searchUtil.keywordHighlight(contactType.toUpperCase().trim(),cKeyword)+":</b> ");
													 
												 if(company_name!=null && company_name.trim().length()>0){	 
													 out.println(searchUtil.keywordHighlight(company_name.trim(),cKeyword));
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
													 String formattedZip = ValidateNumber.formatZipCode(currentContact.getZip().trim());
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
													 String formattedTel = searchUtil.removeSpecialChars(currentContact.getTelephone1().trim());
													 BigDecimal phone_int = null;
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
														 out.println(wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
													 }
													 else
													 {
														 out.println(wrapWithAnchor(currentContact.getTelephone1().trim(),currentContact.getTelephone1().trim(),"tel"));

													 }
												 }

												  // Print telephone 2 if telephone 1 is missing.
												 if (currentContact.getTelephone1() == null &&
													 currentContact.getTelephone2() != null &&
													 !currentContact.getTelephone2().trim().equals(""))
												 {
													 String formattedTel = searchUtil.removeSpecialChars(currentContact.getTelephone2().trim());
													 BigDecimal phone_int = null;
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
														 out.println(wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
													 }
													 else
													 {
														 out.println(wrapWithAnchor(currentContact.getTelephone2().trim()
														 		,searchUtil.keywordHighlight(currentContact.getTelephone2().trim(),keyword),"tel"));
													 }
												 }
												  if (currentContact.getFax1() != null && !currentContact.getFax1().trim().equals(""))
												 {
													 String formattedTel = searchUtil.removeSpecialChars(currentContact.getFax1().trim());
													 BigDecimal phone_int = null;
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
														 out.println("FAX# "+wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
													 }
													 else
													 {
														 out.println("FAX# "+wrapWithAnchor(currentContact.getFax1().trim()
														 		,searchUtil.keywordHighlight(currentContact.getFax1().trim(),cKeyword),"tel"));
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
													   <a href="mailto:<%=currentContact.getContactPersonEmail()%>"><%=currentContact.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(currentContact.getContactPersonName()!=null && !currentContact.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+currentContact.getContactPersonName().trim()+"</b>");
													 }
													 if(currentContact.getContactPersonPhone()!=null && !currentContact.getContactPersonPhone().trim().equals(""))
													 {
													   String formattedTelNo = searchUtil.removeSpecialChars(currentContact.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println("Phone#: "+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(currentContact.getContactPersonFax()!=null && !currentContact.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(currentContact.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println("Fax#: "+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
													   
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
												 Iterator listitr = indexList.iterator();
													while (listitr.hasNext())
													 {
														 if (ownerCounter == ((Integer)listitr.next()).intValue())
															 continue outerloop;
													 }
												  // If it reaches here, owner is not printed. Print it now.
													common.bean.ExtractContact contactOthers = (common.bean.ExtractContact)ownersList.get(ownerCounter);
													 String contactTypeOthers = null; contactTypeOthers="";
													 if(contactOthers.getContactTypeText()!=null)
													 	contactTypeOthers = contactOthers.getContactTypeText().trim();

													 /*// For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.*/
													 String companyNameOthers = null; companyNameOthers="";
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
														 out.println(searchUtil.keywordHighlight(companyNameOthers,cKeyword));
														 }
													out.println("<br>");

														  boolean print_newline = false;
													 if (contactOthers.getAddress1() != null && !contactOthers.getAddress1().equals("") )
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getAddress1().trim(),cKeyword)+", ");
														 print_newline = true;
														// out.println("1");
													 }

													 if (contactOthers.getCity() != null && !contactOthers.getCity().equals(""))
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getCity().trim(),cKeyword)+", ");
														 print_newline = true;
														 //out.println("2");
													 }

													 if ((contactOthers.getAddress1() != null && !contactOthers.getAddress1().equals("") ) || (contactOthers.getCity() != null && !contactOthers.getCity().equals("")))
													 {
														 out.println(searchUtil.keywordHighlight(contactOthers.getStateCode().trim(),cKeyword)+", ");
														 print_newline = true;
													 }

													 if (contactOthers.getZip() != null && !contactOthers.getZip().trim().equals(""))
													 {
														 String formattedZip = ValidateNumber.formatZipCode(contactOthers.getZip().trim());
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
														 String formattedTel = searchUtil.removeSpecialChars(contactOthers.getTelephone1().trim());
														 BigDecimal phone_int = null;
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
															 out.println(wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
														 }
														 else
														 {
															 out.println(wrapWithAnchor(contactOthers.getTelephone1().trim()
															 			,searchUtil.keywordHighlight(contactOthers.getTelephone1().trim(),cKeyword),"tel"));
														 }
													 }
													   // Print telephone2 if telephone1 is missing
													 if (contactOthers.getTelephone1() == null &&
														 contactOthers.getTelephone2() != null &&
														 !contactOthers.getTelephone2().trim().equals(""))
													 {
														 String formattedTel = searchUtil.removeSpecialChars(contactOthers.getTelephone2().trim());
														 BigDecimal phone_int = null;
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
															 out.println(wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
														 }
														 else
														 {
															 out.println(wrapWithAnchor(contactOthers.getTelephone2().trim()
															 			,searchUtil.keywordHighlight(contactOthers.getTelephone2().trim(),cKeyword),"tel"));
														 }
													 }
													if (contactOthers.getFax1() != null && !contactOthers.getFax1().trim().equals(""))
													 {
														 String formattedTel = searchUtil.removeSpecialChars(contactOthers.getFax1().trim());
														 BigDecimal phone_int = null;
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
															 out.println("FAX# "+wrapWithAnchor(formattedTel,searchUtil.keywordHighlight(formattedTel,cKeyword),"tel"));
														 }
														 else
														 {
															 out.println("FAX# "+wrapWithAnchor(contactOthers.getFax1().trim()
															 		,searchUtil.keywordHighlight(contactOthers.getFax1().trim(),cKeyword),"tel"));
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
													   <a href="mailto:<%=contactOthers.getContactPersonEmail()%>"><%=contactOthers.getContactPersonName().trim()%></a>
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
													   out.println(",Phone#: "+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(contactOthers.getContactPersonFax()!=null && !contactOthers.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactOthers.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#: "+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
													   
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
			  <!-- End Owners -->				
             
              <%
						boolean boolean_size = false;
						if( (cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
						|| (cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
						|| (cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
						|| (cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
						){%>
              <TR> 
                <td colspan="6" class="black10px"> 
                  <%
								//out.println("SIZE : ");
								boolean_size=true;
							}
							
							StringBuffer sqft_story_text = new StringBuffer();
								int counter=0;
							if((cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y")) && 
								(cbean.getSqrftDetailsNew() != null || cbean.getDistributedAcresNew() != null 
								|| cbean.getParkingSpaceNew() != null || cbean.getStoriesNew()>0
								|| cbean.getSqrftNew()>0 ))
							{
								//out.println();
								
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			                     
								 sqft_story_text.append("<b style=color>"+"New Construction"+","+"</b>");
				                 //out.println("<b>"+"New Construction,"+"</b>");
								if(cbean.getSqrftNew()>0)
								 {
										  
			
									 sqft_story_text.append(" " +
															ValidateNumber.
															formatAmountString(String.valueOf(cbean.getSqrftNew())));
								   
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
									 String story_string =String.valueOf(cbean.getAboveGradeNew().trim());
									
									
									   
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
			
								 sqft_story_text.append("<b style=color:black;>"+"Renovation,"+"</b>");
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
									 String story_string = String.valueOf(cbean.getStoriesRen());
									 
								   
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
			
								 sqft_story_text.append("<b style=color:black;>"+"Alteration,"+"</b>");
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
									 String story_string = String.valueOf(cbean.getStoriesAlt());
									 
								   
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
			
								 sqft_story_text.append("<b style=color:black>"+"Addition"+ ",</b>");
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
									 String story_string = String.valueOf(cbean.getStoriesAdd());
									 
								   
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
									 String story_string =String.valueOf(cbean.getAboveGradeAdd().trim());
									
									 
									   
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
									String story_string = String.valueOf(cbean.getBelowGradeAdd().trim());
									
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
									
									//out.println("SIZE :"+sqft_story_text.toString()+"<br>");
									out.println("SIZE:"+sqft_story_text.toString()+"<br>");
								}*/
									 if(sqft_story_text.length() > 0)
									{
									 out.println("<b>"+ "SIZE: "+"</b>"+sqft_story_text.toString()+"<br>");
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
                <TD colspan="6" class="black10px"> 
                  <%
									out.println("<b><font face='verdana,arial' size='1' >");
									out.println("USE:");
									out.println("</font></b>");
									if (cbean.getNationalChain() != null && cbean.getNationalChain().equals("Y"))
             						{
                 						out.println("National Chain.");
										//out.println("National Chain.");
             						}
									out.println(cbean.getDetail1());
								%>
                </TD>
              </TR>
              <%	}
				%>
              <!-- THIS IS FOR SCOPE DETAILS-->
              <%
						 			 
							if( (scope_title_list != null) && (scope_title_list.size()>0) ){%>
              <TR> 
                <td colspan="6" class="black10px"> 
                  <%
								out.println("<b>"+"SCOPE: "+"</b>");
								itr = scope_title_list.iterator();
								String scopeStr=null;
								boolean b = false;
								int countScope=0;
								String scopeStrList=null;
								int scopeListSize=scope_title_list.size();
								while(itr.hasNext())
								{
								 ExtractScopeOfWorkData scopeData=(ExtractScopeOfWorkData)itr.next();
									//String scopeStr=((String)itr.next()).trim();
									//out.println(scopeData.getScopeOfWorkTitle());
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
								out.println(scopeStrList);
							%>
                </TD>
              </TR>
              <% }
				
%>
              <!-- THIS IS FOR MIEQ DETAILS-->
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%  
								
								if(	((String)cbean.getMIEQText()) != null && cbean.getMIEQText().equals("")==false)
									{
										
										
										out.println("<pre class='black10px' style='white-space: pre-wrap;word-wrap: break-word;white-space:-moz-pre-wrap!important;white-space: -o-pre-wrap;white-space: -pre-wrap;word-break:break-all;' ><B>"+"MIEQ:"+" </B>"+cbean.getMIEQText().trim()+"</pre>");
																	
									}
							%>
                </TD>
              </TR>
              <!--DISPLAY OF DIVISIONS-->
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%
			
				HashMap hashmap = null;
				if(cbean.getHashmap() != null){
				out.println("<b>"+"DIVISION:"+"</b> <BR>");
					hashmap = (HashMap)cbean.getHashmap();				
					
			
					ArrayList al = new ArrayList((Set)hashmap.keySet());
					Collections.sort(al);
					Iterator itr3 = al.iterator();
					String divList=null;
					boolean b = false;
						while(itr3.hasNext()){					
							String s = (String)itr3.next();
							out.println("<b>");
							
							out.println("Div"+Integer.parseInt(s));							
							out.println("</b>");
							 	ArrayList al1 = (ArrayList)hashmap.get(s);
								int countDiv=0;
								int ListSize=al1.size();
							    	Iterator itr2 = al1.iterator();									
							    	while(itr2.hasNext()){
									String divStr=((String)itr2.next()).trim();
							    
										//out.print(",");
										//divStr=divStr+",";
										 if(countDiv==0)
											{
											  divList=divStr;
											  //out.println("divStr::::"+divStr.trim()+"|");
											
											}
											else
											{
											  divList=divList+", "+divStr.trim();
											 // out.println("else::::"+itrim(divStr)+"|");
											  
											
											}
										   countDiv++;
									}//while
									out.println("<font face='verdana,arial' size='1' >"+divList.trim().toLowerCase()+"</font>");					
							    //	out.print(".");	
							    	
							    	
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
									out.println("Spec Cond:");
									out.println("</font></b>");
									out.println(cbean.getSpecialConditions1());%>
                </TD>
              </TR>
              <%}
					  %>
              <!-- THIS IS FOR SPECIAL CONDITION 2 DETAILS-->
              <%  
							if(((String)cbean.getSpecialConditions2()) != null && cbean.getSpecialConditions2().equals("")==false)
							{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
								out.println("Spec Cond:");
								out.println("</font></b>");
								out.println(cbean.getSpecialConditions2());%>
                </TD>
              </TR>
              <%}
					  %>
              <!--DISPLAY OF  NOTES---->
              <%  
								if(	((String)cbean.getDetail3()) != null && cbean.getDetail3().trim().equals("")==false)
								{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%String details3=cbean.getDetail3();
									out.println("<b><font face='verdana,arial' size='1' >");
									out.println("NOTES:");
									out.println("</font></b>");
									out.println(details3);
									//out.println(details3);
								 /*	if(details3.indexOf(keyword)>0)
									{
									  out.println(details3.trim()+"<br>");
									}
									else
									{
									 out.println(details3.trim()+"<br>");
									}*/
									//out.println("</font>");
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
							out.println("CONTACT:");
							out.println("</font></b>");
							out.println(cbean.getDetailTitle1());%>
                </TD>
              </TR>
              <% }
						
					%>
              <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE2-->
              <%
					if(	((String)cbean.getDetailTitle2()) != null && cbean.getDetailTitle2().equals("")==false)
					{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
						out.println("CONTACT:");
						out.println("</font></b>");
						out.println(cbean.getDetailTitle2());%>
                </TD>
              </TR>
              <%}
				%>
              <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE3-->
              <%
					if(	((String)cbean.getDetailTitle3()) != null && cbean.getDetailTitle3().equals("")==false)
					{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
						out.println("CONTACT:");
						out.println("</font></b>");
						out.println(cbean.getDetailTitle3());%>
                </TD>
              </TR>
              <%}
				%>
              <!--This is for PLANS-->
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%  
					
					 String plansTitle=cbean.getplansAvailableTitle();
					 String plansText=cbean.getplansAvailableFrom();
					 
					 if ((plansTitle!= null && !plansTitle.trim().equals("")) && (plansText!= null && !plansText.trim().equals("")))
					 {
					  out.println(" <b>"+plansTitle+":</b> "+plansText);
					  
					 } 
					
					 if (cbean.getplansAvailableDate() != null)
             		{

               			String plansAvailDate=ValidateDate.getDateStringMMDDYY(cbean.getplansAvailableDate());			
						
						 
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
                <TD colspan="6" class="black10px"> 
                  <% 
					    String amount= Double.toString(cbean.getplanDeposit());
						
  						if(cbean.getplanDeposit()>0)
							{
								out.println("<font face='verdana,arial' size='1' >");
								out.println("PLAN DEP:"+" $"+ValidateNumber.formatAmountStringWithDecimal(amount,2, 2));
								out.println("</font>");
							}
								 // Print refundable text
                 			if (cbean.getRefundText() != null && !cbean.getRefundText().trim().equals(leadsconfig.LeadsConfig.REFUND_TEXT1))
                 			{
                    		 out.println(cbean.getRefundText().trim());
                 			}
							  // Print refundable details
                 			if (cbean.getRefundDetails() != null
                    		 && !cbean.getRefundDetails().trim().equals(""))
                 			{
                    			 out.println(" " + cbean.getRefundDetails().trim());
                 			}
                 
				  %>
                </TD>
              </TR>
              <!-- THIS IS FOR MAILING FEE DEPOSIT-->
              <% 
				    String mailingFee= Double.toString(cbean.getmailingFee());
					
                      
				   
					if(cbean.getmailingFee()>0)
					{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println("MAILING FEE:"+"$"+ValidateNumber.formatAmountStringWithDecimal(mailingFee,2,2));
					
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
						if (ValidateNumber.isNumber(cbean.getbidBondPerct().trim()))
            			 {
                			 out.println("BID BOND: "+cbean.getbidBondPerct()+"%");
             			 }
						 else
						 {
						 
						  out.println("BID BOND: "+cbean.getbidBondPerct());
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
                     	String certCashFlag=cbean.getCertCashFlag();
						
						%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%if(certCashFlag.trim().equals("Y"))
						{
							
							out.println("<font face='verdana,arial' size='1' >");
							out.println("Certified/Cashiers Check");
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getbidBondStdRange());
					
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println("PERF. BOND:"+cbean.getperfBondText());
 
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
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
							out.println("PAYMENT BOND:"+cbean.getpayBondPerct()+"%");
					
							out.println("</font>");%>
                  
                </TD>
              </TR>
			  <%	}
				%>
              <!-- THIS IS FOR MAINTENANCE BOND -->
              <% 
				    
  
				   
					if(cbean.getmaintBondPerct() != null && cbean.getmaintBondPerct().equals("")==false)
					{%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					out.println("MAINT. BOND:"+cbean.getmaintBondPerct()+"%");
					
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
						 if(cbean.getmandatoryMeetFlag().trim().equals("Y"))
						 {
						 // out.println("Mandatory");
						  out.println("Mandatory");
						 
						 }
						
						 
						 if(cbean.getsitePrebidFlag().trim().equals("S"))
						 {
						 
						  // out.println("Site Visit");
						   out.println("Site Visit");
						 }
						 else if(cbean.getsitePrebidFlag().trim().equals("P"))
						 {
						  
						  //out.println("Pre-bid Meeting");
						  out.println("Pre-bid Meeting");
						 }
						 else if(cbean.getsitePrebidFlag().trim().equals("J"))
						 {
						  //out.println("Job Walk");
						  
						  out.println("Job Walk");
						 }
						
					  
					 
					  if(cbean.getPrebidDate() != null &&
										 ! cbean.getPrebidDate().equals(""))
						  {
								 // Convert printdate in MM/DD/YYYY format
								 //out.println("test");
								 String printDatee=ValidateDate.getTodayDate();
								// out.println("test"+printDatee);
								 String formattedPrintDate = (printDatee);
								 
								
								 if (formattedPrintDate != null)
								 {
									
									 
									 String formattedPrebidMDate = ValidateDate.getDateFromDBDate(cbean.getPrebidDate());
									
									 if (formattedPrebidMDate != null)
									 {
										
										 String was_willbe = null;
										 
										 int ret_val = ValidateDate.compareDates(formattedPrintDate,formattedPrebidMDate);
										
										 if (ret_val == 0 || ret_val == 2)
											 was_willbe = "will be held ";
										 else if (ret_val == 1)
											 was_willbe = "was held ";
				
										 String printableDate = ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cbean.getPrebidDate()));
										 if (was_willbe != null)
										 {
											 out.println(was_willbe+"on " +printableDate+" ");
										 }
									 }
								 }
							} // End of if(currentProject.getPrebidMeetDate() != null ...)
							 if(cbean.getPrebidMeetText()!=null)
							 out.println(cbean.getPrebidMeetText().trim()+" ");
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
									 out.println("Pre-bid Meeting: To Be Announced");
								 }
								 else if (cbean.getprebidMeetDetails().trim().equals("U"))
								 {
									 //out.println("Pre-bid Meeting: Unobtainable at Press Time");
									 out.println("Pre-bid Meeting: Unobtainable at Press Time");
									 
								 }
								 else if (cbean.getprebidMeetDetails().trim().equals("S"))
								 {
									// out.println("Pre-bid Meeting: None Scheduled");
									 out.println("Pre-bid Meeting: None Scheduled");
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
                <td colspan="6"  class="maroon10px" > 
                  <%
								
								
								itrPlanRoomInfo = planRoomInfoList.iterator();
								
								while(itrPlanRoomInfo.hasNext())
								{
								 PlanRoomBean pBean=(PlanRoomBean)itrPlanRoomInfo.next();
									out.println("<b>"+pBean.getPlanroomDescription());
									if(pBean.getPlanBinnumber()!=null)
									out.println("Plan Bin Number :"+pBean.getPlanBinnumber());
									
								}
							%>
                </TD>
              </TR>
              <% }%>
              <!-- Print DBC Prequalification required-->
              <% 
				    
                     if(cbean.getdbcPreQualFlag()!=null)
					{
                     	String dbcPreQualFlag=cbean.getdbcPreQualFlag();%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%if(dbcPreQualFlag.trim().equals("Y")==true)
						{
				   			out.println("<font face='verdana,arial' size='1' >");
                           // out.println("D.B.C. Pre-qualification required");
							out.println("D.B.C. Pre-qualification required");
							out.println("</font>");
						}%>
                </TD>
              </TR>
              <%}%>
              <!-- Print 100% set aside for small business-->
              <% 
				   
                     if(cbean.getSmallBusinessFlag()!=null)
					{
                     	String smallBusinessFlag=cbean.getSmallBusinessFlag();%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%if(smallBusinessFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' >");
                            out.println("100% Set Aside for Small Business");
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
                     	String WbeMbeFlag=cbean.getWbeMbeFlag();%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%if(WbeMbeFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' >");
                            out.println("WBE/MBE Required");
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
                     	String preQualFlag=cbean.getpreQualFlag();
					 %>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%if(preQualFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' >");
                          //  out.println("<b>"+"Pre-qualification Required"+"</b>");
							out.println("<b>"+"Pre-qualification Required"+"</b>");
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
                <TD colspan="6" class="black10px"> 
                  <%Locale usLocale=new Locale("EN","us");
     		     		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				 		Date tempdate=sdf.parse(cbean.getpreQualDate());
				 //		sdf=new SimpleDateFormat("MM-dd-yy",usLocale);
				 		String cd=sdf.format(tempdate);
				 		out.println("<b><font face='verdana,arial' size='1' >");
				 
				 
						// out.println();
				 		out.println("<b> "+"Pre-qualification due:"+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd))+"</b>");
						out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is MBE-->
              <%  
					if(	((String)cbean.getMBE()) != null && cbean.getMBE().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					//out.println(cbean.getMBE()+ "%" + " MBE");
					out.println(cbean.getMBE()+"% MBE");
					
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is other pre-qualifications-->
              <%  
					if(	((String)cbean.getOtherPreQual()) != null && cbean.getOtherPreQual().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<b><font face='verdana,arial' size='1' >");
					out.println(cbean.getOtherPreQual());
					out.println("</b></font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is WBE-->
              <%  
					if(	((String)cbean.getWBE()) != null && cbean.getWBE().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					//out.println(cbean.getWBE()+ "%" + " WBE");
					out.println(cbean.getWBE()+"% WBE");
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is DBE-->
              <%  
					if(	((String)cbean.getDBE()) != null && cbean.getDBE().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%	out.println("<font face='verdana,arial' size='1' >");
					//out.println(cbean.getDBE()+ "%" + " DBE");
					out.println(cbean.getDBE()+"% DBE");
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is DVBE-->
              <%  
					if(	((String)cbean.getDVBE()) != null && cbean.getDVBE().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					//out.println(cbean.getDVBE()+ "%" + " DVBE");
					out.println(cbean.getDVBE()+"% DVBE");
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- This is HUB-->
              <%  
					if(	((String)cbean.getHUB()) != null && cbean.getHUB().equals("")==false){%>
              <TR> 
                <TD colspan="6" class="black10px"> 
                  <%out.println("<font face='verdana,arial' size='1' >");
					//out.println(cbean.getHUB()+ "%" + " HUB");
					out.println(cbean.getHUB()+"% HUB");
					out.println("</font>");%>
                </TD>
              </TR>
              <%}
				%>
              <!-- THIS IS FOR Industry DETAILS-->
              <%
							if( (industryList != null) && (industryList.size()>0) ){%>
              <TR> 
                <td colspan="6" class="black10px"> 
                  <%
								
								out.println("<b>Industry Type:</b> ");
								itrIndustry = industryList.iterator();
								HashMap indMap=new HashMap();
								HashMap subIndMap=new HashMap();
								String mainInd=null;
								String subInd=null;
								
								
								while(itrIndustry.hasNext())
								{
								IndustryBean ibean=(IndustryBean)itrIndustry.next();
								indMap.put(ibean.getIndustry(),ibean.getIndustry());
								//out.println("sub indus"+ibean.getSubIndustry());
								subIndMap.put(ibean.getSubIndustry(),ibean.getSubIndustry());  
								mainInd=indMap.keySet().toString().replace('[',' ').replace(']',' ');
								subInd=subIndMap.keySet().toString().replace('[',' ').replace(']',' ');
							    
								
																	
								}
								StringTokenizer stInd = new StringTokenizer(mainInd,",");
								while (stInd.hasMoreTokens()) {
  								 
								 
								 String Industry=stInd.nextToken();
								 //out.println("indus"+Industry);
								// out.println("<a href=/online_product/list_industry_projects.cfm?industry="+Industry.trim().replaceAll(" ", "+")+" target=\"_self\">"+Industry.trim()+"</a>");	
								out.println(Industry.trim());	
								} 
								
								
								
								
								out.println("<br>");
								out.println("<b>Sub Industry Type:</b>");
								StringTokenizer st = new StringTokenizer(subInd,",");
								while (st.hasMoreTokens()) {
  								 
								 
								 String subIndustry=st.nextToken();
								 
								// out.println("<a href=/online_product/list_industry_projects.cfm?industrySub="+subIndustry.trim().replaceAll(" ", "+")+" target=\"_self\">"+subIndustry.trim()+"</a>");
								out.println(subIndustry.trim());	
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
										 String prev_contacttype = null;
										 int lowbidder_count = 0;  // keeps count of low bidders to print numbers
										 boolean printDetails = true; // Decides whether to print details for low-bidder or not.
										 itrLowBidder = lowBiddersList.iterator();
										 while (itrLowBidder.hasNext())
										 {
											 lowbidder_count++;
							
											 common.bean.ExtractContact contactlowBidders = (common.bean.ExtractContact) itrLowBidder.next();
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
													 String company_name = contactlowBidders.getCompanyName().trim();
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
													  out.println("<b>"+lowbidder_count+". "+"</b>"+searchUtil.keywordHighlight(company_name,cKeyword));
								
								
													 BigDecimal amt = contactlowBidders.getLowBidAmount();
													 String lowbid_amount = null;
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
													 String fax_no = null;
													 Long fax_no_int = null;
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
															 out.println("FAX# "+wrapWithAnchor(fax_no,searchUtil.keywordHighlight(fax_no,keyword),"tel"));
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+wrapWithAnchor(contactlowBidders.getFax1().trim()
															 			,searchUtil.keywordHighlight(contactlowBidders.getFax1().trim(),cKeyword),"tel"));
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
															 String formattedZip = ValidateNumber.formatZipCode(contactlowBidders.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,keyword));
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
														 Long tel_no_int = null;
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
																 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(wrapWithAnchor(contactlowBidders.getTelephone1().trim()
																 		,searchUtil.keywordHighlight(contactlowBidders.getTelephone1().trim(),cKeyword),"tel"));
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
													   <a href="mailto:<%=contactlowBidders.getContactPersonEmail()%>"><%=contactlowBidders.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactlowBidders.getContactPersonName()!=null && !contactlowBidders.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactlowBidders.getContactPersonName().trim()+"</b>");
													 }
													 if(contactlowBidders.getContactPersonPhone()!=null && !contactlowBidders.getContactPersonPhone().trim().equals(""))
													 {
													   String formattedTelNo = searchUtil.removeSpecialChars(contactlowBidders.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(contactlowBidders.getContactPersonFax()!=null && !contactlowBidders.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactlowBidders.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
													   
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
										 String prev_contacttype = null;
										 int award_count = 0;  // keeps count of low bidders to print numbers
										 boolean printDetails = true; // Decides whether to print details for low-bidder or not.
										 itrAwards = awardsList.iterator();
										 while (itrAwards.hasNext())
										 {
											 award_count++;
							
											 common.bean.ExtractContact contactAwards = (common.bean.ExtractContact) itrAwards.next();
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
													 String company_name = contactAwards.getCompanyName().trim();
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
													 out.println(award_count+"</b>. "+company_name+"</a>");
								
													 BigDecimal amt = contactAwards.getLowBidAmount();
													 String lowbid_amount = null;
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
									
														 String fax_no = null;
														 Long fax_no_int = null;
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
																 out.println("FAX# "+wrapWithAnchor(fax_no,searchUtil.keywordHighlight(fax_no,cKeyword),"tel"));
																 print_newline = true;
															 }
															 else
															 {
																 out.println("FAX# "+wrapWithAnchor(contactAwards.getFax1().trim()
																 			,searchUtil.keywordHighlight(contactAwards.getFax1().trim(),cKeyword),"tel"));
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
															 String formattedZip = ValidateNumber.formatZipCode(contactAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword));
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
															 Long tel_no_int = null;
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
																	 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
																	 print_newline = true;
																 }
																 else
																 {
																	 out.println(wrapWithAnchor(contactAwards.getTelephone1().trim()
																	 			,searchUtil.keywordHighlight(contactAwards.getTelephone1().trim(),keyword),"tel"));
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
																		 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
																		 print_newline = true;
																	 }
																	 else
																	 {
																		 out.println(wrapWithAnchor(contactAwards.getTelephone2().trim()
																		 			,searchUtil.keywordHighlight(contactAwards.getTelephone2().trim(),keyword),"tel"));
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
													   <a href="mailto:<%=contactAwards.getContactPersonEmail()%>"><%=contactAwards.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactAwards.getContactPersonName()!=null && !contactAwards.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactAwards.getContactPersonName().trim()+"</b>");
													 }
													 if(contactAwards.getContactPersonPhone()!=null && !contactAwards.getContactPersonPhone().trim().equals(""))
													 {
													   String formattedTelNo = searchUtil.removeSpecialChars(contactAwards.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(contactAwards.getContactPersonFax()!=null && !contactAwards.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactAwards.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
													   
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
										 String prev_contacttype = null;
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
													 String company_name = contactsubAwards.getCompanyName().trim();
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
													  out.println(searchUtil.keywordHighlight(company_name,cKeyword));
								
								
													 BigDecimal amt = contactsubAwards.getLowBidAmount();
													 String lowbid_amount = null;
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
													 String fax_no = null;
													 Long fax_no_int = null;
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
															 out.println("FAX# "+wrapWithAnchor(fax_no,searchUtil.keywordHighlight(fax_no,cKeyword),"tel"));
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+wrapWithAnchor(contactsubAwards.getFax1().trim()
															 		,searchUtil.keywordHighlight(contactsubAwards.getFax1().trim(),cKeyword),"tel"));
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
															 String formattedZip = ValidateNumber.formatZipCode(contactsubAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword) );
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
														 Long tel_no_int = null;
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
																 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(wrapWithAnchor(contactsubAwards.getTelephone1().trim()
																 			,searchUtil.keywordHighlight(contactsubAwards.getTelephone1().trim(),cKeyword),"tel"));
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
																 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
																 print_newline = true;
															 }
															 else
															 {
																 out.println(wrapWithAnchor(contactsubAwards.getTelephone2().trim()
																 		,searchUtil.keywordHighlight(contactsubAwards.getTelephone2().trim(),cKeyword),"tel"));
																 
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
													   <a href="mailto:<%=contactsubAwards.getContactPersonEmail()%>"><%=contactsubAwards.getContactPersonName().trim()%></a>
													   <%
													 }
													 else if(contactsubAwards.getContactPersonName()!=null && !contactsubAwards.getContactPersonName().trim().equals(""))
													 {
													 
													   out.println("<b>"+contactsubAwards.getContactPersonName().trim()+"</b>");
													 }
													 if(contactsubAwards.getContactPersonPhone()!=null && !contactsubAwards.getContactPersonPhone().trim().equals(""))
													 {
													   String formattedTelNo = searchUtil.removeSpecialChars(contactsubAwards.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(contactsubAwards.getContactPersonFax()!=null && !contactsubAwards.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactsubAwards.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
													   
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
						  String privateDisclaimer = 
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
							 ArrayList indexList = new ArrayList();
							
							 int i = 0;
				
							 // Search for "GENERAL CONTRACTOR" in the list. Print first.
							 String generalcontKeyWords = "<b><font face='verdana,arial' size='1' >GENERAL CONSTRUCTION</b></font>";
				               
							 
				
							 // header keeps track of any titles that need to be printed for a group of planholders
							 // Print GENERAL CONTRACTOR first.
							 String prev_contacttype = null;
							 itrBidder = planHoldersList.iterator();
							 while (itrBidder.hasNext())
							 {
								 common.bean.ExtractContact contactPlanHolders = (common.bean.ExtractContact) itrBidder.next();
								 String contactType = contactPlanHolders.getContactTypeText().trim();
								 
								
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
											 String company_name = contactPlanHolders.getCompanyName().trim();
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
											 	String contactAddedDate = contactPlanHolders.getAddedDate();
												String lastEnteredDate = cbean.getLastEnteredDate();
												
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
												 String addedDate =
													 ValidateDate.getDateFromDBDate(contactPlanHolders.getAddedDate());
												 String webPublishyDate =
													 ValidateDate.getDateFromDBDate(cbean.getentryDate());
					
												 // If added date is greater, print a plus sign
												 if (ValidateDate.compareDates(addedDate, webPublishyDate)
													 == 0 && cbean.getUpdatedFlag().equals("U") )
												 {
													 printPlusSign = true;
													
												 }
												
											 }*/
					
											 //fHH.getWebFileWriter().write("<b>"+company_name+"</b>");
											 
											 // Project Contact Link change
											 out.println("<b><font face='verdana,arial' size='1' ></b>");
					
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
												 String formattedZip = ValidateNumber.formatZipCode(contactPlanHolders.getZip().trim());
												 if (formattedZip != null)
													 out.println(searchUtil.keywordHighlight(formattedZip,cKeyword) );
											 }	 
											 
																 
												 String tel_no = null;
												 Long tel_no_int = null;
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
															 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword) ,"tel"));
														 }
														 else
														 {
															 out.println(wrapWithAnchor(contactPlanHolders.getTelephone1().trim()
															 			,searchUtil.keywordHighlight(contactPlanHolders.getTelephone1().trim(),cKeyword),"tel"));
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
													 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
												 }
												 else
												 {
													 out.println(wrapWithAnchor(contactPlanHolders.getTelephone2().trim()
													 			,searchUtil.keywordHighlight(contactPlanHolders.getTelephone2().trim(),cKeyword),"tel"));
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
												 Iterator listitr = indexList.iterator();
												 while (listitr.hasNext())
												 {
													 if (planHoldersCounter == ((Integer)listitr.next()).intValue())
														 continue outerloop;
												 }
												 // When the code reach here, will print the rest of Plan Holders.
												 common.bean.ExtractContact contactPlanHoldersOthers = (common.bean.ExtractContact)planHoldersList.get(planHoldersCounter);
												 
												 
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
												 String company_name = contactPlanHoldersOthers.getCompanyName().trim();
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
													 String addedDate =
														 ValidateDate.getDateFromDBDate(contactPlanHoldersOthers.getAddedDate());
													 String lastentryDate =
														 ValidateDate.getDateFromDBDate(cbean.getLastEnteredDate());
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
												 out.println("<b>");
						
												 if (printPlusSign)
													 out.println("+");
						
												 out.println(searchUtil.keywordHighlight(company_name,cKeyword)+"</b>"+"</a>");
						
											 }
											 
											     String fax_no = null;
												 Long fax_no_int = null;
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
														 out.println(" FAX# "+wrapWithAnchor(fax_no,searchUtil.keywordHighlight(fax_no,cKeyword),"tel")+"<BR>");
													 }
													 else
													 {
														 out.println(" FAX# "+wrapWithAnchor(contactPlanHoldersOthers.getFax1().trim()
														 			,searchUtil.keywordHighlight(contactPlanHoldersOthers.getFax1().trim(),keyword),"tel")+"<BR>");
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
														 String formattedZip = ValidateNumber.formatZipCode(contactPlanHoldersOthers.getZip().trim());
														 if (formattedZip != null)
															 out.println(searchUtil.keywordHighlight(formattedZip,keyword));
													 }
                                                     String tel_no = null;
													 Long tel_no_int = null;
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
															 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,keyword),"tel"));
														 }
														 else
														 {
															 out.println(wrapWithAnchor(contactPlanHoldersOthers.getTelephone1().trim()
															 			,searchUtil.keywordHighlight(contactPlanHoldersOthers.getTelephone1().trim(),cKeyword),"tel"));
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
													 out.println(wrapWithAnchor(tel_no,searchUtil.keywordHighlight(tel_no,cKeyword),"tel"));
												 }
												 else
												 {
													 out.println(wrapWithAnchor(contactPlanHoldersOthers.getTelephone2().trim()
													 			,searchUtil.keywordHighlight(contactPlanHoldersOthers.getTelephone2().trim(),cKeyword),"tel"));
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
													   <a href="mailto:<%=contactPlanHoldersOthers.getContactPersonEmail()%>"><%=contactPlanHoldersOthers.getContactPersonName().trim()%></a>
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
													   String formattedTelNo = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getContactPersonPhone().trim());
													   formattedTelNo = ValidateNumber.formatPhoneNumber(formattedTelNo);
													   out.println(",Phone#:"+wrapWithAnchor(formattedTelNo,formattedTelNo,"tel"));
													   
													 }
													 if(contactPlanHoldersOthers.getContactPersonFax()!=null && !contactPlanHoldersOthers.getContactPersonFax().trim().equals(""))
													 {
													   String formattedFaxNo = searchUtil.removeSpecialChars(contactPlanHoldersOthers.getContactPersonFax().trim());
													   formattedFaxNo = ValidateNumber.formatPhoneNumber(formattedFaxNo);
													   
													   out.println(",Fax#:"+wrapWithAnchor(formattedFaxNo,formattedFaxNo,"tel"));
						
											 }

                                              out.println("<br>");
																		 
															
									 } // End of outerloop.
								 } // End of checking the rest of planholders.
							 } // End of checking planholderslist.
						

					   
					  
					  
					  
					  
					  	
						%>
                </td>
              </tr>
             
              <TR> 
                <!--<TD height="30" colspan="6"></TD>-->
				<TD height="10" colspan="6"></TD>
              </TR>
              <TR> 
                <TD colspan="6" ALIGN="left" class="black10px"> 
				<table>
                    <!--THIS IS FOR DISPLAY FOR FIRST REPORTED DATE-->
                    <tr> 
                      <td class="black10px" ALIGN="center"> 
                        <%
	                       String CDCIDVal=cbean.getCDCID();
						  String year[]={"A1990", "B1991","C1992","D1993","E1994","F1995","G1996","H1997",
										   "I1998","J1999","K2000","L2001","M2002","N2003","P2004","Q2005","R2006","S2007","T2008","U2009","V2010","W2011","X2012","Y2013","Z2014"};
					      String Year=null;

 							if(CDCIDVal!=null)  
						   {
							 String cdcID =CDCIDVal;
							 int len=cdcID.length();
							 cdcID=cdcID.substring(len-9,len);
							 String mon=null;
							 String yr=null;
							 String newCdcID=null;
							 String day=null;
							
							  if(ValidateNumber.isNumber(cdcID)==true)
							  {
							   
								cdcID=CDCIDVal.substring(len-10,len);
								}
							  else
							  
							  {
							    cdcID=CDCIDVal.substring(len-8,len);
								
							  
							  }
							  
							 mon=cdcID.substring(1,3);
							 day = cdcID.substring(3,5);
							 yr = cdcID.substring(0,1);
							 for(int i=0; i<year.length; i++)
							 {
							   if(year[i].startsWith(yr))
							   {
								 Year=year[i].substring(1,5);
							   }
							 }
							 
						     Date tempDate  = null;
							 String dateStr=mon+day+Year;
							 String returnDate = null;
							 String dateFormat1 =  "MMddyyyy";
							 Locale usLocalee=new Locale("EN","us");
							 SimpleDateFormat sdff = new SimpleDateFormat(dateFormat1, usLocalee);
							 tempDate = sdff.parse(dateStr);
							 dateFormat1 = "MMMM d, yyyy";
							 sdff = new SimpleDateFormat(dateFormat1, usLocalee);
							 returnDate = sdff.format(tempDate);
							 out.println("First Reported "+returnDate);

							 
						}		 
			
			
	                %>
                      </td>
                    </tr>
					</table>
					</TD>
					</TR>
                   <!--THIS IS FOR DISPLAY OF FINAL PUBLISH DATE-->
                    <TR> 
                      <TD class="black10px"  align="left" height="15"> 
                        <%
						 if(cbean.getFinalPublishDate()!=null)
							  {
							   Locale usLocale=new Locale("EN","us");
			     		       SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				               Date tempdate=sdf.parse(cbean.getFinalPublishDate());
				               sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			   String convertedDate=sdf.format(tempdate);
							
							  
							    out.println("<font face='verdana,arial' size='1' >");
								out.println("Final Published "+ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate))+"</font>");
							  }
							   else 
							  {
							    
								Locale usLocale=new Locale("EN","us");
			     		        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				                Date tempdate=sdf.parse(cbean.getentryDate());
				                sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			    String convertedDate=sdf.format(tempdate);
								if(cbean.getUpdatedFlag().equals("N"))
								{
							    	out.println("First Published "+ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate).toLowerCase()));
								} 	
							    else
								{
								   out.println("Last Published "+ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate).toLowerCase()));
								   //  out.println(convertedDate);
								}
							  }
							%>
                      </TD>
                    </TR>
					<!--<tr>
						<td>
							<table border="0" cellpadding="0" cellspacing="0">
								  <tr>
									  <td>
										  <table width="460">
										  <tr>
											<td class="black10px" ALIGN="center" colspan="6"> ©COPYRIGHT <%out.print(ValidateDate.getCurrentYear());%>, CONSTRUCTION DATA COMPANY, ALL RIGHTS RESERVED. This material 
											  may not be published, broadcast, rewritten or distributed. 
											</td>
										  </tr>
										</table>
									</td>
								</tr>
						   
						  	</table>
						</td>
					</tr>-->
					</table>
					</td>
					</TR>
					</table>
					</td>
					</tr>
					</table>
					</td>
					</tr>
                    <%}%>
			  <%if(contentList.size()>0)  { %>
			  
		  
		 
		<%}else{out.println("NO RECORD FOUND");}%>	 

	</td>
<!--<td>
	<table cellpadding="0" cellspacing="0" style="font-size:12px;margin-bottom:-10px;" width="472" align="center">
		<tr align="left">
		<td align="left" width="30%">
			<img src="http://lm.cdcnews.com/images/cdcnews_logo_site.gif" border="0" width="90" height="48" />
		</td>
		<td align="center" width="40%" style="font-size:14px;">
		<%
			//if(companyName != null)
			//{
		%>
			<b><i><%//=companyName%></i></b>
		<%
			//}
			//if(fName != null || lName != null)
			//{
		%>
			<br><i>Attention:<%//=fName+" "+lName%></i>
		<%
			//}
		%>
		</td>
		<td align="right" width="30%" style="font-size:11px;">
			<i><%//=ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(runDate))%></i><br>
			<i>Saved Search Name:
			<br>
			<b><%//=ssName%></b></i>
		</td>
		</tr>
	</table>
</td>-->

</table>

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
</body>

<link rel="stylesheet" href="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/development-bundle/themes/base/jquery.ui.all.css" />
<script src="<%=request.getContextPath()%>/jquery-ui-1.8.16.custom/jquery-1.11.3.min.js" type="text/javascript"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/jquery.colorbox.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/JSScripts/Javascript_template.js"></script>
<script src="<%=request.getContextPath()%>/js/JSScripts/global.js?v=4.6" type="text/javascript"></script>
</html>	 
