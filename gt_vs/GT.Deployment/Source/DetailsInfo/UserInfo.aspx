<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="UserInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.UserInfo" Title="User information" %>

<%@ Import Namespace="Resources" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/UserFeedbacks.ascx" TagName="UserFeedbacks" TagPrefix="gt" %>
<%@ Register Src="~/Controls/UserCorrespondence.ascx" TagName="UserCorrespondence" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>

<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
 <%-- <asp:ScriptManagerProxy runat="server" ID="smpMain">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/PopupManager.js" />
    </Scripts>
  </asp:ScriptManagerProxy>--%>
  <asp:Label ID="err" runat="server" CssClass="error" Visible="false"></asp:Label>
  <asp:Panel ID="info" runat="server">
    <table style=" height: 100%">
      <tr>
        <td style="height: 54px">
          <b>
            <%= CommonResources.SignUpUserName %></b>
        </td>
        <td style="height: 54px">
          <asp:Label ID="UserNameValue" runat="server" Text="UserNameValue"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>
          <b>
            <%= CommonResources.Registred %></b>
        </td>
        <td>
          <asp:Label ID="UserRegistrDateValue" runat="server" Text="UserRegistrDateValue"></asp:Label>
        </td>
      </tr>
      <tr>
        <td>
          <b>
            <%= CommonResources.LastVisit %></b>
        </td>
        <td>
          <asp:Label ID="LastVisitDateValue" runat="server" Text="LastVisitDateText"></asp:Label>
        </td>
      </tr>
     <tr>
     <td colspan="2">
        <div id="dealSellers">
            <gt:Box ID="bxDealsAsSeller" runat="server" CssClass="boxUserDeals boxBrown"><Title><%= Resources.CommonResources.PersonalAccount_Office_StatisticsAsSeller %></Title>
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
        </div>
        <div id="dealBuyers">
            <gt:Box ID="bxDealsAsBuyer" runat="server" CssClass="boxUserDeals boxBrown"><Title><%= Resources.CommonResources.PersonalAccount_Office_StatisticsAsBuyer%></Title>
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
          </div>
        </td>
      </tr>
    </table>
    
    <div class="feedbacks">
      <gt:UserFeedbacks runat="server" ID="userFeedbacks" UserId="<%# UserId.Value %>" />
    </div>
    
    <div class="correspondence">
      <gt:UserCorrespondence runat="server" ID="userCorrespondence" SenderId="<%# Credentials.User != null ? Credentials.UserId : Guid.Empty %>" RecipientId="<%# UserId.HasValue ? UserId.Value : Guid.Empty %>" /> 
    </div>
    <div class="actions">
      <gt:Button runat="server" ID="btnNewMessage" CausesValidation="false" OnClientClick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(AddMessage, {RecipientId :\"",  UserId.Value , "\"}); return false;} return true;") %>' Text="<%# CommonResources.DetailsInfo_UserInfo_NewMessage %>" Visible="<%# Credentials.User != null %>" />
    </div>
  </asp:Panel>
  
</asp:Content>
