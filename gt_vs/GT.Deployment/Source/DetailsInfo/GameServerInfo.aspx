<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" 
    CodeBehind="GameServerInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.GameServerInfo" EnableViewState="true"
    Title="Информация об игровом сервере"%>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Label ID="err" runat="server" CssClass="error" Visible="false"></asp:Label>
    <asp:Panel ID="info" runat="server">
       <table class="detailView">
        <tr>
            <td><b><%= CommonResources.GameServerName %></b></td>
            <td><%= m_Server != null ? TypeConverter.ToString(m_Server[GT.DA.Dictionaries.GameServerFields.LocalizedName]) : string.Empty %></td>
        </tr>
        <tr>
            <td><b><%= CommonResources.GameServerSite %></b></td>
            <td><asp:HyperLink ID="gameServerSiteValue" runat="server" Target="_blank"></asp:HyperLink></td>
        </tr>
        <tr>
            <td><b><%= CommonResources.Game %>:</b></td>
            <td><asp:HyperLink ID="gameValue" runat="server" Text='<%# m_GS == null ? null : Dictionaries.Instance.GetGameNameByGameServerId(m_GS.GameServerId) %>'
                NavigateUrl='<%# m_GS == null ? null : string.Format("~/DetailsInfo/GameInfo.aspx?{0}={1}", GT.Global.DetailsInfo.GameInfoParams.GAMEID, Dictionaries.Instance.GetGameIdByGameServerId(m_GS.GameServerId)) %>'
                onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : ", TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(m_GS.GameServerId)), "}); return false;} return true;") %>'/>
            </td>
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
                             onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId), "\"}); return false;} return true;") %>'></asp:HyperLink>
                  </ItemTemplate>
               </asp:DataList>
             </Content>
          </gt:Box>
       </div>
       <div id="popBuyers">
          <gt:Box runat="server" ID="bxPopBuyers" CssClass="boxPopBuyers boxBrown"><Title><%= CommonResources.TopBuyers %></Title>
             <Content>
               <asp:DataList ID="dlPopBuyers" runat="server" RepeatColumns="1" DataSource="<%# m_GS == null ? null : m_GS.TopBuyers %>" RepeatLayout="Flow" RepeatDirection="Vertical" HorizontalAlign="Center" CellSpacing="20">
                  <ItemTemplate>
                     <asp:HyperLink ID="link" runat="server" NavigateUrl='<%# String.Format("~/DetailsInfo/UserInfo.aspx?{0}={1}", GT.Global.DetailsInfo.UserInfoParams.USERID, ((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId)  %>'
                      Text='<%# ((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserName %>'
                      onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString(((System.Collections.Generic.KeyValuePair<GT.BO.Implementation.Users.User, int>)Container.DataItem).Key.UserId), "\"}); return false;} return true;") %>'></asp:HyperLink>
                  </ItemTemplate>
               </asp:DataList>
            </Content>
          </gt:Box>
       </div>
       <div class="descriptionContext">
          <%= m_Server != null ? GT.Common.Types.TypeConverter.ToString(m_Server[GT.DA.Dictionaries.GameServerFields.LocalizedDescription]) : string.Empty %>
       </div>
    </asp:Panel>
</asp:Content>