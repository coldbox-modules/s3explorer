Welcome to our amazing S3 Amazon Explorer.

> Based on Joe Danziger (joe@ajaxcf.com) with much help from dorioo on the Amazon S3 Forums.  

* Thanks to Steve Hicks for the bucket ACL updates.
* Thanks to Carlos Gallupa for the EU storage location updates.
* Thanks to Joel Greutman for the fix on the getObject link.
* Thanks to Jerad Sloan for the Cache Control headers.
* Thanks to Curt Gratz for collaboration and fixes
* Thanks to Alagukannap "Al" for his constributions


## Important Links
* Source: https://github.com/coldbox-modules/s3explorer
* Issues: https://github.com/coldbox-modules/s3explorer/issues
* S3 SDK: https://github.com/coldbox-modules/s3sdk
* [Changelog](changelog.md)

## Installation

Use CommandBox to install the module:

```
box install s3explorer
```

## Settings

You will have to create a struct called `s3sdk` in your ColdBox configuration `config/Coldbox.cfc` in order for the SDK to connect to Amazon with your credentials:

```
s3sdk = {
    // Your amazon access key
    accessKey = "",
    // Your amazon secret key
    secretKey = "",
    // The default encryption character set
    encryption_charset = "utf-8",
    // SSL mode or not on cfhttp calls.
    ssl = false,
    // Temp directory before uploading to s3
    tempuploaddirectory = "/tmp"
};
```

Once installed just visit the entry point: `/s3explorer` and enjoy your S3 Buckets.
