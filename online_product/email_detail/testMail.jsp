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
   Description    : Send Email if any error occurs in the included jsp file.
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<%@ page import="java.util.Map,java.util.Properties,java.util.StringTokenizer,javax.mail.*,javax.mail.internet.*,delmconfig.DataExportLMConfig" isErrorPage="true" %>
<%

	Properties props = null;
	String smtpHost=null;
	String smtpPort=null;
	Message message = null;
	InternetAddress inetAddress = null;
	Multipart multiPart = null;
	BodyPart bodyPart = null;
	String from=null;
	String personalName=null;
	String subject=null;
	String mailBody=null;

 	//String to="yoe.samuel@gmail.com,muthu@tentsoftware.com,sathya@tentsoftware.com";
 String to="muthu@tentsoftware.com";
 try{
 		if(!exception.getClass().getName().toString().equalsIgnoreCase("java.lang.IllegalStateException")){ // Filter the IllegalStateException to avoid numerous mails.
		
 		smtpHost=DataExportLMConfig.DATAEXPORT_SMTP_SERVER;
		smtpPort=DataExportLMConfig.DATAEXPORT_SMTP_PORT;
		from="error@cdcnews.com";
		subject = "Sending email from JSP! 72";		
		
		java.io.StringWriter stringWritter = new java.io.StringWriter();  
        java.io.PrintWriter printWritter = new java.io.PrintWriter(stringWritter, true);  
       	exception.printStackTrace(printWritter); 
        printWritter.flush();  
        stringWritter.flush();  
		
		String loginId = (String)((Map)(session.getAttribute("cdcnews"))).get("login_id");
		
		mailBody= "\nError in LM 72 server !";
		mailBody += "\nLoinId: "+loginId;		
		mailBody += "\nThe  error is "+ stringWritter;		
		
    
		props = new Properties();				
		// mail server
		props.put("mail.smtp.host", smtpHost);
		props.put("mail.smtp.port", smtpPort);
		javax.mail.Session mailSession = javax.mail.Session.getInstance(props, null);
		message = new MimeMessage(mailSession);
			inetAddress = new InternetAddress(from);
			//Sets Personal Name
			//inetAddress.setPersonal(personalName);
			//Get the multiple 'From' email address
			 StringTokenizer st = new StringTokenizer(to, ",;");
		        int tokenCount = st.countTokens();
		        InternetAddress[] recipientList = new InternetAddress[tokenCount];

		        //Tokenize the recipient list, and create the Internet Address Array of Recipients

		        for (int i = 0; st.hasMoreTokens(); i++) {
		          //Get the next token
		          String msgTo = st.nextToken();

		          //Ensure the token received is a valid address
		          if (msgTo != null && msgTo.trim().length() > 0) {	           

		              recipientList[i] = new InternetAddress(msgTo);              
		          }
		        }
		        
		message.setFrom(inetAddress);	
		message.setRecipients(javax.mail.internet.MimeMessage.RecipientType.TO,
						  recipientList);		
		//Sets subject			
		message.setSubject(subject);		
		
		bodyPart = new MimeBodyPart();
		
		multiPart = new MimeMultipart();
		bodyPart.setText(mailBody);
		multiPart.addBodyPart(bodyPart);
		
		//Sets final content
		message.setContent(multiPart);
		
		//send
		Transport.send(message); 
	}
}
  catch (Exception e){	
     System.out.println("ERROR SENDING EMAIL:"+e);
  }
%>