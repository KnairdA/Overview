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
	<datasource type="main"  mode="full" source="00_content/repositories.xml" target="repositories"/>
	<target     mode="plain" value="repository_feeds.xml"/>
</xsl:variable>

<xsl:template match="repositories/entry">
	<entry handle="{@handle}">
		<xsl:apply-templates mode="remove_namespace" select="InputXSLT:external-command(
			concat('./utility/fetch_feed.sh ', feed/text())
		)/self::command/atom:feed/atom:entry"/>
	</entry>
</xsl:template>

</xsl:stylesheet>
