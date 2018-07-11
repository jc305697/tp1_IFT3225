<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="2.0">
    <xsl:output method="html" encoding="UTF-8"
        doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
    />
    
    <xsl:template match="/">
        <html>
            <head>
                <title>
                    Information sur les auteurs
                </title>
            </head>
            <body>
                <!--xsl:for-each select="//bibliotheque/auteur/nom" -->
                <!-- <p>
                    mon identiant de auteur est <xsl:value-of select="//auteur[nom='Dumas']/@ident"/>
                    
                </p> -->
                <xsl:call-template name="tri_auteur">
                    <xsl:with-param name="prixMin">0</xsl:with-param> 
                    <xsl:with-param name="prixMax">50</xsl:with-param>
                </xsl:call-template>
                <!--/xsl:for-each -->
            </body>
        </html>
    </xsl:template> 
    
    <xsl:template name="tri_auteur">
        <xsl:param name="prixMin" select="-5"/>
        <xsl:param name="prixMax" select="-5"/>
        
        <xsl:if test="$prixMin>$prixMax">
            <xsl:call-template name="tri_auteur">
                <xsl:with-param name="prixMin"><xsl:value-of select="$prixMax"/></xsl:with-param>
                <xsl:with-param name="prixMax"><xsl:value-of select="$prixMin"/></xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        
        <xsl:if test="$prixMin &lt;=$prixMax">
            <!--  <xsl:for-each select="idref($idAuteur)">
                    <p>
                        <xsl:value-of select="titre"/>
                    </p>
                </xsl:for-each> -->   
        
                    <table>
                        <!--thead-->
                        <th>titre</th>
                        <th>annee</th>
                        <th>prix</th>
                        <th>auteurs</th>
                        <th>commentaire</th>
                        <th>couverture</th>
                        
                        <!--/thead-->
                        <!--tbody-->
           
                        <xsl:for-each select="/bibliotheque/livre">
                            <xsl:sort select="//(auteur[@ident=substring-before(current()/@auteurs,' ')])/nom" data-type="text" order="descending" />
                            <xsl:variable name="valAuteurs"><xsl:value-of select="@auteurs"/></xsl:variable>
                            <xsl:variable name="prixLiv">
                                <xsl:value-of select="number(prix)"/>
                            </xsl:variable>
                            <xsl:variable name="titre">
                                <xsl:value-of select="titre"/>
                            </xsl:variable>
                            <xsl:variable name="annee">
                                <xsl:value-of select="annee"/>
                            </xsl:variable>
                            
                            <xsl:variable name="testMonnaie">
                                <xsl:value-of select="boolean(prix/@monnaie)"/>
                            </xsl:variable>
                            
                            <xsl:variable name="monnaie">
                                <xsl:value-of select="prix/@monnaie"/>
                            </xsl:variable>
                            
                            
                            <!-- <xsl:variable name="test">
                                  <xsl:value-of select="contains(@auteurs,$idAuteur)"/>
                              </xsl:variable> -->
                             
                      
                            <!--p>
                                nom de l'auteur est <xsl:value-of select="//(auteur[@ident=substring-before(@auteurs,' ')]/nom)"/>
                            </p-->
                            
                            <xsl:if test="$prixMin &lt;= $prixLiv and $prixLiv &lt; $prixMax">
                                <tr>
                                    <td>
                                        <xsl:value-of select="$titre"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="$annee"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="$prixLiv"/> 
                                        <xsl:if test="$testMonnaie">
                                            &#160;<xsl:value-of select="$monnaie"/>
                                        </xsl:if>
                                    </td>
                                    
                                    <td>
                                        <ul>
                                            <xsl:for-each select="/bibliotheque/auteur">
                                                <xsl:sort select="nom" data-type="text" order="descending"/>
                                                <xsl:if test="contains($valAuteurs,@ident)">
                                                    <li><xsl:value-of select="prenom"/> &#160;<xsl:value-of select="nom"/></li>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </ul>    
                                    </td>
                                    
                                    <td>
                                        <xsl:value-of select="commentaire"/>
                                    </td>
                                    
                                    <td>
                                        <xsl:if test="boolean(couverture)">
                                            <img>
                                                <xsl:attribute name="src">
                                                    <xsl:value-of select="couverture"/>
                                                </xsl:attribute>
                                                <xsl:attribute name="alt">page couverture de <xsl:value-of select="$titre"/>
                                                </xsl:attribute>
                                            </img>
                                        </xsl:if>
                                    </td>
                                </tr>
                            </xsl:if>
                            
                            
                            
                        </xsl:for-each>
                        <!--/tbody-->
                        
                    </table>
        </xsl:if>   
               
    </xsl:template>
    
</xsl:stylesheet>