<cfoutput>
<h1><img src="#prc.root#/includes/images/disks.png" alt="disks" /> My Amazon S3 API Docs</h1>

<div id="button-bar">
	<ul>
		<li>
			<a href="#event.buildLink('s3explorer')#" class="hotbutton">
				<span><img src="#prc.root#/includes/images/arrow-return.png" alt="return" border="0" /> Explorer Home</span>
			</a>
		</li>
	</ul>
</div>

#rc.viewer.renderit()#
</cfoutput>