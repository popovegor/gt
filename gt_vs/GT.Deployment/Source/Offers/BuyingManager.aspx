<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="BuyingManager.aspx.cs" Inherits="GT.Web.Site.Offers.BuyingManager" EnableViewState="true" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="Resources"  %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>

<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
  <br />
  <h2><%= CommonResources.MyDemands %></h2>
  <br />
  <div>
      <asp:Label ID="errLbl" runat="server" Visible="false" ForeColor="Red"></asp:Label>
  </div>
  <div>
      <asp:GridView ID="gvBuyer" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvBuyer_PageIndexChanging"
                OnRowDataBound="gvBuyer_RowDataBound" CssClass="grid offers">
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
                <AlternatingRowStyle CssClass="gridAlternative" />
                <Columns>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId])%>"></asp:Label>
                            <asp:Label ID="lblSuggested" runat="server" Text="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Game %>">
                        <ItemStyle CssClass="game" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGame" runat="server" Text="<%# Dictionaries.Instance.GetGameNameByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameInfo.aspx?GameID=",Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]))) %>'
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : " + TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]))) + "}); return false;} return true;" %>'>
                                </asp:HyperLink>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Server %>">
                        <ItemStyle  CssClass="server" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGameServer" runat="server" Text="<%# Dictionaries.Instance.GetGameServerNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameServerInfo.aspx?GameServerId=",(Container.DataItem as DataRow)[BuyingOfferFields.GameServerId] ) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Title %>">
                        <ItemStyle CssClass="title" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplTitle" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.Title]) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/BuyingOfferInfo.aspx?id=",(Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewBuyingOfferInfo, {BuyingOfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, SuggestedOffer %>">
                        <ItemStyle CssClass="seller" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink runat="server" ID="hplSuggested" NavigateUrl='<%# string.Concat("~/DetailsInfo/OfferInfo.aspx?id=", (Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>'
                                    Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.SellerTitle]) %>"
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewOfferInfo, {OfferID : \"" + (Container.DataItem as DataRow)[SellingOfferFields.SellingId].ToString() + "\"}); return false;} return true;" %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Price %>">
                        <ItemStyle CssClass="price" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[BuyingOfferFields.Price])) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, UpdatedOn %>">
                        <ItemStyle CssClass="date" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", (Container.DataItem as DataRow)[BuyingOfferFields.UpdateDate]) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle Width="150" />
                        <ItemTemplate>
                            <div class="offerbtns">
                                      <asp:ImageButton runat="server" ID="btnZero"  AlternateText="<%$ Resources:CommonResources, EditDemand %>"
                                                       ToolTip="<%$ Resources:CommonResources, EditDemand %>" ImageUrl="../App_Themes/Tutynin/Images/actions/edit.png"
                                                       OnClientClick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(EditBuying, {Id : ", TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]), "}); return false;} return true;") %>'/>
                                      <asp:ImageButton runat="server" ID="btnOne" OnClick="btnOne_Click" AlternateText="<%$ Resources:CommonResources, Accept %>"
                                                       ToolTip="<%$ Resources:CommonResources, Accept %>" ImageUrl="../App_Themes/Tutynin/Images/actions/select.png"/>
                                      <asp:ImageButton runat="server" ID="btnTwo" OnClick="btnTwo_Click" AlternateText="<%$ Resources:CommonResources, Decline %>" 
                                                       ToolTip="<%$ Resources:CommonResources, Decline %>" ImageUrl="../App_Themes/Tutynin/Images/actions/reject.png"/>
                                      <asp:ImageButton runat="server" ID="btnThree" OnClick="btnThree_Click" AlternateText="<%$ Resources:CommonResources, Delete %>"
                                                       ToolTip="<%$ Resources:CommonResources, Delete %>" ImageUrl="../App_Themes/Tutynin/Images/actions/delete.png"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle CssClass="gridEmpty" />
                <EmptyDataTemplate>
                    <div>
                        <asp:Label runat="server" ID="lblNoBuyerOffers" Text="<%$ Resources:CommonResources, DemandsNotFound %>" />
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
</asp:Content>
