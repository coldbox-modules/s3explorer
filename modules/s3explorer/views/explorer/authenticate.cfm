<cfoutput>
<h1><img src="#rc.root#/includes/images/security.png" alt="security" /> Amazon Credentials</h1>
<p>You can either put your Amazon credentials below or you can add them
to your ColdBox configuration file as <i>s3_accessKey, s3_secretKey, s3_ssl</i>.

<form name="authForm" action="#event.buildLink('s3explorer.explorer.authenticate')#" method="post">
<label for="accessKey">Access Key: </label>
<input type="text" name="accessKey" size="35" />

<label for="secretKey">Secret Key: </label>
<input type="password" name="secretKey" size="35" />

<input type="submit" value="Submit" name="authButton" />

</form>
</cfoutput>