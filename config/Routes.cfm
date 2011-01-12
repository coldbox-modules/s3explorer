<cfscript>
	// General Properties
	setUniqueURLS(false);	
	setExtensionDetection(False);
	
	if( getSetting("environment") eq "development"){
		setAutoReload(true);
	}
	
	// Base URL
	if( len(getSetting('AppMapping') ) lte 1){
		setBaseURL("http://#cgi.HTTP_HOST#/index.cfm");
	}
	else{
		setBaseURL("http://#cgi.HTTP_HOST#/#getSetting('AppMapping')#/index.cfm");
	}
	
	// Your Application Routes
	addRoute(pattern="/bucket/:bucketname",handler="explorer",action="viewBucket");
	addRoute(pattern=":handler/:action?");
</cfscript>