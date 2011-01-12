Amazon S3 REST Wrapper

Based on Joe Danziger (joe@ajaxcf.com) with much help from
dorioo on the Amazon S3 Forums.  See the readme for more
details on usage and methods.
Thanks to Steve Hicks for the bucket ACL updates.
Thanks to Carlos Gallupa for the EU storage location updates.
Thanks to Joel Greutman for the fix on the getObject link.
Thanks to Jerad Sloan for the Cache Control headers.

Version 1.4
* Cleanup and fixes for gen auth URLs

Version 1.3 
* Fixed encoding signatures of time expired links for adobe cf.

Version 1.2
* Fixed the ability to add credentials on the fly.

Version 1.1
* Ability to add content-disposition headers when putting objects
* Caching headers to actual ColdBox plugin
* LogBox logging
 
Version 1.0
 * Initial Release


You will have to create some settings in your ColdBox configuration file:

s3_accessKey : The Amazon access key
s3_secretKey : The Amazon secret key
s3_encryption_charset : encryptyion charset (Optional, defaults to utf-8)
s3_ssl : Whether to use ssl on all cals or not (Optional, defaults to false)