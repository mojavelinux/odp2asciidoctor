<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0" xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0">

	<xsl:output  method="text" encoding="utf-8"/>
	
	<xsl:preserve-space elements="text:p"/>
	
	<xsl:template match="/">
	
= Presentation

		<xsl:apply-templates />
	</xsl:template>
	
	<xsl:template match="draw:page">
	
== Page

		<xsl:apply-templates />

	</xsl:template>	
	
	<xsl:template match="draw:frame/draw:text-box/text:p">
	</xsl:template>
</xsl:stylesheet>