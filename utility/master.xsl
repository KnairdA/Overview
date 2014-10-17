<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="xml"
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
	omit-xml-declaration="yes"
	encoding="UTF-8"
	indent="no"
/>

<xsl:variable name="root" select="/datasource"/>

<xsl:template match="/">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta name="robots" content="all"/>
	<meta name="viewport" content="width=device-width,initial-scale=1.0"/>
</head>
<body>
	<xsl:apply-templates />
</body>
</html>
</xsl:template>

<xsl:template match="text()|@*"/>

</xsl:stylesheet>
