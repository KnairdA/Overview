<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/xhtml.xsl]"/>
<xsl:include href="[utility/master.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main" mode="iterate" source="02_augment/formatted_commits.xml" target="repositories"/>
	<target     mode="xpath" value="concat($datasource/repositories/entry/@handle, '/index.html')"/>
</xsl:variable>

<xsl:template match="repositories/entry/commit/message">
	<xsl:copy-of select="node()"/>
</xsl:template>

</xsl:stylesheet>
