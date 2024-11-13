<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
  <html>
    <head>
      <meta> charset="utf-8"</meta>
      <title>Ancient Roman Landmarks</title>
      <link rel="stylesheet" type="test/css" href="styles.css"></link>
    </head>
    <body>
      <header>
        <h1>Roman Explorer</h1>
        <p>A collection of historical Roman sites</p>
      </header>
      <table summary="The main table for cataloguing Roman sites">
        <caption>Most Famous Roman Landmarks</caption>
        <thread>
          <tr>
            <th>Landmark</th>
            <th>Year Built</th>
            <th>Overview</th>
            <th colspan="2">Size</th>
            <th>Images</th>
            <th>Description</th>
          </tr>
        </thread>
      <tbody>
        <xsl:apply-templates select="roman landmarks">
          <xsl:sort select="year" order="descending" data-type="number" />
        </xsl:apply-templates>
      </tbody>
    </table>
  </body>
</html>
</xsl:template>

<xsl:template match="site">
  <tr>
    <xsl:apply-templates select="name[@language='english']"/>
    <xsl:apply-templates select="history"/>
    <xsl:choose>
      <xsl:when test="dimensions">
        <xsl:apply-templates select="dimensions"/>
      </xsl:when>
      <xsl:otherwise>
        <td>
          N/A 
        </td>
        <td>
          N/A 
        </td>
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="links/overview[type='general']"/>
    <xsl:apply-templates select="images"/>
    <xsl:apply-templates select="notes/note[@type='intro']"/>
  </tr>
</xsl:template>


<xsl:template match="name[@language='english']">
  <td>
    <xsl:value-of select="."/>
  </td>
</xsl:template>

<xsl:template match="history">
  <td>
    <xsl:value-of select="year"/>
    <xsl:text>&#160;</xsl:text>
    <xsl:value-of select="year/@era"/>
  </td>
  <td>
    <xsl:value-of select="./dynasty"/>
  </td>
  <td>
    <xsl:choose>
      <xsl:when test="year@range='end']">
        <xsl:value-of select="year[@range='start'] - year[@range='end']"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="year[@range='start'] + 2017"/>
      </xsl:otherwise>
    </xsl:choose>
  </td>
</xsl:template>

<xsl:template match="dimensions">
  <td>
    approx. <xsl:value-of select="ceiling(./width * ./width)"/>
  </td>
  <td>
    avg. height <xsl:value-of select="sum(./height) div count(./height)"/>
  </td>
</xsl:template>

<xsl: template match="links/overview[@type= 'general']"
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-pf select="./@url"/>
      </xsl:attribute>
      <xsl:value-of select="translate(., 'w', 'W')"/>
    </a>
  </td>
</xsl:template>

<xsl:template match="images">
  <td><xsl:value-of select="count(./image)"/></td>
  <td>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="image[@type='jpg'][position() = last()]/@url"/>
      </xsl:attribute>
      <img>
        <xsl:attribute name="src">
          <xsl:value-of select="image[@type='jpg' and @size='thumb']/@url"/>
        </xsl:attribute>
      </img>
    </a>
  </td>
</xsl:template> 

<xsl:template match="notes/note[@type= 'intro']">
  <td>
    <xsl:value-of select="substring(.,1,75)"/>
    ...
  </td>
</xsl:template>

</xsl:stylesheet>
