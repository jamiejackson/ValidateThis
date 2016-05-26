component
	output="false"
	name="ServerRuleValidator_Extension"
	extends="AbstractServerRuleValidator_Upload"
	hint="I am responsible for performing the Extension validation."
{

	public any function validate(
		required any validation hint="The validation object created by the business object being validated.",
		required string locale hint="The locale to use to generate the default failure message."
	)
		hint = "I perform the validation returning info in the validation object."
	{
		var parameters = arguments.validation.getParameters();
		var theValue = arguments.validation.getObjectValue();
		var args = [arguments.validation.getPropertyDesc()];
		
		if ( !structKeyExists(parameters, "extension") ) {
			throw(
				type="validatethis.server.ServerRuleValidator_Extension.missingParameter",
				message="An extension parameter must be defined for an extension rule type."
			);
		}
		
		var isValid = true;
		if ( len(trim(theValue)) > 0 ) {
			var formFieldName = validation.getClientFieldName();
			var fileName = getFileUploadUtil().getUploadFileName(formFieldName);
			var fileExtension = getFileUploadUtil().getFileExtension(fileName);
			var validFileExtensions = parameters.extension;
			
			isValid = listFind(
				validFileExtensions,
				fileExtension,
				"|"
			);
		}
		
		if ( shouldTest(arguments.validation) AND !isValid ) {
			fail(arguments.validation,variables.messageHelper.getGeneratedFailureMessage("defaultMessage_Extension",args,arguments.locale));
		}
	}
	
}