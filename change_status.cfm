<cfif structKeyExists(form, 'open_error') AND (#form.error_status# EQ 'Новая' OR #form.error_status# EQ 'Решенная')>
	<cfquery datasource="bug_db">
		UPDATE errors SET status = 'Открытая' WHERE id=#form.error_id#;
		INSERT INTO logs(action, comment, username, id) VALUES('Открытие', '#form.comment#', '#getAuthUser()#', #form.error_id#);
	</cfquery>
	
<cfelseif structKeyExists(form, 'solve_error') AND #form.error_status# EQ 'Открытая'>
	<cfquery datasource="bug_db">
		UPDATE errors SET status = 'Решенная' WHERE id=#form.error_id#;
		INSERT INTO logs(action, comment, username, id) VALUES('Решение', '#form.comment#', '#getAuthUser()#', #form.error_id#);
	</cfquery>
	
<cfelseif structKeyExists(form, 'close_error') AND #form.error_status# EQ 'Решенная'>
	<cfquery datasource="bug_db">
		UPDATE errors SET status = 'Закрытая' WHERE id=#form.error_id#;
		INSERT INTO logs(action, comment, username, id) VALUES('Закрытие', '#form.comment#', '#getAuthUser()#', #form.error_id#);
	</cfquery>
</cfif>

<cflocation url="error_page.cfm?id=#error_id#"  addtoken="no">