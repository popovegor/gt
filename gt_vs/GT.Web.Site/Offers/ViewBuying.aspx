<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.Master" AutoEventWireup="true" CodeBehind="ViewBuying.aspx.cs" Inherits="GT.Web.Site.Offers.ViewBuying" EnableViewState="true" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Offer.ascx" TagName="Offer" TagPrefix="gt" %>

<%@ Register Src="~/Menu/Submenu.ascx" TagName="Submenu" TagPrefix="gt" %>
<%@ Register Src="~/Menu/SubmenuItem.ascx" TagName="SubmenuItem" TagPrefix="gt"
 %>



<asp:Content ContentPlaceHolderID="cphSidebar" ID="cntSidebar" runat="server">
  <gt:Submenu runat="server" ID="sm" Visible="<%# BuyingOffer != null && BuyingOffer.BuyerId != Credentials.UserId  %>" >
      <Content>
        <noindex>
        <gt:SubmenuItem CssClass="send-message" runat="server" ID="smiSendMessage" NavigateUrl='<%# BuyingOffer != null ? String.Format("/Users/User/{0}/Conversation", BuyingOffer.BuyerId)  : string.Empty%>' Text='<%# CommonResources.SendMessageToBuyer %>' />
        </noindex>
      </Content>
    </gt:Submenu>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server"><asp:Label ID="errLbl" runat="server" Visible="false" CssClass="error"></asp:Label>
  <div id="viewbuying">
    <asp:Panel ID="info" runat="server">
      <div id="top">
        <table class="detailView">
          <tr runat="server" id="category" visible="false" enableviewstate="false">
            <td style=" width:14em; padding-right:2em">
              <b>
                <%= CommonResources.Offers_ProductCategory %></b>
            </td>
            <td>
              <asp:Label ID="lblProductCategory" runat="server"></asp:Label>
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.Title %></b>
            </td>
            <td>
              <asp:Label ID="name" runat="server"></asp:Label>
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.Game %></b>
            </td>
            <td>
              <gt:Game runat="server" ID="game" ShowNewWindow="true" />
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.Server %></b>
            </td>
            <td>
              <gt:Server runat="server" ID="server" ShowNewWindow="true" />
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.Buyer %></b>
            </td>
            <td>
              <gt:User runat="server" ShowUserCard="true" ID="buyer" ShowNewWindow="true" />
              <%--<noindex><asp:HyperLink runat="server" ID="writeBuyer" Text="<%# CommonResources.SellingViewer_SendMessage %>" Font-Bold="true" /></noindex>--%><asp:Label ID="buyerId" runat="server" Visible="false"></asp:Label>
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.CreatedOn %></b>
            </td>
            <td>
              <asp:Label ID="dateCreation" runat="server"></asp:Label>
            </td>
          </tr>
          <tr>
            <td>
              <b>
                <%= CommonResources.Price %></b>
            </td>
            <td>
              <asp:Label ID="price" runat="server"></asp:Label>
            </td>
          </tr>
        </table>
      </div>
      <div id="suggested">
        <gt:Panel runat="server" ID="sellersTitle" Visible="false">
          <Content><span>
            <%= CommonResources.SuggestedOffers %></span> </Content>
        </gt:Panel>
        <div id="text">
          <%# GetActionText() %>
        </div>
        <asp:GridView ID="sellers" runat="server" Visible="false" CellSpacing="2" GridLines="None" AutoGenerateColumns="false" AllowPaging="false" OnRowDataBound="suggested_RowDataBound">
          <Columns>
            <asp:TemplateField Visible="false">
              <ItemTemplate><asp:Label ID="suggestedIdLbl" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>" Font-Bold="true"></asp:Label>
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
              <ItemTemplate>
                <gt:Offer runat="server" ID="buyer" OfferType="SellingOffer" OfferId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>" Title="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>" ShowNewWindow="true" />
              </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
              <ItemTemplate>
                <div class="offerbtns">
                  <asp:ImageButton ID="btn1" runat="server" AlternateText="<%# CommonResources.Select %>" ToolTip="<%# CommonResources.Select %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png" OnClick="btn1_Click" />
                  <asp:ImageButton ID="btn2" runat="server" AlternateText="<%# CommonResources.Decline %>" ToolTip="<%# CommonResources.Decline %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png" OnClick="btn2_Click" />
                </div>
              </ItemTemplate>
            </asp:TemplateField>
          </Columns>
        </asp:GridView>
      </div>
      <div id="actions">
        <table class="detailView">
          <tr>
            <td colspan="2">
              <asp:DropDownList ID="forSuggesting" runat="server" Style="display: none"></asp:DropDownList>
              <gt:Button ID="btnOne" runat="server" Visible="false" OnClick="btnOne_Click" />
              <gt:Button ID="btnTwo" runat="server" OnClick="btnTwo_Click" Text="<%# CommonResources.CreateForDemand %>" />
            </td>
          </tr>
        </table>
      </div>
      <div class="description">
        <%--<gt:Panel runat="server" ID="pnl">
          <Content>--%><span class="description-title">
            <%= CommonResources.Description %></span><%-- </Content>
        </gt:Panel>--%>
        <div class="text">
          <pre><asp:Label ID="description" runat="server"></asp:Label></pre>
        </div>
      </div>
    </asp:Panel>
  </div>
</asp:Content>
