<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:InputXSLT="function.inputxslt.application"
	exclude-result-prefixes="InputXSLT"
>

<xsl:include href="[utility/datasource.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"    mode="full" source="00_content/repositories.xml" target="repositories"/>
	<datasource type="support" mode="full" source="00_content/meta.xml"         target="meta"/>
	<target     mode="plain" value="commits.xml"/>
</xsl:variable>

<xsl:template match="repositories/entry">
	<entry handle="{@handle}">
		<xsl:copy-of select="InputXSLT:external-command(
			concat('./utility/git_log.sh ', path, ' ', $root/meta/commit_count)
		)/self::command/commit"/>
	</entry>
</xsl:template>

</xsl:stylesheet>
