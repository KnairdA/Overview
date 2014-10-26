<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>
<xsl:include href="[utility/formatter.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="01_raw/repository_feeds.xml" target="repositories"/>
	<target     mode="plain" value="commits.xml"/>
</xsl:variable>

<xsl:template match="entry" mode="commit">
	<commit hash="{substring(id, 0, 7)}">
		<xsl:apply-templates select="@*|node()" mode="commit"/>
	</commit>
</xsl:template>

<xsl:template match="id"                       mode="commit"/>
<xsl:template match="updated"                  mode="commit"/>
<xsl:template match="content[@type = 'xhtml']" mode="commit"/>

<xsl:template match="author" mode="commit">
	<xsl:copy>
		<xsl:value-of select="name"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="published" mode="commit">
	<date>
		<xsl:attribute name="time">
			<xsl:value-of select="substring(text(), 12, 5)"/>
		</xsl:attribute>

		<xsl:apply-templates select="@*|node()" mode="commit"/>
	</date>
</xsl:template>

<xsl:template match="published/text()" mode="commit">
	<xsl:value-of select="substring(., 0, 11)"/>
</xsl:template>

<xsl:template match="link" mode="commit">
	<link>
		<xsl:value-of select="@href"/>
	</link>
</xsl:template>

<xsl:template match="content[@type = 'text']" mode="commit">
	<message>
		<xsl:apply-templates select="node()" mode="commit"/>
	</message>
</xsl:template>

<xsl:template match="content[@type = 'text']/text()" mode="commit">
	<xsl:call-template name="formatter">
		<xsl:with-param name="format">markdown</xsl:with-param>
		<xsl:with-param name="source" select="."/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="@* | node()" mode="commit">
	<xsl:copy>
		<xsl:apply-templates select="@*|node()" mode="commit"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="repositories/entry">
	<entry handle="{@handle}">
		<xsl:apply-templates select="entry" mode="commit"/>
	</entry>
</xsl:template>

</xsl:stylesheet>
