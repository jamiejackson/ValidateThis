component {

	any function init () {
		return this;
	}

	public string function getFileExtension(
		required string fileName hint="File name from which to get an extension."
	) 
		hint="Gets file extension from a file name."
	{
		if(find(".",fileName)) return listLast(fileName,".");
		else return "";
	}
	
	public string function getUploadFileName(
		required string formFieldName hint="Field name from which to get a file name."
	)
		hint="Gets the file name of an upload file."
	{
		if ( isRailoDerivative() ) {
			return getPageContext().formScope().getUploadResource(formFieldName).getName();
		} else {
			return getFileUploadMetadatumACF("fileName", formFieldName);
		}
	}
	
	public string function getUploadFileMimeType(
		required string formFieldName hint="Upload field name from which to get mime type."
	)
		hint="Gets the mime (a.k.a., 'content') type of an upload file."
	{
		if ( isRailoDerivative() ) {
			return getPageContext().formScope().getUploadResource(formFieldName).getContentType();
		} else {
			return getFileUploadMetadatumACF("contentType", formFieldName);
		}
		
	}
	
	private string function getFileUploadMetadatumACF(
		required string partName hint="Part of metadata to get about an upload part.",
		required string formFieldName
	)
		hint="Gets a piece of metadata about an upload file. (Adobe version.)"
	{
		var metaDatum = "";
		var parts = form.getPartsArray();
		if ( isDefined("parts") ) {
			for ( var part in parts ) {
				if ( part.isFile() and part.getName() eq formFieldName ) {
					if (partName == "fileName") {
						metaDatum = part.getFileName();
					} else if ( partName == "contentType" ) {
						metaDatum = part.getContentType();
					} else {
						throw("I don't know how to get the '#metaDatum#'.");
					}
				}
			}
		}
		return metaDatum;
	}
	
	private string function getFileUploadMetadatumLucee(
		required string partName hint="Part of metadata to get about an upload part.",
		required string formFieldName
	)
		hint="Gets a piece of metadata about an upload file. (Lucee version.)"
	{
		var metaDatum = "";
		if (partName == "fileName") {
			metaDatum = getPageContext()
				.formScope().getUploadResource(formFieldName).getName();
		} else if ( partName == "contentType" ) {
			metaDatum =	getPageContext()
				.formScope().getUploadResource(formFieldName).getContentType();
		} else {
			throw("I don't know how to get the '#metaDatum#'.");
		}
		return metaDatum;
	}
	
	private boolean function isRailoDerivative()
		hint="Is current CFML engine Railo or a Derivative (e.g., Lucee)?"
	{
		if ( listFindNoCase("railo,lucee", server.coldfusion.productname) ) {
			return true;
		} else {
			return false;
		}
	}
	
}