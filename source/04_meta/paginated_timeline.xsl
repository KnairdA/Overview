<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:include href="[utility/datasource.xsl]"/>
<xsl:include href="[utility/reference_commit.xsl]"/>

<xsl:variable name="meta">
	<datasource type="main"  mode="full" source="03_merge/timeline.xml" target="timeline"/>
	<target     mode="plain" value="paginated_timeline.xml"/> 
</xsl:variable>

<xsl:variable name="commits_per_page">20</xsl:variable>
<xsl:variable name="total" select="ceiling(count(datasource/timeline/commit) div $commits_per_page)"/>

<xsl:template match="timeline/commit[position() mod $commits_per_page = 1]">
	<entry index="{floor(position() div $commits_per_page)}" total="{$total}">
		<xsl:apply-templates select=". | following-sibling::commit[not(position() > ($commits_per_page - 1))]" mode="commit"/>
	</entry>
</xsl:template>

</xsl:stylesheet>
