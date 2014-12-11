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
	<datasource type="main"    mode="full" source="03_merge/timeline.xml"  target="timeline"/>
	<datasource type="support" mode="full" source="02_augment/commits.xml" target="repositories"/>
	<datasource type="support" mode="full" source="00_content/meta.xml"    target="meta"/>
	<target     mode="plain"   value="timeline.xml"/>
</xsl:variable>

<xsl:variable name="root"   select="/datasource"/>
<xsl:variable name="url"    select="concat($root/meta/url, '/timeline.xml')"/>
<xsl:variable name="latest" select="$root/repositories/entry[
	@handle = $root/timeline/commit[1]/@repository
]/commit[
	@hash   = $root/timeline/commit[1]/@hash
]"/>

<xsl:template match="repositories/entry/commit">
	<entry xmlns="http://www.w3.org/2005/Atom">
		<id>
			<xsl:value-of select="link"/>
		</id>
		<title>
			<xsl:value-of select="title"/>
		</title>
		<link rel="alternate" title="{title}" href="{link}"/>
		<author>
			<name>
				<xsl:value-of select="author"/>
			</name>
		</author>
		<updated>
			<xsl:value-of select="date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>
		<content type="xhtml">
			<div xmlns="http://www.w3.org/1999/xhtml">
				<xsl:apply-templates select="message/*" mode="xhtml"/>
			</div>
		</content>
	</entry>
</xsl:template>

<xsl:template match="datasource">
	<feed>
		<link href="{$url}" rel="self" title="{$root/meta/title}" type="application/atom+xml"/>

		<id>
			<xsl:value-of select="$url"/>
		</id>
		<title>
			<xsl:text>Latest commits @ </xsl:text>
			<xsl:value-of select="$root/meta/title"/>
		</title>
		<updated>
			<xsl:value-of select="$latest/date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="$latest/date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>

		<xsl:apply-templates select="timeline/commit[position() &lt;= $root/meta/timeline/commit_count]"/>
	</feed>
</xsl:template>

<xsl:template match="timeline/commit">
	<xsl:variable name="repository" select="@repository"/>
	<xsl:variable name="hash"       select="@hash"/>

	<xsl:apply-templates select="$root/repositories/entry[
		@handle = $repository
	]/commit[
		@hash = $hash
	]"/>
</xsl:template>

</xsl:stylesheet>
