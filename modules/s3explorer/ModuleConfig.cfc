<!-----------------------------------------------------------------------
********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************

Author     :	Luis Majano
Description :
	Amazon S3 Explorer Configuration
----------------------------------------------------------------------->
<cfcomponent output="false" hint="Amazon S3 Explorer Configuration">
<cfscript>
	// Module Properties
	this.title 				= "Amazon S3 Explorer";
	this.author 			= "Luis Majano";
	this.webURL 			= "http://www.ortussolutions.com";
	this.description 		= "A Cool Amazon S3 Explorer Module For ColdBox";
	this.version			= "2.0";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "s3explorer";
	
	function configure(){
		
		// S3 Configuration Settings, go into parent so plugin can use it
		parentSettings = {
			s3_accessKey = "",
			s3_secretKey = "",
			s3_ssl		 = false,
			s3_tempUploadDirectory = expandPath("/#moduleMapping#/_tmp")
		};

		// Layout Settings
		layoutSettings = { defaultLayout = "S3Layout.cfm" };
		
		// SES Routes
		routes = [
			{pattern="/",handler="explorer",action="index"},
			{pattern="/bucket/:bucketname/:foldername?",handler="explorer",action="viewBucket"},
			{pattern="/:handler/:action?"}
		];	
	}
	
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}	
</cfscript>
</cfcomponent>