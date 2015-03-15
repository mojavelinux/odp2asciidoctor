<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
	xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
	xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
	xmlns:presentation="urn:oasis:names:tc:opendocument:xmlns:presentation:1.0">

	<xsl:output method="text" encoding="utf-8" />

	<xsl:preserve-space elements="text:p" />

	<xsl:template match="/">
= Presentation

		<xsl:apply-templates />
	</xsl:template>

	<!-- template for a single page/slide of presentation -->
	<xsl:template match="office:presentation/draw:page">
== <xsl:value-of select="draw:frame[@presentation:class='title']/draw:text-box/text:p/text()" /> <xsl:text>&#xa;</xsl:text><xsl:text>&#xa;</xsl:text>

		<xsl:apply-templates select="draw:frame[@presentation:class='outline']" />

	</xsl:template>

<!-- template for single paragraph -->
	<xsl:template match="draw:text-box">
		<xsl:apply-templates />
	</xsl:template>

<!-- template for unordered list -->
	<xsl:template match="text:list/text:list-item">
		<xsl:for-each select="ancestor::text:list">*</xsl:for-each><xsl:text> </xsl:text><xsl:apply-templates />
	</xsl:template>

<!-- template for unordered list item content -->
	<xsl:template match="text:list-item/text:p">
		<xsl:value-of select="text()" /><xsl:text>&#xa;</xsl:text>
	</xsl:template>

</xsl:stylesheet>