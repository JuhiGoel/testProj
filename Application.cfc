<cfcomponent displayname="CFML_login" output="false" hint="Handle the application.">

	<!--- Configure Application ----------------------------------->
	<cfset this.name = "MyApp">
	<cfset this.applicationTimeout = createTimeSpan( 0, 0, 1, 0 )>
	<cfset this.sessionManagement = true>
	<cfset this.setClientCookies = true>
	<cfset this.sessionTimeout = createTimeSpan( 0, 0, 30, 0 )>
	<cfsetting requesttimeout="60" showdebugoutput="false" enablecfoutputonly="false">
	
	<!--- Application start --------------------------------------->
	<cffunction name="onApplicationStart" access="public" returntype="boolean" output="false" hint="Fires when the application is first created.">
		<cfset application.dataSource = "cfml_login">
		<cfset application.objErrorLog = createObject("component", "components.error-log")>
		<cfreturn true>
	</cffunction>

	<!--- Session  Start ------------------------------------------>
	<cffunction name="onSessionStart" access="public" returntype="void" hint="Fires when a session is created.">
		<cfset sessionRotate()/>
		<cfreturn>
	</cffunction>
	
	<!--- Session  End ------------------------------------------>
	<cffunction name="onSessionEnd" access="public" returntype="void" hint="Fires when a session ends.">
		<cfset sessionInvalidate()/>
		<cfreturn>
	</cffunction>

	<!--- Error --------------------------------------------------->
	<cffunction name="onError" access="public" returntype="void" output="true" hint="Fires when an exception occurs that is not caught by a try/catch.">

		<!--- Define Arguments --->
		<cfargument name="exception" type="any" required="true">
		
		<!--- Log error --->
		<cfset application.objErrorLog.logError(methodName = "On Error"
												, cfCatch = arguments.exception)>
										
		<!--- Check for Ajax Request --->
		<cfif structKeyExists(getHTTPRequestData().headers, "X-Requested-With")>
			<cfset local.results = structNew()>
			<cfset local.results.error = "Internal server error. Please try later.">
			<cfoutput> #serializeJSON(local.results)# </cfoutput>
			<cfreturn>
		</cfif>
		<cfreturn>
	</cffunction>

	<!--- Application End ----------------------------------------->
	<cffunction name="onApplicationEnd" access="public" returntype="void" output="false" hint="Fires when the application is terminated.">
		
		<!--- Define Arguments --->
		<cfargument name="applicationScope" type="struct" required="false" default="#structNew()#">
		
		<!--- Return --->
		<cfreturn>
	</cffunction>
</cfcomponent>