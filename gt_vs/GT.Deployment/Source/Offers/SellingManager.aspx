<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true"
    Codebehind="SellingManager.aspx.cs" Inherits="GT.Web.Site.Offers.SellingManager"
    Title="Selling Offers Manager" EnableEventValidation="false" EnableViewState="true"  %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server" EnableViewState="true">
    <div>
        <div>
            <br />
            <h2>
                <%= CommonResources.Buy %>:</h2>
            <br />
        </div>
        <div>
            <asp:Label ID="errLbl" runat="server" Visible="false"></asp:Label>
        </div>
        <div>
             <asp:GridView ID="gvBuyer" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvBuyer_PageIndexChanging"
                OnRowDataBound="gvBuyer_RowDataBound" CssClass="grid offers" 
                 EnableViewState="true">
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
                <AlternatingRowStyle CssClass="gridAlternative" />
                <Columns>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId])%>"></asp:Label>
                            <asp:Label ID="lblSellerId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellerId])  %>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Game %>">
                        <ItemStyle CssClass="game" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGame" runat="server" Text="<%# Dictionaries.Instance.GetGameNameByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameInfo.aspx?GameID=",Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) %>'
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : " + TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) + "}); return false;} return true;" %>'>
                                </asp:HyperLink>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Server %>">
                        <ItemStyle  CssClass="server" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGameServer" runat="server" Text="<%# Dictionaries.Instance.GetGameServerNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameServerInfo.aspx?GameServerId=",(Container.DataItem as DataRow)[SellingOfferFields.GameServerId] ) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Title %>">
                        <ItemStyle CssClass="title" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplTitle" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/OfferInfo.aspx?id=",(Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewOfferInfo, {OfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Seller %>">
                        <ItemStyle CssClass="seller" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink runat="server" ID="hplSeller" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserID=", (Container.DataItem as DataRow)[SellingOfferFields.SellerId]) %>'
                                    Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellerName]) %>"
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + (Container.DataItem as DataRow)[SellingOfferFields.SellerId].ToString() + "\"}); return false;} return true;" %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Price %>">
                        <ItemStyle CssClass="price" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[SellingOfferFields.Price])) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Delivery %>">
                    <ItemStyle CssClass="delivery" />
                    <ItemTemplate>
                        <div>
                            <asp:Label runat="server" ID="lblDeliveryTime" Text='<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime) %>' />
                        </div>
                    </ItemTemplate>
                </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, State %>">
                        <ItemStyle Width="100" HorizontalAlign="center" VerticalAlign="Middle" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblStatus" Text='<%# Dictionaries.Instance.GetTransactionPhaseNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId])) %>'
                                                                         ToolTip='<%# TypeConverter.ToString(Dictionaries.Instance.GetTransactionPhaseById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId]))[TransactionPhaseFields.LocalizedDescription]) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, UpdatedOn %>">
                        <ItemStyle CssClass="date" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", (Container.DataItem as DataRow)[SellingOfferFields.UpdateDate]) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Key %>">
                        <ItemStyle Width="100" HorizontalAlign="center" VerticalAlign="Middle" />
                        <ItemTemplate>
                            <b>
                                <asp:Label runat="server" ID="lblOfferKey" Text='<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.ValidKey]) %>' />
                            </b>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle Width="100" />
                        <ItemTemplate>
                          <div class="offerbtns">
                            <asp:ImageButton runat="server" ID="btnOne" OnClick="btnOne_Click"/>
                            <asp:ImageButton runat="server" ID="btnTwo" OnClick="btnTwo_Click"/>
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
                        <asp:Label runat="server" ID="lblNoBuyerOffers" Text="<%$ Resources:CommonResources, NoMyBuyOffers %>" />
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
        <div>
            <br />
             <h2>
                <%= CommonResources.Sell %>:</h2>
            <br />
        </div>
        <div>
            <asp:Label ID="errLblSeller" runat="server" Visible="false"></asp:Label>
        </div>
        <div>
            <asp:GridView ID="gvSeller" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvSeller_PageIndexChanging"
                OnRowDataBound="gvSeller_RowDataBound" CssClass="grid offers" EnableViewState="true">
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
                <AlternatingRowStyle CssClass="gridAlternative" />
                <Columns>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblIdSeller" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId])%>"></asp:Label>
                            <asp:Label ID="lblBuyerId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.BuyerId])  %>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Game %>">
                        <ItemStyle CssClass="game" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGame" runat="server" Text="<%# Dictionaries.Instance.GetGameNameByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameInfo.aspx?GameID=",Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) %>'
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewGameInfo, {GameID : " + TypeConverter.ToString(Dictionaries.Instance.GetGameIdByGameServerId(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]))) + "}); return false;} return true;" %>'>
                                </asp:HyperLink>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Server %>">
                        <ItemStyle CssClass="server" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplGameServer" runat="server" Text="<%# Dictionaries.Instance.GetGameServerNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId])) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/GameServerInfo.aspx?GameServerId=",(Container.DataItem as DataRow)[SellingOfferFields.GameServerId] ) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewGameServerInfo, {GameServerID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Title %>">
                        <ItemStyle CssClass="title" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink ID="hplTitleSeller" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>"
                                    NavigateUrl='<%# string.Concat("~/DetailsInfo/OfferInfo.aspx?id=",(Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewOfferInfo, {OfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]), "}); return false;} return true;") %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Buyer %>">
                        <ItemStyle CssClass="seller" />
                        <ItemTemplate>
                            <div>
                                <asp:HyperLink runat="server" ID="hplBuyer" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserID=", (Container.DataItem as DataRow)[SellingOfferFields.BuyerId]) %>'
                                    Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.BuyerName]) %>"
                                    onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + (Container.DataItem as DataRow)[SellingOfferFields.BuyerId].ToString() + "\"}); return false;} return true;" %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Price %>">
                        <ItemStyle CssClass="price" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblPriceSeller" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[SellingOfferFields.Price])) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Delivery %>">
                    <ItemStyle CssClass="delivery" />
                    <ItemTemplate>
                        <div>
                            <asp:Label runat="server" ID="lblDeliveryTimeSeller" Text='<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime) %>' />
                        </div>
                    </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, State %>">
                        <ItemStyle Width="100" HorizontalAlign="center" VerticalAlign="Middle" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblStatusSeller" Text='<%# Dictionaries.Instance.GetTransactionPhaseNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId])) %>'
                                                                               ToolTip='<%# TypeConverter.ToString(Dictionaries.Instance.GetTransactionPhaseById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId]))[TransactionPhaseFields.LocalizedDescription]) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="<%$ Resources:CommonResources, UpdatedOn %>">
                        <ItemStyle CssClass="date" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblUpdateSeller" Text='<%# string.Format("{0:f}", (Container.DataItem as DataRow)[SellingOfferFields.UpdateDate]) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemStyle Width="150" VerticalAlign="Middle" HorizontalAlign="Center" />
                        <ItemTemplate>
                            <asp:Label ID="lblValid" runat="server" Visible="false"></asp:Label>
                            <asp:TextBox runat="Server" ID="txtBoxValid" Visible='false'></asp:TextBox>
                            &nbsp;&nbsp;&nbsp;
                            <asp:Button runat="server" ID="btnValid" Text='<%$ Resources:CommonResources, Validate %>' Width="100" OnClick="btnValid_Click" Visible='false'/>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField>
                        <ItemStyle Width="200" />
                        <ItemTemplate>
                           <div class="offerbtns">
                            <asp:ImageButton runat="server" ID="btnZeroSeller" Visible="false" AlternateText="<%$ Resources:CommonResources, EditOffer %>" ToolTip="<%$ Resources:CommonResources, EditOffer %>" ImageUrl="../App_Themes/Tutynin/Images/actions/edit.png"
                                       OnClientClick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(EditSelling, {Id : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]), "}); return false;} return true;") %>' />
                            <asp:ImageButton runat="server" ID="btnOneSeller" OnClick="btnOneSeller_Click" />
                            <asp:ImageButton runat="server" ID="btnTwoSeller" OnClick="btnTwoSeller_Click" />
                            <asp:ImageButton runat="server" ID="btnThreeSeller" AlternateText='<%$ Resources:CommonResources, Delete %>' ToolTip='<%$ Resources:CommonResources, Delete %>'
                                            ImageUrl="../App_Themes/Tutynin/Images/actions/delete.png"  OnClick="btnThreeSeller_Click" />           
                        </div></ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle CssClass="gridEmpty" />
                <EmptyDataTemplate>
                    <div>
                        <asp:Label runat="server" ID="lblNoSellerOffers" Text="<%$ Resources:CommonResources, NoMySellOffers %>" />
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
        </div>
    </div>
</asp:Content>
