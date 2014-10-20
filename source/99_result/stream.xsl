<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/master.xsl]"/>
<xsl:include href="[utility/xhtml.xsl]"/>
<xsl:include href="[utility/date-time.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="iterate" source="04_meta/paginated_timeline.xml"   target="page"/>
	<datasource type="support" mode="full"    source="02_augment/formatted_commits.xml" target="commits"/>
	<datasource type="support" mode="full"    source="00_content/meta.xml"              target="meta"/>
	<target     mode="xpath"   value="concat($datasource/page/entry/@index, '/index.html')"/>
</xsl:variable>

<xsl:template name="get_commit">
	<xsl:param name="repository"/>
	<xsl:param name="hash"/>

	<xsl:variable name="commit" select="$root/commits/entry[@handle = $repository]/commit[@hash = $hash]"/>

	<div class="commit">
		<h2>
			<xsl:text>» </xsl:text>
			<a href="">
				<xsl:value-of select="$commit/message/h1"/>
			</a>
		</h2>
		<p class="info">
			<xsl:call-template name="format-date">
				<xsl:with-param name="date" select="$commit/date"/>
				<xsl:with-param name="format" select="'M x, Y'"/>
			</xsl:call-template>
			<xsl:text> at </xsl:text>
			<xsl:value-of select="$commit/date/@time"/>
			<xsl:text> | </xsl:text>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="concat(
						$root/meta/mirror/repository, '/',
						$repository
					)"/>
				</xsl:attribute>

				<xsl:value-of select="$repository"/>
			</a>
			<xsl:text> | </xsl:text>
			<a>
				<xsl:attribute name="href">
					<xsl:value-of select="concat(
						$root/meta/mirror/repository, '/',
						$repository,                  '/',
						$root/meta/mirror/commit,
						$commit/@hash
					)"/>
				</xsl:attribute>

				<xsl:value-of select="$commit/@hash"/>
			</a>
		</p>

		<xsl:apply-templates select="$commit/message/*[name() != 'h1']" mode="xhtml"/>
	</div>
</xsl:template>

<xsl:template match="page/entry">
	<xsl:apply-templates />

	<div id="pagination">
		<xsl:if test="@index > 0">
			<span>
				<a class="pagination-previous" href="/0">
					<xsl:text>« first</xsl:text>
				</a>
			</span>

			<span>
				<a class="pagination-previous" href="/{@index - 1}">
					<xsl:text>« newer</xsl:text>
				</a>
			</span>
		</xsl:if>

		<xsl:if test="@index &lt; @total - 1">
			<span>
				<a class="pagination-next" href="/{@total - 1}">
					<xsl:text>last »</xsl:text>
				</a>
			</span>

			<span>
				<a class="pagination-next" href="/{@index + 1}">
					<xsl:text>older »</xsl:text>
				</a>
			</span>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="page/entry/commit">
	<xsl:call-template name="get_commit">
		<xsl:with-param name="repository" select="@repository"/>
		<xsl:with-param name="hash"       select="@hash"/>
	</xsl:call-template>
</xsl:template>

</xsl:stylesheet>
