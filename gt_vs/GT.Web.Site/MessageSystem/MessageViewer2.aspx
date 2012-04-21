<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.Master" AutoEventWireup="true" CodeBehind="MessageViewer2.aspx.cs" Inherits="GT.Web.Site.MessageSystem.MessageViewer2" %>

<%@ Import Namespace="GT.DA.MessageSystem" %>
<%@ Import Namespace="GT.Web.Site.WebServices.Ajax" %>
<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.Global.Users" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="System.Linq" %>
<%@ Import Namespace="GT.BO.Implementation.MessageSystem" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Web.UI.HtmlTemplateSystem" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Global.Security" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Menu/Submenu.ascx" TagName="Submenu" TagPrefix="gt" %>
<%@ Register Src="~/Menu/SubmenuItem.ascx" TagName="SubmenuItem" TagPrefix="gt"
 %>
<asp:Content ContentPlaceHolderID="cphSidebar" ID="cntFilter" runat="server">
  <div class="messages-menu">
    <gt:Submenu runat="server" ID="sm1">
      <Content>
        <gt:SubmenuItem runat="server" ID="smiIn" NavigateUrl='<%# string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.In.ToString() )%>' Text='<%# string.Format(GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_In, Dynamics.MessagesUnread > 0 ? string.Format("<b>({0})</b>", Dynamics.MessagesUnread) : string.Empty) %>' />
        <gt:SubmenuItem runat="server" ID="smiOut" NavigateUrl='<%# string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.Out.ToString() )%>' Text='<%# GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_Out %>' />
      </Content>
    </gt:Submenu>
  
   <%-- <ul id="submenu">
      <li class="in">
        <a href='<%= string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.In.ToString() )%>' id="hplIn"><%# string.Format(GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_In, Dynamics.MessagesUnread > 0 ? string.Format("<b>({0})</b>", Dynamics.MessagesUnread) : string.Empty) %></a>
      </li>
      <li class="out">
        <asp:HyperLink NavigateUrl='<%# string.Format("~/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.Out.ToString() )%>' ID="hplOut" runat="server" Text="<%# GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_Out %>" />
      </li>
    </ul>--%>
  </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="sm">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/MessageViewer.js" />
    </Scripts>
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/MessageSystemService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <%--version 3--%>
  <div class="messages">
    <%--IN--%>
    <asp:UpdatePanel ChildrenAsTriggers="true" runat="server" RenderMode="Block">
      <ContentTemplate>
        <asp:GridView ID="gv" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" DataSource="<%# Direction == MessageType.In ? InMessages : Direction == MessageType.Out ? OutMessages : new Message[] {}%>" CssClass="grid in" EnableViewState="false" Visible="<%#Direction == MessageType.In || Direction == MessageType.Out %>">
          <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
          <PagerStyle CssClass="pager" />
          <RowStyle CssClass="row" />
          <Columns>
            <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
              <ItemTemplate>&nbsp; </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-CssClass="user" ItemStyle-CssClass="user separator">
              <HeaderTemplate>
                <%# Direction == MessageType.In ? CommonResources.MessageSystem_MessageViewer_Sender : Direction == MessageType.Out ? CommonResources.MessageSystem_MessageViewer_Recipient : string.Empty %>
              </HeaderTemplate>
              <ItemTemplate>
                <p>
                  <gt:User runat="server" ShowUserCard="true" ID="sender" UserId='<%# Direction == MessageType.In ? Eval("SenderId") : Direction == MessageType.Out ? Eval("RecipientId") : Guid.Empty %>' />
                </p>
                <p class="date">
                  <%# ((DateTime)Eval("CreateDate")).UtcToLocal().ToString(CommonResources.MessageSystem_MessageViewer_DateFormat)%>
                </p>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-CssClass="message separator" ItemStyle-CssClass="message separator">
              <HeaderTemplate>
                <%# GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_Message %>
              </HeaderTemplate>
              <ItemTemplate>
                <div class="new">
                  <p class="attention ">
                    <%= CommonResources.Messages_NewMessage_Attention %>
                  </p>
                  <asp:TextBox runat="server" ID="txtBody" AutoPostBack="false" TextMode="MultiLine" />
                  <asp:RequiredFieldValidator SetFocusOnError="true" ControlToValidate="txtBody" runat="server" Display="None" ErrorMessage='<%# CommonResources.MessageSystem_MessageViewer_IsEmpty %>' ID="rfvBody" ValidationGroup='<%# Eval("MessageId") %>' />
                  <ajaxToolkit:ValidatorCalloutExtender PopupPosition="TopLeft" TargetControlID="rfvBody" ID="vceBody" runat="server" />
                  <div>
                    <span name="send">
                      <gt:Button runat="server" Name="send" ID="btnSend" Text="<%# CommonResources.MessageSystem_MessageViewer_Send %>" OnClientClick='<%# string.Format("return msg_send(event, {0}, \"{1}\", \"{2}\")", Eval("MessageId"), GetTargetUser(Container.DataItem as Message),  CommonResources.AddMessageSuccess) %>' UseSubmitBehavior="false" />
                    </span><span name="cancel">
                      <gt:Button runat="server" Name="cancel" ID="btnCancel" Text="<%# CommonResources.MessageSystem_MessageViewer_Cancel %>" OnClientClick='<%# string.Concat("return msg_cancel(event,", Eval("MessageId"),")") %>' UseSubmitBehavior="false" CausesValidation="false" />
                    </span>
                  </div>
                </div>
                <p class="body"><span>
                  <%# Eval("LocalizedBody")%></span> </p>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderStyle-CssClass="actions separator" ItemStyle-CssClass="actions separator">
              <HeaderTemplate>
                <%# GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_Actions %>
              </HeaderTemplate>
              <ItemTemplate>
                <div style='<%# GetTargetUser(Container.DataItem as Message) == MembershipSettings.SystemUserKey ? "display:none": "" %>'>
                  <p class="reply"><a href="#" target="_self" runat="server" onclick='<%# string.Concat("msg_reply(event,", Eval("MessageId"),");")%>'>
                    <%#  Direction == MessageType.In ? CommonResources.MessageSystem_MessageViewer_Reply : Direction == MessageType.Out ? CommonResources.MessageSystem_MessageViewer_New : string.Empty%></a></p>
                  <p class="conversation"><a href='<%# string.Format("~/Users/User/{1}/{3}#new", UserCardParams.UserId, GetTargetUser(Container.DataItem as Message), UserCardParams.DataType, UserCardParams.Data.Conversation) %>' runat="server" target="_self">
                    <%# CommonResources.MessageSystem_MessageViewer_ShowConversation %></a><a class="new-window" href='<%# string.Format("~/Users/User/{1}/{3}#new", UserCardParams.UserId, GetTargetUser(Container.DataItem as Message), UserCardParams.DataType, UserCardParams.Data.Conversation) %>' target="_blank" runat="server" title="<%# CommonResources.OpenNewWindow %>">&nbsp;</a> </p>
                </div>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right"></asp:TemplateField>
          </Columns>
          <EmptyDataRowStyle CssClass="grid-empty" />
          <EmptyDataTemplate>
            <asp:Label EnableViewState="false" runat="server" ID="lblNoMessages" Text="<%# GT.Localization.Resources.CommonResources.NoMessagesFound %>" />
          </EmptyDataTemplate>
        </asp:GridView>
      </ContentTemplate>
    </asp:UpdatePanel>
  </div>
</asp:Content>
