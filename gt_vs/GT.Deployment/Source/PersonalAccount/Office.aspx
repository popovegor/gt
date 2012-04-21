<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="Office.aspx.cs" Inherits="GT.Web.Site.PersonalAccount.Office" %>

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
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>

<asp:Content ID="cntSidebar" ContentPlaceHolderID="cphSidebar" runat="server">
  <div>
    <ul id="submenu">
      <li><a href="/PersonalAccount/Profile.aspx" runat="server" id="profile" onclick='<%# "if (window.PopupManager) {PopupManager.Open(EditProfile); return false;} return true;" %>'><%= Resources.CommonResources.PersonalAccount_Office_MyProfile %></a></li>
      <li><a href="/Authentication/ChangePassword.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_ChangePassword %></a></li>
      <li><a href="/Authentication/ChangeEmail.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_ChangeEmail %></a></li>
      <li class="separator"></li>
      <li><a href="/Selling/SellingOffer.aspx" runat="server" id="sellingOffer" onclick='<%# "if (window.PopupManager) {PopupManager.Open(EditSelling, {Id : 0}); return false;} return true;" %>'><%= Resources.CommonResources.PersonalAccount_Office_AddOffer %></a></li>
      <li><a href="/Offers/SellingManager.aspx" id="myDeals"><%= Resources.CommonResources.PersonalAccount_Office_MyDeals %></a></li>
      <li class="separator"></li>
      <li><a href="/UserRating/FeedbackViewer.aspx" runat="server" id="feedbackViewer"><%= Resources.CommonResources.PersonalAccount_Office_Feedbacks %></a> </li>
      <li class="separator"></li>
      <li><a href="/Selling/BuyingOffer.aspx" runat="server" id="buyingOffer" onclick='<%# "if (window.PopupManager) {PopupManager.Open(EditBuying, {Id : 0}); return false;} return true;" %>'><%= Resources.CommonResources.PersonalAccount_Office_AddNewDemand %></a></li>
      <li><a href="/Offers/BuyingManager.aspx" id="myDemands"><%= Resources.CommonResources.PersonalAccount_Office_MyDemands %></a></li>
      <li class="separator"></li>
      <li><a href="/MessageSystem/MessageViewer.aspx" runat="server" id="allMessages"><%= Resources.CommonResources.PersonalAccount_Office_Messages %></a></li>
      <li class="separator"></li>
      <li><a href="/BillingSystem/TransferViewer.aspx" runat="server" id="moneyTransfers"><%= Resources.CommonResources.PersonalAccount_Office_MoneyTransfers %></a> </li>
      <li><a href="/BillingSystem/TopUp.aspx" runat="server" id="topUp"><%= Resources.CommonResources.PersonalAccount_Office_TopUp %></a> </li>
      <li><a href="/BillingSystem/DrawOut.aspx" runat="server" id="drawOut"><%= Resources.CommonResources.PersonalAccount_Office_DrawOut %></a> </li>
    </ul>
  </div>
  <div>
  </div>
