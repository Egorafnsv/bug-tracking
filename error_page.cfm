<cfmodule template="base.cfm" title="Bug tracking system | Error">

<cftry>
	<cfquery datasource="bug_db" name='error'>
		SELECT * FROM errors WHERE id=#id#;
	</cfquery>
	
	<cfquery datasource="bug_db" name='logs'>
		SELECT l.datetime, action, comment, l.username FROM errors e JOIN logs l ON e.id=l.id WHERE e.id=#id#;
	</cfquery>
	
<cfcatch type="database">
	<cfoutput>#cfcatch.message#</cfoutput>
	<cfabort>
</cfcatch>
<cfcatch type="expression">
	<cfoutput>#cfcatch.message#</cfoutput>
	<cfabort>
</cfcatch>
</cftry>

<link rel="stylesheet" type="text/css" href="css/error_page.css">

<div class="content">
	<div class="column">
		<cfoutput query="error">
			<h3>#short_desc#</h3>
			<p><b>Дата создания:</b><br>#DateFormat(datetime, 'dd.mm.yy kk:mm')#</p>
			<p><b>Создал:</b><br>#username#</p>
			<p><b>Подробное описание:</b><br>#detailed_desc#</p>
			<p><b>Текущий статус:</b><br>#status#</p>
			<p><b>Срочность:</b><br>#urgency#</p>
			<p><b>Критичность:</b><br>#criticality#</p>
	
			<cfif #status# NEQ 'Закрытая'>
				<p><b>Изменить статус:</b></p>
				<cfform name="change_status" method="Post" action="change_status.cfm">
					<input type="hidden" name="error_id" value="#id#">
					
					<input type="hidden" name="error_status" value="#status#">
					
					<cftextarea name="comment" required="yes" placeholder="Введите комментарий..."
					message="Comment is required"></cftextarea>
		
					<cfif #status# EQ 'Новая'>
						<input type="submit" name="open_error" value="Открыть"> 
					<cfelseif #status# EQ 'Открытая'>
						<input type="submit" name="solve_error" value="Решенная"> 
					<cfelseif #status# EQ 'Решенная'>
						<input type="submit" name="open_error" value="Открыть"> 
						<input type="submit" name="close_error" value="Закрыть"> 
					</cfif>
				</cfform>
			<cfelse>
				<p>Ошибка закрыта, изменение статуса невозможно<p>
			</cfif>
		</cfoutput>
	</div>
	
	<div class="column">
		<h3>История изменений:</h3>
		<table>
			<tr>
				<th>Дата</th>
				<th>Изменил</th>
				<th>Действие</th>
				<th>Комментарий</th>
			</tr>
			
			<cfoutput query="logs">
				<tr>
					<td>#DateFormat(datetime, 'dd.mm.yy kk:mm')#</td>	
					<td>#username#</td>	
					<td>#action#</td>	
					<td>#comment#</td>	
				</tr>
			</cfoutput>
		</table>
	</div>
</div>
</cfmodule>