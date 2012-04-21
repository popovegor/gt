<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="MessageViewer.aspx.cs" Inherits="GT.Web.Site.MessageSystem.MessageViewer" EnableViewState="false" %>

<%@ Import Namespace="GT.DA.MessageSystem" %>
<%@ Import Namespace="GT.Web.Site.WebServices.Ajax" %>
<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.MessageSystem" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain">
    <Services>
      <asp:ServiceReference Path="~/WebServices/Ajax/MessageSystemService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <div id="messagesFilter">
    <div class="search">
      <dl>
        <dt>
          <%= CommonResources.Messages_MessageViewer_Sender %>:</dt>
        <dd>
          <asp:DropDownList AppendDataBoundItems="true" runat="server" DataValueField="Key" DataTextField="Value" DataSource="<%# new MessageSystemService().GetSenderList()  %>" ID="ddlSenderList" />
        </dd>
        <dt>
          <%= CommonResources.Messages_MessageViewer_Last %>: </dt>
        <dd>
          <asp:DropDownList AppendDataBoundItems="true" runat="server" DataValueField="Key" DataTextField="Value" DataSource='<%# new[] {new KeyValuePair<string, string>(DefaultCount.ToString(), DefaultCount.ToString()),new KeyValuePair<string, string>("100", "100"), new KeyValuePair<string, string>("500", "500"), new KeyValuePair<string, string>("1000", "1000"), new KeyValuePair<string, string>(int.MaxValue.ToString(), CommonResources.All)} %>' ID="ddlCount" />
        </dd>
      </dl>
      <div>
        <input type="checkbox" runat="server" checked='<%# UnreadOnly %>' id="chkUnreadOnly" />
        <label id="lblUnreadOnly" for="<%# chkUnreadOnly.ClientID %>" runat="server">
          <%= CommonResources.UnreadOnly %></label>
      </div>
    </div>
    <div class="controls">
      <gt:Button runat="server" ID="btnSearch" ToolTip="<%$ Resources:CommonResources, Search %>" Text="<%$ Resources:CommonResources, Search %>" />
      <gt:Button ID="btnReset" runat="server" ToolTip="<%$ Resources:CommonResources, Reset %>" Text="<%$ Resources:CommonResources, Reset %>" />
    </div>
  </div>
  <div id="messages">
    <asp:GridView ID="gvMessages" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvMessages_PageIndexChanging" DataSource="<%# Messages %>" CssClass="grid messages" EnableViewState="false" OnRowDataBound="gvMessages_RowDataBound">
      <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
      <AlternatingRowStyle CssClass="gridAlternative" />
      <Columns>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
          <ItemTemplate></ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, MessageSystem_MessageViewer_CreatedAt %>" HeaderStyle-CssClass="data" ItemStyle-CssClass="data">
          <ItemTemplate><span>
            <%# ((DateTime)Eval("CreateDate")).UtcToLocal() %></span> </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, MessageSystem_MessageViewer_Sender %>" HeaderStyle-CssClass="sender" ItemStyle-CssClass="sender">
          <ItemTemplate>
            <gt:User runat="server" ID="ulSender" UserId='<%# Eval("SenderId") %>' />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="<%$ Resources:CommonResources, MessageSystem_MessageViewer_Message %>" HeaderStyle-CssClass="message" ItemStyle-CssClass="message">
          <ItemTemplate>
            <dl>
              <dt>
                <%= Resources.CommonResources.MessageSystem_MessageViewer_Subject %>: </dt>
              <dd>
                <asp:Label runat="server" ID="lblSubject" Text='<%# Eval("LocalizedSubject") %>' />
                 <div class="actions">
                  <asp:ImageButton SkinID="btnReplySkin" Text="<%# Resources.CommonResources.MessageSystem_MessageViewer_Reply %>" runat="server" ToolTip="<%# Resources.CommonResources.MessageSystem_MessageViewer_Reply %>" ID="btnReply" OnClientClick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(AddMessage, {RecipientId :\"",  Eval("SenderId") , "\"}); return false;} return true;") %>' Visible='<%# Eval("SenderId").Equals(GT.Global.Membership.MembershipSettings.SystemUserKey) == false %>' />
                  <asp:ImageButton SkinID="btnDeleteSkin" Text="<%# Resources.CommonResources.MessageSystem_MessageViewer_Delete %>" runat="server" ToolTip="<%# Resources.CommonResources.MessageSystem_MessageViewer_Delete%>" ID="btnDelete" OnClientClick='<%# string.Format("message_delete({0}); return false;", Eval("MessageId")) %>' />
                </div>
              </dd>
              <dt>
                <%= Resources.CommonResources.MessageSystem_MessageViewer_Body %>:</dt>
              <dd>
                <asp:HyperLink Visible='<%# TypeConverter.ToBool(Eval("Unread")) == true  %>' runat="server" ID="hplShowBody" showBodyId='<%# Eval("MessageId") %>' Text="<%# Resources.CommonResources.MessageSystem_MessageViewer_ShowBody %>" NavigateUrl="#" onclick='<%# string.Format("javascript:message_showBody({0}); return false;", Eval("MessageId")) %>' />
                <asp:Label runat="server" Text='<%# Eval("LocalizedBody") %>' Style='<%# TypeConverter.ToBool(Eval("Unread")) == true ? "display:none": string.Empty %>' bodyId='<%# Eval("MessageId") %>' />
              </dd>
            </dl>
          </ItemTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
          <ItemTemplate></ItemTemplate>
        </asp:TemplateField>
      </Columns>
      <EmptyDataRowStyle CssClass="gridEmpty" />
      <EmptyDataTemplate>
        <asp:Label EnableViewState="false" runat="server" ID="lblNoMessages" Text="<%$ Resources:CommonResources, NoMessagesFound %>" />
      </EmptyDataTemplate>
    </asp:GridView>
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[

    function pageLoad() {
      $addHandler($get('<%= btnSearch.ClientID %>'), 'click', btnSearch_onClick);
      $addHandler($get('<%= btnReset.ClientID %>'), 'click', btnReset_onClick);
    }

    function pageUnload() {
      $clearHandlers($get('<%= btnSearch.ClientID %>'));
      $clearHandlers($get('<%= btnReset.ClientID %>'));
    }

    function btnSearch_onClick(domEvent) {
      try {
        var sb = new Sys.StringBuilder();
        sb.append('<%= Request.Url.AbsolutePath %>');
        var fromSender = DomManager.getSelectedValue($get("<%= ddlSenderList.ClientID %>"));
        sb.append(String.format("?{0}={1}"
                    , "<%= MessageFilterParams.FromSender %>", fromSender));
        var unreadOnly = DomManager.isChecked($get("<%= chkUnreadOnly.ClientID %>"));
        sb.append(String.format("&{0}={1}"
                    , "<%= MessageFilterParams.UnreadOnly %>", unreadOnly));
        var count = DomManager.getSelectedValue($get("<%= ddlCount.ClientID %>"));
        sb.append(String.format("&{0}={1}"
                    , "<%= MessageFilterParams.Count %>", count));
        window.location.assign(sb.toString());
        window.doCancelEvent(domEvent);
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }

    function btnReset_onClick(domEvent) {
      try {
        var sb = new Sys.StringBuilder();
        sb.append('<%= Request.Url.AbsolutePath %>');
        window.location.assign(sb.toString());
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }

    function message_getMessageId(messageId) {
      return String.format("message{0}", messageId);
    }

    function message_getMessageName(messageId) {
      return message_getMessageId(messageId);
    }

    function message_getBody(messageId) {
      var selector = String.format("span[bodyId={0}]", messageId);
      return $(selector)[0];
    }

    function message_getShowBody(messageId) {
      var selector = String.format("a[showBodyId={0}]", messageId);
      return $(selector)[0];
    }

    function message_showBody(messageId) {
      try {
        if (isNaN(messageId) == false && messageId > 0) {
          var body = message_getBody(messageId);
          var show = message_getShowBody(messageId);
          if (body && show) {
            DomManager.hide(show, true);
            DomManager.show(body);
            var message = new GT.BO.Implementation.MessageSystem.Message();
            message.MessageId = messageId;
            GT.Web.Site.WebServices.Ajax.MessageSystemService.ReadMessage(
              message, message_onReadSuccess, message_onReadFailure, messageId);
          }
        }
      }
      catch (e) {
        Sys.Debug.traceDump(e);
      }
    }

    function message_onReadSuccess(result, context, methodName) {
      Sys.Debug.traceDump(result);
    }

    function message_onReadFailure(error, context, methodName) {
      Sys.Debug.traceDump(error);
    }

    function message_delete(messageId) {
      var message = new GT.BO.Implementation.MessageSystem.Message();
      message.MessageId = messageId;
      var msg = $get(message_getMessageId(messageId));
      //var msg = document.getElementsByName(message_getMessageName(messageId)[0];
      if (msg) {
        if (confirm("<%= CommonResources.DeleteMessageConfirmation %>")) {
          //DomManager.setText(msg, "Deleting...");
          GT.Web.Site.WebServices.Ajax.MessageSystemService.DeleteMessage(
                        message
                        , message_onDeleteSuccess
                        , message_onDeleteFailure
                        , messageId);
        }
      }
    }

    function message_onDeleteSuccess(result, context, methodName) {
      if (context) {
        var msg = $get(message_getMessageId(context));
        DomManager.hide(msg, true);
      }
    }

    function message_onDeleteFailure(error, context, methodName) {
      Sys.Debug.traceDump(error);
    }

    //]]>
  </script>

</asp:Content>
