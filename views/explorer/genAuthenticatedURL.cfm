<cfoutput>
<h1><img src="#prc.root#/includes/images/security.png" alt="security" /> Timed Expired Secure Link</h1>
<p>Click to select URL</i>.

<form>
<textarea cols='40' rows='5' onclick="selectAll(this)">#rc.timedLink#</textarea>
</form>
<script type="text/javascript">
function selectAll(text){
	text.focus();
	text.select();
}
</script>
</cfoutput>