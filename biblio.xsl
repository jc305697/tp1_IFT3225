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
                        <xsl:with-param name="nomAuteur" >
                            Verne
                        </xsl:with-param>
                    </xsl:call-template>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template> 
    <xsl:template name="tri_auteur">
        <xsl:param name="nomAuteur"/>
        
        <xsl:variable name="idAuteur">
            <xsl:value-of select="(/bibliotheque/auteur[nom=$nomAuteur])/@ident"/>
        </xsl:variable>

        <!--  <xsl:for-each select="idref($idAuteur)">
                <p>
                    <xsl:value-of select="titre"/>
                </p>
            </xsl:for-each> -->   
        
        <xsl:choose>
            <!-- quand un auteur en paramètre -->
            <xsl:when test="$nomAuteur != ' '"> 
               <!-- <p><xsl:value-of select="prenom"/></p>
                <p><xsl:value-of select="nom"/></p>
                <p><xsl:value-of select="pays"/></p>
                <p><xsl:value-of select="commentaire"/></p>
                <p><xsl:value-of select="photo"/></p>
                //award[auteur=' $nomAuteur ']/titre -->
 
                    <table>
                        <thead>
                            <th>titre</th>
                            <th>annee</th>
                            <th>prix</th>
                            <th>commentaire</th>
                        </thead>
                        <tbody>
                      <xsl:for-each select="idref($idAuteur)">
                            <tr>
                                <td>
                                    <xsl:value-of select="titre"/>
                                </td>
                                <td>
                                    <xsl:value-of select="annee"/>
                                </td>
                                <td>
                                    <xsl:value-of select="prix"/>
                                </td>
                                
                                <td>
                                    <xsl:value-of select="commentaire"/>
                                </td>
                            </tr>
                      </xsl:for-each>
                        </tbody>
                        
                    </table>
                
            </xsl:when>
            
            <!-- aucun auteur en paramètre: tous les auteurs et livres triés par prix croissant -->
            <xsl:otherwise>
                <p><xsl:value-of select="prenom"/></p>
                <p><xsl:value-of select="nom"/></p>
                <p><xsl:value-of select="pays"/></p>
                <p><xsl:value-of select="commentaire"/></p>
                <p><xsl:value-of select="photo"/></p>
                //award[auteur=' $nomAuteur ']/titre
             
                <xsl:for-each select="bibliotheque/auteur">
                    <table>
                        <thead>
                            <th>titre</th>
                            <th>annee</th>
                            <th>prix</th>
                            <th>commentaire</th>
                        </thead>
                        <tbody>
                            <xsl:for-each select="idref(@ident)">
                                <tr>
                                    <td>
                                        <xsl:value-of select="titre"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="annee"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="prix"/>
                                    </td>
                                    
                                    <td>
                                        <xsl:value-of select="commentaire"/>
                                    </td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                        
                    </table>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
     
</xsl:stylesheet>