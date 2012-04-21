<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="FastOfferSearch.ascx.cs" Inherits="GT.Web.Site.Controls.FastOfferSearch" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="GT.Global.Offers" %>
<div class="fastOfferSearch">
  <%--<span>Search</span>--%>
  <div class="searchValue">
    <asp:TextBox runat="server" ID="txtSearchValue" />
  </div>
  <%--<ajaxToolkit:TextBoxWatermarkExtender runat="server" ID="tbweSearchValue" TargetControlID="txtSearchValue"
    WatermarkText="Enter any word you would like to find" WatermarkCssClass="textBoxWatermark" />--%>
  <%--<span>in</span>--%>
  <asp:Panel runat="server" ID="pnlActions" CssClass="actions">
    <asp:HyperLink runat="server" ID="hplSellingSearch" Text="<%$ Resources:CommonResources, SearchInSelling %>" SkinID="hplSellingSearchSkin" NavigateUrl="~/Offers/SellingViewer.aspx" />
    <%--or--%>
    <asp:HyperLink runat="server" ID="hplBuyingSearch" Text="<%$ Resources:CommonResources, SearchInBuying %>" SkinID="hplBuyingSearchSkin" NavigateUrl="~/Offers/BuyingViewer.aspx" />
  </asp:Panel>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[

  Sys.Application.add_load(
    function() {
      $addHandler($get('<%= hplSellingSearch.ClientID %>'), 'click', hplSellingSearch_onClick);
      $addHandler($get('<%= hplBuyingSearch.ClientID %>'), 'click', hplBuyingSearch_onClick);
    });

  Sys.Application.add_unload(function() {
    $clearHandlers($get('<%= hplSellingSearch.ClientID %>'));
    $clearHandlers($get('<%= hplBuyingSearch.ClientID %>'));
  });

  function hplBuyingSearch_onClick(event) {
    doSearch(GT.Ajax.Scripts.SearchIn.Buying);
    window.doCancelEvent(event);
  }

  function hplSellingSearch_onClick(event) {
    doSearch(GT.Ajax.Scripts.SearchIn.Selling);
    window.doCancelEvent(event);
  }

  function doSearch(searchIn) {
    var url = '<%= string.Format("{0}/Offers/{{0}}?{1}=true&{2}=", Request.Url.GetComponents(UriComponents.SchemeAndServer,UriFormat.UriEscaped), ViewFilterParams.IsSearchUsed,ViewFilterParams.SearchValue) %>';
    var searchValue = $get("<%= txtSearchValue.ClientID %>").value;
    url += searchValue;
    switch (searchIn) {
      case GT.Ajax.Scripts.SearchIn.Selling:
        url = String.format(url, "SellingViewer.aspx");
        break;
      case GT.Ajax.Scripts.SearchIn.Buying:
        url = String.format(url, "BuyingViewer.aspx");
        break;
    }
    if (window.location) {
      window.location.href = url;
    }
  }

  //]]>
</script>

