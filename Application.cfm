<cfapplication name = "bugTrackingApp"
sessionmanagement="Yes" 
sessiontimeout=#CreateTimeSpan(0,2,0,0)#>
<cfsetting showdebugoutput="yes">

<cftry>
	<cflogin> 
	<cfif NOT IsDefined("cflogin")> 
		<cfinclude template="loginform.cfm"> 
		<cfabort> 
	</cfif> 

	</cflogin> 
<cfcatch> 
	<cflogout>
	<cflocation url="loginform.cfm"  addtoken="no">
</cfcatch> 
</cftry>