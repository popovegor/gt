<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Filter.ascx.cs" Inherits="GT.Web.Site.Offers.Filter" %>
<%@ Import Namespace="GT.Web.UI.HierarchicalDataSources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register TagName="Button" TagPrefix="gt" Src="~/Controls/Button.ascx" %>
<asp:ScriptManagerProxy runat="server" ID="smpOffersFilter" />
<div id="offersFilter" class="filter" onkeypress='javascript:return WebForm_FireDefaultButton(event, "<%= btnSearch.ClientID %>")'>
  <div class="search">
    <div class="content">
      <div class="by-game">
        <asp:DropDownList ID="ddlGame" runat="server" Width="240" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" Category="<%# DictionaryTypes.Game.ToString() %>" SelectedValue="<%# GameId.HasValue ? GameId.Value : 0 %>" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.AnyGame %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# CommonResources.LoadingGameList %>" />
      </div>
      <div class="by-server">
        <asp:DropDownList ID="ddlServer" runat="server" Width="200" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" SelectedValue="<%# GameServerId.HasValue ? GameServerId.Value : 0 %>" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.AnyServer %>" ParentControlID="ddlGame" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# CommonResources.LoadingServerList %>" />
      </div>
      <div class="by-product-category">
        <asp:DropDownList ID="ddlProductCategory" runat="server" DataSource="<%# GetProductCategories() %>" AutoPostBack="false" DataValueField="Key" DataTextField="Value" AppendDataBoundItems="false" OnDataBound="ddlProductCategory_DataBound" Width="150" />
        
      </div>
      <div class="button">
        <gt:Button runat="server" ID="btnSearch" Text="<%# CommonResources.Search %>" />
      </div>
    </div>
  </div>
  <div class="add">
    <div class="content">
      <div>
        <%--<gt:Button runat="server" ID="btnAdd" Text="<%# CommonResources.Offers_ViewFilter_Sell  %>" />--%>
        <noindex>
         <asp:HyperLink runat="server" NavigateUrl="~/Office/Selling/Add" ID="hplAddSell" Text="<%# GT.Localization.Resources.CommonResources.Offers_ViewFilter_Sell%>" CssClass="sell" ToolTip="<%# CommonResources.Offers_ViewFilter_CreateNewOffer %>" Visible='<%# Entity == EntityType.SellingOffer %>' />
          <asp:HyperLink runat="server" NavigateUrl="~/Office/Buying/Add" ID="hplAddBuy" Text="<%# GT.Localization.Resources.CommonResources.Offers_ViewFilter_Buy%>" CssClass="buy" ToolTip="<%# CommonResources.Offers_ViewFilter_CreateNewDemand %>" Visible='<%# Entity == EntityType.BuyingOffer %>' />
  </noindex>
      </div>
    </div>
  </div>

  <script type="text/javascript" language="javascript">
    //<![CDATA[

    $(function() {
      $('#<%= btnSearch.ClientID %>').click(btnSearch_onClick);
    });

    function btnSearch_onClick(domEvent) {
      try {
        var sb = new Sys.StringBuilder();
        if ("<%= Entity %>" == "<%= EntityType.BuyingOffer%>") {
          sb.append('/Buying');
        } else {
          sb.append('/Selling');
        }
        sb.append(String.format('?{0}={1}', '<%= ViewFilterParams.IsSearchUsed %>', true.toString()));

        var gameId = $find("<%= cddGame.BehaviorID %>").get_SelectedValue();
        var gameServerId = $find("<%= cddServer.BehaviorID %>").get_SelectedValue();

        if (String.isNullOrEmpty(gameId) == false) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.GameId %>', gameId));
        }
        if (String.isNullOrEmpty(gameServerId) == false) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.GameServerId %>', gameServerId));
        }
        var productCategoryId = $("#<%# ddlProductCategory.ClientID %> option:selected").val();
        if (String.isNullOrEmpty(productCategoryId) == false) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.ProductCategoryId %>', productCategoryId));
        }
        
        window.cancelEvent(domEvent);
        window.location.href = sb.toString();
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }

    function btnReset_onClick(domEvent) {
      try {
        var sb = new Sys.StringBuilder();
        sb.append('<%= Request.Url.AbsolutePath %>');
        window.cancelEvent(domEvent);
        window.location.href = sb.toString();
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }
    //]]>
  </script>

</div>
