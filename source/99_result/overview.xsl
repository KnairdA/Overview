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

<xsl:include href="[utility/xhtml.xsl]"/>
<xsl:include href="[utility/date-time.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="00_content/meta.xml"         target="meta"/>
	<datasource type="support" mode="full" source="02_augment/articles.xml"     target="articles"/>
	<datasource type="support" mode="full" source="03_merge/timeline.xml"       target="timeline"/>
	<datasource type="support" mode="full" source="02_augment/commits.xml"      target="commits"/>
	<datasource type="support" mode="full" source="00_content/repositories.xml" target="repositories"/>
	<target     mode="plain"   value="index.html"/>
</xsl:variable>

<xsl:variable name="root" select="/datasource"/>

<xsl:template name="get_commit">
	<xsl:param name="repository"/>
	<xsl:param name="hash"/>

	<xsl:variable name="commit" select="$root/commits/entry[
		@handle = $repository
	]/commit[
		@hash = $hash
	]"/>

	<xsl:variable name="project" select="$root/repositories/entry[
		@handle = $repository
	]"/>

	<h3>
		<xsl:text>» </xsl:text>
		<span>
			<a href="{$commit/link}">
				<xsl:value-of select="$commit/title"/>
			</a>
		</span>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="$commit/date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> at </xsl:text>
			<xsl:value-of select="$commit/date/@time"/>
		<xsl:text> | </xsl:text>
		<a href="{$project/url}">
			<xsl:value-of select="$repository"/>
		</a>
		<xsl:text> | </xsl:text>
		<a href="{$commit/link}">
			<xsl:value-of select="$commit/@hash"/>
		</a>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="$commit/author"/>
	</span>

	<xsl:apply-templates select="$commit/message/node()" mode="xhtml"/>
</xsl:template>

<xsl:template match="timeline/commit">
	<xsl:call-template name="get_commit">
		<xsl:with-param name="repository" select="@repository"/>
		<xsl:with-param name="hash"       select="@hash"/>
	</xsl:call-template>
</xsl:template>

<xsl:template match="articles/entry">
	<h3>
		<xsl:text>» </xsl:text>
		<span>
			<a href="{link}">
				<xsl:value-of select="title"/>
			</a>
		</span>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="author"/>
	</span>

	<p>
		<xsl:apply-templates select="content/node()" mode="xhtml"/>
		<xsl:text> </xsl:text>

		<a href="{link}">
			<xsl:text>↪</xsl:text>
		</a>
	</p>
</xsl:template>

<xsl:template match="datasource">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="author"      content="Adrian Kummerländer"/>
		<meta name="description" content="Overview of kummerlaender.eu; blog and commit timeline aggregator"/>
		<meta name="viewport"    content="width=device-width,initial-scale=1.0"/>

		<title>
			<xsl:value-of select="$root/meta/title"/>
		</title>

		<link rel="stylesheet" type="text/css" href="/main.css"/>
	</head>
	<body>
		<div id="content">
			<div class="large menuhead">
				<h1>
					<xsl:value-of select="$root/meta/title"/>
				</h1>
				<ul>
					<li>
						<a href="https://blog.kummerlaender.eu">blog</a>
					</li>
					<li>
						<a href="https://code.kummerlaender.eu">code</a>
					</li>
					<li>
						<a href="https://key.kummerlaender.eu">key</a>
					</li>
				</ul>
			</div>

			<div id="introduction">
				<img src="https://static.kummerlaender.eu/media/me_in_ireland.jpg"/>
				<p>
					<span class="greeting">Hi there!</span> My name is Adrian Kummerländer and I am a software developer currently studying mathematics in Karlsruhe. On these pages you will find <a href="https://blog.kummerlaender.eu">blog articles</a> covering amongst other topics some of my experiences in software development, open source and self hosting as well as <a href="https://code.kummerlaender.eu">repositories</a> and information on some of my personal <a href="https://blog.kummerlaender.eu/category/projects">projects</a>. If you have any comments or questions feel free to <a href="https://blog.kummerlaender.eu/page/contact">reach out</a>. I hope you will find something here worth your time.
				</p>
			</div>

			<div class="normal menuhead">
				<h2>
					<a href="https://blog.kummerlaender.eu">
						<xsl:text>Latest articles</xsl:text>
					</a>
				</h2>
				<ul>
					<li>
						<a href="https://blog.kummerlaender.eu/archive">Archive</a>
					</li>
					<li>
						<a href="https://blog.kummerlaender.eu/atom.xml">Feed</a>
					</li>
				</ul>
			</div>

			<xsl:apply-templates select="articles/entry"/>

			<div class="normal menuhead">
				<h2>
					<a href="https://code.kummerlaender.eu">
						<xsl:text>Latest commits</xsl:text>
					</a>
				</h2>
				<ul>
					<li>
						<a href="https://github.com/KnairdA">GitHub</a>
					</li>
					<li>
						<a href="https://blog.kummerlaender.eu/category/projects">Projects</a>
					</li>
					<li>
						<a href="{$root/meta/url}/timeline.xml">Feed</a>
					</li>
				</ul>
			</div>

			<xsl:apply-templates select="timeline/commit[position() &lt;= $root/meta/overview/commit_count]"/>
		</div>
	</body>
</html>
</xsl:template>

<xsl:template match="text()|@*"/>

</xsl:stylesheet>
