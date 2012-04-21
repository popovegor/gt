<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="GameInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.GameInfo" Title="Game information" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Label ID="err" runat="server" Visible="false" CssClass="error"></asp:Label>
    <asp:panel ID="info" runat="server">
        <table class="detailView">
          <tr>
            <td><b><%= CommonResources.GameName %></b></td>
            <td><%= m_Game != null ? GT.Common.Types.TypeConverter.ToString(m_Game[GT.DA.Dictionaries.GameFields.LocalizedName]) : String.Empty %></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.OfficialGameSite %></b></td>
            <td><asp:HyperLink ID="gameSiteValue" runat="server" Target="_blank"></asp:HyperLink></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.TotalSells %></b></td>
            <td><%= m_GS == null ? null : m_GS.SellingOffersCount %></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.TotalBuys %></b></td>
            <td><%= m_GS == null ? null : m_GS.BuyingOffersCount %></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.CurrentDealBalance %>:</b></td>
            <td><%= m_GS == null ? null : m_GS.Money %></td>
          </tr>
        </table>
        <div id="popSellers">
             <gt:Box runat="server" ID="bxPopSellers" CssClass="boxPopSellers boxBrown"><Title><%= CommonResources.TopSellers %></Title>
                 <Content>
                    <asp:DataList ID="dlPopSellers" runat="server" RepeatColumns="1" DataSource="<%# m_GS == null ? null : m_GS.TopSellers %>" RepeatLayout="Flow" RepeatDirection="Vertical" HorizontalAlign="Center" CellSpacing="20">
                       <ItemTemplate>
                          <asp:HyperLink ID="link" runat="server" NavigateUrl='<%# String.Format("~/DetailsInfo/UserInfo.aspx?{0}={1}", GT.Global.DetailsInfo.UserInfoParams.USERID, ((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId)  %>'
                                          Text='<%# ((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserName %>'
                                          onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" , TypeConverter.ToString(((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId), "\"}); return false;} return true;") %>'></asp:HyperLink>
                       </ItemTemplate>
                    </asp:DataList>
                 </Content>
             </gt:Box>
        </div>
        <div id="popBuyers">
             <gt:Box runat="server" ID="bxPopBuyers" CssClass="boxPopBuyers boxBrown"><Title><%= CommonResources.TopBuyers %></Title>
                  <Content>
                     <asp:DataList ID="dlPopBuyers" runat="server" RepeatColumns="1" DataSource="<%# m_GS == null ? null :  m_GS.TopBuyers %>" RepeatLayout="Flow" RepeatDirection="Vertical" HorizontalAlign="Center" CellSpacing="20">
                       <ItemTemplate>
                         <asp:HyperLink ID="link" runat="server" NavigateUrl='<%# String.Format("~/DetailsInfo/UserInfo.aspx?{0}={1}", GT.Global.DetailsInfo.UserInfoParams.USERID,((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId) %>'
                          Text='<%# ((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserName %>'
                          onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId), "\"}); return false;} return true;") %>'></asp:HyperLink>
                       </ItemTemplate>
                      </asp:DataList>
                  </Content>
             </gt:Box>
        </div>
        <div class="descriptionContext">
           <%= m_Game != null ? GT.Common.Types.TypeConverter.ToString(m_Game[GT.DA.Dictionaries.GameFields.LocalizedDescription]) : string.Empty %>
        </div>
      </asp:panel>
</asp:Content>
