<cfoutput>
<h1><img src="includes/images/copy.png" alt="0" /> Copy Object > /#rc.fromBucket#/#rc.fromURI#</h1>

<form action="#event.buildLink('explorer.copyObject')#" method="post" name="copyForm" id="copyForm">
	
	<input type="hidden" name="fromBucket" value="#rc.fromBucket#" />
	<input type="hidden" name="fromURI" value="#rc.fromURI#" />
	
	<label for="toBucket">Destination Bucket: </label>
	<select name="toBucket" id="toBucket">
		<cfloop array="#rc.allBuckets#" index="bucket">
			<option value="#urlEncodedFormat(bucket.name)#">#bucket.name#</option>
		</cfloop>
	</select>
	
	<label for="toURI">Destination URI: </label>
	<input type="text" name="toURI" id="toURI" value="#rc.fromURI#" size="45" />
	
	<label for="acl">ACL: </label>
	<select name="acl" id="acl">
		<option selected="selected">private</option>
		<option>public-read</option>
		<option>public-read-write</option>
		<option>authenticated-read</option>
	</select>
	
	<label for="copyMetadata">Copy Metadata: </label>
	<select name="copyMetadata" id="copyMetadata">
		<option selected="selected">true</option>
		<option>false</option>
	</select>
	
	<label for="cc">Extra Metadata (As a JSON struct)</label> <em>Ex: {name:'luis',awesome:'true'} <br/>
	<input type="text" value="{}" name="extrametadata" id="extrametadata" size="40" />
	
	<br/><br/>
	
	<input type="submit" name="copy" value="Copy" />
	
</form>	
</cfoutput>