</asp:Content>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference Path="~/WebServices/Ajax/MessageSystemService.asmx" InlineScript="false" />
    </Services>
  </asp:ScriptManagerProxy>
  <div>
    <gt:Box ID="bxBalance" runat="server" CssClass="boxBalance boxBrown"><Title><a href="/BillingSystem/TransferViewer.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_Balance %></a> </Title>
      <Content>
        <dl>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_BalanceAvailable %>" ID="ltrBalanceAvailable" />: </dt>
          <dd>
            <%= string.Format("{0:0.##}", Dynamics.MoneyAvailable) %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_BalanceBlocked %>" ID="ltrBalanceBlocked" />: </dt>
          <dd>
            <%= string.Format("{0:0.##}", Dynamics.MoneyBlocked)%>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_BalanceTotal %>" ID="ltrBalanceTotal" />: </dt>
          <dd>
            <%= string.Format("{0:0.##}", Dynamics.MoneyTotal)%>
          </dd>
        </dl>
      </Content>
    </gt:Box>
    <gt:Box ID="bxRating" runat="server" CssClass="boxRating boxBrown"><Title><a href="/UserRating/FeedbackViewer.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_Rating %></a> </Title>
      <Content>
        <dl>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_RatingPositive %>" ID="ltrRatingPositive" />: </dt>
          <dd>
            <%= Dynamics.FeedbacksPositive %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_RatingNegative %>" ID="ltrRatingNegative" />: </dt>
          <dd>
            <%= Dynamics.FeedbacksNegative %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_RatingNeutral %>" ID="ltrRatingNeutral" />: </dt>
          <dd>
            <%= Dynamics.FeedbacksNeutral %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_RatingTotal %>" ID="ltrRatingTotal" />: </dt>
          <dd>
            <%= Dynamics.FeedbacksTotal %>
          </dd>
        </dl>
      </Content>
    </gt:Box>
    <gt:Box ID="bxDealsAsSeller" runat="server" CssClass="boxDeals boxBrown"><Title><a href="/Offers/SellingManager.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_StatisticsAsSeller %></a> </Title>
      <Content>
        <dl>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsFinish %>" ID="ltrDealsFinished" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsSellerFinished) %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsConflicted %>" ID="ltrDealsConflicted" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsSellerConflicted)%>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsActive %>" ID="ltrDealsActive" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsSellerTotal - Dynamics.DealsSellerFinished - Dynamics.DealsSellerConflicted)%>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsTotal %>" ID="ltrDealsTotal" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsSellerTotal)%>
          </dd>
        </dl>
      </Content>
    </gt:Box>
    <gt:Box ID="bxDealsAsBuyer" runat="server" CssClass="boxDeals boxBrown"><Title><a href="/Offers/SellingManager.aspx" runat="server"><%= Resources.CommonResources.PersonalAccount_Office_StatisticsAsBuyer %></a> </Title>
      <Content>
        <dl>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsFinish %>" ID="ltrDealsBuyerFinished" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsBuyerFinished) %>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsConflicted %>" ID="ltrDealsBuyerConflicted" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsBuyerConflicted)%>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsActive %>" ID="ltrDealsBuyerActive" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsBuyerTotal - Dynamics.DealsBuyerFinished - Dynamics.DealsBuyerConflicted)%>
          </dd>
          <dt>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_DealsTotal %>" ID="ltrDealsBuyerTotal" />: </dt>
          <dd>
            <%= string.Format("{0}", Dynamics.DealsBuyerTotal)%>
          </dd>
        </dl>
      </Content>
    </gt:Box>
    <gt:Box ID="bxUnapprovedFeedbacks" Visible="<%# UnapprovedFeedbacks != null && UnapprovedFeedbacks.Rows.Count > 0 %>" runat="server" CssClass="boxUnapprovedFeedbacks boxRed"><Title><span><%= Resources.CommonResources.PersonalAccount_Office_LeaveFeedback %></span></Title>
      <Content>
        <asp:GridView ID="gvUnapprovedFeedbacks" runat="server" CssClass="gridUnapprovedFeedbacks" GridLines="None" AllowPaging="false" AllowSorting="false" AutoGenerateColumns="false" PageSize="10000" DataSource="<%# UnapprovedFeedbacks %>" ShowFooter="false" ShowHeader="false">
          <AlternatingRowStyle CssClass="gridAlternative" />
          <Columns>
             <asp:TemplateField>
              <ItemTemplate>
                <dl class="feedback">
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_DealTitle %>: </dt>
                  <dd class="title">
                    <%# Eval(UnapprovedFeedbackFields.SellingTitle)%>
                    <div class="number">
                      #<%# Container.DataItemIndex + 1 %></div>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_DealStatus%>: </dt>
                  <dd class="status">
                    <span> <%# Dictionaries.Instance.GetTransactionPhaseNameById( (int)Eval(UnapprovedFeedbackFields.TransactionPhaseId)) %></span>
                  <div class="leave">
                      <asp:ImageButton runat="server" ID="btnLeaveFeedback" SkinID="btnLeaveFeedbackSkin" OnClientClick='<%# string.Concat("javascript:if (window.PopupManager) {PopupManager.Open(AddFeedback, {Id : 0, SellingHistoryId : ", Eval(UnapprovedFeedbackFields.SellingHistoryId),"}); return false;} return true;") %>' ToolTip="<%# Resources.CommonResources.PersonalAccount_Office_Leave %>" />
                    </div>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_ToUser %>: </dt>
                  <dd class="user">
                    <gt:User runat="server" ID="usFromUser" UserName="<%# Eval(UnapprovedFeedbackFields.ToUserName) %>" UserId="<%# Eval(UnapprovedFeedbackFields.ToUserId) %>" />
                  </dd>
                </dl>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </Content>
    </gt:Box>
    <gt:Box ID="bxLastMessages" runat="server" CssClass="boxLastMessages boxBrown"><Title><a href="/MessageSystem/MessageViewer.aspx" runat="server">
      <%= LastMessageDisplayCount%>
      <%= Resources.CommonResources.PersonalAccount_Office_LastMessages %></a> </Title>
      <Content>
        <asp:GridView runat="server" GridLines="None" PageSize="<%# LastMessageDisplayCount %>" AutoGenerateColumns="false" DataSource="<%# LastMessages %>" ID="gvLastMessages" ShowHeader="false" ShowFooter="false" CssClass="gridLastMessages">
          <Columns>
            <asp:TemplateField>
              <ItemTemplate>
                <dl class="message">
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_Subject%>: </dt>
                  <dd class="subject">
                    <%# Eval("LocalizedSubject")%>
                    <div class="number">
                      #<%# Container.DataItemIndex + 1 %></div>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_Body%>:</dt>
                  <dd>
                    <%# Eval("LocalizedBody")%>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_Sender%>: </dt>
                  <dd class="sender">
                    <gt:User runat="server" ID="ulSender" UserId='<%# Eval("SenderId") %>' />
                    <div class="createdDate">
                      <%= Resources.CommonResources.PersonalAccount_Office_CreatedAt%>
                      <%# ((DateTime)Eval("CreateDate")).UtcToLocal() %></div>
                  </dd>
                </dl>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <EmptyDataRowStyle CssClass="gridEmpty" />
          <EmptyDataTemplate>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_NoLastMessages %>" ID="ltrNoLastMessages" />
          </EmptyDataTemplate>
        </asp:GridView>
      </Content>
    </gt:Box>
    <gt:Box ID="bxLastFeedbacks" runat="server" CssClass="boxLastFeedbacks boxBrown"><Title><a href="/UserRating/FeedbackViewer.aspx" runat="server">
      <%= LastFeedbacksCount%>
      <%= Resources.CommonResources.PersonalAccount_Office_LastFeedbacks %></a> </Title>
      <Content>
        <asp:GridView runat="server" GridLines="None" PageSize="<%# LastFeedbacksCount %>" AutoGenerateColumns="false" DataSource="<%# LastFeedbacks %>" ID="gvLastFeedbacks" ShowHeader="false" ShowFooter="false" CssClass="gridLastFeedbacks">
          <Columns>
            <asp:TemplateField>
              <ItemTemplate>
                <dl class="feedback">
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_DealTitle %>: </dt>
                  <dd class="title">
                    <%# Eval(FeedbackFields.SellingTitle) %>
                    <div class="number">
                      #<%# Container.DataItemIndex + 1 %></div>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_FromUser %>: </dt>
                  <dd>
                    <gt:User runat="server" ID="usFromUser" UserName="<%# Eval(FeedbackFields.FromUserName) %>" UserId="<%# Eval(FeedbackFields.FromUserId) %>" />
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_Rating %>:</dt>
                  <dd>
                    <%# Dictionaries.Instance.GetFeedbackTypeNameById((int)Eval(FeedbackFields.FeedbackTypeId)) %>
                  </dd>
                  <dt><%= Resources.CommonResources.PersonalAccount_Office_Comment %>: </dt>
                  <dd class="comment">
                    <%# Eval(FeedbackFields.Comment) %>
                    <div class="createdDate">
                      <%= Resources.CommonResources.PersonalAccount_Office_CreatedAt %>
                      <%# ((DateTime)Eval(FeedbackFields.CreateDate)).UtcToLocal() %></div>
                  </dd>
                </dl>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
          <EmptyDataRowStyle CssClass="gridEmpty" />
          <EmptyDataTemplate>
            <asp:Literal runat="server" Text="<%# Resources.CommonResources.PersonalAccount_Office_NoLastFeedbacks %>" ID="ltrNoLastFeedbacks" />
          </EmptyDataTemplate>
        </asp:GridView>
      </Content>
    </gt:Box>
  </div>
</asp:Content>
