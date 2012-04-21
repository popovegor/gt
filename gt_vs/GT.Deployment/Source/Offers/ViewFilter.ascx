﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ViewFilter.ascx.cs"
  Inherits="GT.Web.Site.Offers.ViewFilter" %>
<%@ Import Namespace="GT.Web.UI.HierarchicalDataSources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="Resources" %>
<%@ Register TagName="Button" TagPrefix="gt" Src="~/Controls/Button.ascx" %>
<asp:ScriptManagerProxy runat="server" ID="smpOffersFilter" />
<div id="offersFilter" onkeypress='javascript:return WebForm_FireDefaultButton(event, "<%= btnSearch.ClientID %>")'>
  <div class="searchByDictionaries">
    <dl class="filter">
      <dt>
        <%= CommonResources.Game %>:</dt>
      <dd>
        <asp:DropDownList ID="ddlGame" runat="server" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" Category="<%# DictionaryTypes.Game.ToString() %>"
          SelectedValue="<%# GameId.HasValue ? GameId.Value : 0 %>" TargetControlID="ddlGame"
          ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.SelectGame %>"
          ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# CommonResources.LoadingGameList %>" />
      </dd>
      <dt>
        <%= CommonResources.Server %>:</dt>
      <dd>
        <asp:DropDownList ID="ddlServer" runat="server" />
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>"
          SelectedValue="<%# GameServerId.HasValue ? GameServerId.Value : 0 %>" TargetControlID="ddlServer"
          ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# CommonResources.SelectServer %>"
          ParentControlID="ddlGame" ServicePath="~/WebServices/Ajax/DictionariesService.asmx"
          LoadingText="<%# CommonResources.LoadingServerList %>" />
      </dd>
    </dl>
  </div>
  <div class="searchByValue">
    <dl>
      <dt>
        <%= CommonResources.Value %>:</dt>
      <dd class="value">
        <asp:TextBox runat="server" ID="txtSearchValue" Text="<%# SearchValue %>" />
      </dd>
      <dt>
        <%= CommonResources.OnlyIn %>:</dt>
      <dd id="searchIn">
        <asp:Repeater runat="server" ID="rptSearchIn" DataSource="<%# SearchInCollection %>">
          <ItemTemplate>
            <input type="checkbox" value='<%# (int)TypeConverter.ToEnumMember<SearchInTypes>(Eval("Key").ToString()) %>'
              id='<%# string.Format("{0}_{1}", Eval("Key"), ((DelegateWrapper)Eval("Value")).Value ) %>' <%# EnumHelper.HasFlags<SearchInTypes>(SearchIn, TypeConverter.ToEnumMember<SearchInTypes>(Eval("Key").ToString())) ? "checked" : string.Empty %> />
            <label for='<%# string.Format("{0}_{1}", Eval("Key"), ((DelegateWrapper)Eval("Value")).Value ) %>'>
              <%# ((DelegateWrapper)Eval("Value")).Value %>
            </label>
          </ItemTemplate>
        </asp:Repeater>
      </dd>
    </dl>
  </div>
  <div class="controls">
    <gt:Button runat="server" ID="btnSearch" Text="<%# CommonResources.Search %>" />
    <gt:Button runat="server" ID="btnReset" Text="<%# CommonResources.Reset %>" />
  </div>

  <script type="text/javascript" language="javascript">
    //<![CDATA[

    Sys.Application.add_load(
    function() {
      $addHandler($get('<%= btnSearch.ClientID %>'), 'click', btnSearch_onClick);
      $addHandler($get('<%= btnReset.ClientID %>'), 'click', btnReset_onClick);
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get('<%= btnSearch.ClientID %>'));
      $clearHandlers($get('<%= btnReset.ClientID %>'));
    });

    function btnSearch_onClick(domEvent) {
      try {
        var sb = new Sys.StringBuilder();
        sb.append('<%= Request.Url.AbsolutePath %>');
        sb.append(String.format('?{0}={1}', '<%= ViewFilterParams.IsSearchUsed %>', true.toString()));
        var searchValue = $get('<%= txtSearchValue.ClientID %>').value;
        var searchIn = 0;
        var searchInCollection = $get("searchIn").getElementsByTagName("input");
        if (searchInCollection) {
          for (var i = 0; i < searchInCollection.length; i++) {
            var elem = searchInCollection[i];
            if (elem && elem.checked) {
              searchIn = searchIn | elem.value;
            }
          }
        }
        var gameId = $find("<%= cddGame.BehaviorID %>").get_SelectedValue();
        var gameServerId = $find("<%= cddServer.BehaviorID %>").get_SelectedValue();
        if (false == String.isNullOrEmpty(searchValue)) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.SearchValue %>', escape(searchValue)));
          if (searchIn > 0) {
            sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.SearchIn %>', searchIn));
          }
        }
        if (String.isNullOrEmpty(gameId) == false) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.GameId %>', gameId));
        }
        if (String.isNullOrEmpty(gameServerId) == false) {
          sb.append(String.format('&{0}={1}', '<%= ViewFilterParams.GameServerId %>', gameServerId));
        }
        window.doCancelEvent(domEvent);
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
        window.doCancelEvent(domEvent);
        window.location.href = sb.toString();
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }
    //]]>
  </script>

</div>