<cfparam name="attributes.title" default="Bug tracking system" >

<cfif thistag.executionMode EQ 'start'>	
<!DOCTYPE html>
<html>
	<head>
		<title><cfoutput>#attributes.title#</cfoutput></title>
		<meta content="width=device-width, initial-scale=1" charset="utf-8">
			
		<link rel="stylesheet" type="text/css" href="css/base.css">
	</head>
	
	<body>
		<div class="topnav">
		  <a href="index.cfm" class="errors_list">Список ошибок</a>
		  <a href="add_error.cfm" class="add_error">Добавить ошибку</a>
		  <a href="users.cfm" class="users_list">Список пользователей</a>
		  <a href="add_user.cfm" class="add_user">Добавить пользователя</a>
		  <cfif len(getAuthUser())> 
		  	<cfoutput>
		  	<a href="logout.cfm">Выход (#getAuthUser()#)</a>
		  	</cfoutput>
		  </cfif> 
		</div>
<cfelse>
	</body>
</html>
</cfif>