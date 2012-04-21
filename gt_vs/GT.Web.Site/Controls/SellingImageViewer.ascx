<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SellingImageViewer.ascx.cs" Inherits="GT.Web.Site.Controls.SellingImageViewer" %>
<div class="image">
  <a runat="server" href="<%# ImageUrl %>" id="imageAnchor">
    <img runat="server" alt="" src="<%# ImageUrl %>" width="<%# Width %>" height="<%# Height %>" id="image" />
  </a>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[

  function applyZoom(imageAnchorId) {
    if (imageAnchorId) {
      $(String.format("#{0}", imageAnchorId)).imageZoom();
    } else {
      $("#<%= imageAnchor.ClientID %>").imageZoom();
    }
  };
  
  $(function() {
    applyZoom();
  });

  function imageSellingViewer_updateUrl(imageAnchorId, imageId, newUrl) {
    newUrl = newUrl.replace(/^~/, "");
    var imageAnchor = $(String.format("#{0}", imageAnchorId));
    var image = $(String.format("#{0}", imageId));
    if (imageAnchor && image) {
      imageAnchor.attr("href", newUrl);
      image.attr("src", newUrl);
      applyZoom(imageAnchorId);
      imageAnchor.show();
    }
  };

  

  //]]>
</script>

