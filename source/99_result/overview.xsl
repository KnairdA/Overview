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
	<datasource type="main"    mode="full" source="00_content/meta.xml"      target="meta"/>
	<datasource type="support" mode="full" source="02_augment/articles.xml"  target="articles"/>
	<datasource type="support" mode="full" source="00_content/blip_feed.xml" target="timeline"/>
	<target     mode="plain"   value="index.html"/>
</xsl:variable>

<xsl:variable name="root" select="/datasource"/>

<xsl:template match="articles/entry">
	<h3>
		<span class="arrow">
			<xsl:text>» </xsl:text>
		</span>
		<a href="{link}">
			<xsl:value-of select="title"/>
		</a>
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

		<a class="more" href="{link}">
			<xsl:text>↪</xsl:text>
		</a>
	</p>
</xsl:template>

<xsl:template match="timeline/entry[@type='commit']">
	<h3>
		<span class="arrow">
			<xsl:text>» </xsl:text>
		</span>
		<a href="{$root/meta/repository_base}/{@repo}/commit/?id={@hash}">
			<xsl:value-of select="title"/>
		</a>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> at </xsl:text>
			<xsl:value-of select="date/@time"/>
		<xsl:text> | </xsl:text>
		<a href="{$root/meta/repository_base}/{@repo}/">
			<xsl:value-of select="@repo"/>
		</a>
		<xsl:text> | </xsl:text>
		<a href="{$root/meta/repository_base}/{@repo}/commit/?id={@hash}">
			<xsl:value-of select="substring(@hash,0,7)"/>
		</a>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="$root/meta/author"/>
	</span>

	<xsl:apply-templates select="content/node()" mode="xhtml"/>
</xsl:template>

<xsl:template match="timeline/entry[@type='unstructured']">
	<h3>
		<span class="arrow">
			<xsl:text>» </xsl:text>
		</span>
		<a href="{title/@href}">
			<xsl:value-of select="title"/>
		</a>
	</h3>

	<span class="info">
		<xsl:call-template name="format-date">
			<xsl:with-param name="date" select="date"/>
			<xsl:with-param name="format" select="'M x, Y'"/>
		</xsl:call-template>
		<xsl:text> at </xsl:text>
			<xsl:value-of select="date/@time"/>
		<xsl:text> | </xsl:text>
		<xsl:value-of select="$root/meta/author"/>
	</span>

	<xsl:apply-templates select="content/node()" mode="xhtml"/>
</xsl:template>

<xsl:template match="datasource">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
		<meta name="author"      content="{$root/meta/author}"/>
		<meta name="description" content="{$root/meta/description}"/>
		<meta name="viewport"    content="width=device-width,initial-scale=1.0"/>

		<title>
			<xsl:value-of select="$root/meta/title"/>
		</title>

		<link rel="shortcut icon" type="image/x-icon" href="/favicon.ico" />
		<link rel="stylesheet"    type="text/css"     href="/main.css"/>

		<xsl:if test="//*[(self::p or self::span) and @class = 'math']">
			<link rel="stylesheet" type="text/css" href="https://static.kummerlaender.eu/katex/katex.min.css" />
		</xsl:if>
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
						<a href="https://tree.kummerlaender.eu">tree</a>
					</li>
				</ul>
			</div>

			<div id="introduction">
				<img src="https://static.kummerlaender.eu/media/me_in_the_highlands_square.jpg"/>
				<p>
					<span class="greeting">Hi there!</span> My name is Adrian Kummerländer.
						I am a software developer by vocation and a mathematician by degree, currently pursuing a doctorate at <a href="https://www.lbrg.kit.edu/">LBRG</a> in the intersection between HPC and LBM.
						On these pages you will find <a href="https://blog.kummerlaender.eu">articles</a> covering some of my experiences in software development and related tinkerings as well as <a href="https://code.kummerlaender.eu">repositories</a> and information on some of my personal <a href="https://tree.kummerlaender.eu/projects">projects</a>. If you have any comments or questions feel free to <a href="https://tree.kummerlaender.eu/contact">reach out</a>. I hope you will find something here worth your time.
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
					<a href="https://blip.kummerlaender.eu">
						<xsl:text>Selected commits</xsl:text>
					</a>
				</h2>
				<ul>
					<li>
						<a href="https://tree.kummerlaender.eu/projects">Projects</a>
					</li>
					<li>
						<a href="https://blip.kummerlaender.eu/atom.xml">Feed</a>
					</li>
				</ul>
			</div>

			<xsl:apply-templates select="timeline/entry[position() &lt;= $root/meta/limits/blips]"/>
		</div>
	</body>
</html>
</xsl:template>

<xsl:template match="a[@class = 'footnote-ref']" mode="xhtml">
	<xsl:element name="{local-name()}" namespace="http://www.w3.org/1999/xhtml">
		<xsl:copy-of select="@*[name()='id' or name()='class']"/>
		<xsl:attribute name="href">
			<xsl:value-of select="concat(./ancestor::entry/link, '/', ./@href)"/>
		</xsl:attribute>
		<xsl:apply-templates select="node()" mode="xhtml"/>
	</xsl:element>
</xsl:template>

<xsl:template match="text()|@*"/>

</xsl:stylesheet>
