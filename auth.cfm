<cfquery datasource="bug_db" name="Authenticate">
  SELECT password
  FROM users
  WHERE username = '#form.j_username#'
</cfquery>

<cfif !Authenticate.recordCount>
  <cfoutput>
  	<cfinclude template="loginform.cfm">
  	<p style="text-align: center;">Неверный логин и/или пароль</p>
  	<cfabort>
  </cfoutput>
</cfif>

<cfif Authenticate.password EQ hash(form.j_password, "SHA-256")>
	<cflogin>
		<cfloginuser
		name = "#form.j_username#"
		password ="#form.j_password#"
		roles='user'>		
	</cflogin>
	
	<cflocation url="index.cfm"  addtoken="no">
<cfelse>
	<cfoutput>
		<cfinclude template="loginform.cfm">
		<p style="text-align: center;">Неверный логин и/или пароль</p>
	</cfoutput>
</cfif>
