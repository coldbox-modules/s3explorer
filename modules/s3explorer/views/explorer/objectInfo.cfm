<cfoutput>
<h1><img src="#rc.root#/includes/images/info.png" alt="disks" /> Info > #rc.bucketName#/#rc.objectKey#</h1>

<table width="98%">
<thead>
<tr>
	<th>Property</th>
	<th>Value</th>
</tr>
</thead>
<tbody>
<cfloop collection="#rc.info#" item="key">
	<tr>
		<td>#key#</td>
		<td>#rc.info[key]#</td>
	</tr>
</cfloop>
</tbody>
</table>

</cfoutput>