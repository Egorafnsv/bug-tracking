<cfmodule template="base.cfm" title="Bug tracking system | Adding users">

<cfset query_status=''>

<cfif structKeyExists(form, 'add_user_submit')>
	<cftry>
		<cfif len(trim(form.username)) EQ 0>
			<cfthrow type="InvalidData" message="Идентификатор не может состоять из одних пробелов">
		</cfif>
		
		<cfquery datasource="bug_db">
				INSERT INTO users (username, name, surname, password) 
				VALUES ('#form.username#', '#form.name#', '#form.surname#', '#hash(form.password, "SHA-256")#');
		</cfquery>
		
		<cfset query_status='Пользователь успешно добавлен!'>
		
	<cfcatch type="database">
		<cfset query_status='Не удалось добавить пользователя'>
	</cfcatch>
		
	<cfcatch type="InvalidData" >
		<cfset query_status=#cfcatch.message#>
	</cfcatch>
	</cftry>
	
</cfif>

<link rel="stylesheet" type="text/css" href="css/add_user.css">

<div class='content'>
	<cfform name="add_user" method="Post">
		<label for="username">Идентификатор:</label>
		<cfinput type="text" name="username" id="username" required="yes"  maxlength="20" message="an username is required">
		
		<label for="name">Имя:</label>
		<cfinput type="text" name="name" id="name" required="yes" message="a name is required">
		
		<label for="surname">Фамилия:</label>
		<cfinput type="text" name="surname" id="surname" required="yes" message="a surname is required">
		
		<label for="password">Пароль:</label>
		<cfinput type="password" name="password" id="password" required="yes"  message="a password is required">
		
		<input type="submit" name="add_user_submit" value="Добавить"> 
	</cfform>
	
	<cfoutput><p>#query_status#</p></cfoutput>
</div>
</cfmodule>