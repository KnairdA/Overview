<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="01_raw/blip_feed.xml" target="blips"/>
	<target     mode="plain" value="blips.xml"/>
</xsl:variable>

<xsl:template match="id" mode="blip"/>

<xsl:template match="author" mode="blip">
	<xsl:copy>
		<xsl:value-of select="name"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="updated" mode="blip">
	<date>
		<xsl:value-of select="substring(., 0, 11)"/>
	</date>
</xsl:template>

<xsl:template match="link" mode="blip">
	<link>
		<xsl:value-of select="@href"/>
	</link>
</xsl:template>

<xsl:template match="content[@type = 'xhtml']" mode="blip">
	<content>
		<xsl:apply-templates select="node()" mode="blip"/>
	</content>
</xsl:template>

<xsl:template match="@* | node()" mode="blip">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()" mode="blip"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="blips">
	<xsl:apply-templates select="entry" mode="blip"/>
</xsl:template>

</xsl:stylesheet>
