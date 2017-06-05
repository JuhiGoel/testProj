<cfcomponent name="user" output="false">

	<!---- CREATE NEW USER ------------------>
	<cffunction name="createNewUser" access="remote" returnformat="json" returntype="struct">
		<cfargument name="first_name" type="string" required="false"	default="">
		<cfargument name="last_name" type="string" required="false"	default="">
		<cfargument name="phone_number" type="string" required="false"	default="">
		<cfargument name="email_id" type="string" required="false"	default="">
		<cfargument name="password" type="string" required="false" default="">
		<cfargument name="confirm_password" type="string" required="false" default="">
		
		<cfset local.results = structNew()>
		<cfset local.results['error'] = "">
		<cfset local.results['sessionExist'] = false>
		
		<!--- check if session exist --->
		<cfif structKeyExists(session,'user')>
			<cfset local.results.sessionExists = 'true'>
			<cfset local.results['userName'] = session.user.name>
			<cfreturn local.results>
		</cfif>
		
		<!--- field validations --->
		<cfif NOT len(trim(arguments.first_name))>
			<cfset local.results.error = "First name is required.">
			<cfreturn local.results>
		</cfif>
		<cfif NOT len(trim(arguments.last_name))>
			<cfset local.results.error = "First name is required.">
			<cfreturn local.results>
		</cfif>
		<cfif NOT len(trim(arguments.phone_number))>
			<cfset local.results.error = "Phone number is required.">
			<cfreturn local.results>
		<cfelseif NOT reFind("^(((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4})|\d{10}$", arguments.phone_number)>
			<cfset local.results.error = "Please enter a valid phone number.">
			<cfreturn local.results>
		</cfif>
		<cfif NOT len(trim(arguments.email_id))>
			<cfset local.results.error = "Email Id is required.">
			<cfreturn local.results>
		<cfelseif NOT isValid("email",arguments.email_id)>
			<cfset local.results.error = "Please enter a valid phone number.">
			<cfreturn local.results>
		</cfif>
		<cfif NOT len(trim(arguments.password))>
			<cfset local.results.error = "Password is required.">
			<cfreturn local.results>
		<cfelseif arguments.password NEQ arguments.confirm_password>
			<cfset local.results.error = "Password and confirm passord does not match.">
			<cfreturn local.results>
		</cfif>
		
		<!--- check duplicate email_id --->
		<cfset local.checkDuplicate = checkDuplicateUser(arguments.email_id)>
		<cfif len(local.checkDuplicate.error)>
			<cfset local.results.error = "Some internal error has occured, Please try again.">
			<cfreturn local.results>
		<cfelseif local.checkDuplicate.count>
			<cfset local.results.error = "We already have this email id in our records.">
			<cfreturn local.results>
		</cfif>
		
		<!--- create new user --->
		<cftry>

			<cfquery name="local.addUser" datasource="#application.datasource#">
				INSERT INTO user_name(
					first_name,
					last_name,
					phone_number,
					email_id,
					password
				)
				VALUES(
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.first_name#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.last_name#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.phone_number#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_id#">,
					<cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(hash(arguments.password, 'MD5'), 'MD5')#">
				)	
			</cfquery>
		<cfcatch>

			<!--- log error ---->
			<cfset application.objErrorLog.logError(methodName = "Create New User"
													, cfCatch = cfCatch)>
			<cfset local.results.error = "Error occured while creating user, Please try again.">
			<cfreturn local.results>

		</cfcatch>
		</cftry>
		<cfreturn local.results>
	</cffunction>

	<!---- CHECK DUPLICATE USER ------------------>
	<cffunction name="checkDuplicateUser" returnformat="json" returntype="struct">
		<cfargument name = "email" type="string" required="true">
		
		<cfset local.result =  structNew()>
		<cfset local.results.count = 0>
		<cfset local.results['error'] = "">
		<cftry>
			<cfquery name="local.checkUserByEmail" datasource="#application.datasource#">
				SELECT email_id 
				FROM user_name
				WHERE email_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email#">
			</cfquery>

			<cfset local.results.count = local.checkUserByEmail.recordCount>
		<cfcatch>

			<!--- log error ---->
			<cfset application.objErrorLog.logError(methodName = "Check Duplicate User"
													, cfCatch = cfCatch)>

			<cfset local.results.error = "Error">
		</cfcatch>
		</cftry>
		<cfreturn local.results>
	</cffunction>

	<!----USER LOGIN ------------------>
	<cffunction name="userLogin" access="remote" returnformat="json" returntype="struct">
		<cfargument name="email_id" type="string" required="true">
		<cfargument name="password" type="string" required="true">

		<cfset local.results =  structNew()>
		<cfset local.results['error'] = "">
		<cfset local.results['userName'] = "">
		
		<cfif structKeyExists(session, 'user')>
			<cfset local.result.error = "Invalid request.">
			<cfreturn local.results>
		</cfif>

		<cftry>
			<cfquery name="local.checkCredentials" datasource="#application.datasource#">
				SELECT first_name,
					last_name,
					user_id
				FROM user_name
				WHERE email_id = <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.email_id#">
				AND password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#hash(hash(arguments.password, 'MD5'), 'MD5')#">
			</cfquery>

			<cfif NOT local.checkCredentials.recordCount>
				<cfset local.results.error = "Invalid Email Id/Password">
				<cfreturn local.results>
			</cfif>
			
			<cfset local.results.userName = #local.checkCredentials.first_name# &' '&#local.checkCredentials.last_name#>

			<cflock scope="session" timeout="10" type="exclusive">
				<cfset session.user = {
					name = local.results.userName,
					id = local.checkCredentials.user_id,
					email = arguments.email_id
				}/>
			</cflock>
		<cfcatch>
			
			<!--- error log --->
			<cfset application.objErrorLog.logError(methodName = "USER LOGIN"
													, cfCatch = cfCatch)>
			<cfset local.results.error = "Some internal error has occured. Please try again.">
			<cfreturn local.results>
		</cfcatch>
		</cftry>
		<cfreturn local.results>
	</cffunction>

	<!---- USER LOGOUT ------------------>
	<cffunction name="userLogout" access="remote" returnformat="json" returntype="struct">

		<!--- Set local variables --->
		<cfset local.results = structNew()>
		<cfset local.results['error'] = "">
		<cfif NOT structKeyExists(session, 'user')>
			<cfset local.results.error = "invalid requiest.">
			<cfreturn local.results>
		</cfif>
		<cftry>
			<cflock scope="session" timeout="10" type="exclusive">
	
				<!--- Delete User Session --->
				<cfset structDelete(session,'user')>
			</cflock>
		<cfcatch>
			
			<!--- error log --->
			<cfset application.objErrorLog.logError(methodName = "USER LOGIN"
													, cfCatch = cfCatch)>
													
			<cfset local.results.error =  "error occured while trying to log out">
		</cfcatch>
		</cftry>
		<cfreturn local.results>
	</cffunction>
</cfcomponent>