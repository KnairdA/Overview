<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="InputXSLT"
>

<xsl:include href="[utility/datasource.xsl]"/>
<xsl:include href="[utility/remove_namespace.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="00_content/blog_feed.xml" target="feed"/>
	<datasource type="support" mode="full" source="00_content/meta.xml" target="meta"/>
	<target     mode="plain" value="blog_feed.xml"/>
</xsl:variable>

<xsl:template match="feed">
	<xsl:apply-templates mode="remove_namespace" select="entry[position() &lt;= $root/meta/limits/articles]"/>
</xsl:template>

</xsl:stylesheet>
