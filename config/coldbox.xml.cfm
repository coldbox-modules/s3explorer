<?xml version="1.0" encoding="UTF-8"?>
<!-- 
For all possible configuration options please refer to the documentation:
http://ortus.svnrepository.com/coldbox/trac.cgi/wiki/cbConfigGuide
 -->
<Config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
	xsi:noNamespaceSchemaLocation="http://www.coldbox.org/schema/config_3.0.0.xsd">
	<Settings>
		<!-- Application Setup-->
		<Setting name="AppName"						value="S3 Explorer"/>
		<!-- If you are using a coldbox app to power flex/remote apps, you NEED to set the AppMapping also. In Summary,
			 the AppMapping is either a CF mapping or the path from the webroot to this application root. If this setting
			 is not set, then coldbox will try to auto-calculate it for you. Please read the docs.
		<Setting name="AppMapping"					value="/MyApp"/> -->
		
		<!-- Development Settings -->
		<Setting name="DebugMode" 					value="true"/>
		<Setting name="DebugPassword" 				value=""/>
		<Setting name="ReinitPassword" 				value=""/>
		<Setting name="HandlersIndexAutoReload" 	value="true"/>
		<Setting name="HandlerCaching" 				value="false"/>
		<Setting name="EventCaching" 				value="false"/>
		
		<!-- Implicit Events -->
		<Setting name="DefaultEvent" 				value="Explorer.index"/>
		<Setting name="RequestStartHandler" 		value=""/>
		<Setting name="RequestEndHandler" 			value=""/>
		<Setting name="ApplicationStartHandler" 	value=""/>
		<Setting name="SessionStartHandler" 		value=""/>
		<Setting name="SessionEndHandler" 			value=""/>
		<Setting name="MissingTemplateHandler"		value=""/>
		
		<!-- Error/Exception Handling -->
		<Setting name="ExceptionHandler" 			value=""/>
		<Setting name="onInvalidEvent" 				value=""/>
		<Setting name="CustomErrorTemplate"			value="" />
	</Settings>

	<YourSettings>
		<!-- YOUR AMAZON CREDENTIALS -->
		<Setting name="s3_accessKey" value="" />
		<Setting name="s3_secretKey" value="" />
		<Setting name="s3_ssl" value="false" />
	</YourSettings>
	
	<!-- 
		ColdBox Logging via LogBox
		Levels: -1=OFF,0=FATAL,1=ERROR,2=WARN,3=INFO,4=DEBUG
	-->
	<LogBox>
		<Appender name="coldboxTracer" class="coldbox.system.logging.appenders.ColdboxTracerAppender" />
		<Root levelMin="FATAL" levelMax="DEBUG" appenders="*" />
		<Category name="coldbox.system" levelMax="INFO" />
	</LogBox>
	
	<Layouts>
		<DefaultLayout>Layout.Main.cfm</DefaultLayout>
	</Layouts>

	<Interceptors>
		<!-- USE AUTOWIRING -->
		<Interceptor class="coldbox.system.interceptors.Autowire" />
		<!-- USE SES -->
		<Interceptor class="coldbox.system.interceptors.SES" />		
	</Interceptors>
	
</Config>