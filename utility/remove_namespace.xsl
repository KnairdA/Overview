<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<xsl:template match="*" mode="remove_namespace">
    <xsl:element name="{local-name()}">
        <xsl:copy-of select="@*"/>
        <xsl:apply-templates select="node()" mode="remove_namespace"/>
    </xsl:element>
</xsl:template>

<xsl:template match="comment() | processing-instruction()" mode="remove_namespace">
    <xsl:copy/>
</xsl:template>

</xsl:stylesheet>
