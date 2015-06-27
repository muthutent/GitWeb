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
   Modifier       : Sathish 
   Description    : Prints the selected job to the printer
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<%@ page import="java.util.*,datavalidation.*,java.util.Map,java.lang.StringBuffer,java.math.BigDecimal,com.ContentBean,com.ContactBean,java.net.URLEncoder,java.util.Date,datavalidation.*,javax.swing.text.DateFormatter,java.text.*,java.rmi.*,common.bean.*,javax.rmi.*,java.sql.*,javax.naming.*,javax.ejb.*,flashgateway.samples.ejb.*,content.*" errorPage="error.jsp"%>
<%!
String keyword=null;
%>

<%
	 Map map=null;
	 String id=request.getParameter("cid");
     map = (java.util.Map) session.getAttribute("cdcnews");
	 Content contentID=null;
	 //contentID=(Content)map.get("ID");
	
	 //out.println("IDList"+contentID);
	 Properties cProp = new Properties();
	 cProp.put(Context.INITIAL_CONTEXT_FACTORY,"jrun.naming.JRunContextFactory");
	 cProp.put(Context.PROVIDER_URL,"localhost:2902");
	 Context contentCtx = new InitialContext(cProp);
	 Object contentObj = contentCtx.lookup("ContentEJBean");
	 
	 ContentHome contentHome = (ContentHome)PortableRemoteObject.narrow(contentObj,ContentHome.class);
	 contentID = contentHome.create();
	 ArrayList contentList=contentID.getContentList(id);
	 //out.println("size"+contentList.size());
	 Iterator contentIterator = contentList.iterator();
	 while(contentIterator.hasNext())
	 {
	  common.bean.ContentBean cbean=(common.bean.ContentBean)contentIterator.next();
	 // out.println("id"+cbean.getCDCID());
	 
	  
	 
	
	
	
	
	
	
	
	//ContentBean cbean = (ContentBean)request.getAttribute("cbean");
	Iterator itr = null;
	Iterator itrOwner = null;
	Iterator itrBidder = null;
	Iterator itrAwards = null;
	Iterator itrLowBidder = null;
	Iterator itrSubAwards = null;
	ArrayList scope_title_list = (ArrayList)cbean.getProjectScopeOfWork();
	ArrayList division_name_list = (ArrayList)cbean.getDivision_name_list();
	ArrayList ownersList = cbean.getOwners();
	ArrayList planHoldersList = cbean.getPlanHolders();
	ArrayList awardsList = cbean.getAwards();
	ArrayList lowBiddersList = cbean.getLowBidders();
	ArrayList subAwardsList = cbean.getSubAwards();
	
		
	if(map.get("lastkey_to_highlight")!=null)
	{
	 keyword=(String)map.get("lastkey_to_highlight");
	}
		
%>
<%!

 /**
      *  Removes special characters from phone numbers and zip codes
      */
     public String removeSpecialChars(String str)
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
     }
	 
	 
	  


/******************************THIS IS A METHOD FOR KEYWORD HIGHLIGHTER******************************/

/*public String keywordHighlight(String originalTxt,String Keyword)
    {
      String[] kword=null;
      kword=Keyword.split("\\,");
      for(int i=0;i<kword.length;i++)
      {
       kword[i]=kword[i].replaceAll("\\*","");
       originalTxt=originalTxt.replaceAll(kword[i].trim().toUpperCase(),"<b style=color:black;background-color:FFFF66>"+kword[i].trim().toUpperCase()+"</b>");
      }
    
    return originalTxt;
    
    }*/
	 public String keywordHighlight(String originalTxt,String Keyword)
	    {
	      String[] kword=null;
	      kword=Keyword.split("\\,");
	      for(int i=0;i<kword.length;i++)
	      {
	       kword[i]=kword[i].replaceAll("\\*","");
	       originalTxt=originalTxt.toUpperCase().replaceAll(kword[i].trim().toUpperCase(),"<b style=color:black;background-color:FFFF66>"+kword[i].trim().toUpperCase()+"</b>");
	      }
	    
	    return originalTxt;
	    
	    }

%>

<script language="JavaScript">
function doPrint()
{
	//self.moveTo(200,200);
  	self.print();
  	var is_chrome = navigator.userAgent.toLowerCase().indexOf('chrome') > -1;
	if(!is_chrome)
	{
		self.close(); 
	}
}	
function checkprintboxes(singleboxflag)
{
	counter = document.mainform.jobscount.value;
	if (counter == 1)
	{
		if (singleboxflag == 0)
		{
			if (document.mainform.printalljobs.checked)
				document.mainform.printjobs.checked = true;
			else
				document.mainform.printjobs.checked = false;
		}
		else
		{
			if (document.mainform.printjobs.checked)
				document.mainform.printalljobs.checked = true;
			else
				document.mainform.printalljobs.checked = false;
		}
	}
	else
	{
		if (singleboxflag == 0)
		{
			if (document.mainform.printalljobs.checked)
			{
				for (var i = 0; i < counter; ++i)
				{
					document.mainform.printjobs[i].checked = true
				}
			}
			else
			{
				for (var i = 0; i < counter; ++i)
				{
					document.mainform.printjobs[i].checked = false
				}
			}
		}
		else
		{
			allflag = 0;
			for (var i = 0; i < counter; ++i)
			{
				if (!document.mainform.printjobs[i].checked)
				{
					allflag = 1;
					break;
				}
			}
			if (allflag == 1)
				document.mainform.printalljobs.checked = false
			else
				document.mainform.printalljobs.checked = true
		}
	}

}
</script>

