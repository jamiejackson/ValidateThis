component {

	any function init () {
		return this;
	}

	/**
	* @hint Gets an extension from a file name.
	* @fileName File name from which to get an extension.
	*/
	public string function getFileExtension(
		required string fileName
	){
		if(find(".",fileName)) return listLast(fileName,".");
		else return "";
	}

	/**
	* @hint Gets the file name of an upload file.
	* @formFieldName "Field name from which to get a file name.
	*/
	public string function getUploadFileName(
		required string formFieldName
	){
		if ( isCurrentCFMLEngineAdobe() ) {
			return getFileUploadMetadatumACF("fileName", formFieldName);
		} else {
			return getPageContext().formScope().getUploadResource(formFieldName).getName();
		}
	}
	
	/**
	* @hint Gets the mime (a.k.a., 'content') type of an upload file.
	* @formFieldName Upload field name from which to get mime type.
	*/
	public string function getUploadFileMimeType(
		required string formFieldName
	){
		if ( isCurrentCFMLEngineAdobe() ) {
			return getFileUploadMetadatumACF("contentType", formFieldName);
		} else {
			return getPageContext().formScope().getUploadResource(formFieldName).getContentType();
		}
		
	}
	
	/**
	* @hint Gets a piece of metadata about an upload file. (Adobe version.)
	* @partName Part of metadata to get about an upload part.
	* @formFieldName Upload field name from which to get mime type.
	*/
	private string function getFileUploadMetadatumACF(
		required string partName,
		required string formFieldName
	){
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
	
	/**
	* @hint Gets a piece of metadata about an upload file. (Lucee version.)
	* @partName Part of metadata to get about an upload part.
	* @formFieldName Upload field name from which to get mime type.
	*/
	private string function getFileUploadMetadatumLucee(
		required string partName,
		required string formFieldName
	){
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
	
	/**
	* @hint Is the current CFML engine Adobe? (Note: Only considers Railo/Lucee as alternatives.)
	*/
	private boolean function isCurrentCFMLEngineAdobe() {
		if ( listFindNoCase("railo,lucee", server.coldfusion.productname) ) {
			return false;
		} else {
			return true;
		}
	}
	
}