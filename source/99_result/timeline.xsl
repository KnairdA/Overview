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

<xsl:template name="get_commit">
	<xsl:param name="repository"/>
	<xsl:param name="hash"/>

	<xsl:variable name="commit" select="$root/repositories/entry[
		@handle = $repository
	]/commit[
		@hash = $hash
	]"/>

	<entry xmlns="http://www.w3.org/2005/Atom">
		<id>
			<xsl:value-of select="$hash"/>
		</id>
		<title>
			<xsl:value-of select="$commit/message/h1"/>
		</title>
		<link rel="alternate" title="{@hash}">
			<xsl:attribute name="href">
				<xsl:value-of select="concat(
					$root/meta/mirror/repository, '/',
					$repository,                  '/',
					$root/meta/mirror/commit,
					$hash
				)"/>
			</xsl:attribute>
		</link>
		<content type="xhtml">
			<div xmlns="http://www.w3.org/1999/xhtml">
				<xsl:apply-templates select="$commit/message/*[name() != 'h1']" mode="xhtml"/>
			</div>
		</content>
		<updated>
			<xsl:value-of select="$commit/date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="$commit/date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>
	</entry>
</xsl:template>

<xsl:template match="datasource">
	<feed>
		<link href="{$url}" rel="self" title="{$root/meta/title}" type="application/atom+xml"/>

		<id>
			<xsl:value-of select="$url"/>
		</id>
		<title>
			<xsl:value-of select="$root/meta/title"/>
		</title>
		<updated>
			<xsl:value-of select="$latest/date"/>
			<xsl:text>T</xsl:text>
			<xsl:value-of select="$latest/date/@time"/>
			<xsl:text>:00+02:00</xsl:text>
		</updated>

		<xsl:apply-templates select="timeline/commit[position() &lt;= $root/meta/commit_count]"/>
	</feed>
</xsl:template>

<xsl:template match="timeline/commit">
	<xsl:call-template name="get_commit">
		<xsl:with-param name="repository" select="@repository"/>
		<xsl:with-param name="hash"       select="@hash"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
