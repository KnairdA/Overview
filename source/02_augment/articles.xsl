<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="01_raw/article_feed.xml" target="articles"/>
	<target     mode="plain" value="articles.xml"/>
</xsl:variable>

<xsl:template match="id" mode="article"/>

<xsl:template match="author" mode="article">
	<xsl:copy>
		<xsl:value-of select="name"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="updated" mode="article">
	<date>
		<xsl:value-of select="substring(., 0, 11)"/>
	</date>
</xsl:template>

<xsl:template match="link" mode="article">
	<link>
		<xsl:value-of select="@href"/>
	</link>
</xsl:template>

<xsl:template match="content[@type = 'xhtml']" mode="article">
	<content>
		<xsl:apply-templates select="div/p[1]/node()" mode="article"/>
	</content>
</xsl:template>

<xsl:template match="@* | node()" mode="article">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()" mode="article"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="articles">
	<xsl:apply-templates select="entry" mode="article"/>
</xsl:template>

</xsl:stylesheet>
