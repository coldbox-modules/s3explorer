<cffunction name="parseISO8601" access="public" output="false" returntype="string" hint="Parse a UTC or iso8601 date to a normal CF datetime object: <a href='http://en.wikipedia.org/wiki/ISO_8601'>http://en.wikipedia.org/wiki/ISO_8601</a>, usually follows the YYYY-MM-DDThh:mm:ss format">
	<!--- ******************************************************************************** --->
	<cfargument name="datetime" type="string" required="true" hint="The datetime string to convert"/>
	<!--- ******************************************************************************** --->
	<cfset var returnDate = arguments.datetime>
	<cfset var datebits = structnew()>
	<cfset var roundedSeconds = "00">
	<cfset var wddxPacket = "">

	<!--- Date Bits Initialization --->
	<cfset datebits.main = returnDate>
	<cfset datebits.offset = "">

	<!--- Parse if its an ISO Date --->
	<cfif REFind("[[:digit:]]T[[:digit:]]", datebits.main)>
		<cfscript>
		/* Test for Z */
		if( datebits.main contains "Z" ){
			/* Set Offset to 0 and replace the Z with nothing. */
			datebits.offset = "+00:00";
			datebits.main = replace(arguments.datetime, "Z", "", "ONE");
		}
		/* test for containz + */
		else if( datebits.main contains "+"){
			/* Split offset and remove it from main datetime */
			datebits.offset = "+" & ListLast(datebits.main,"+");
			datebits.main = replace(datebits.main,datebits.offset,"","ONE");
		}
		else{
			/* Split negative offset and remove it from main datetime */
			datebits.offset = "-" & ListLast(datebits.main,"-");
			datebits.main = replace(datebits.main,datebits.offset,"","ONE");
		}
		/* If no seconds, add them */
		if( listLen(datebits.main, ":") lt 3){
			datebits.main = datebits.main & ":00";
		}
		/* If it has fractional seconds, round it up. BIG DEAL!! */
		roundedSeconds = numberFormat(round(listLast(datebits.main,":")),"00");
		datebits.main =	listSetAt(datebits.main, listLen(datebits.main,":"), roundedSeconds,":");
		/* Append All */
		datebits.main = datebits.main & datebits.offset;

		/* Wddx hack to get a datetime object */
		wddxPacket = "<wddxPacket version='1.0'><header/><data><dateTime>#datebits.main#</dateTime></data></wddxPacket>";
		</cfscript>
		<!--- WDDX Hack --->
		<cfwddx action="wddx2cfml" input="#wddxPacket#" output="wddxPacket" />
		<cfset returnDate = DateConvert("local2utc", wddxPacket) />
	</cfif>

	<!--- Return the date --->
	<cfreturn returnDate>
</cffunction>