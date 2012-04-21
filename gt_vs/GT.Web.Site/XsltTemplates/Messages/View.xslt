<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ms="urn:schemas-microsoft-com:xslt"
      xmlns:dt="urn:schemas-microsoft-com:datatypes">
  <xsl:template match="/">
    <div>
      <xsl:for-each select="//Message">
        <xsl:variable name="MessageId" select="MessageId"/>
        <xsl:variable name="CreateDate" select="CreateDate" />
        <xsl:variable name="Unread" select="Unread"/>
        <div class="message dashed">
          <xsl:attribute name="id">
            <xsl:value-of select="concat('message_', $MessageId)"/>
          </xsl:attribute>
          <p class="subject">
            <xsl:value-of select="Subject"/>
          </p>
          <p class="body">
            <xsl:choose>
              <xsl:when test="$Unread = 'true'">
                <a href="#" unread="true" name="Show">
                  <xsl:attribute name="onclick">
                    <xsl:value-of select="concat('message_showBody(', $MessageId ,'); return false;')"/>
                  </xsl:attribute>
                  <xsl:attribute name="id">
                    <xsl:value-of select="concat('messageShow_', $MessageId)"/>
                  </xsl:attribute>
                  <xsl:attribute name="messageId">
                    <xsl:value-of select="$MessageId"/>
                  </xsl:attribute>
                  <xsl:text>Show body</xsl:text>
                </a>
                <span title="Body">
                  <xsl:attribute name="style">display:none</xsl:attribute>
                  <xsl:attribute name="id">
                    <xsl:value-of select="concat('messageBody_', $MessageId)"/>
                  </xsl:attribute>
                  <xsl:value-of select="Body"/>
                </span>
              </xsl:when>
              <xsl:otherwise>
                <span title="Body">
                  <xsl:value-of select="Body"/>
                </span>
              </xsl:otherwise>
            </xsl:choose>
          </p>
          <p class="sentTime">
            <xsl:text>created at </xsl:text>
            <xsl:value-of select="ms:format-time($CreateDate, 'HH:mm')"/>
            <xsl:text> on </xsl:text>
            <xsl:value-of select="ms:format-date($CreateDate, 'MMM dd, yyyy')"/>
            <xsl:text> by </xsl:text>
            <a href="#" class="user" onclick="return false;">
              <xsl:value-of select="SenderName"/>
            </a>
          </p>
          <p class="delete">
            <input type="button" class="deleteOperation">
              <xsl:attribute name="onclick">
                <xsl:value-of select="concat('message_delete(', $MessageId ,'); return false;')"/>
              </xsl:attribute>
              <xsl:attribute name="value">Delete</xsl:attribute>
            </input>
          </p>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

</xsl:stylesheet>