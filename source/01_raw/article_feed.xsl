<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:atom="http://www.w3.org/2005/Atom"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="InputXSLT"
>

<xsl:include href="[utility/datasource.xsl]"/>
<xsl:include href="[utility/remove_namespace.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="00_content/meta.xml" target="meta"/>
	<target     mode="plain" value="article_feed.xml"/>
</xsl:variable>

<xsl:template match="meta">
	<xsl:apply-templates mode="remove_namespace" select="InputXSLT:external-command(
		'curl http://blog.kummerlaender.eu/atom.xml'
	)/self::command/atom:feed/atom:entry[position() &lt;= $root/meta/overview/article_count]"/>
</xsl:template>

</xsl:stylesheet>