<html>
<head>
<title>CDCNews details job display</title>
<link rel="stylesheet" type="text/css" href="/sheet.css">
<link href="../sheet.css" rel="stylesheet" type="text/css">
</head>
<BODY LEFTMARGIN="2" TOPMARGIN="2" RIGHTMARGIN="0" BOTTOMMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" onLoad="doPrint()">
<FORM ACTION="" NAME="mainform" METHOD="post">
<table border="0" cellspacing="0" cellpadding="0" >
	<TR>
		<TD>
			<table border="0" cellpadding="0" cellspacing="0" width="440">		
				<tr>								
					<td>		
		
						<table border="0" cellpadding="0" cellspacing="0"  WIDTH="100%">
						    <!--DISPLAY OF THE PROJECT TITLE-->
          					  
							<!-- <TR> 
								  <td  width="345" ALIGN="center" class="black10px"> </TD>
								  <td width="36" ALIGN="center" class="black10px"><img src="../cdc/online_product/images/button_pt_icn.gif" border="0" ></TD>
								  <td width="36" ALIGN="center" class="black10px"> <img src="../cdc/online_product/images/button_print_icn.gif" border="0" ></TD>
								  <td width="30"  valign="bottom" class="black10px"><div align="center"><STRONG>Map</STRONG></div></TD>
							</TR>-->
			
							<!-- DISPLAY OF THE PROJECT CDCID-->
							
							<TR>
								<TD CLASS="black11px" >
									
									
								</td>
							</TR>
							<tr > 
							  <td   align="center" class="black12px"> 
								<%
								if( cbean.getCDCID() != null )
								{
                                   //String testString=keywordHighlight(cbean.getStateName(),keyword);
									out.println("<B>"+cbean.getCDCID());
									//out.println("test String"+testString+"end");
									
									
								}
									
								%>
							  </TD>
							</TR>
			                <!-- THIS IS FOR SUBSECTION-->
			
							<tr> 
								<td    height="1" > </td>
							</tr>
							<tr > 
							
							  <td  class="black12px" align="center"> 
								<%
								if( cbean.getSubSection() != null ){
									out.println("<B>BID STAGE:"+cbean.getSubSection());
								}
								//out.println(cbean.getSub_section() );
								%>
							  </TD>
							</TR>
							<tr> 
             					 <td height="20" colspan="4" class="black12px" > 
               						 <b><%
											out.println(cbean.getTitle());
										%></b>
              					</TD>
           					 </TR>
			                	<!-- THIS IS FOR TITLE-->
							<TR> 
							<TR> 
							  <td colspan="4" class="black10px">
								<%
									//String title=cbean.getTitle().toLowerCase();
									out.println("<B>"+cbean.getCity() + ",");
									//out.println(cbean.getState_id());
									
									/*Commented for time being------------*/
									//out.println(cbean.getStateName().toLowerCase());
									out.println("(" + cbean.getCounty().toLowerCase() +")");
									
									
								%>
							  </TD>
							</TR>
							<tr > 
							  <td  colspan="4"   class="black10px"> 
								<%
								if( cbean.getCDCID() != null )
								{
                                   //String testString=cbean.getStateName();
									out.println("<B>CDC# "+cbean.getCDCID());
									//out.println("test String"+testString+"end");
									
									
								}
									
								%>
							  </TD>
							</TR>
							  <td colspan="4" class="black10px"> 
								<%
										out.println("<b><font face='verdana,arial' size='1' color='800000'>");
										out.println(cbean.getTitle());
										
										out.println("</font></b>");
											
								%>
							  </TD>
							</TR>
							<TR> 
							  <td colspan="4" class="black10px"><b><font face='verdana,arial' size='1' color='800000'>LOCATION 
								: </font></b> 
								<%
									//String title=cbean.getTitle().toLowerCase();
									out.println(cbean.getCity() + ",");
									//out.println(cbean.getState_id());
									
									/*Commented for time being------------*/
									//out.println(cbean.getStateName().toLowerCase());
									out.println("(" + cbean.getCounty().toLowerCase() +")");
									out.println(cbean.getStreetAdd().toLowerCase());
									
								%>
							  </TD>
							</TR>
			                <!-- THIS IS FOR ESTIMATED AMOUNT DETAILS-->
			
							<TR> 
							  <td colspan="4" class="black10px"><b><font face='verdana,arial' size='1' color='800000'>ESTIMATED 
								AMOUNT : </font></b> 
								<% if(cbean.getEstimatedAmountLower()>0){
									String amount_lower=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountLower());
									out.println("$" + ValidateNumber.formatAmountString(amount_lower)); 
								}
								if((cbean.getEstimatedAmountLower()>0) && (cbean.getEstimatedAmountUpper()>0)){
									out.println("to " );
								}
								
								if(cbean.getEstimatedAmountUpper()>0){
									String amount_upper=ValidateNumber.formatDecimalAmount(cbean.getEstimatedAmountUpper());
									out.println("$" + ValidateNumber.formatAmountString(amount_upper));
								}
								
					
								%>
							  </TD>
						 </TR>	  
						    <!-- THIS IS FOR CONTRACTING METHOD DETAILS-->
							<TR> 
							  <td colspan="4" class="black10px"> 
								<%
								if( cbean.getConMethod() != null){
								out.println("<b><font face='verdana,arial' size='1' color='800000'>");
								out.println("CONTRACTING METHOD:  " );
								out.println("</font></b>");
							
								 out.println(cbean.getConMethod().toLowerCase());
								}
								
									//out.println(cbean.getCon_method());				
					
								%>
							  </TD>
							   
							</TR>
							<tr>
							  <td>
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
												 String company_name = currentContact.getCompanyName().trim();
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
												 out.println
													 ("<b><font face='verdana,arial' size='1' color='800000'>"+contactType.toUpperCase()+":</b> "
													 +"<a href=\"../list_contact_projects.cfm?contact_id="
													 +currentContact.getContactID()
													 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
													 +" target=\"_self\">"
													 +company_name+"</a>");
													 boolean print_newline = false;
													 out.println("<br>");
												 if (currentContact.getAddress1() != null)
												 {
													 out.println(currentContact.getAddress1().trim());
													 print_newline = true;
												 }
												 if (currentContact.getCity() != null)
												 {
													 out.println(", "+currentContact.getCity().trim());
													 print_newline = true;
												 }
												 if (currentContact.getAddress1() != null || currentContact.getCity() != null)
												 {
													 out.println(", "+currentContact.getStateCode().trim());
													 print_newline = true;
												 }
												 if (currentContact.getZip() != null && !currentContact.getZip().trim().equals(""))
												 {
							
													 // New Zip Code Formatting Logic
													 String formattedZip = ValidateNumber.formatZipCode(currentContact.getZip().trim());
													 if (formattedZip != null)
													 {
														 out.println(" " + formattedZip);
														 print_newline = true;
													 }
												 }
												
												 if (print_newline)
												 {
													 out.println("<br>");
												 }
							
											   if (currentContact.getTelephone1() != null && !currentContact.getTelephone1().trim().equals(""))
												 {
													 String formattedTel = removeSpecialChars(currentContact.getTelephone1().trim());
													 BigDecimal phone_int = null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 }
							
													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println(formattedTel+" ");
													 }
													 else
													 {
														 out.println(currentContact.getTelephone1().trim()+" ");
													 }
												 }
												 
												  // Print telephone 2 if telephone 1 is missing.
												 if (currentContact.getTelephone1() == null &&
													 currentContact.getTelephone2() != null &&
													 !currentContact.getTelephone2().trim().equals(""))
												 {
													 String formattedTel = removeSpecialChars(currentContact.getTelephone2().trim());
													 BigDecimal phone_int = null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 }
							
													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println(formattedTel+" ");
													 }
													 else
													 {
														 out.println(currentContact.getTelephone2().trim()+" ");
													 }
												 }
												  if (currentContact.getFax1() != null && !currentContact.getFax1().trim().equals(""))
												 {
													 String formattedTel = removeSpecialChars(currentContact.getFax1().trim());
													 BigDecimal phone_int = null;
													 try
													 {
														 phone_int = new BigDecimal(formattedTel);
													 }
													 catch (Exception e)
													 {
													 }
							
													 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
													 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
													 {
														 out.println("FAX# "+formattedTel);
													 }
													 else
													 {
														 out.println("FAX# "+currentContact.getFax1().trim()+" ");
													 }
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
													 String contactTypeOthers = contactOthers.getContactTypeText().trim();
							
													 /*// For printing company name, check if there's any semi-colon. If there is any,
													 // parse it and print text on the right of semicolon to the left of company name.*/
													 String companyNameOthers = contactOthers.getCompanyName().trim();
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
													 out.println("<b><font face='verdana,arial' size='1' color='800000'>"+contactTypeOthers.toUpperCase()+":</b> "
														 +"<a href=\"../list_contact_projects.cfm?contact_id="
														 +contactOthers.getContactID()
														 +"&contact_name="+ URLEncoder.encode(companyNameOthers)+"\""
														 +" target=\"_self\">"
														 +companyNameOthers+"</a>");
													out.println("<br>");
														 
														  boolean print_newline = false;
													 if (contactOthers.getAddress1() != null)
													 {
														 out.println(contactOthers.getAddress1().trim());
														 print_newline = true;
													 }
							
													 if (contactOthers.getCity() != null)
													 {
														 out.println(", "+contactOthers.getCity().trim());
														 print_newline = true;
													 }
							
													 if (contactOthers.getAddress1() != null || contactOthers.getCity() != null)
													 {
														 out.println(", "+contactOthers.getStateCode().trim());
														 print_newline = true;
													 }
							
													 if (contactOthers.getZip() != null && !contactOthers.getZip().trim().equals(""))
													 {
														 String formattedZip = ValidateNumber.formatZipCode(contactOthers.getZip().trim());
														 if (formattedZip != null)
														 {
															 out.println(" " + formattedZip);
															 print_newline = true;
														 }
													 }
													  if (print_newline)
													 {
														 out.println("<br>");
													 }
													  if (contactOthers.getTelephone1() != null && !contactOthers.getTelephone1().trim().equals(""))
													 {
														 String formattedTel = removeSpecialChars(contactOthers.getTelephone1().trim());
														 BigDecimal phone_int = null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 }
							
														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println(formattedTel+" ");
														 }
														 else
														 {
															 out.println(contactOthers.getTelephone1().trim()+" ");
														 }
													 }
													   // Print telephone2 if telephone1 is missing
													 if (contactOthers.getTelephone1() == null &&
														 contactOthers.getTelephone2() != null &&
														 !contactOthers.getTelephone2().trim().equals(""))
													 {
														 String formattedTel = removeSpecialChars(contactOthers.getTelephone2().trim());
														 BigDecimal phone_int = null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 }
							
														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println(formattedTel+" ");
														 }
														 else
														 {
															 out.println(contactOthers.getTelephone2().trim()+" ");
														 }
													 }
													if (contactOthers.getFax1() != null && !contactOthers.getFax1().trim().equals(""))
													 {
														 String formattedTel = removeSpecialChars(contactOthers.getFax1().trim());
														 BigDecimal phone_int = null;
														 try
														 {
															 phone_int = new BigDecimal(formattedTel);
														 }
														 catch (Exception e)
														 {
														 }
							
														 formattedTel = ValidateNumber.formatPhoneNumber(formattedTel);
							
														 if (formattedTel != null && phone_int != null && phone_int.intValue() != 0)
														 {
															 out.println("FAX# "+formattedTel);
														 }
														 else
														 {
															 out.println("FAX# "+contactOthers.getFax1().trim()+" ");
														 }
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
								   
			             <!-- THIS IS FOR SUFFIX  DETAILS-->
			   
					   <TR> 
						 <TD colspan="4" class="black10px"> 
									<%
										if( cbean.getSuffixText() != null)
										{
											out.println("<b><font face='verdana,arial' size='1' color='800000'>");
											out.println("STATUS:  " );
											out.println("</font></b>");
											out.println(cbean.getSuffixText());
										}
									%>
					   </TD>
					</TR>  
			
			
					 <!-- THIS IS FOR START DATE DETAILS-->
					  <TR> 
						 <TD colspan="4" class="black10px"> 
								<%
								if(cbean.getEstimatedStartDate()!=null && cbean.getEstimatedStartDate().equals("")==false)
								{
								 
								 Locale usLocale=new Locale("EN","us");
								 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
								 Date tempdate=sdf.parse(cbean.getEstimatedStartDate());
								 sdf=new SimpleDateFormat("MM-dd-yy",usLocale);
								 String cd=sdf.format(tempdate);
								 out.println("<b><font face='verdana,arial' size='1' color='800000'>");
								 out.println("Start Date:  ");
								 out.println("</font></b>");
								 out.println(ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd)));
								}
								
								
											
					
								%>
					  </TD>
					</TR>  
			
					 <!-- THIS IS FOR  END DATE DETAILS-->
					 <TR> 
					  <td colspan="4" class="black10px"> 
						<%
						if(cbean.getEstimatedEndDate()!=null && cbean.getEstimatedEndDate().equals("")==false)
						{
						 //String formattedStrtDt = ValidateDate.ValidateDate.formatPrintableDate(ValidateDate.getDateFromDBDate(cbean.getEstimatedStartDate()));
						 Locale usLocale=new Locale("EN","us");
						 SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
						 Date tempdate=sdf.parse(cbean.getEstimatedEndDate());
						 sdf=new SimpleDateFormat("MM-dd-yy",usLocale);
						 String cd=sdf.format(tempdate);
						 out.println("<b><font face='verdana,arial' size='1' color='800000'>");
						 out.println("End Date:  ");
						 out.println("</font></b>");
						// out.println();
						 out.println(ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd)));
						}
						
						
									
			
						%>
					  </TD>
					</TR>  
			
						 <!-- THIS IS FOR NO OF DAYS-->
						
						<TR> 
						  <td colspan="4" class="black10px"> 
							<%
							
							//String formattedStrtDt = ValidateDate.ValidateDate.formatPrintableDate(cbean.getEstimatedStartDate().trim());
							if( cbean.getCompletionDays() != null && cbean.getCompletionDays().equals("")==false){
							out.println("<b><font face='verdana,arial' size='1' color='800000'>");
							out.println("No of Days:  ");
							out.println("</font></b>");
							
							 out.println((cbean.getCompletionDays()));
							}
							
												
				
							%>
						  </TD>
						</TR>  
						<!--DISPLAY FOR PROJECT COMPLETION DAYS-->
						<TR> 
						  <td colspan="4" class="black10px"> 
							<%
							
							
							if( cbean.getProjCompletion() != null && cbean.getProjCompletion().equals("")==false){
							out.println("<b><font face='verdana,arial' size='1' color='800000'>");
							out.println("% Comp:  ");
							out.println("</font></b>");
							
							 out.println((cbean.getProjCompletion()));
							}
							
											
				
							%>
						  </TD>
						</TR>  
			
			  
			           <!--DISPLAY OF THE PROJECT BIDS DETAILS-->
			  
						<TR> 
						  <td colspan="4" class="black10px"> 
							<%
							if( cbean.getBidsDetails() != null && cbean.getBidsDetails().equals("")==false)
							{
								out.println("<b><font face='verdana,arial' size='1' color='800000'>");
								out.println("BIDS DUE:  ");
								out.println("</font></b>");
								out.println(cbean.getBidsDetails());
								
							}
								
				
							%>
						  </TD>
						  
					  </TR>
					   <%
						boolean boolean_size = false;
						if( (cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
						|| (cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
						|| (cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
						|| (cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
						){%>
						<TR> 
						  <td colspan="4" class="black10px"> 
						   <%
								out.println("SIZE : ");
								boolean_size=true;
							}
							
							StringBuffer sqft_story_text = new StringBuffer();
								int counter=0;
							if( cbean.getConst_new() != null &&	cbean.getConst_new().equals("Y"))
							{
								out.println();
								
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			                      
								 sqft_story_text.append("<b>"+"New Construction"+ ",</b>");
								
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
							if( cbean.getConst_ren() != null && cbean.getConst_ren().equals("Y"))
							{
								//StringBuffer sqft_story_text = new StringBuffer();
								//int counter=0;
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b>"+"Renovation"+ ",</b>");
								
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
							
							if( cbean.getConst_alt() != null && cbean.getConst_alt().equals("Y"))
							{
								out.println();
							//	StringBuffer sqft_story_text = new StringBuffer();
							  //  int counter=0;
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b>"+"Alteration"+ ",</b>");
								
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
							if( cbean.getConst_add() != null && cbean.getConst_add().equals("Y"))
							{
							//	StringBuffer sqft_story_text = new StringBuffer();
							 //   int counter=0;
								if (sqft_story_text.length() > 0)
									 sqft_story_text.append("; ");
			
								 sqft_story_text.append("<b>"+"Addition"+ ",</b>");
								
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
							   if (sqft_story_text.length() > 0)
								{
									
									out.println(sqft_story_text.toString().toLowerCase()+"<br>");
								}
											
								if(boolean_size){
									//out.println(cbean.getTotalSqrft() + " " + cbean.getTotalSqrft());
									//out.println("Stories"+cbean.getTotalStories()+"SqftUnitTotal"+cbean.getSqrftTotalunit()+"Sqft Total:"+cbean.getTotalSqrft());
								%>
						
						   </TD>
						</TR>
					   <% }%>
				
			        <!-- THIS IS FOR SCOPE DETAILS--> 
						 <%
							if( (scope_title_list != null) && (scope_title_list.size()>0) ){%>   
						<TR> 
						  <td colspan="4" class="black10px"> 
						   <%
								out.println("SCOPE : ");
								itr = scope_title_list.iterator();
								//out.println("B 4 while-1");
								while(itr.hasNext()){
									out.println((String)itr.next());
								}
							%>
						  </TD>
						 </TR>
						<% }
				
%>
						
				
			 <!--DETAILS TABLE-USE FIELD COLUMN NAME-DETAILS1-->
				  <%  
					if(	((String)cbean.getDetail1()) != null && cbean.getDetail1().equals("")==false){%>
						 <TR> 
						  	<TD colspan="4" class="black10px"> 
								<%
									out.println("<b><font face='verdana,arial' size='1' color='800000'>");
									out.println("USE : ");
									out.println("</font></b>");
									out.println(cbean.getDetail1());
								%>	
							
						  </TD> 
					   </TR>
			  	
				<%	}
				%>
			   <!-- THIS IS FOR SPECIAL CONDITION 1 DETAILS-->
			   <TR> 
              		<TD colspan="4" class="black10px"> 
                		<%  
								if(	((String)cbean.getSpecialConditions1()) != null && cbean.getSpecialConditions1().equals("")==false)
								{
									out.println("<b><font face='verdana,arial' size='1' color='800000'>");
									out.println("Spec Cond : ");
									out.println("</font></b>");
									out.println(cbean.getSpecialConditions1());
								}
					  %>
              	</TD> 
			</TR>
			  			  <!-- THIS IS FOR SPECIAL CONDITION 2 DETAILS-->
			    <TR> 
            		  <TD colspan="4" class="black10px"> 
                		<%  
							if(((String)cbean.getSpecialConditions2()) != null && cbean.getSpecialConditions2().equals("")==false)
							{
								out.println("<b><font face='verdana,arial' size='1' color='800000'>");
								out.println("Spec Cond : ");
								out.println("</font></b>");
								out.println(cbean.getSpecialConditions2());
							}
					  %>
              		</TD> 
			  </TR>
			  <!-- THIS IS FOR MIEQ DETAILS-->
			   <TR> 
		              <TD colspan="4" class="black10px"> 
        			        <%  
								if(	((String)cbean.getMIEQText()) != null && cbean.getMIEQText().equals("")==false)
									{
										out.println("<b><font face='verdana,arial' size='1' color='800000'>");
										out.println("MIEQ : ");
										out.println("</font></b>");
										out.println(cbean.getMIEQText());
									}
							%>
              		</TD> 
			  </TR>
			  	 
			  <!--DISPLAY OF DIVISIONS-->
             <TR> 
              <TD colspan="4" class="black10px"> 
                <%
			
				HashMap hashmap = null;
				if(cbean.getHashmap() != null){
				out.println("DIVISION: ");
					hashmap = (HashMap)cbean.getHashmap();				
					
			
					ArrayList al = new ArrayList((Set)hashmap.keySet());
					Collections.sort(al);
					Iterator itr3 = al.iterator();
					
					boolean b = false;
						while(itr3.hasNext()){					
							String s = (String)itr3.next();
							out.println("<b>");
							out.println("Div"+s);							
							out.println("</b>");
							 	ArrayList al1 = (ArrayList)hashmap.get(s);
							    	Iterator itr2 = al1.iterator();									
							    	while(itr2.hasNext()){
							    		if(b){
										out.println(",");	
									}
																    	
								    out.println("<font face='verdana,arial' size='1' color='800000'>"+(String)itr2.next());
								    b=true;
							    	
							    	}//while					
							    	out.println(".");	
							    	
							    	
							%>
                <br> 
                <%
			
				b=false;
						}					
					
				}//if
				
			
			%>
              </TD>
            </TR>
			<!--DISPLAY OF  NOTES---->
			  <TR> 
		              <TD colspan="4" class="black10px"> 
        			        <%  
								if(	((String)cbean.getDetail3()) != null && cbean.getDetail3().equals("")==false)
								{
									out.println("<b><font face='verdana,arial' size='1' color='800000'>");
									out.println("NOTES : ");
									out.println("</font></b>");
									out.println(cbean.getDetail3());
								}
							%>
              		</TD> 
			  </TR>
			
			 <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE1-->
			 <TR> 
		           <TD colspan="4" class="black10px"> 
        	        <%
						if(	((String)cbean.getDetailTitle1()) != null && cbean.getDetailTitle1().equals("")==false)
						{
							out.println("<b><font face='verdana,arial' size='1' color='800000'>");
							out.println("CONTACT : ");
							out.println("</font></b>");
							out.println(cbean.getDetailTitle1());
					    }
					%>
              	</TD> 
			</TR>
			  
			   <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE2-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%
					if(	((String)cbean.getDetailTitle2()) != null && cbean.getDetailTitle2().equals("")==false)
					{
						out.println("<b><font face='verdana,arial' size='1' color='800000'>");
						out.println("CONTACT : ");
						out.println("</font></b>");
						out.println(cbean.getDetailTitle2());
					}
				%>
              </TD> 
		  </TR>
			  
			  
			   <!--DETAILS TABLE-CONTACTS FIELD COLUMN NAME-TITLE3-->
			 <TR> 
             	 <TD colspan="4" class="black10px"> 
               	 <%
					if(	((String)cbean.getDetailTitle3()) != null && cbean.getDetailTitle3().equals("")==false)
					{
						out.println("<b><font face='verdana,arial' size='1' color='800000'>");
						out.println("CONTACT : ");
						out.println("</font></b>");
						out.println(cbean.getDetailTitle3());
					}
				%>
              </TD> 
		  </TR>
		
		   <!--DISPLAY OF INDUSTRIES-->
			<TR> 
              <TD colspan="4" class="black10px"> 
                <%
					if( cbean.getIndustry() != null && cbean.getIndustry().equals("")==false)
						{
							out.println("Industry Type: " + cbean.getIndustry().toLowerCase() );
						}
			
			   %>
             </TD>
          </TR>
		 
		 
		  <TR> 
              <TD colspan="4" class="black10px"> 
                <%
					if( cbean.getSubindustry() != null && cbean.getSubindustry().equals("")==false)
					{
						out.println("Industry Sub Type: " + cbean.getSubindustry().toLowerCase() );
					}	
			
				%>
              </TD>
          </TR>
			<!--This is for PLANS-->
			<TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getplansAvailableDate()) != null && cbean.getplansAvailableDate().equals("")==false){
					 Locale usLocale=new Locale("EN","us");
     		         SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				     Date tempdate=sdf.parse(cbean.getplansAvailableDate());
					
				     sdf=new SimpleDateFormat("MM-dd-yy",usLocale);
				     String cd=sdf.format(tempdate);
					 
					 String dateFormatted=ValidateDate.getDateStringMMDDYY(cd);
					
					 out.println("<font face='verdana,arial' size='1' color='800000'>");
					 if(cbean.getplansAvailableFrom()!=null && cbean.getplansAvailableFrom().equals("")==false)
					 {
					  out.println("PLANS:"+cbean.getplansAvailableFrom());
					  
					 } 
					 if(ValidateDate.checkFromToDate(dateFormatted,ValidateDate.getTodayDateMMDDYY())==false)
                    {

                       out.println(", available on or about " +ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd)));
				   
                    }
					
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
		 </TR>
			<!-- THIS IS FOR PLAN DEPOSIT-->
			 <TR> 
        	      <TD colspan="4" class="black10px"> 
            	    <% 
					    String amount= Double.toString(cbean.getplanDeposit());
						
  						if(cbean.getplanDeposit()>0)
							{
								out.println("<font face='verdana,arial' size='1' color='800000'>");
								out.println("PLAN DEP :"+"$"+amount);
								out.println("</font>");
							}
				  %>
              </TD> 
		  </TR>
			  
			  
			  <!-- THIS IS FOR MAILING FEE DEPOSIT-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    String mailingFee= Double.toString(cbean.getmailingFee());
                     
				   
					if(cbean.getmailingFee()>0)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println("MAILING FEE :"+"$"+mailingFee);
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  
			    <!-- THIS IS FOR BID BOND PERCT-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
  
				   
					if(cbean.getbidBondPerct() != null && cbean.getbidBondPerct().equals("")==false)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println("BID BOND : "+cbean.getbidBondPerct()+"$");
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  
			  <!--Certified/Cashiers need to be incoporated here-->
			  
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    if(cbean.getCertCashFlag()!=null)
					{
                     	String certCashFlag=cbean.getCertCashFlag();
					 
				   
						if(certCashFlag.equals("Y")==true)
						{
							out.println("<font face='verdana,arial' size='1' color='800000'>");
							out.println("Certified/Cashiers Check");
					 		out.println("</font>");
						}
					}	
				%>
              </TD> 
			</TR>
			
			
			
			
			
			     <!-- THIS IS FOR BID BOND STD RANGE-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
  
				   
					if(cbean.getbidBondStdRange() != null && cbean.getbidBondStdRange().equals("")==false)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println(cbean.getbidBondStdRange());
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			
			
			 
			     <!-- THIS IS FOR PERF BOND -->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
  
				   
					if(cbean.getperfBondText() != null && cbean.getperfBondText().equals("")==false)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println("PERF BOND :"+cbean.getperfBondText()+"%");

					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			
			
			   <!-- THIS IS FOR PAYMENT BOND -->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
  
				   
					if(cbean.getpayBondPerct() != null && cbean.getpayBondPerct().equals("")==false)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println("PAYMENT BOND :"+cbean.getpayBondPerct()+"%");
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			
			
			  <!-- THIS IS FOR MAINTENANCE BOND -->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
  
				   
					if(cbean.getmaintBondPerct() != null && cbean.getmaintBondPerct().equals("")==false)
					{
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println("MAINT. BOND :"+cbean.getmaintBondPerct()+"%");
					
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  	
			  <!-- Print DBC Prequalification required-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				    
                     if(cbean.getdbcPreQualFlag()!=null)
					{
                     	String dbcPreQualFlag=cbean.getdbcPreQualFlag();
					 
				   
						if(dbcPreQualFlag.trim().equals("Y")==true)
						{
				   			out.println("<font face='verdana,arial' size='1' color='800000'>");
                            out.println("D.B.C. Pre-qualification required");
							out.println("</font>");
						}	
					
					
					
					}
				%>
              </TD> 
			  </TR>
			    <!-- Print 100% set aside for small business-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				   
                     if(cbean.getSmallBusinessFlag()!=null)
					{
                     	String smallBusinessFlag=cbean.getSmallBusinessFlag();
					 
				      
						if(smallBusinessFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' color='800000'>");
                            out.println("100% Set Aside for Small Business");
							out.println("</font>");
						}	
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			    <!-- Print WBE/MBE required-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				   
                     if(cbean.getWbeMbeFlag()!=null)
					{
                     	String WbeMbeFlag=cbean.getWbeMbeFlag();
					 
				      
						if(WbeMbeFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' color='800000'>");
                            out.println("WBE/MBE Required");
							out.println("</font>");
						}	
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			   <!-- Print prequalification required text-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				   
                     if(cbean.getpreQualFlag()!=null)
					{
                     	String preQualFlag=cbean.getpreQualFlag();
					 
				      
						if(preQualFlag.trim().equals("Y")==true)
						{
				   			
							out.println("<font face='verdana,arial' size='1' color='800000'>");
                            out.println("<b>"+"Pre-qualification Required"+"</b>");
							out.println("</font>");
						}	
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			    <!-- Print pre-qualification due date-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <% 
				   
                     if(cbean.getpreQualDate()!=null)
					{
                     	
					    Locale usLocale=new Locale("EN","us");
     		     		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				 		Date tempdate=sdf.parse(cbean.getpreQualDate());
				 		sdf=new SimpleDateFormat("MM-dd-yy",usLocale);
				 		String cd=sdf.format(tempdate);
				 		out.println("<b><font face='verdana,arial' size='1' color='800000'>");
				 
				 
						// out.println();
				 		out.println("<b>Pre-qualification due: "+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(cd))+"</b>");
						out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			
			 <!-- This is MBE-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getMBE()) != null && cbean.getMBE().equals("")==false){
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println(cbean.getMBE()+ "%" + " MBE");
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  
			  <!-- This is other pre-qualifications-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getOtherPreQual()) != null && cbean.getOtherPreQual().equals("")==false){
					out.println("<b><font face='verdana,arial' size='1' color='800000'>");
					out.println(cbean.getOtherPreQual());
					out.println("</b></font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  
			   <!-- This is WBE-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getWBE()) != null && cbean.getWBE().equals("")==false){
					out.println("<font face='verdana,arial' size='1' color='800000'>");
					out.println(cbean.getWBE()+ "%" + " WBE");
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  
			     <!-- This is DBE-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getDBE()) != null && cbean.getDBE().equals("")==false){
					out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getDBE()+ "%" + " DBE");
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			  	     <!-- This is DVBE-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getDVBE()) != null && cbean.getDVBE().equals("")==false){
					out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getDVBE()+ "%" + " DVBE");
					out.println("</font>");
					
					
					
					}
				%>
              </TD> 
			  </TR>
			  
			   	     <!-- This is HUB-->
			 <TR> 
              <TD colspan="4" class="black10px"> 
                <%  
					if(	((String)cbean.getHUB()) != null && cbean.getHUB().equals("")==false){
					out.println("<font face='verdana,arial' size='1' >");
					out.println(cbean.getHUB()+ "%" + " HUB");
					out.println("</font>");
					
					
					
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
						 out.println("<font face='verdana,arial' size='1' > FILED SUB-BIDS DUE: "+"</font>");
						 out.println("<font face='verdana,arial' size='1' >"+filedsubbid_text+"</font>");
					 }
				%>
				</TD>
			  
			  </TR>
			   <!--THIS IS FOR DISPLAY OF PLAN HOLDER'S -->
			   <tr> 
                    <td> 
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
						
						 
						if (cbean.getBiddersListDisclmr() !=null)
         				{
			             	String biddersListDisclmr=cbean.getBiddersListDisclmr();
					 
				      
						if(biddersListDisclmr.trim().equals("Y")==true)
						 {
						   out.println("<font face='verdana' size='1' >"+privateDisclaimer+"</font>");
						 }   
         				
						
						
				        else if (biddersListDisclmr.trim().equals("P")==true)
         				{
			             out.println("<font face='verdana' size='1' >"+publicDisclaimer+"</font>");
         				}
					  }
					  
					   if (planHoldersList != null && planHoldersList.size() > 0)
						 {
							 // The indexList list keeps track of the indexes of the contacts that have been
							 // printed in the loop.
							 ArrayList indexList = new ArrayList();
				
							 int i = 0;
				
							 // Search for "GENERAL CONTRACTOR" in the list. Print first.
							 String generalcontKeyWords = "GENERAL CONSTRUCTION";
				
							 //fHH.getWebFileWriter().write(newLine);
				
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
											 out.println("<br>"+"<b>"+contactPlanHolders.getContactTypeText().trim().toUpperCase()
												 +"</b>"+"<br>");
										 }		 
										 // check if header has changed
										 else if (prev_contacttype != null && contactPlanHolders.getContactTypeText() != null
												 && !contactPlanHolders.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
										 {
											 prev_contacttype = contactPlanHolders.getContactTypeText().trim();
										  // print header
										 	out.println("<b>"+contactPlanHolders.getContactTypeText().trim().toUpperCase()
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
											 if (cbean.getPublishDate() != null)
											 {
												 String addedDate =
													 ValidateDate.getDateFromDBDate(contactPlanHolders.getAddedDate());
												 String webPublishyDate =
													 ValidateDate.getDateFromDBDate(cbean.getPublishDate());
					
												 // If added date is greater, print a plus sign
												 if (ValidateDate.compareDates(addedDate, webPublishyDate)
													 == 1)
												 {
													 printPlusSign = true;
												 }
											 }
					
											 //fHH.getWebFileWriter().write("<b>"+company_name+"</b>");
											 // Project Contact Link change
											 out.println("<b><font face='verdana,arial' size='1' color='800000'><a href=\"/cdc/online_product/list_contact_projects.cfm?contact_id="
												 +contactPlanHolders.getContactID()
												 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
												 +" target=\"_self\">"
												 +"</b>");
					
											 if (printPlusSign)
												 out.println ("+ ");
					
											 out.println(company_name+"</b>"+"</a>");
					                         if (printPlusSign)
												 out.println ("+ ");
					
											 out.println(company_name+"</b>"+"</a>");
					                         if (contactPlanHolders.getAddress1() != null && !contactPlanHolders.getAddress1().trim().equals(""))
											 {
												 out.println("<br>"+"&nbsp;&nbsp;"+contactPlanHolders.getAddress1().trim());
											 }
						
											 if (contactPlanHolders.getCity() != null && !contactPlanHolders.getCity().trim().equals(""))
											 {
												 out.println(", "+contactPlanHolders.getCity().trim());
											 }
						
											 if (contactPlanHolders.getCity() != null || contactPlanHolders.getAddress1() != null)
											 {
												out.println(", "+contactPlanHolders.getStateCode().trim());
											 }
						
											 if (contactPlanHolders.getZip() != null && !contactPlanHolders.getZip().trim().equals(""))
											 {
												 String formattedZip = ValidateNumber.formatZipCode(contactPlanHolders.getZip().trim());
												 if (formattedZip != null)
													 out.println(" " +formattedZip );
											 }	 
											 
																 
												 String tel_no = null;
												 Long tel_no_int = null;
												if (contactPlanHolders.getTelephone1() != null && !contactPlanHolders.getTelephone1().trim().equals(""))
												 {
													 tel_no = removeSpecialChars(contactPlanHolders.getTelephone1().trim());
							
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
															 out.println(" "+tel_no );
														 }
														 else
														 {
															 out.println(" "+contactPlanHolders.getTelephone1().trim() );
														 }

												}//end of if	 
													 // If telephone1 is missing, print telephone2
											 if (contactPlanHolders.getTelephone1() == null &&
												 contactPlanHolders.getTelephone2() != null &&
												 !contactPlanHolders.getTelephone2().trim().equals(""))
											 {
												 tel_no = removeSpecialChars(contactPlanHolders.getTelephone2().trim());
						
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
													 out.println(" "+tel_no);
												 }
												 else
												 {
													 out.println(" "+contactPlanHolders.getTelephone2().trim());
												 }
						
											 }//end of if

											 out.println("<br>");
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
													 out.println("<br>"+"<b><font face='verdana,arial' size='1' color='800000'>"+contactPlanHoldersOthers.getContactTypeText().trim().toUpperCase()
														 +"</b>"+"<br>");
												 }
												 // check if header has changed
												 else if (prev_contacttype != null && contactPlanHoldersOthers.getContactTypeText() != null
														 && !contactPlanHoldersOthers.getContactTypeText().trim().equalsIgnoreCase(prev_contacttype))
												 {
													 prev_contacttype = contactPlanHoldersOthers.getContactTypeText().trim();
													 // print header
													 out.println("<br>"+"<b><font face='verdana,arial' size='1' color='800000'>"+contactPlanHoldersOthers.getContactTypeText().trim().toUpperCase()
														 +"</b>"+"<br>");
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
												 if (cbean.getPublishDate() != null)
												 {
													 String addedDate =
														 ValidateDate.getDateFromDBDate(contactPlanHoldersOthers.getAddedDate());
													 String webPublishyDate =
														 ValidateDate.getDateFromDBDate(cbean.getPublishDate());
						
													 // If added date is greater, print a plus sign
													 if (ValidateDate.compareDates(addedDate, webPublishyDate)
														 == 1)
													 {
														 printPlusSign = true;
													 }
												 }
						
												 //fHH.getWebFileWriter().write("<b>"+company_name+"</b>");
												 // Project Contact Link change
												 out.println("<a href=\"/cdc/online_product/list_contact_projects.cfm?contact_id="
													 +contactPlanHoldersOthers.getContactID()
													 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
													 +" target=\"_self\">"
													 +"<b>");
						
												 if (printPlusSign)
													 out.println("+ ");
						
												 out.println(company_name+"</b>"+"</a>");
						
											 }
											 
											     String fax_no = null;
												 Long fax_no_int = null;
												 if (contactPlanHoldersOthers.getFax1() != null && !contactPlanHoldersOthers.getFax1().trim().equals(""))
												 {
													 fax_no = removeSpecialChars(contactPlanHoldersOthers.getFax1().trim());
							
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
														 out.println("<br> FAX# "+fax_no);
													 }
													 else
													 {
														 out.println("<br> FAX# "+contactPlanHoldersOthers.getFax1().trim());
													 }
							
												 }
												 
												    if (contactPlanHoldersOthers.getAddress1() != null && !contactPlanHoldersOthers.getAddress1().trim().equals(""))
													 {
														 out.println("	&nbsp;"+contactPlanHoldersOthers.getAddress1().trim());
													 }
								
													 if (contactPlanHoldersOthers.getCity() != null && !contactPlanHoldersOthers.getCity().trim().equals(""))
													 {
														 out.println(","+contactPlanHoldersOthers.getCity().trim());
													 }
								
													 if (contactPlanHoldersOthers.getCity() != null || contactPlanHoldersOthers.getAddress1() != null)
													 {
														 out.println(","+contactPlanHoldersOthers.getStateCode().trim());
													 }
								
													 if (contactPlanHoldersOthers.getZip() != null && !contactPlanHoldersOthers.getZip().trim().equals(""))
													 {
														 String formattedZip = ValidateNumber.formatZipCode(contactPlanHoldersOthers.getZip().trim());
														 if (formattedZip != null)
															 out.println(" " + formattedZip);
													 }
                                                     String tel_no = null;
													 Long tel_no_int = null;
													 if (contactPlanHoldersOthers.getTelephone1() != null && !contactPlanHoldersOthers.getTelephone1().trim().equals(""))
													 {
														 tel_no = removeSpecialChars(contactPlanHoldersOthers.getTelephone1().trim());
								
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
															 out.println(" "+tel_no);
														 }
														 else
														 {
															 out.println(" "+contactPlanHoldersOthers.getTelephone1().trim());
														 }
								
													 }
													 
													  // If telephone1 is missing, print telephone2
											 if (contactPlanHoldersOthers.getTelephone1() == null &&
												 contactPlanHoldersOthers.getTelephone2() != null &&
												 !contactPlanHoldersOthers.getTelephone2().trim().equals(""))
											 {
												 tel_no = removeSpecialChars(contactPlanHoldersOthers.getTelephone2().trim());
						
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
													 out.println(" "+tel_no);
												 }
												 else
												 {
													 out.println(" "+contactPlanHoldersOthers.getTelephone2().trim());
												 }
						
											 }

                                              out.println("<br>");
																		 
															
									 } // End of outerloop.
								 } // End of checking the rest of planholders.
							 } // End of checking planholderslist.
						

					   
					  
					  
					  
					  
					  	
						%>
					 
					</td>
                  </tr>
				   <!--THIS IS FOR DISPLAY OF  AWARDS-->
				  
			     <tr> 
                    <td > 
					       <%
						   		if (awardsList != null && awardsList.size() > 0)
         						{
					            	   if (awardsList.size() > 1)
             							{
							                 out.println("<b><b><font face='verdana,arial' size='1' color='800000'>Awards:</b>"+"<br>");
             							}
             						  else
             							{
							                  out.println("<b>Award:</b>"+"<br>");
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
												 out.println("<b><font face='verdana,arial' size='1' >"+contactAwards.getContactTypeText().trim()+"</b>"+"<br>");
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
												 out.println("<b><font face='verdana,arial' size='1' >"+contactAwards.getContactTypeText().trim()+"</b>"+"<br>");
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
													 out.println(award_count+"</b>. "
														 +"<a href=\"../list_contact_projects.cfm?contact_id="
														 +contactAwards.getContactID()
														 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
														 +" target=\"_self\">"
														 +company_name+"</a>");
								
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
															 fax_no = removeSpecialChars(contactAwards.getFax1().trim());
									
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
																 out.println("FAX# "+fax_no);
																 print_newline = true;
															 }
															 else
															 {
																 out.println("FAX# "+contactAwards.getFax1().trim());
																 print_newline = true;
															 }
														 }
														 if (contactAwards.getAddress1() != null && !contactAwards.getAddress1().trim().equals(""))
														 {
															 out.println(", "+contactAwards.getAddress1().trim());
															 print_newline = true;
														 }
									
														 if (contactAwards.getCity() != null && !contactAwards.getCity().trim().equals(""))
														 {
															 out.println(", "+contactAwards.getCity().trim());
															 print_newline = true;
														 }
									
														 if (contactAwards.getAddress1() != null || contactAwards.getCity() != null)
														 {
															 out.println(", "+contactAwards.getStateCode().trim());
															 print_newline = true;
														 }
									
														 if (contactAwards.getZip() != null && !contactAwards.getZip().trim().equals(""))
														 {
															 String formattedZip = ValidateNumber.formatZipCode(contactAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(" " + formattedZip);
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
															 Long tel_no_int = null;
															 if (contactAwards.getTelephone1() != null && !contactAwards.getTelephone1().trim().equals(""))
															 {
																 tel_no = removeSpecialChars(contactAwards.getTelephone1().trim());
										
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
																	 out.println(" "+tel_no);
																	 print_newline = true;
																 }
																 else
																 {
																	 out.println(" "+contactAwards.getTelephone1().trim());
																	 print_newline = true;
																 }
																   // If telephone1 is missing, print telephone2
																 if (contactAwards.getTelephone1() == null &&
																 contactAwards.getTelephone2() != null &&
																 !contactAwards.getTelephone2().trim().equals(""))
																 {
																	 tel_no = removeSpecialChars(contactAwards.getTelephone2().trim());
											
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
																		 out.println(" "+tel_no);
																		 print_newline = true;
																	 }
																	 else
																	 {
																		 out.println(" "+contactAwards.getTelephone2().trim());
																		 print_newline = true;
																	 }
											
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
			   <!---THIS IS FOR DISPLAY OF LOW BIDDERS LIST--->
			  
			   <tr> 
                    <td > 
					<% 
					              if (lowBiddersList != null && lowBiddersList.size() > 0)
									 {
										 if (lowBiddersList.size() > 1)
										 {
											 out.println("<b><font face='verdana,arial' size='1' >Apparent Low Bidders:</b>"+"<br>");
										 }
										 else
										 {
											 out.println("<b><font face='verdana,arial' size='1' >Apparent Low Bidder:</b>"+"<br>");
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
												 out.println("<b>"+contactlowBidders.getContactTypeText().trim()+"</b>"+"<br> ");
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
												 out.println("<b>"+contactlowBidders.getContactTypeText().trim()+"</b>"+"<br> ");
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
													  out.println("<b><font face='verdana,arial' size='1' >"+lowbidder_count+". "
														 +"</b><a href=\"../list_contact_projects.cfm?contact_id="
														 +contactlowBidders.getContactID()
														 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
														 +" target=\"_self\">"
														 +company_name+"</a>");
								
								
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
														 fax_no = removeSpecialChars(contactlowBidders.getFax1().trim());
								
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
															 out.println("FAX# "+fax_no);
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+contactlowBidders.getFax1().trim());
															 print_newline = true;
														 }
								
													 }
													  if (contactlowBidders.getAddress1() != null && !contactlowBidders.getAddress1().trim().equals(""))
														 {
															 String commaStr="";
															 if (fax_no != null && fax_no_int != null
																				&& fax_no_int.intValue() != 0) {
																 commaStr=", ";
															 }
															 out.println(commaStr+contactlowBidders.getAddress1().trim());
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getCity() != null && !contactlowBidders.getCity().trim().equals(""))
														 {
															 out.println(", "+contactlowBidders.getCity().trim());
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getAddress1() != null || contactlowBidders.getCity() != null)
														 {
															 out.println(", "+contactlowBidders.getStateCode().trim());
															 print_newline = true;
														 }
									
														 if (contactlowBidders.getZip() != null && !contactlowBidders.getZip().trim().equals(""))
														 {
															 String formattedZip = ValidateNumber.formatZipCode(contactlowBidders.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(" " + formattedZip);
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
														 Long tel_no_int = null;
														 if (contactlowBidders.getTelephone1() != null && !contactlowBidders.getTelephone1().trim().equals(""))
														 {
															 tel_no = removeSpecialChars(contactlowBidders.getTelephone1().trim());
									
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
																 out.println(" "+tel_no);
																 print_newline = true;
															 }
															 else
															 {
																 out.println(" "+contactlowBidders.getTelephone1().trim());
																 print_newline = true;
															 }
									
														 }
														 // If telephone1 is missing, print telephone2
														 if (contactlowBidders.getTelephone1() == null &&
														 contactlowBidders.getTelephone2() != null &&
														 !contactlowBidders.getTelephone2().trim().equals(""))
														 {
															 tel_no = removeSpecialChars(contactlowBidders.getTelephone2().trim());
									
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
																 out.println(" "+tel_no);
																 print_newline = true;
															 }
															 else
															 {
																 out.println(" "+contactlowBidders.getTelephone2().trim());
																 print_newline = true;
															 }
									
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
			   <!---THIS IS FOR DISPLAY OF SUB CONTRACTORS AWARDS LIST--->
				 <tr> 
                    <td>
					  <%
					                if (subAwardsList != null && subAwardsList.size() > 0)
									 {
										 if (subAwardsList.size() > 1)
										 {
											 out.println("<b><font face='verdana,arial' size='1' >Sub Contractors:</b>"+"<br>");
										 }
										 else
										 {
											 out.println("<b><font face='verdana,arial' size='1' >Sub Contractors:</b>"+"<br>");
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
												 out.println("<b>"+contactsubAwards.getContactTypeText().trim()+"</b>"+"<br> ");
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
												 out.println("<b>"+contactsubAwards.getContactTypeText().trim()+"</b>"+"<br>");
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
													  out.println("<b><font face='verdana,arial' size='1' > "
														 +"</b><a href=\"../list_contact_projects.cfm?contact_id="
														 +contactsubAwards.getContactID()
														 +"&contact_name="+ URLEncoder.encode(company_name)+"\""
														 +" target=\"_self\">"
														 +company_name+"</a>");
								
								
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
														 fax_no = removeSpecialChars(contactsubAwards.getFax1().trim());
								
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
															 out.println("FAX# "+fax_no);
															 print_newline = true;
														 }
														 else
														 {
															 out.println("FAX# "+contactsubAwards.getFax1().trim());
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
															 out.println(commaStr+contactsubAwards.getAddress1().trim());
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getCity() != null && !contactsubAwards.getCity().trim().equals(""))
														 {
															 out.println(", "+contactsubAwards.getCity().trim());
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getAddress1() != null || contactsubAwards.getCity() != null)
														 {
															 out.println(", "+contactsubAwards.getStateCode().trim());
															 print_newline = true;
														 }
									
														 if (contactsubAwards.getZip() != null && !contactsubAwards.getZip().trim().equals(""))
														 {
															 String formattedZip = ValidateNumber.formatZipCode(contactsubAwards.getZip().trim());
															 if (formattedZip != null)
															 {
																 out.println(" " +formattedZip );
																 print_newline = true;
															 }
														 }
														  String tel_no = null;
														 Long tel_no_int = null;
														 if (contactsubAwards.getTelephone1() != null && !contactsubAwards.getTelephone1().trim().equals(""))
														 {
															 tel_no = removeSpecialChars(contactsubAwards.getTelephone1().trim());
									
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
																 out.println(" "+tel_no);
																 print_newline = true;
															 }
															 else
															 {
																 out.println(" "+contactsubAwards.getTelephone1().trim());
																 print_newline = true;
															 }
									
														 }
														 // If telephone1 is missing, print telephone2
														 if (contactsubAwards.getTelephone1() == null &&
														 contactsubAwards.getTelephone2() != null &&
														 !contactsubAwards.getTelephone2().trim().equals(""))
														 {
															 tel_no = removeSpecialChars(contactsubAwards.getTelephone2().trim());
									
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
																 out.println(" "+tel_no);
																 print_newline = true;
															 }
															 else
															 {
																 out.println(" "+contactsubAwards.getTelephone2().trim());
																 print_newline = true;
															 }
									
														 }
														     if (print_newline)
															 {
																 out.println("<br></font>");
															 }


								                
												 }//end of if Print details if printDetails flag is true.

											 
											 
											 
										 }//END OF MAIN WHILE	 
										 
										 
										 
				                    }//END OF MAIN IF					
									
					  %>
					</td>
                  </tr>
				   
            
           		 <TR> 
             		 <TD height="30" colspan="4"></TD>
            	</TR>
				 <TR > 
              <TD colspan="4" ALIGN="center" class="black10px">
				  <table>
				  
				   <!--THIS IS FOR DISPLAY FOR FIRST REPORTED DATE-->
			  		<tr> 
                      <td class="black10px" ALIGN="center"> 
					  
                      
					    <%
               					
								if(cbean.getfirstReportedDate()!=null)
								{
								Locale usLocale=new Locale("EN","us");
			     		        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				                Date tempdate=sdf.parse(cbean.getfirstReportedDate());
				                sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			    String convertedDate=sdf.format(tempdate);
								//out.println(convertedDate);
						        out.println("<font face='verdana,arial' size='1' >");
								out.println("First Reported "+ValidateDate.formatPrintableDate(ValidateDate.getDateStringMMDDYY(convertedDate))+"<br>");
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
							   Locale usLocale=new Locale("EN","us");
			     		       SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd",usLocale);
				               Date tempdate=sdf.parse(cbean.getFinalPublishDate());
				               sdf=new SimpleDateFormat("yy-MM-dd",usLocale);
                  			   String convertedDate=sdf.format(tempdate);
							
							  
							    out.println("<font face='verdana,arial' size='1' >");
								out.println("Final Published "+ValidateDate.formatPrintableDateShort(ValidateDate.getDateStringMMDDYY(convertedDate)));
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
		
          
							
			
			<%}contentID.remove(); %>				
									
						</TD>			
					</TR>
                  <tr> 
                    <td class="black10px" ALIGN="center"> ©COPYRIGHT 2006, CONSTRUCTION 
                      DATA COMPANY, ALL RIGHTS RESERVED. This material may not 
                      be published, broadcast, rewritten or distributed. </td>
                  </tr>
                </table></td>
            </tr>
          </table>
		  <tr> 
    			<td colspan="10" ><img src="../cdc/online_product/images/pixel_blue.gif" width="100%" height="1" border="0"></td>
  		 </tr>
		<tr>
		<td valign="top">
			

</td></tr>
</table>
</FORM>	
	
</body>

</html>




