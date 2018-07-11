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
                        <xsl:with-param name="nomAuteur">Verne</xsl:with-param> 
                    </xsl:call-template>
                <!--/xsl:for-each -->
            </body>
        </html>
    </xsl:template> 
    <xsl:template name="tri_auteur">
        <xsl:param name="nomAuteur"/>
        
        
        <!--  <xsl:for-each select="idref($idAuteur)">
                <p>
                    <xsl:value-of select="titre"/>
                </p>
            </xsl:for-each> -->   
        
        <xsl:choose>
            <!-- quand un auteur en paramètre -->
            <xsl:when test="$nomAuteur != ' '"> 
                <xsl:variable name="idAuteur">
                    <!--xsl:value-of select="(/bibliotheque/auteur[nom=$nomAuteur])/@ident"/-->
                    <xsl:value-of select="(//auteur[nom=$nomAuteur])/@ident"/>
                </xsl:variable>
             
                <h2> <xsl:value-of select="//auteur[@ident=$idAuteur]/prenom"/> <xsl:value-of select="//auteur[@ident=$idAuteur]/nom"/> </h2>
                <xsl:if test="boolean(//auteur[@ident=$idAuteur]/photo)">
                    <h3>Photo</h3>
                    <img>
                        <xsl:attribute name="src"><xsl:value-of select="//auteur[@ident=$idAuteur]/photo"/></xsl:attribute>
                        <xsl:attribute name="alt">photo de 
                            <xsl:value-of select="//auteur[@ident=$idAuteur]/prenom"/> 
                            <xsl:value-of select="//auteur[@ident=$idAuteur]/nom"/>
                        </xsl:attribute>
                    </img>
                    
                </xsl:if>
                <h3>Origine</h3>
                <p>
                    Cet auteur est originaire de <xsl:value-of select="//auteur[@ident=$idAuteur]/pays"/>.
                </p>
                
                <xsl:if test="boolean(//auteur[@ident=$idAuteur]/commentaire)">
                    <h3>Informations supplémentaire</h3>
                    <p>
                        <xsl:value-of select="//auteur[@ident=$idAuteur]/commentaire"/>
                    </p>
                </xsl:if>
                
                
               <!-- <p>
                    
                    mon identiant de auteur est <xsl:value-of select="//auteur[nom=string($nomAuteur)]/@ident"/> <br/>
                    mon identifiant de auteur fixe est <xsl:value-of select="//auteur[nom='Dumas']/@ident"/>
                </p> -->
                <h3>Livres publiés par cet auteur</h3>
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
                            <xsl:sort select="prix" data-type="number" order="ascending" />
                          <!-- <xsl:variable name="test">
                              <xsl:value-of select="contains(@auteurs,$idAuteur)"/>
                          </xsl:variable> -->
                          <xsl:variable name="valAuteurs"><xsl:value-of select="@auteurs"/></xsl:variable> 
                        <!--  <p>
                                ma condition est <xsl:value-of select="$test"/>
                          </p> -->
                          
                              <xsl:if test="contains(@auteurs,$idAuteur)">
                                  <tr>
                                      <td>
                                          <xsl:value-of select="titre"/>
                                      </td>
                                      <td>
                                          <xsl:value-of select="annee"/>
                                      </td>
                                      <td>
                                          <xsl:value-of select="prix"/> <xsl:if test="boolean(prix/@monnaie)">
                                              <xsl:value-of select="prix/@monnaie"/>
                                          </xsl:if>
                                      </td>
                                      
                                      <td>
                                          <ul>
                                              <xsl:for-each select="/bibliotheque/auteur">
                                                  <xsl:if test="contains($valAuteurs,@ident)">
                                                      <li><xsl:value-of select="prenom"/> <xsl:value-of select="nom"/></li>
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
                                                 <xsl:attribute name="alt">page couverture de <xsl:value-of select="titre"/>
                                                 </xsl:attribute>
                                             </img>
                                          </xsl:if>
                                      </td>
                                      
                                  </tr>
                              </xsl:if>
                              
                          
                          
                      </xsl:for-each>
                        <!--/tbody-->
                        
                    </table>
                
            </xsl:when>
            
            <!-- aucun auteur en paramètre: tous les auteurs et livres triés par prix croissant -->
            <xsl:otherwise>
                <xsl:for-each select="/bibliotheque/auteur">
            
                    <xsl:variable name="idAuteur">
                        <!--xsl:value-of select="(/bibliotheque/auteur[nom=$nomAuteur])/@ident"/-->
                        <xsl:value-of select="@ident"/>
                    </xsl:variable>
                    
                    <h2> test <xsl:value-of select="prenom"/> <xsl:value-of select="nom"/> </h2>
                    
                    <xsl:if test="boolean(photo)">
                        <h3>Photo</h3>
                        <img>
                            <xsl:attribute name="src"><xsl:value-of select="photo"/></xsl:attribute>
                            <xsl:attribute name="alt">photo de 
                                <xsl:value-of select="prenom"/> 
                                <xsl:value-of select="nom"/>
                            </xsl:attribute>
                        </img>
                        
                    </xsl:if>
                    
                    <h3>Origine</h3>
                    <p>
                        Cet auteur est originaire de <xsl:value-of select="pays"/>
                    </p>
                    
                    <xsl:if test="boolean(commentaire)">
                        <h3>Informations supplémentaire</h3>
                        <p>
                            <xsl:value-of select="commentaire"/>
                        </p>
                    </xsl:if>
                    
                    <table>
                        <thead>
                            <th>titre</th>
                            <th>annee</th>
                            <th>prix</th>
                            <th>auteurs</th>
                            <th>commentaire</th>
                            <th>couverture</th>
                        </thead>
                        <tbody>
                            <xsl:for-each select="/bibliotheque/livre">
                                <xsl:sort select="prix" data-type="number" order="ascending" />
                                <xsl:variable name="valAuteurs"><xsl:value-of select="@auteurs"/></xsl:variable>
                                <xsl:if test="contains(@auteurs,$idAuteur)">
                                     <tr>
                                         <td>
                                             <xsl:value-of select="titre"/>
                                         </td>
                                         <td>
                                             <xsl:value-of select="annee"/>
                                         </td>
                                         <td>
                                             <xsl:value-of select="prix"/> <xsl:if test="boolean(prix/@monnaie)">
                                                 <xsl:value-of select="prix/@monnaie"/>
                                             </xsl:if>
                                         </td>
                                         
                                         <td>
                                             <ul>
                                                 <xsl:for-each select="/bibliotheque/auteur">
                                                     <xsl:if test="contains($valAuteurs,@ident)">
                                                         <li><xsl:value-of select="prenom"/> <xsl:value-of select="nom"/></li>
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
                                                    <xsl:attribute name="alt">page couverture de <xsl:value-of select="titre"/>
                                                    </xsl:attribute>
                                                </img>
                                             </xsl:if>  
                                         </td>
                                         
                                     </tr>
                                </xsl:if>
                                </xsl:for-each>
                        </tbody>
                        
                    </table>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>      
    </xsl:template>
     
</xsl:stylesheet>