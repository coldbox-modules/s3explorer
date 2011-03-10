<cfoutput>
<h1><img src="#rc.root#/includes/images/disks.png" alt="disks" /> My Amazon S3 Buckets</h1>

#getPlugin("Messagebox").renderit()#

<!--- Button Bar --->
<div id="button-bar">
	<ul>
		<li>
			<a href="javascript:createBucket()" class="hotbutton">
				<span><img src="#rc.root#/includes/images/add.png" alt="add" border="0" /> Create Bucket</span>
			</a>
		</li>
		<li>
			<a href="#event.buildLink(linkTo='s3explorer')#" class="hotbutton">
				<span><img src="#rc.root#/includes/images/reload.png" alt="reload" border="0" /> Reload</span>
			</a>
		</li>
		<li>
			<a href="#event.buildLink(linkTo='s3explorer.explorer.docs')#" class="hotbutton">
				<span><img src="#rc.root#/includes/images/help.png" alt="reload" border="0" /> API Help</span>
			</a>
		</li>
	</ul>
</div>

<!--- Generic Dialog --->
<div id="dialog"><img src="#rc.root#/includes/images/ajax-loader.gif" alt="loader" id="ajaxLoader" /></div>

<!--- Create Dialog --->
<div id="createDialog">
<form action="#event.buildLink('s3explorer.explorer.createbucket')#" method="post">
	<fieldset>
		<legend>Create Bucket</legend>
		
		<label for="bucketName">Bucket Name:</label>
		<input type="text" name="bucketName" size="30" />
		
		<label for="acl">ACL Policy:</label>
		<select name="acl">
			<option value="private">Private</option>
			<option value="public-read">Public-Read</option>
			<option value="public-read-write">Public-Read-Write</option>
			<option value="authenticated-read">Authenticated-Read</option>
		</select>
		
		<label for="storage">Storage Location:</label>
		<select name="storage">
			<option value="US">United States</option>
			<option value="EU">Europa</option>
		</select>
		
		<br/>
		<div id="actionBar">
			<input type="button" class='simplemodal-close' onClick='$.modal.close()' value="Cancel" />
			<input type="submit" name="createBucket" value="Create Bucket" />	
		</div>
		
	</fieldset>
</form>
</div>

<!--- Buckets Table --->
<table id="bucketsTable" class="tablesorter">
<thead>
<tr>
	<th>Bucket</th>
	<th width="200">Creation</th>
	<th class="actions {sorter: false}">Actions</th>
</tr>
</thead>
<tbody>
<cfloop array="#rc.allBuckets#" index="bucket">
<tr>
	<td>
		<a href="#event.buildLink(linkTo='s3explorer.bucket',queryString="#URLEncodedFormat(bucket.Name)#")#"
		   title="Go into bucket">
		   <img src="#rc.root#/includes/images/folder.gif" alt="folder" border="0" />#bucket.Name#
		</a>
	</td>
	<td>
		#dateFormat(getPlugin("DateUtils").parseISO8601(bucket.CreationDate),"mm/dd/yy")#
		#timeFormat(getPlugin("DateUtils").parseISO8601(bucket.CreationDate),"hh:mm tt")#
	</td>
	<td class="center">
		<a href="#event.buildLink('s3explorer.explorer.viewBucket.bucketName.' & URLEncodedFormat(bucket.Name))#"
		   title="Go into bucket">
			<img src="#rc.root#/includes/images/view.png" border="0" alt="view" />
		</a>
		
		<a href="javascript:showACL('#bucket.name#')"
		   title="Show bucket ACL">
			<img src="#rc.root#/includes/images/security.png" border="0" alt="security" />
		</a>
		
		<a href="#event.buildLink('s3explorer.explorer.removeBucket.bucketName.' & URLEncodedFormat(bucket.Name))#" 
		   onClick="return confirm('Really Delete?')"
		   title="Remove object">
			<img src="#rc.root#/includes/images/delete.png" border="0" alt="delete" />
		</a>
	</td>
</tr>
</cfloop>
</tbody>
</table>

<script type="text/javascript">
$(document).ready(function() {
	$("##bucketsTable").tablesorter();
});

var closeHTML = "<p><button class='simplemodal-close' onClick='$.modal.close()'>Close-Cancel</button> <span>(or press ESC to cancel)</span></p>";
	
function createBucket(){
	$("##createDialog").modal({minWidth:500,overlayClose:true});
}
function showACL(bucket){
	var data = {objectName:bucket};
	$("##dialog").load('#event.buildLink("s3explorer.explorer.objectACL")#',
						data,
						function(){
							$(this).append(closeHTML);
						}).modal({minWidth:600,overlayClose:true});
}
</script>
</cfoutput>