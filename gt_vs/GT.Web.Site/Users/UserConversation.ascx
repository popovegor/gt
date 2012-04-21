<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserConversation.ascx.cs" Inherits="GT.Web.Site.Users.UserConversation" %>
<%@ Import Namespace="System.Threading" %>
<%@ Import Namespace="GT.Localization.Resources " %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<div class="uc-conversation">
  <dl class="uc-message-new">
    <dt><span>
      <%# CommonResources.Users_UserCard_NewMessage%></span> </dt>
    <dd>
      <%--<p class="attention">
          <%= CommonResources.Messages_NewMessage_Attention %>
        </p>--%>
      <asp:TextBox runat="server" TabIndex="0" ID="txtBody" AutoPostBack="false" Text="" TextMode="MultiLine" Rows="10" />
      <asp:RequiredFieldValidator SetFocusOnError="true" ControlToValidate="txtBody" runat="server" Display="None" ErrorMessage='<%# CommonResources.MessageSystem_MessageViewer_IsEmpty %>' ID="rfvBody" ValidationGroup='MessageNew' />
      <ajaxToolkit:ValidatorCalloutExtender TargetControlID="rfvBody" ID="vceBody" runat="server" PopupPosition="Right" />
      <div class="uc-message-send">
        <gt:Button runat="server" Name="send" ID="btnSend" Text="<%# CommonResources.MessageSystem_MessageViewer_Send %>" ValidationGroup="MessageNew" UseSubmitBehavior="true" OnClientClick="this.style.visible=false;" OnClick="btnSend_Click" />
      </div>

      <script language="javascript" type="text/javascript">
        //<![CDATA[
        $(function() {
          var txt = $(".uc-message-new textarea");
          txt.textLimiter({ maxLength: 250, show : false });
          txt.val("");
        });
        //]]>
      </script>

    </dd>
  </dl>
  <dl class="uc-dialog">
    <dt class="all" id="conv"><span>
      <%# CommonResources.Users_UserCard_Messages%></span> </dt>
    <dd>
      <asp:UpdatePanel runat="server" ID="upMessages" RenderMode="Block">
        <ContentTemplate>
          <asp:GridView runat="server" GridLines="None" AllowPaging="true" PageSize="15" AutoGenerateColumns="false" DataSource="<%# Messages %>" ID="gv" ShowHeader="false" ShowFooter="false" CssClass="grid conversation" OnPageIndexChanging="gv_PageIndexChanging" OnRowDataBound="gv_RowDataBound">
            <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
            <PagerStyle CssClass="pager" />
            <RowStyle CssClass="row" />
            <Columns>
              <asp:TemplateField ItemStyle-CssClass="sender separator" HeaderStyle-CssClass="sender">
                <HeaderTemplate>
                  <%# CommonResources.MessageSystem_MessageViewer_Sender %>
                </HeaderTemplate>
                <ItemTemplate>
                  <p>
                    <gt:User runat="server" ShowUserCard="true" ID="sender" UserId='<%# Eval("SenderId")  %>' />
                  </p>
                  <p class="uc-dialog-entry-date">
                    <%# ((DateTime)Eval("CreateDate")).UtcToLocal(CommonResources.MessageSystem_MessageViewer_DateFormat)%>
                  </p>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField ItemStyle-CssClass="message separator" HeaderStyle-CssClass="message">
                <HeaderTemplate>
                  <%# GT.Localization.Resources.CommonResources.MessageSystem_MessageViewer_Message %>
                </HeaderTemplate>
                <ItemTemplate>
                  <p class="body"><span>
                    <%# Eval("LocalizedBody")%></span> </p>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="grid-empty" />
            <EmptyDataTemplate>
              <%# CommonResources.Users_UserCard_MessagesNo%>. </EmptyDataTemplate>
          </asp:GridView>
        </ContentTemplate>
      </asp:UpdatePanel>
    </dd>
  </dl>
</div>
