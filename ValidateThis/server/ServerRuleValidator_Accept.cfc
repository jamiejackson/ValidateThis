component
	output="false"
	name="ServerRuleValidator_Accept"
	extends="AbstractServerRuleValidator_Upload"
	hint="I am responsible for performing the Accept validation."
{

	public any function validate (
		required any validation hint="The validation object created by the business object being validated.",
		required string locale hint="The locale to use to generate the default failure message."
	)
		hint = "I perform the validation returning info in the validation object."
	{
		var parameters = arguments.validation.getParameters();
		var theValue = arguments.validation.getObjectValue();
		var args = [arguments.validation.getPropertyDesc()];
		
		if ( !structKeyExists(parameters, "accept") ) {
			throw(
				type="validatethis.server.ServerRuleValidator_Accept.missingParameter",
				message="An accept parameter must be defined for an accept rule type."
			);
		}
		
		var isValid = true;
		if ( len(trim(theValue)) > 0 ) {
			var formFieldName = validation.getClientFieldName();
			var fileMimeType = getFileUploadUtil().getUploadFileMimeType(formFieldName);
			var validMimeTypes = parameters.accept;
			
			isValid = listFind(
				validMimeTypes,
				fileMimeType,
				"|"
			);
		}
		
		if ( shouldTest(arguments.validation) AND !isValid ) {
			fail(arguments.validation,variables.messageHelper.getGeneratedFailureMessage("defaultMessage_Accept",args,arguments.locale));
		}
	}
	
}