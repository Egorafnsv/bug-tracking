<cfmodule template="base.cfm" title="Bug tracking system | Adding errors">

<cfset query_status = ''>

<cfif structKeyExists(form, 'add_error_submit')>
	<cftry>
		<cfquery datasource="bug_db">
			INSERT INTO errors (username, short_desc, detailed_desc, urgency, criticality) 
			VALUES ('#getAuthUser()#', '#form.short_desc#', '#form.detailed_desc#', '#form.urgency#', '#form.criticality#');
			<!--- trigger new_error --->
		</cfquery>
		<cfset query_status = 'Ошибка успешно добавлена!'>
		
	<cfcatch type="database">
		<cfset query_status = 'Не удалось добавить ошибку'>
	</cfcatch>
	</cftry>
</cfif>

<link rel="stylesheet" type="text/css" href="css/add_error.css">

<div class='content'>
	<cfform name="add_error" method="Post">
		<label for="short_desc">Короткое описание:</label>
		<cfinput type="text" name="short_desc" id="short_desc" required="yes"  maxlength="150"
		message="A short description is required">

		<label for="detailed_desc">Подробное описание:</label>
		<cftextarea name="detailed_desc" id="detailed_desc" required="yes" 
		message="A detailed description is required"></cftextarea>

		<label for="urgency">Срочность:</label>
		<cfselect name="urgency" id="urgency">
			<option value="Очень срочно">Очень срочно</option>
			<option value="Срочно">Срочно</option>
			<option value="Несрочно">Несрочно</option>
		</cfselect>

		<label for="criticality">Критичность:</label>
		<cfselect name="criticality" id="criticality">
			<option value="Авария">Авария</option>
			<option value="Критичная">Критичная</option>
			<option value="Некритичная">Некритичная</option>
			<option value="Некритичная">Запрос на изменения</option>
		</cfselect>

		<input type="submit" name="add_error_submit" value="Добавить"> 
	</cfform>
	
	<cfoutput><p>#query_status#</p></cfoutput>
	
</div>
</cfmodule>