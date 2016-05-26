component
	output=false
	name="AbstractServerRuleValidator_Upload"
	hint="I am an abstract validator responsible for performing one specific type of upload validation."
	extends="AbstractServerRuleValidator"
	accessors=true
{
	property name="fileUploadUtil";

	public any function init(
		required any messageHelper,
		required string defaultFailureMessagePrefix,
		required any fileUploadutil
	)
		hint = "I build a new ServerRuleValidator"
	{
		setFileUploadUtil(fileUploadUtil);
		return super.init(messageHelper, defaultFailureMessagePrefix);
	}

}