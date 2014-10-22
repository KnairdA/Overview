<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/2005/Atom"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:output
	method="xml"
	omit-xml-declaration="no"
	encoding="UTF-8"
	indent="no"
/>

<xsl:include href="[utility/xhtml.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="iterate" source="02_augment/formatted_commits.xml" target="repository"/>
	<datasource type="support" mode="full"    source="00_content/meta.xml"              target="meta"/>
	<target     mode="xpath"   value="concat($datasource/repository/entry/@handle, '.xml')"/>
</xsl:variable>

<xsl:variable name="root"   select="/datasource"/>
<xsl:variable name="title"  select="datasource/repository/entry/@handle"/>
<xsl:variable name="url"    select="concat('/feed/', $title, '.xml')"/>
<xsl:variable name="latest" select="repository/entry/commit[1]"/>

<xsl:template match="datasource">
	<feed>
		<link href="{$url}" rel="self" title="{$title}" type="application/atom+xml"/>

		<id>
			<xsl:value-of select="$url"/>
		</id>
		<title>
			<xsl:value-of select="$title"/>
		</title>
		<updated>
			<xsl:value-of select="$latest/date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="$latest/date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>

		<xsl:apply-templates select="repository/entry/commit"/>
	</feed>
</xsl:template>

<xsl:template match="repository/entry/commit">
	<entry xmlns="http://www.w3.org/2005/Atom">
		<id>
			<xsl:value-of select="@hash"/>
		</id>
		<title>
			<xsl:value-of select="message/h1"/>
		</title>
		<link rel="alternate" title="{@hash}">
			<xsl:attribute name="href">
				<xsl:value-of select="concat(
					$root/meta/mirror/repository, '/',
					../@handle,                '/',
					$root/meta/mirror/commit,
					@hash
				)"/>
			</xsl:attribute>
		</link>
		<content type="xhtml">
			<div xmlns="http://www.w3.org/1999/xhtml">
				<xsl:apply-templates select="message/*[name() != 'h1']" mode="xhtml"/>
			</div>
		</content>
		<updated>
			<xsl:value-of select="date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>
	</entry>
</xsl:template>

</xsl:stylesheet>
