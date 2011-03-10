<cfcomponent extends="coldbox.system.EventHandler" output="false">	<!--- Dependencies --->	<cfproperty name="s3" inject="coldbox:myplugin:AmazonS3@s3explorer" />		<!--- Advice only/exceptions --->	<cfset this.preHandler_except = "authenticate" />	<!--- preHandler --->	<cffunction name="preHandler" output="false">		<cfargument name="event" required="true">		<cfscript>			var rc = event.getCollection();						// Verify Authentication			if(NOT len(getSetting("s3_accessKey")) OR NOT len(getSetting("s3_secretKey")) ){				event.overrideEvent('s3explorer:explorer.authenticate');			}						// module root			rc.root = event.getModuleRoot();		</cfscript>	</cffunction>		<!--- authenticate --->
    <cffunction name="authenticate" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>    		    		var rc = event.getCollection();    		    		if( event.valueExists('authButton') ){				// Save credentials				setSetting("s3_accessKey",rc.accessKey);				setSetting("s3_secretKey",rc.secretKey);				s3.setAuth(rc.accessKey,rc.secretKey);				// relocate				setNextEvent('s3explorer/explorer');			}    		
    		event.setView("explorer/authenticate");
    	</cfscript>
    </cffunction>	<!--- Default Action --->	<cffunction name="index" returntype="void" output="false" hint="My main event">		<cfargument name="event" required="true">		<cfscript>			var rc = event.getCollection();						rc.allBuckets = s3.listBuckets();					</cfscript>	</cffunction>		<!--- createBucket --->
    <cffunction name="createBucket" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();    		s3.putBucket(rc.bucketName,rc.acl,rc.storage);			getPlugin("MessageBox").setMessage(type="info", message="bucket created");			setNextEvent('s3explorer');
    	</cfscript>
    </cffunction>		<!--- removeBucket --->
    <cffunction name="removeBucket" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	    		var rc = event.getCollection();
    		if( s3.deleteBucket(rc.bucketName) ){				getPlugin("MessageBox").setMessage(type="info", message="Bucket Removed!");			}			else{				getPlugin("MessageBox").setMessage(type="error", message="S3 service could not remove bucket. Please refer to debugging information.");			}			setNextEvent("s3explorer");
    	</cfscript>
    </cffunction>		<!--- viewBucket --->
    <cffunction name="viewBucket" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();    		    		event.paramValue("delimiter","/");			event.paramValue("folderName","");			// do we have a folder to display?			if (len(rc.folderName) > 0){				rc.foldername = replacenocase(rc.foldername,"|","/", "all") & '/';			}	    		rc.allObjects = s3.getBucket(bucketName=replace(rc.bucketName,"|","/","all"), delimiter = "#rc.delimiter#", prefix = "#rc.folderName#");  					rc.allBuckets = s3.listBuckets();
    	</cfscript>
    </cffunction>		<!--- genAuthenticatedURL --->
    <cffunction name="genAuthenticatedURL" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();						rc.timedLink = s3.getAuthenticatedURL(bucketName=rc.bucketname,uri=rc.key,virtualHostStyle=true);						event.renderData(data=renderView("explorer/genAuthenticatedURL"));
    	</cfscript>
    </cffunction>		<!--- getObjectInfo --->    <cffunction name="getObjectInfo" access="public" returntype="void" output="false" hint="">    	<cfargument name="Event" type="any" required="yes">    	<cfscript>	    		var rc = event.getCollection();    		rc.info = s3.getObjectInfo(rc.bucketname,rc.objectKey);			event.renderData(data=renderView("explorer/objectInfo"));    	</cfscript>    </cffunction>		<!--- uploadFile --->
    <cffunction name="upload" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();			var tempDir = getSetting("s3_tempUploadDirectory");			var fileInfo = getPlugin("FileUtils").uploadFile(fileField="fileobject",											  				 destination=tempDir,											 			 	 mode="666",															 NameConflict="overwrite");			var returnFolderPath = "";			if ( listLen(rc.foldername) ){				returnFolderPath = replacenocase(reverse(replacenocase(reverse(rc.foldername),"/","","one")),"/","|","all");			}			// Inflate json metadata			if( NOT len(event.getTrimValue("extraMetadata")) ){ rc.extrametadata = "{}"; }			rc.extrametadata = getPlugin("JSON").decode(rc.extrametadata);						try{				rc.results = s3.putObjectFile(bucketName=rc.bucketName,										      filePath=fileInfo.serverDirectory & "/" & fileInfo.serverFile,										      uri=rc.foldername & getFileFromPath(fileInfo.serverDirectory & "/" & fileInfo.serverFile),										      contentType=fileInfo.contentType,										      cacheControl=event.getTrimValue("cc"),										      expires=event.getTrimValue("expires"),										      acl=rc.acl,										      metaHeaders=rc.extrametadata);											  				getPlugin("MessageBox").setMessage(type="info", message="Uploaded file with etag: #rc.results#");			}			catch(Any e){				getPlugin("MessageBox").setMessage(type="error", message="Error uploading file: #e.message# #e.detail#");				log.error("Error putting file to S3",e);			}    			// remove file			fileDelete("#tempDir#/#fileInfo.serverFile#");								// relocate			setNextEvent(event="s3explorer/bucket/#urlEncodedFormat(rc.bucketName)#/#urlEncodedFormat(returnFolderPath)#");
    	</cfscript>
    </cffunction>        <!--- createFolder --->    <cffunction name="createFolder" access="public" returntype="void" output="false" hint="">    	<cfargument name="Event" type="any" required="yes">    	<cfscript>	    		var rc = event.getCollection();						try{				rc.results = s3.putObjectFolder(bucketName=rc.bucketName,											  uri = urlEncodedformat(rc.foldername & "_$folder$"),											  acl=rc.acl);											  				getPlugin("MessageBox").setMessage(type="info", message="Uploaded Folder with etag: #rc.results#");			}			catch(Any e){				getPlugin("MessageBox").setMessage(type="error", message="Error uploading Folder: #e.message# #e.detail#");				log.error("Error putting file to S3",e);			}    						// relocate			setNextEvent(event="s3explorer/bucket/#urlEncodedFormat(rc.bucketName)#/#urlEncodedFormat(replacenocase(rc.foldername,'/','|','all'))#");    	</cfscript>    </cffunction>		<!--- removeObject --->
    <cffunction name="removeObject" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();    		var returnFolderPath = "";			if ( listLen(rc.uri) ){				returnFolderPath = listrest(reverse(urlDecode(rc.uri)),"/");				returnFolderPath = reverse(replacenocase(returnFolderPath,"/","|","all"));			}    		if( s3.deleteObject(rc.bucketName,rc.uri) ){				getPlugin("MessageBox").setMessage(type="info", message="#rc.uri# Removed!");			}			else{				getPlugin("MessageBox").setMessage(type="error", message="S3 service could not remove object. Please refer to debugging information.");			}			setNextEvent(event="s3explorer/bucket/#urlEncodedFormat(rc.bucketName)#/#urlEncodedFormat(returnFolderPath)#");
    	</cfscript>
    </cffunction>		<!--- copyDialog --->
    <cffunction name="copyDialog" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();    		rc.allBuckets = s3.listBuckets();						event.renderData(data=renderView("explorer/copyDialog"));
    	</cfscript>
    </cffunction>		<!--- copyObject --->    <cffunction name="copyObject" access="public" returntype="void" output="false" hint="">    	<cfargument name="Event" type="any" required="yes">    	<cfscript>	    		var rc = event.getCollection();						// Inflate json metadata			if( len(event.getTrimValue("extraMetadata")) ){ rc.extrametadata = "{}"; }			rc.extrametadata = getPlugin("JSON").decode(rc.extrametadata);						// Copy			rc.results = s3.copyObject(fromBucket=rc.fromBucket,									   fromURI=rc.fromURI,									   toBucket=rc.toBucket,									   toURI=rc.toURI,									   acl=rc.acl,									   copymetaData=rc.copyMetadata,									   metaHeaders=rc.extrametadata);						getPlugin("MessageBox").setMessage(type="info", message="Object copied successfully");						// relocate			setNextEvent(event="s3explorer/bucket/#urlEncodedFormat(rc.fromBucket)#");    	</cfscript>    </cffunction>	<!--- objectACL --->
    <cffunction name="objectACL" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();			rc.grants = s3.getAcessControlPolicy(rc.objectName);    				event.renderData(data=renderView('explorer/objectACL'));
    	</cfscript>
    </cffunction>		<!--- docs --->
    <cffunction name="docs" access="public" returntype="void" output="false" hint="">
    	<cfargument name="Event" type="any" required="yes">
    	<cfscript>	
    		var rc = event.getCollection();						rc.viewer = getPlugin("CFCViewer").setup(dirpath="#getSetting('modules').s3explorer.mapping#/plugins",													 dirLink=event.buildLink('s3explorer.explorer.docs'),													 linkBaseURL=getSetting('sesBaseURL'));						event.setView('explorer/docs');
    	</cfscript>
    </cffunction><!------------------------------------------- PRIVATE EVENTS ------------------------------------------>
	</cfcomponent>