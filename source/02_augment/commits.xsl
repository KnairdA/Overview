<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="InputXSLT"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main" mode="full" source="01_raw/commits.xml" target="repositories"/>
	<target     mode="plain" value="commits.xml"/>
</xsl:variable>

<xsl:template name="formatter">
	<xsl:param name="format"/>
	<xsl:param name="source"/>

	<xsl:copy-of select="InputXSLT:external-command(
		$format,
		$source
	)/self::command/node()"/>
</xsl:template>

<xsl:template match="date" mode="commit">
	<xsl:copy>
		<xsl:attribute name="time">
			<xsl:value-of select="substring(text(), 12, 5)"/>
		</xsl:attribute>

		<xsl:apply-templates select="@*|node()" mode="commit"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="date/text()" mode="commit">
	<xsl:value-of select="substring(., 0, 11)"/>
</xsl:template>

<xsl:template match="message/text()" mode="commit">
	<xsl:call-template name="formatter">
		<xsl:with-param name="format">markdown</xsl:with-param>
		<xsl:with-param name="source" select="."/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="@*|node()" mode="commit">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()" mode="commit"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="repositories/entry">
	<entry handle="{@handle}">
		<xsl:apply-templates select="commit" mode="commit"/>
	</entry>
</xsl:template>

</xsl:stylesheet>
