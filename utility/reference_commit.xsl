<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:template match="@* | node()" mode="commit">
	<xsl:copy>
		<xsl:apply-templates select="@* | node()" mode="commit"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="commit" mode="commit">
	<xsl:copy>
		<xsl:attribute name="repository">
			<xsl:value-of select="../@handle"/>
		</xsl:attribute>

		<xsl:apply-templates select="@* | node()" mode="commit"/>
	</xsl:copy>
</xsl:template>

<xsl:template match="message | date | text()" mode="commit"/>

</xsl:stylesheet>
