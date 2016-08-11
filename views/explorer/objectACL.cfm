<cfoutput>
<h1><img src="#prc.root#/includes/images/security.png" alt="disks" /> ACL > #rc.objectName#</h1>

<table width="98%">
<thead>
<tr>
	<th>ACL Type</th>
	<th>Permission</th>
	<th>Display Name</th>
	<th>URI</th>
</tr>
</thead>
<tbody>
<cfloop array="#rc.grants#" index="grant">
	<tr>
		<td>#grant.type#</td>
		<td>#grant.permission#</td>
		<td>#grant.displayname#</td>
		<td>#grant.uri#</td>
	</tr>
</cfloop>
</tbody>
</table>
</cfoutput>