<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserCorrespondence.ascx.cs" Inherits="GT.Web.Site.Controls.UserCorrespondence" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<asp:UpdatePanel runat="server" ID="upFeedbacks" RenderMode="Block" UpdateMode="Conditional">
  <ContentTemplate>
    <gt:Box ID="bxCorrespondence" runat="server" CssClass="boxBrown boxCorrespondence"><Title><span>
      <%= Resources.CommonResources.Controls_UserCorrespondence_Correspondence %></span></Title>
      <Content>
        <asp:GridView runat="server" GridLines="None" AllowPaging="true" PageSize="5" AutoGenerateColumns="false" DataSource="<%# Correspondence %>" ID="gvCorrespondence" ShowHeader="false" ShowFooter="false" CssClass="gridCorrespondence" OnPageIndexChanging="gvCorrespondence_PageIndexChanging">
          <RowStyle CssClass="message" />
          <PagerStyle CssClass="gridPager" />
          <Columns>
            <asp:TemplateField>
              <ItemStyle CssClass="direction" />
              <ItemTemplate>
                <asp:Panel runat="server" CssClass='<%# (Guid)Eval("SenderId") == SenderId ? "messageDirection messageDirectionIn" : "messageDirection messageDirectionOut" %>' ID="pnlDirection" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
              <ItemStyle CssClass="data" />
              <ItemTemplate>
                <dl>
                  <dt>
                    <%= Resources.CommonResources.Controls_UserCorrespondence_Subject%>: </dt>
                  <dd class="subject">
                    <asp:Label runat="server" Text='<%# Eval("LocalizedSubject")%>' ID="lblSubject" />
                    <div class="number">
                      #<%# Container.DataItemIndex + 1 %></div>
                  </dd>
                  <dt>
                    <%= Resources.CommonResources.Controls_UserCorrespondence_Body%>:</dt>
                  <dd class="body">
                    <asp:Label runat="server" Text='<%# Eval("LocalizedBody")%>' ID="lblBody" />
                    <div class="createdDate">
                      <%= Resources.CommonResources.Controls_UserCorrespondence_CreatedAt%>
                      <asp:Label runat="server" Text='<%# Eval("CreateDate") %>' ID="lblCreateDate" /></div>
                  </dd>
                </dl>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <EmptyDataRowStyle CssClass="gridEmpty" />
          <EmptyDataTemplate>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.Controls_UserCorrespondence_NoCorrespondence %>" ID="ltrNoCorrespondence" />
          </EmptyDataTemplate>
        </asp:GridView>
      </Content>
    </gt:Box>
  </ContentTemplate>
</asp:UpdatePanel>
