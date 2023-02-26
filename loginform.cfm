<cfmodule template='base.cfm'>

<link rel="stylesheet" type="text/css" href="css/loginform.css">

<div class="content">
	<cfform name="loginform" action="auth.cfm" method="Post"> 
		<label for="username">Идентификатор:</label>
		<cfinput type="text" name="j_username" id="username" required="yes" maxlength="20"
		message="A user name is required">
		
		<label for="password">Пароль:</label>
		<cfinput type="password" id="password" name="j_password" required="yes" 
		message="A password is required">
		
		<input type="submit" value="Войти"> 
	</cfform>
</div>
</cfmodule>