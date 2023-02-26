<cfmodule template="base.cfm" title="Bug tracking system | Users">

<cfquery datasource="bug_db" name="users">
	SELECT * FROM users ORDER BY surname;
</cfquery>

<link rel="stylesheet" type="text/css" href="css/users.css">

<div class="content">
	<table>
		<tr>
			<th>Идентификатор</th>
			<th>Имя</th>
			<th>Фамилия</th>
		</tr>
		<cfoutput query="users">
			<tr>
				<td style="width: 10%;"><a href="user_page.cfm?username=#username#">#username#</a></td>	
				<td style="width: 45%;">#name#</td>	
				<td style="width: 45%;">#surname#</td>	
				</th>
			</tr>
		</cfoutput>
	</table>
</div>
</cfmodule>