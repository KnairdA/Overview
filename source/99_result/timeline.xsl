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
	<datasource type="support" mode="full" source="00_content/meta.xml"    target="meta"/>
	<target     mode="plain"   value="timeline.xml"/>
</xsl:variable>

<xsl:variable name="root"   select="/datasource"/>
<xsl:variable name="url"    select="concat($root/meta/url, '/timeline.xml')"/>

<xsl:template match="timeline/entry">
	<xsl:variable name="link" select="concat($root/meta/repository_base, '/', @repo, '/commits/?id=', @hash)"/>
	
	<entry xmlns="http://www.w3.org/2005/Atom">
		<id>
			<xsl:value-of select="$link"/>
		</id>
		<title>
			<xsl:value-of select="title"/>
		</title>
		<link rel="alternate" title="{title}" href="$link"/>
		<author>
			<name>
				<xsl:value-of select="$root/meta/author"/>
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
				<xsl:apply-templates select="content/*" mode="xhtml"/>
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
			<xsl:value-of select="timeline/entry[1]/date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="timeline/entry[1]/date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>

		<xsl:apply-templates select="timeline/entry[position() &lt;= $root/meta/timeline/commit_count]"/>
	</feed>
</xsl:template>

</xsl:stylesheet>
