<cfmodule template="base.cfm" title="Bug tracking system | User">

<cfif structKeyExists(form, 'change_user_submit')>
	<cfset query=arrayNew(1)>
	<cfif len(trim(form.username)) GT 0>
		<cfset ArrayAppend(query, "username='" & trim(form.username) & "'")>
	</cfif>
	<cfif len(form.name) GT 0>
		<cfset ArrayAppend(query, "name='" & form.name & "'")>
	</cfif>
	<cfif len(form.surname) GT 0>
		<cfset ArrayAppend(query, "surname='" & form.surname & "'")>
	</cfif>
	<cfif len(form.password) GT 0>
		<cfset ArrayAppend(query, "password='" & hash(form.password, "SHA-256") & "'")>
	</cfif>
	
	<cfif ArrayLen(query) GT 0>
		<cfset query = query.toList()>
		<cfoutput>
			#query#
		</cfoutput>
		<cfquery datasource="bug_db">
			UPDATE users SET #replace("#query#","""","'","all")# WHERE username='#username#';
		</cfquery>
		<cflocation url="users.cfm" addtoken="no">
	</cfif>
</cfif>

<cftry>
<cfquery datasource="bug_db" name='user'>
	SELECT * FROM users WHERE username='#username#';
</cfquery>
<cfcatch type="expression">
	<cfoutput>#cfcatch.message#</cfoutput>
	<cfabort>
</cfcatch>	
</cftry>



<link rel="stylesheet" type="text/css" href="css/user_page.css">

<div class="content">
	<cfoutput query="user">
		<p><b>Идентификатор:</b><br>#username#</p>
		<p><b>Имя:</b><br>#name#</p>
		<p><b>Фамилия:</b><br>#surname#</p>
		
		<cfform name="change_user" method="Post">
			<label for="username">Идентификатор:</label> 
			<cfinput type="text" id="username" name="username" maxlength="20">
			
			<label for="name">Имя:</label>
			<cfinput type="text" id="name" name="name">
			
			<label for="surname">Фамилия:</label>
			<cfinput type="text" id="surname" name="surname">
			
			<label for="password">Пароль:</label>
			<cfinput type="password" id="password" name="password">
			
			<input type="submit" name="change_user_submit" value="Изменить"> 
		</cfform>
	</cfoutput>
</div>
</cfmodule>