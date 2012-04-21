<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="OfferFilterPopup.ascx.cs" Inherits="GT.Web.Site.Controls.OfferFilterPopup" %>
<%@ Import Namespace="GT.Web.UI.HierarchicalDataSources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Global.Entities" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register TagName="Button" TagPrefix="gt" Src="~/Controls/Button.ascx" %>
<asp:ScriptManagerProxy runat="server" ID="smpOfferFilterPopup" />
<div class="offerFilterPopup" id="offerFilterPopup" runat="server">
  <div id="filter" runat="server">
    <dl>
      <dt>
        <%= CommonResources.Game %>:</dt>
      <dd>
        <asp:DropDownList ID="ddlGame" runat="server" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" Category="<%# DictionaryTypes.Game.ToString() %>" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.AnyGame %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# CommonResources.LoadingGameList %>" />
      </dd>
      <dt>
        <%= CommonResources.Server %>:</dt>
      <dd>
        <asp:DropDownList ID="ddlServer" runat="server" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.AnyServer %>" ParentControlID="ddlGame" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# CommonResources.LoadingServerList %>" />
      </dd>
    </dl>
    <div class="searchControls">
      <gt:Button runat="server" ID="btnSearch" Text="<%# CommonResources.Search %>" />
    </div>
  </div>
  <div id="waiting" class="waiting" runat="server">
    <asp:Image ImageUrl="~/App_Themes/Tutynin/Images/waiting.gif" runat="server" ID="imgWaiting" />
  </div>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[

  var offerFilterPopup = null;

  Sys.Application.add_load(function() {
    offerFilterPopup = new GT.Ajax.Scripts.OfferFilterPopup("<%= offerFilterPopup.ClientID %>", "<%= CommonResources.Controls_OfferFilterPopup_Title %>");
    raiseSearch = function(event) { WebForm_FireDefaultButton(event.rawEvent, "<%= btnSearch.ClientID %>"); }
    $addHandler($get("<%= offerFilterPopup.ClientID %>"), "keypress", raiseSearch);
    $addHandler($get("<%= btnSearch.ClientID %>"), "click", btnSearch_onClick);
  });

  Sys.Application.add_unload(function() {
    $clearHandlers($get("<%= offerFilterPopup.ClientID %>"));
    $clearHandlers($get("<%= btnSearch.ClientID %>"));
  });


  function btnSearch_onClick(event) {
    $("#<%= filter.ClientID %>").hide();
    $("#<%= waiting.ClientID %>").show();
    var sb = new Sys.StringBuilder("<%= Request.Url.GetComponents(UriComponents.SchemeAndServer, UriFormat.UriEscaped) %>");
    switch (offerFilterPopup.get_inSearch()) {
      case GT.Ajax.Scripts.SearchIn.Buying:
        sb.append("/Offers/BuyingViewer.aspx");
        break;
      case GT.Ajax.Scripts.SearchIn.Selling:
        sb.append("/Offers/SellingViewer.aspx");
        break;
    }
    sb.append("?<%=ViewFilterParams.IsSearchUsed %>=true");
    var game = $find("<%= cddGame.BehaviorID %>").get_SelectedValue();
    if (String.isNullOrEmpty(game) == false) {
      sb.append(String.format("&<%=ViewFilterParams.GameId %>={0}", game));
    }
    var server = $find("<%= cddServer.BehaviorID %>").get_SelectedValue();
    if (String.isNullOrEmpty(server) == false) {
      sb.append(String.format('&<%= ViewFilterParams.GameServerId %>={0}', server));
    }
    window.redirect(sb.toString());
    window.cancelEvent(event);
  }

  //]]>
</script>

