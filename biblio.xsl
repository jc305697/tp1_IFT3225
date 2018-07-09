<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        
        <xsl:param name="nomAuteur" select="Verne"/>
        
        <html>
            <head>
                <title>
                    Information sur les auteurs
                </title>
            </head>
            <body>
                <h1>
                    <xsl:value-of select="//auteur"/>
                </h1>
                <p>
                    <b>Auteur:</b>
                    <xsl:value-of select="//auteur"/>
                </p>

            </body>
        </html>
    </xsl:template> 
    
    
</xsl:stylesheet>