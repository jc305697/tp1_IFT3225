<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs" version="2.0">
    <xsl:output method="html" encoding="UTF-8" doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN" doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <!--Charles-Frédéric Amringer et Jérémy Coulombe-->    
    <xsl:template match="/">
        <html>
            <head>
                <title> Information sur les livres </title>
            </head>
            <body>
                <!-- xsl:for-each select="//bibliotheque/auteur/nom"  -->
                <!--
 <p>
                    mon identiant de auteur est <xsl:value-of select="//auteur[nom='Dumas']/@ident"/>
                    
                </p> 
-->
                <xsl:call-template name="tri_auteur">
                    <xsl:with-param name="prixMin">10</xsl:with-param>
                    <xsl:with-param name="prixMax">20</xsl:with-param>
                </xsl:call-template>
                <!-- /xsl:for-each  -->
            </body>
        </html>
    </xsl:template>
    <xsl:template name="tri_auteur">
        <xsl:param name="prixMin"/>
        <xsl:param name="prixMax"/>
        <xsl:variable name="min">
            <xsl:value-of select="normalize-space($prixMin)"/>
        </xsl:variable>
        <xsl:variable name="max">
            <xsl:value-of select="normalize-space($prixMax)"/>
        </xsl:variable>
        <xsl:if test="$min>$max">
            <xsl:call-template name="tri_auteur">
                <xsl:with-param name="prixMin">
                    <xsl:value-of select="$max"/>
                </xsl:with-param>
                <xsl:with-param name="prixMax">
                    <xsl:value-of select="$min"/>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
        <xsl:if test="not($min > $max) or ($min= '') or ($max= '')">
            <!--
  <xsl:for-each select="idref($idAuteur)">
                    <p>
                        <xsl:value-of select="titre"/>
                    </p>
                </xsl:for-each> 
-->
            <table border="1">
                <!-- thead -->
                <th bgcolor="#00cc00">titre</th>
                <th bgcolor="#00cc00">annee</th>
                <th bgcolor="#00cc00">prix</th>
                <th bgcolor="#00cc00">auteurs</th>
                <th bgcolor="#00cc00">commentaire</th>
                <th bgcolor="#00cc00">couverture</th>
                <!-- /thead -->
                <!-- tbody -->
                <xsl:for-each select="/bibliotheque/livre">
                    <xsl:sort select="//(auteur[@ident=substring-before(current()/@auteurs,' ') or (not(contains(current()/@auteurs,' ')) and normalize-space(@ident)=normalize-space(current()/@auteurs))])/nom" data-type="text" order="descending"/>
                    <xsl:variable name="valAuteurs">
                        <xsl:value-of select="@auteurs"/>
                    </xsl:variable>
                    <xsl:variable name="prixLiv">
                        <xsl:value-of select="number(prix)"/>
                    </xsl:variable>
                    <xsl:if test="not($prixLiv > $max) and not($min > $prixLiv)">
                        <tr>
                            <td bgcolor="#cccc00">
                                <xsl:value-of select="titre"/>
                            </td>
                            <td bgcolor="#ffffcc">
                                <xsl:value-of select="annee"/>
                            </td>
                            <td bgcolor="#ffffcc">
                                <xsl:value-of select="$prixLiv"/>
                                <xsl:if test="boolean(prix/@monnaie)">
                                    &#160;
                                    <xsl:value-of select="prix/@monnaie"/>
                                </xsl:if>
                            </td>
                            <td bgcolor="#ffffcc">
                                <ul>
                                    <xsl:for-each select="/bibliotheque/auteur">
                                        <xsl:sort select="nom" data-type="text" order="descending"/>
                                        <xsl:if test="contains($valAuteurs,@ident)">
                                            <li>
                                                <xsl:value-of select="prenom"/>
                                                &#160;
                                                <xsl:value-of select="nom"/>
                                            </li>
                                        </xsl:if>
                                    </xsl:for-each>
                                </ul>
                            </td>
                            <td bgcolor="#ffffcc">
                                <xsl:value-of select="commentaire"/>
                            </td>
                            <td bgcolor="#ffffcc">
                                <xsl:if test="boolean(couverture)">
                                    <img>
                                        <xsl:attribute name="src">
                                            <xsl:value-of select="couverture"/>
                                        </xsl:attribute>
                                        <xsl:attribute name="alt">page couverture de <xsl:value-of select="titre"/></xsl:attribute>
                                    </img>
                                </xsl:if>
                            </td>
                        </tr>
                    </xsl:if>
                </xsl:for-each>
                <!-- /tbody -->
            </table>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>