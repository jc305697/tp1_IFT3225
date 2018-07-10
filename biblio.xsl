<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    
    <xsl:template match="/">
        
        
        
        <html>
            <head>
                <title>
                    Information sur les auteurs
                </title>
            </head>
            <body>
                <xsl:for-each select="//bibliotheque/auteur/nom">
                    <xsl:call-template name="tri_auteur">
                        <xsl:with-param name="nomAuteur" select = "$nomAuteur" />
                    </xsl:call-template>
                    
                    <xsl:choose>
                        <!-- quand un auteur en paramètre -->
                        <xsl:when test="$nomAuteur"> 
                            <p><xsl:value-of select="prenom"/></p>
                            <p><xsl:value-of select="nom"/></p>
                            <p><xsl:value-of select="pays"/></p>
                            <p><xsl:value-of select="commentaire"/></p>
                            <p><xsl:value-of select="photo"/></p>
                            //award[auteur=' $nomAuteur ']/titre
                        </xsl:when>
                        
                        <!-- aucun auteur en paramètre: tous les auteurs et livres triés par prix croissant -->
                        <xsl:otherwise>
                            <p><xsl:value-of select="prenom"/></p>
                            <p><xsl:value-of select="nom"/></p>
                            <p><xsl:value-of select="pays"/></p>
                            <p><xsl:value-of select="commentaire"/></p>
                            <p><xsl:value-of select="photo"/></p>
                            //award[auteur=' $nomAuteur ']/titre
                        </xsl:otherwise>
                    </xsl:choose>                
                </xsl:for-each>
            </body>
        </html>
    </xsl:template> 
    <xsl:template name="temp">
        <xsl:param name="nomAuteur"/>
        
        <xsl:variable name="idAuteur">
            <xsl:value-of select="(/bibliotheque/auteur[nom=$nomAuteur])/@ident"/>
        </xsl:variable>
        <p>
            Ma variable est <xsl:value-of select="$idAuteur"/> <br/>
        </p>
        
            <p>passe ici</p>
            <xsl:for-each select="idref($idAuteur)">
                <p>
                    <xsl:value-of select="titre"/>
                </p>
            </xsl:for-each>
        
    </xsl:template>
    
    <xsl:template name = "tri_auteur" >
        <xsl:param name = "nomAuteur" />
        <xsl:value-of select = "$nomAuteur" />
    </xsl:template>
    
</xsl:stylesheet>