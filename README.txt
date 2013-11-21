********************************************************************************
Copyright Since 2005 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
www.coldbox.org | www.luismajano.com | www.ortussolutions.com
********************************************************************************
HONOR GOES TO GOD ABOVE ALL
********************************************************************************
Because of His grace, this project exists. If you don't like this, then don't read it, its not for you.

"Therefore being justified by faith, we have peace with God through our Lord Jesus Christ:
By whom also we have access by faith into this grace wherein we stand, and rejoice in hope of the glory of God.
And not only so, but we glory in tribulations also: knowing that tribulation worketh patience;
And patience, experience; and experience, hope:
And hope maketh not ashamed; because the love of God is shed abroad in our hearts by the 
Holy Ghost which is given unto us. ." Romans 5:5

********************************************************************************
WELCOME TO OUR S3 AMAZON EXPLORER
********************************************************************************
Amazon S3 REST Wrapper and Explorer
Created & copyright by Luis Majano (Ortus Solutions, Corp)
Luis Majano (lmajano@ortussolutions.com)
Based on Joe Danziger (joe@ajaxcf.com) with much help from dorioo on the Amazon S3 Forums.  
Thanks to Steve Hicks for the bucket ACL updates.
Thanks to Carlos Gallupa for the EU storage location updates.
Thanks to Joel Greutman for the fix on the getObject link.
Thanks to Jerad Sloan for the Cache Control headers.
Thanks to Curt Gratz for collaboration and fixes
Thanks to Alagukannap "Al" for his constributions

Version 2.0
* ColdFusion 10 bug fixes with XMLSearch and XPath 2.0

Version 1.5
* Fixes by Curt Gratz and CKH on filename characters

Version 1.4
* Updates to ColdBox 3.0 compat and cleanup
* auth URL fixes
* folder support for buckets thanks to Alagukannan Alagappan!

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


********************************************************************************
INSTALLATION
********************************************************************************
You will have to create some settings in your Module configuration file:

s3_accessKey : The Amazon access key
s3_secretKey : The Amazon secret key
s3_encryption_charset : encryptyion charset (Optional, defaults to utf-8)
s3_ssl : Whether to use ssl on all cals or not (Optional, defaults to false)

Also, the module requires wirebox to be enabled and SES to be enabled.