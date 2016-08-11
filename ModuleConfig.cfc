component{

	// Module Properties
	this.title 				= "Amazon S3 Explorer";
	this.author 			= "Ortus Solutions";
	this.webURL 			= "https://www.ortussolutions.com";
	this.description 		= "A Cool Amazon S3 Explorer Module For ColdBox";
	this.version			= "3.0.0";
	this.viewParentLookup 	= true;
	this.layoutParentLookup = true;
	this.entryPoint			= "s3explorer";
	this.dependencies 		= [ "cbMessageBox" ];
	
	function configure(){

		settings = {
			accessKey 			= "",
		    secretKey 			= "",
		    encryption_charset 	= "utf-8",
		    ssl 				= false,
		    tempUploadDirectory = expandPath( "/#moduleMapping#/_tmp" )
		}

		// Layout Settings
		layoutSettings = { defaultLayout = "S3Layout.cfm" };
		
		// SES Routes
		routes = [
			{ pattern="/", handler="explorer", action="index" },
			{ pattern="/bucket/:bucketname/:foldername?", handler="explorer", action="viewBucket" },
			{ pattern="/:handler/:action?" }
		];	
	}
	
	/**
	* Fired when the module is registered and activated.
	*/
	function onLoad(){
		// parse parent settings
		parseParentSettings();

		binder.map( "AmazonS3@s3Explorer" )
			.to( "#moduleMapping#.models.AmazonS3" )
			.initArg( name="accessKey", value=settings.accessKey )
			.initArg( name="secretKey", value=settings.secretKey )
			.initArg( name="encryption_charset", value=settings.encryption_charset )
			.initArg( name="ssl", value=settings.ssl );
	}
	
	/**
	* Fired when the module is unregistered and unloaded
	*/
	function onUnload(){
		
	}	

	//**************************************** PRIVATE ************************************************//	

	/**
	* parse parent settings
	*/
	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var s3explorer 		= oConfig.getPropertyMixin( "s3explorer", "variables", structnew() );

		// defaults
		configStruct.s3explorer = settings;

		// incorporate settings
		structAppend( configStruct.s3explorer, s3explorer, true );

	}

}