<cfmodule template="base.cfm" title="Bug tracking system | Errors">


<cfif NOT structKeyExists(url,'sort')>
	<cfset orderby="ORDER BY datetime DESC">
<cfelse>
	<cfset orderby="ORDER BY " & #sort#>
</cfif>

<cftry>
	<cfquery datasource="bug_db" name="errors">
		SELECT * FROM errors #orderby#
	</cfquery>	
<cfcatch type="database">
	<cfoutput>#cfcatch.message#</cfoutput>
	<cfabort>
</cfcatch>
</cftry>

<link rel="stylesheet" type="text/css" href="css/index.css">

<div class="content">
	<table>
		<tr>
			<th><a href="index.cfm">Дата</a></th>
			<th><a href="index.cfm?sort=short_desc">Краткое описание</a></th>
			<th><a href="index.cfm?sort=username">Пользователь</a></th>
			<th><a href="index.cfm?sort=status">Статус</a></th>
			<th><a href="index.cfm?sort=urgency">Срочность</a></th>
			<th><a href="index.cfm?sort=criticality">Критичность</a></th>
		</tr>
		<cfoutput query="errors">
			<tr>
				<td style="width: 20%;">#DateFormat(datetime, 'dd.mm.yy kk:mm')#</td>
				<td style="width: 35%;"><a class="error_link" href="error_page.cfm?id=#id#">#short_desc#</a></td>
				<td>#username#</td>
				<td>#status#</td>
				<td>#urgency#</td>
				<td>#criticality#</td>
				</tr>	
		</cfoutput>
	</table>
</div>			
</cfmodule>