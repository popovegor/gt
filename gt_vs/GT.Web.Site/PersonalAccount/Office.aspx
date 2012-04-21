<%@ Page Language="C#" MasterPageFile="~/MasterPages/Office.Master" AutoEventWireup="true" CodeBehind="Office.aspx.cs" Inherits="GT.Web.Site.PersonalAccount.Office" EnableViewState="false" EnableEventValidation="false" %>

<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="GT.DA.UserRating" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.DA.MessageSystem" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Web.UI.Controls" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Global.MessageSystem" %>
<%@ Import Namespace="GT.BO.Implementation.MessageSystem" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/PersonalAccount/OfficeBlock.ascx" TagName="OfficeBlock" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference Path="~/WebServices/Ajax/MessageSystemService.asmx" InlineScript="false" />
    </Services>
  </asp:ScriptManagerProxy>
  <div id="office">
    <div class="left-side">
      <div class="ls-block">
        <div class="balance-block">
          <gt:OfficeBlock runat="server" ID="obBalance" Title='<%# string.Format(CommonResources.PersonalAccount_Office_MyBalance, "/Office/Transfers") %>' Url="/Billing/Transfers" AsLink="false" TitleImgClass="title-img">
            <Content>
              <div class="formula">
                <div class="available">
                  <p><span>
                    <%# Dynamics.MoneyAvailable.ToFormattedMoney(CommonResources.MoneyFormat)%></span></p>
                  <p><span class="desc">(<%= CommonResources.PersonalAccount_Office_BalanceAvailable%>)</span></p>
                </div>
                <div class="equal">
                  <p><span>=</span></p>
                </div>
                <div class="total">
                  <p><span>
                    <%# Dynamics.MoneyTotal.ToFormattedMoney(CommonResources.MoneyFormat)%></span></p>
                  <p><span class="desc">(<%= CommonResources.PersonalAccount_Office_BalanceTotal%>)</span></p>
                </div>
                <div class="minus">
                  <p><span>&minus;</span></p>
                </div>
                <div class="blocked">
                  <p><span>
                    <%# Dynamics.MoneyBlocked.ToFormattedMoney(CommonResources.MoneyFormat)%></span>.</p>
                  <p><span class="desc">(<%= CommonResources.PersonalAccount_Office_BalanceBlocked%>)</span><p>
                </div>
              </div>
              <div class="actions">
                <asp:HyperLink runat="server" NavigateUrl="~/Office/TopUp" Target="_self" Text="<%#CommonResources.PersonalAccount_Office_TopUp %>"></asp:HyperLink>
                <%-- <gt:Button ID="btnTopUp" Text="<%#CommonResources.PersonalAccount_Office_TopUp %>" runat="server" OnClientClick='window.redirect("/Office/TopUp"); return false;' PostBackUrl="~/Office/TopUp" />--%>
                &nbsp;&nbsp;
                <asp:HyperLink runat="server" NavigateUrl="~/Office/DrawOut" Target="_self" Text="<%#CommonResources.PersonalAccount_Office_DrawOut %>"></asp:HyperLink>
                <%--<gt:Button ID="btnDrawOut" Text="<%#CommonResources.PersonalAccount_Office_DrawOut %>" runat="server" OnClientClick='window.redirect("/Office/DrawOut"); return false;' PostBackUrl="~/Billing/DrawOut" />--%>
              </div>
            </Content>
          </gt:OfficeBlock>
        </div>
        <div class="rating-block">
          <gt:OfficeBlock ID="obRating" runat="server" Title='<%# string.Format(CommonResources.PersonalAccount_Office_MyRating, "/Office/Feedbacks")%>' Url="/Office/Feedbacks" TitleImgClass="title-img">
            <Content>
              <div class="feedbacks">
                <p class="positive"><span class="value">
                  <%#Dynamics.FeedbacksPositive %></span>&nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_RatingPositive%>.</p>
                <p class="negative"><span class="value">
                  <%#Dynamics.FeedbacksNegative %></span>&nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_RatingNegative%>.</p>
                <p class="neutral"><span class="value">
                  <%#Dynamics.FeedbacksNeutral %></span>&nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_RatingNeutral%>.</p>
              </div>
              <%--<div class="actions">
              <asp:HyperLink NavigateUrl="~/UserRating/UnusedFeedbacks.aspx" runat="server" Target="_self" Text="<%#CommonResources.PersonalAccount_Office_LeaveFeedback %>" Visible="<%# Dynamics.FeedbacksUnused > 0 %>"  />
            </div>--%>
            </Content>
          </gt:OfficeBlock>
        </div>
        <div class="messages-block">
          <gt:OfficeBlock ID="obMessages" runat="server" Title="<%# CommonResources.PersonalAccount_Office_MyMessages%>" Url='<%# string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.In.ToString() )%>' TitleImgClass="title-img">
            <Content>
              <div class="counters">
                <p class="in"><span class="value">
                  <%# Dynamics.MessagesIn%></span>&nbsp;&mdash;&nbsp;<%# CommonResources.Count%>&nbsp;<a href='<%= string.Format("/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.In.ToString() )%>' id="hplIn" /><span><%# string.Format( CommonResources.PersonalAccount_Office_MessagesIn, Dynamics.MessagesUnread > 0 ? string.Format(" <b>({0})</b>", Dynamics.MessagesUnread) : string.Empty) %><span></a>. </p>
                <p class="out"><span class="value">
                  <%# Dynamics.MessagesOut%></span>&nbsp;&mdash;&nbsp;<%# CommonResources.Count%>&nbsp;<asp:HyperLink NavigateUrl='<%# string.Format("~/Office/Messages/{1}", MessageFilterParams.Direction, MessageType.Out.ToString() )%>' ID="HyperLink1" runat="server" Text="<%# CommonResources.PersonalAccount_Office_MessagesOut %>" />. </p>
              </div>
            </Content>
          </gt:OfficeBlock>
        </div>
        <div class="profile-block">
          <gt:OfficeBlock ID="obProfile" runat="server" Title="<%# CommonResources.PersonalAccount_Office_Profile%>" Url="/PersonalAccount/Profile.aspx" TitleImgClass="title-img">
            <Content>
              <div class="fields">
                <p class="name"><span class="value">
                  <gt:User runat="server" ID="me" ShowUserCard="true" UserId="<%# Credentials.UserId %>" />
                </span>&nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_ProfileName %>. </p>
                <p class="email"><span class="value">
                  <%# Credentials.User.Email %></span>&nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_ProfileEmail %>. </p>
              </div>
              <div class="actions">
                <asp:HyperLink runat="server" Target="_self" NavigateUrl="~/Office/Profile" Text="<%# CommonResources.PersonalAccount_Office_ProfileEdit %>" />
              </div>
            </Content>
          </gt:OfficeBlock>
        </div>
      </div>
    </div>
    <div class="right-side">
      <div class="purchases-block">
        <gt:OfficeBlock ID="ofPurchases" runat="server" Title="<%# CommonResources.PersonalAccount_Office_MyPurchases%>" Url="/Office/Buying" AsLink="true" TitleClass="title" TitleImgClass="title-img">
          <Content>
            <div>
              <p class="active"><span class="value">
                <%# Dynamics.DealsBuyerTotal - Dynamics.DealsBuyerFinished - Dynamics.DealsBuyerConflicted%></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_PurchasesActive %>. </p>
              <p class="complete"><span class="value">
                <%# Dynamics.DealsBuyerFinished %></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_PurchasesComplete %>. </p>
              <p class="conflicted"><span class="value">
                <%# Dynamics.DealsBuyerConflicted %></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_PurchasesConflicted %>. </p>
            </div>
            <div class="actions">
              <a href="/Office/Buying/Add" class="offer-add buying" title='<%= SiteMap.Provider.FindSiteMapNode("/Offers/EditBuying.aspx").Title %>'><span>
                <%= CommonResources.PostSelling%></span></a>
            </div>
          </Content>
        </gt:OfficeBlock>
      </div>
      <div class="sales-block">
        <gt:OfficeBlock ID="ofSales" runat="server" Title="<%# CommonResources.PersonalAccount_Office_MySales%>" Url="/Office/Selling" AsLink="true" TitleImgClass="title-img" TitleClass="title">
          <Content>
            <div>
              <p class="active"><span class="value">
                <%# Dynamics.DealsSellerTotal - Dynamics.DealsSellerFinished - Dynamics.DealsSellerConflicted%></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_SalesActive %>. </p>
              <p class="complete"><span class="value">
                <%# Dynamics.DealsSellerFinished%></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_SalesComplete %>. </p>
              <p class="conflicted"><span class="value">
                <%# Dynamics.DealsSellerConflicted%></span> &nbsp;&mdash;&nbsp;<%# CommonResources.PersonalAccount_Office_SalesConflicted %>. </p>
            </div>
            <div class="actions">
              <a href="/Office/Selling/Add" class="offer-add selling" title='<%= SiteMap.Provider.FindSiteMapNode("/Offers/EditSelling.aspx").Title %>'><span>
                <%=  CommonResources.PostSelling %></span></a>
            </div>
          </Content>
        </gt:OfficeBlock>
      </div>
    </div>
  </div>
</asp:Content>
