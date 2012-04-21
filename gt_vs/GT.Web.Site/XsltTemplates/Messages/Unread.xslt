<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ms="urn:schemas-microsoft-com:xslt">
  <xsl:template match="/">
    <ul class="dashed">
      <xsl:variable name="MessageCount" select="count(//Message)" />
      <xsl:for-each select="//Message">
        <xsl:variable name="MessageId" select="MessageId"/>
        <li>
          <xsl:element name="a">
            <xsl:attribute name="onclick">return false;</xsl:attribute>
            <xsl:attribute name="href">#</xsl:attribute>
            <xsl:attribute name="class">user</xsl:attribute>
            <xsl:value-of select="SenderName"/>
          </xsl:element>
          <span class="subject">
            <xsl:value-of select="concat(': ', Subject)"/>
          </span>
        </li>
      </xsl:for-each>
    </ul>
  </xsl:template>
</xsl:stylesheet>