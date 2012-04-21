<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserFeedbacks.ascx.cs" Inherits="GT.Web.Site.Controls.UserFeedbacks" %>
<%@ Import Namespace="GT.DA.UserRating" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>

<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>

<asp:UpdatePanel runat="server" ID="upFeedbacks" RenderMode="Block" UpdateMode="Conditional">
  <ContentTemplate>
    <ajaxToolkit:TabContainer runat="server" ID="tcFeedbacks" CssClass="tabConteiner tabConteinerBrown" AutoPostBack="true" OnActiveTabChanged="tcFeedbacks_ActiveTabChanged">
      <ajaxToolkit:TabPanel runat="server" >
        <HeaderTemplate><span><%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_AsSeller, CountOfFeedbacksAsSeller)%></span> </HeaderTemplate>
        <ContentTemplate>
          <asp:GridView runat="server" GridLines="None" PageSize="5" AllowPaging="true" AutoGenerateColumns="false" DataSource="<%# FeedbacksAsSeller %>" ID="gvFeedbacksAsSeller" ShowHeader="false" ShowFooter="false" CssClass="gridFeedbacks" OnPageIndexChanging="gvFeedbacksAsSeller_PageIndexChanging">
          <PagerStyle CssClass="gridPager" />
            <Columns>
              <asp:TemplateField>
                <ItemTemplate>
                  <dl class="feedback">
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_DealTitle %>: </dt>
                    <dd class="title">
                      <%# Eval(FeedbackFields.SellingTitle) %>
                      <div class="number">
                        #<%# Container.DataItemIndex + 1 %></div>
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_FromBuyer %>: </dt>
                    <dd>
                      <gt:User runat="server" ID="usFromUser" UserName="<%# Eval(FeedbackFields.FromUserName) %>" UserId="<%# Eval(FeedbackFields.FromUserId) %>" />
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_Rating%>:</dt>
                    <dd>
                      <%# Dictionaries.Instance.GetFeedbackTypeNameById((int)Eval(FeedbackFields.FeedbackTypeId)) %>
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_Comment%>: </dt>
                    <dd class="comment">
                      <%# Eval(FeedbackFields.Comment) %>
                      <div class="createdDate">
                        <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_CreatedAt%>
                        <%# Eval(FeedbackFields.CreateDate) %></div>
                    </dd>
                  </dl>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="grid-empty" />
            <EmptyDataTemplate>
              <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_NoFeedbacks %>" />
            </EmptyDataTemplate>
          </asp:GridView>
        </ContentTemplate>
      </ajaxToolkit:TabPanel>
      <ajaxToolkit:TabPanel runat="server" >
        <HeaderTemplate>
          <span><%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_AsBuyer, CountOfFeedbacksAsBuyer) %></span>
        </HeaderTemplate>
        <ContentTemplate>
          <asp:GridView runat="server" GridLines="None" PageSize="5" AllowPaging="true" AutoGenerateColumns="false" DataSource="<%# FeedbacksAsBuyer %>" ID="gvFeedbacksAsBuyer" ShowHeader="false" ShowFooter="false" CssClass="gridFeedbacks" OnPageIndexChanging="gvFeedbacksAsBuyer_PageIndexChanging">
          <PagerStyle CssClass="gridPager" />
            <Columns>
              <asp:TemplateField>
                <ItemTemplate>
                  <dl class="feedback">
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_DealTitle %>: </dt>
                    <dd class="title">
                      <%# Eval(FeedbackFields.SellingTitle) %>
                      <div class="number">
                        #<%# Container.DataItemIndex + 1 %></div>
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_FromSeller%>: </dt>
                    <dd>
                      <gt:User runat="server" ID="usFromUser" UserName="<%# Eval(FeedbackFields.FromUserName) %>" UserId="<%# Eval(FeedbackFields.FromUserId) %>" />
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_Rating%>:</dt>
                    <dd>
                      <%# Dictionaries.Instance.GetFeedbackTypeNameById((int)Eval(FeedbackFields.FeedbackTypeId)) %>
                    </dd>
                    <dt>
                      <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_Comment%>: </dt>
                    <dd class="comment">
                      <%# Eval(FeedbackFields.Comment) %>
                      <div class="createdDate">
                        <%= GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_CreatedAt%>
                        <%# Eval(FeedbackFields.CreateDate) %></div>
                    </dd>
                  </dl>
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
            <EmptyDataRowStyle CssClass="grid-empty" />
            <EmptyDataTemplate>
              <asp:Literal ID="ltrNoData" runat="server" Text="<%# GT.Localization.Resources.CommonResources.Controls_UserFeedbacks_NoFeedbacks %>" />
            </EmptyDataTemplate>
          </asp:GridView>
        </ContentTemplate>
      </ajaxToolkit:TabPanel>
    </ajaxToolkit:TabContainer>
  </ContentTemplate>
</asp:UpdatePanel>
