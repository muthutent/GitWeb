<%@ Page Language="C#" AutoEventWireup="true" CodeFile="forgotPassword.aspx.cs" Inherits="projects_forgotPassword" %>

<html>
<head>
	<title>Forgot Password - CDCNews - Construction Data Company</title>
	
	<link rel="icon" href="/favicon.ico" type="image/ico">
	<link rel="shortcut icon" href="/favicon.ico" type="image/ico">

	<SCRIPT SRC="../JSScripts/mouseovertabs.js" TYPE="text/javascript"></SCRIPT>
	
	<script language="JavaScript" src="../JSScripts/javascript_template.js"></script>
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet/mainsite.css">
	<LINK REL="STYLESHEET" TYPE="text/css" HREF="../stylesheet/sheet.css">
	
<script language="JavaScript">
<!--
// Validation Starts 
function CDC_check_form(_CF_this)
{	
	// use id 
	if (!check_textbox(_CF_this.tbEmail,"TEXT", "Please enter company email!"))
		 return false
	if (!check_mail(_CF_this.tbEmail,_CF_this.tbEmail.value, "Please enter email address in correct format!"))
	     return false
	if (!check_textbox(_CF_this.tbCaptcha,"TEXT", "Please enter code shown in image!"))
		 return false
		
    return true
}

//-->
</script>
</head>

<body onLoad="LogFocus()">


<!--#include file="../header_logoPanel.htm" -->
<!--#include file="../header_menuPanel_others.htm"-->
<% Server.Execute("../header_loginpanel.aspx");%>
<!--#include file="../header_submenuPanel.htm" -->
<!--#include file="../leftSideBoxes1.htm" -->


  <DIV ID="mainContent"> 
    <TABLE CELLSPACING="0" CELLPADDING="0" BORDER="0" WIDTH="620">
      <TR> 
        <TD WIDTH="15">&nbsp;</TD>
        <TD VALIGN="top" CLASS="black12px"> <SPAN CLASS="skyblue10px"><A HREF="../default.aspx" CLASS="b01">Home</A> 
          > Forgot Password</SPAN> <BR>
          <BR> <H1>Forgot Password</H1>
          
            Enter your email address and we'll email your password to you. 
            <!--- form start--->
			
            <form id="theform" name="theform" runat="server" >
              <table border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td CLASS="black12px">Email Address:</TD>
                  <td>&nbsp;</td>
                  <td><input type="text" name="company_email" size="30" maxlength="50" runat="server" id="tbEmail" /></td>
                </tr>
				
				<tr> 
                  <td CLASS="black12px">&nbsp;</TD>
                  <td>&nbsp;</td>
                  <td>
                    <asp:Image ID="Image1" runat="server" /> <br />
                  </td>
                </tr>
                <tr> 
                  <td CLASS="black12px" ALIGN="right">Enter the code shown:</td>
                  <td>&nbsp;</td>
                  <td CLASS="black12px"> <input type="text" name="captcha" SIZE="30" id="tbCaptcha" runat="server" />
                    <%--<input name="captchaHash" type="hidden" value="<CFOUTPUT>#codeHash#</CFOUTPUT>"> --%>
                    
                  </td>
                </tr>
				
				 <tr> 
                  <td CLASS="black12px"></TD>
                  <td>&nbsp;</td>
                  <td>This helps prevent automated submissions.</td>
                </tr>
				
                <tr valign="bottom" align="center" height=30> 
                  <td colspan="4"> <%--<input type="submit" name="submit" value="Submit">--%>
                   <asp:Button ID="btnSubmit" runat="server"  Text="Submit" 
                        OnClientClick="return CDC_check_form(document.theform)" onclick="btnSubmit_Click"/> 
                    <input type="reset" name="reset" value="Reset" /> </td>
                </tr>
              </table>
            </form>
            <!--- form end --->
          </TD>
        <TD WIDTH="10">&nbsp;</TD>
      </TR>
    </TABLE>
  </DIV>
  
<%  Server.Execute("../hrBoxes1.aspx");%>
  <!--#include file="../footer.htm" -->
  

</body>
</html>
