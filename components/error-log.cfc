<cfcomponent displayname="Error-Log" hint="Log errors">
	
	<!--- Log error --->
	<cffunction name="logError" access="public" returntype="void">
		<cfargument name="methodName" type="string" required="yes">
		<cfargument name="cfCatch" type="any" required="yes">
		<cfargument name="comments" type="string" required="no" default="">
		
		<!--- Set local variables --->
		<cfset local.detail = "">
		<cfset local.message = "">
		<cfset local.type = "">
		<cfif structKeyExists(arguments.cfCatch, "detail")>
			<cfset local.detail = arguments.cfCatch.detail>
		</cfif>
		<cfif structKeyExists(arguments.cfCatch, "message")>
			<cfset local.message = arguments.cfCatch.message>
		</cfif>
		<cfif structKeyExists(arguments.cfCatch, "type")>
			<cfset local.type = arguments.cfCatch.type>
		</cfif>
		
		<!--- Query --->
		<cfquery datasource="#application.dataSource#">
		INSERT INTO errors (
		  error_method_name,
		  error_catch,
		  error_detail,
		  error_message,
		  error_type,
		  error_created_date )
		VALUES (
		  <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.methodName#">,
		<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#arguments.cfCatch#">,
		<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#local.detail#">,
		<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#local.message#">,
		<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#local.type#">,
		now() )
		</cfquery>
	</cffunction>
</cfcomponent>