<!---
	
	// **************************************** LICENSE INFO **************************************** \\
	
	Copyright 2010, Bob Silverberg
	
	Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in 
	compliance with the License.  You may obtain a copy of the License at 
	
		http://www.apache.org/licenses/LICENSE-2.0
	
	Unless required by applicable law or agreed to in writing, software distributed under the License is 
	distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or 
	implied.  See the License for the specific language governing permissions and limitations under the 
	License.
	
--->
<cfcomponent extends="validatethis.unitTests.SRV.BaseForServerRuleValidatorTests" output="false">
	
	<cffunction name="getSRV" access="private" returntype="Any">
		<cfargument name="validation" />
		<cfargument name="defaultLocale" required="false" default="en_US" />
		<cfargument name="defaultFailureMessagePrefix" required="false" default="The " />
		
		<cfreturn CreateObject("component","ValidateThis.server.ServerRuleValidator_#arguments.validation#").init(
			messageHelper = msgHelper,
			defaultFailureMessagePrefix = arguments.defaultFailureMessagePrefix,
			fileUploadUtil = new validateThis.util.FileUploadUtil()
		) />
		
	</cffunction>
	
	<cffunction name="setUp" access="public" returntype="void">
		<cfscript>
			super.setup();
			SRV = getSRV("Accept");
			parameters = {accept="text/plain|application/pdf"};
		</cfscript>
	</cffunction>
	
	<cffunction name="validateReturnsFalseForInvalidContentType" access="public" returntype="void">
		<cfscript>
			objectValue = 1;
			configureValidationMock();
			var fileUploadUtilMock = mock(SRV.getFileUploadUtil());
			fileUploadUtilMock.getUploadFileMimeType("{string}").returns("application/x-msdownload");
			executeValidate(validation);
			validation.verifyTimes(1).fail("{*}"); 
		</cfscript>  
	</cffunction>
	
	<cffunction name="validateReturnsTrueForValidContentType" access="public" returntype="void">
		<cfscript>
			objectValue = 1;
			configureValidationMock();
			var fileUploadUtilMock = mock(SRV.getFileUploadUtil());
			fileUploadUtilMock.getUploadFileMimeType("{string}").returns("application/pdf");
			executeValidate(validation);
			validation.verifyTimes(0).fail("{*}"); 
		</cfscript>  
	</cffunction>
	<!--- 
	<cffunction name="validateReturnsFalseForInvalidMax" access="public" returntype="void">
		<cfscript>
			objectValue = 6;
            configureValidationMock();		
			
			executeValidate(validation);
			validation.verifyTimes(1).fail("{*}"); 
		</cfscript>  
	</cffunction>
	
	<cffunction name="validateReturnsFalseForEmptyPropertyIfRequired" access="public" returntype="void" 
		hint="Need to override this from the base test as it isn't valid in here">
	</cffunction>
	
	<cffunction name="failureMessageIsCorrect" access="public" returntype="void">
		<cfscript>
			objectValue = "6";
            failureMessage = "The PropertyDesc must be no more than 5.";
			
			configureValidationMock();
			
			executeValidate(validation);
			validation.verifyTimes(1).fail(failureMessage); 
		</cfscript>  
	</cffunction>
	 --->
</cfcomponent>