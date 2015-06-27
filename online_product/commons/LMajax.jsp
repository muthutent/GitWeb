
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
   Date Created   : 02/07/2015
   Last Modified  : 03/10/2015
   Modifier       : Selva 
   Description    : ALL AJAX CALL FUNCTIONS ROOTING DONE HERE. THE JAVA FUNCITONS ARE TRIGGERED ACCORDING TO THE ACTION NAME.
					PARAMETERS ARE RETRIEVED FROM THE ENUMERATION LIST AND PUSHED INTO MAP.
					INVOKES THE JAVA FUNCTION BY PASSING THE MAP CONTAINING THE PARAMETERS LIST.
					After the Lead Manager Migration from coldfusion to JBoss
*/
%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*,java.util.Enumeration,java.util.ArrayList,java.util.Collections,java.util.Arrays,java.util.Map,java.util.HashMap,java.util.List,java.lang.reflect.Method,common.utils.AjaxUtil" errorPage="" %>

<%!
	String paramName = null;
	Map paramMap=null;
	Enumeration parameterList1=null;
 	Enumeration parameterList2=null;
	List valueList = null;
	String[] values=null;

%>

<% 
	paramMap = new HashMap();
 	parameterList1 = request.getParameterNames();	// For Getting the Parameters.
	parameterList2 = request.getParameterNames(); // To indentify the action to invoke.

	ArrayList newAssetList = null;
 	 
	// Gets the key,value and puts into map.
	while( parameterList1.hasMoreElements() )
  	{
		//Gets the parameter name.
		paramName = parameterList1.nextElement().toString();	
		//Gets the parameter values.
		values =request.getParameterValues(paramName);
		newAssetList = new ArrayList();
		if(newAssetList!=null)
		{
			newAssetList.addAll(Arrays.asList(values));
		}
		//puts the key,value into map.
		paramMap.put(paramName,newAssetList);
	}

	// Iterates through the Parameters list and indentifies the 'action' name to invoke.
  while( parameterList2.hasMoreElements() )
  {
 
  	paramName = parameterList2.nextElement().toString();
		
		//Gets the action name
		if(paramName.equals("action")) {		
			String actionName=request.getParameter("action");
			try {
				
				Class mapparams[] = {Map.class};	
				AjaxUtil test = new AjaxUtil();
				//call the desired Method				
				Method method = AjaxUtil.class.getDeclaredMethod(actionName, mapparams);
				
				//Invokes the java function and echos the retured output.				
				out.println(method.invoke(test, new Object[] {paramMap}));

				
			} catch (IllegalArgumentException e) {
				System.out.print("illegalExcep");
			}catch(Exception ex) {
				System.out.println(ex.toString());
			}

		}
  }


%>
