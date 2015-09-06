<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>
<xsl:include href="[utility/reference_commit.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main" mode="full" source="02_augment/commits.xml" target="repositories"/>
	<target     mode="plain" value="timeline.xml"/>
</xsl:variable>

<xsl:template match="repositories">
	<xsl:apply-templates select="entry/commit[count(message//text()) &gt;= 6]" mode="commit">
		<xsl:sort select="date"       data-type="text" order="descending"/>
		<xsl:sort select="date/@time" data-type="text" order="descending"/>
	</xsl:apply-templates>
</xsl:template>

</xsl:stylesheet>
