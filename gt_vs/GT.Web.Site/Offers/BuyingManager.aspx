<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="BuyingManager.aspx.cs" Inherits="GT.Web.Site.Offers.BuyingManager" EnableViewState="true" %>

<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Offer.ascx" TagName="Offer" TagPrefix="gt" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<asp:Content ID="Content2" ContentPlaceHolderID="cphContent" runat="server">
 <div id="buyingmanager">
  <div>
      <h2><%= CommonResources.IBuy %>:</h2>
      <br />
  </div>
  <div id="errSelling">
      <asp:Label ID="errLabelSelling" runat="server" Visible="false"></asp:Label>
  </div>
  <div>
      <asp:GridView ID="sellingGW" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None"
                    PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="sellingGW_PageIndexChanging"
                    OnRowDataBound="sellingGW_RowDataBound" CssClass="grid offers">
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
        <AlternatingRowStyle CssClass="grid-alternative-row" />
        <Columns>
          <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
            <ItemTemplate></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField Visible="false">
            <ItemTemplate>
              <asp:Label ID="lblId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId])%>"></asp:Label>
              <asp:Label ID="lblSellerId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellerId])  %>"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Game %>
          </HeaderTemplate>
            <HeaderStyle CssClass="game" />
            <ItemStyle CssClass="separator" />
            <ItemTemplate>
                <gt:Game runat="server" ID="g" ServerId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]) %>" ShowNewWindow="true" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Server %>
          </HeaderTemplate>
            <HeaderStyle CssClass="server" />
            <ItemStyle CssClass="separator" />
            <ItemTemplate>
               <gt:Server runat="server" ID="s" ServerId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.GameServerId]) %>" ShowNewWindow="true" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Title %>
          </HeaderTemplate>
            <HeaderStyle CssClass="title" />
            <ItemTemplate>
                <gt:Offer runat="server" ID="sel" OfferType="SellingOffer" OfferId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>" Title="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>" ShowNewWindow="true" OfferData="<%# new GT.BO.Implementation.Offers.Selling().Load<GT.BO.Implementation.Offers.Selling>(Container.DataItem as DataRow) %>" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Seller %>
          </HeaderTemplate>
            <HeaderStyle CssClass="seller" />
            <ItemStyle CssClass="separator" />
            <ItemTemplate>
               <gt:User runat="server" ShowUserCard="true" ID="uSeller" UserId="<%# TypeConverter.ToGuid((Container.DataItem as DataRow)[SellingOfferFields.SellerId]) %>" ShowNewWindow="true" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Price %>
          </HeaderTemplate>
            <HeaderStyle CssClass="price" />
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[SellingOfferFields.Price])) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
            <HeaderStyle CssClass="delivery" />
            <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Delivery %>
          </HeaderTemplate>
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblDeliveryTime" Text='<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.State %>
          </HeaderTemplate>
            <HeaderStyle Width="100" />
            <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" />
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblStatus" Text='<%# Dictionaries.Instance.GetTransactionPhaseNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId])) %>' ToolTip='<%# TypeConverter.ToString(Dictionaries.Instance.GetTransactionPhaseById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId]))[TransactionPhaseFields.LocalizedDescription]) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Date %>
          </HeaderTemplate>
            <HeaderStyle CssClass="date" />
            <ItemTemplate>
              <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", ((DateTime)(Container.DataItem as DataRow)[SellingOfferFields.ModifyDate]).UtcToLocal()) %>' />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
          <%# GT.Localization.Resources.CommonResources.Key %>
          </HeaderTemplate>
            <HeaderStyle Width="100" />
            <ItemStyle HorizontalAlign="center" VerticalAlign="Middle" />
            <ItemTemplate><b>
              <asp:Label runat="server" ID="lblOfferKey" Text='<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.ValidKey]) %>' />
            </b></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
            <HeaderStyle Width="100" />
            <HeaderTemplate>
                <%# GT.Localization.Resources.CommonResources.Actions %>
            </HeaderTemplate>
            <ItemTemplate>
              <div class="offerbtns">
                <asp:ImageButton runat="server" ID="btnOne" OnClick="btnOneSelling_Click" />
                <asp:ImageButton runat="server" ID="btnTwo" OnClick="btnTwoSelling_Click" />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
            <ItemTemplate></ItemTemplate>
          </asp:TemplateField>
        </Columns>
        <EmptyDataRowStyle CssClass="grid-empty" />
        <EmptyDataTemplate>
          <div>
            <asp:Label runat="server" ID="lblNoBuyerOffers" Text="<%# GT.Localization.Resources.CommonResources.NoMyBuyOffers %>" />
          </div>
        </EmptyDataTemplate>
      </asp:GridView>
  </div>
  <br />
  <h2><%= CommonResources.IWantBuy %>:</h2>
  <br />
  <div>
      <asp:Label ID="errLbl" runat="server" Visible="false" ForeColor="Red"></asp:Label>
  </div>
  <div id="buyinggrid">
      <asp:GridView ID="buyingGW" runat="server" AllowPaging="true" AutoGenerateColumns="false"
                GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="buyingGW_PageIndexChanging"
                OnRowDataBound="buyingGW_RowDataBound" CssClass="grid offers">
                <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
                <AlternatingRowStyle CssClass="grid-alternative-row" />
                <Columns>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField Visible="false">
                        <ItemTemplate>
                            <asp:Label ID="lblId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId])%>"></asp:Label>
                            <asp:Label ID="lblSuggested" runat="server" Text="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
          <HeaderTemplate>
            <%# GT.Localization.Resources.CommonResources.Game %>
          </HeaderTemplate>
                        <HeaderStyle CssClass="game" />
                        <ItemStyle CssClass="separator" />
                        <ItemTemplate>
                            <gt:Game runat="server" ID="g" ServerId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]) %>" ShowNewWindow="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <%# GT.Localization.Resources.CommonResources.Server %>
                    </HeaderTemplate>
                        <HeaderStyle CssClass="server" />
                        <ItemStyle CssClass="separator" />
                        <ItemTemplate>
                           <gt:Server runat="server" ID="s" ServerId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.GameServerId]) %>" ShowNewWindow="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <%# GT.Localization.Resources.CommonResources.Title %>
                    </HeaderTemplate>
                        <HeaderStyle CssClass="title" />
                        <ItemTemplate>
                            <gt:Offer runat="server" OfferType="BuyingOffer" OfferId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]) %>" Title="<%# TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.Title]) %>" ID="buy" ShowNewWindow="true" EnableViewState="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <%# GT.Localization.Resources.CommonResources.SuggestedOffer %>
                    </HeaderTemplate>
                        <HeaderStyle CssClass="seller" />
                        <ItemTemplate>
                            <gt:Offer runat="server" ID="sel" OfferType="SellingOffer" OfferId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>" Title="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[BuyingOfferFields.SellerTitle]) %>" ShowNewWindow="true" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <%# GT.Localization.Resources.CommonResources.Price %>
                    </HeaderTemplate>
                        <HeaderStyle CssClass="price" />
                        <ItemTemplate>
                            <div>
                                <asp:Label runat="server" ID="lblPrice" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[BuyingOfferFields.Price])) %>' />
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                    <HeaderTemplate>
                    <%# GT.Localization.Resources.CommonResources.Date %>
                    </HeaderTemplate>
                        <HeaderStyle CssClass="date" />
                        <ItemTemplate>
                            <asp:Label runat="server" ID="lblUpdate" Text='<%# string.Format("{0:f}", ((DateTime)(Container.DataItem as DataRow)[BuyingOfferFields.ModifyDate]).UtcToLocal()) %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <HeaderStyle Width="150" />
                        <HeaderTemplate>
                            <%# GT.Localization.Resources.CommonResources.Actions %>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <div class="offerbtns">
                                      <asp:ImageButton runat="server" ID="btnZero"  AlternateText="<%# GT.Localization.Resources.CommonResources.EditDemand %>"
                                                       ToolTip="<%# GT.Localization.Resources.CommonResources.EditDemand %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/edit.png"
                                                       OnClientClick='<%# string.Format("window.location.href = \"/Office/Buying/Edit/{0}\"; return false;", (Container.DataItem as DataRow)[BuyingOfferFields.BuyingOfferId]) %>'/>
                                      <asp:ImageButton runat="server" ID="btnOne" OnClick="btnOne_Click" AlternateText="<%# GT.Localization.Resources.CommonResources.Accept %>"
                                                       ToolTip="<%# GT.Localization.Resources.CommonResources.Accept %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png"/>
                                      <asp:ImageButton runat="server" ID="btnTwo" OnClick="btnTwo_Click" AlternateText="<%# GT.Localization.Resources.CommonResources.Decline %>" 
                                                       ToolTip="<%# GT.Localization.Resources.CommonResources.Decline %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png"/>
                                      <asp:ImageButton runat="server" ID="btnThree" OnClick="btnThree_Click" AlternateText="<%# GT.Localization.Resources.CommonResources.Delete %>"
                                                       ToolTip="<%# GT.Localization.Resources.CommonResources.Delete %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/delete.png"/>
                            </div>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
                      <ItemTemplate>
                      </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EmptyDataRowStyle CssClass="grid-empty" />
                <EmptyDataTemplate>
                    <div>
                        <asp:Label runat="server" ID="lblNoBuyerOffers" Text="<%# GT.Localization.Resources.CommonResources.DemandsNotFound %>" />
                    </div>
                </EmptyDataTemplate>
            </asp:GridView>
  </div>
  <script language="javascript" type="text/javascript">
        function showActionInfo() {
            var obj = document.getElementById("showActionInfoElem");
            if ($(obj).attr("state") == 0) {
                $(obj).attr("state", 1);
                $(obj).attr("innerHTML", $("#visibleActionText").attr("value"));
                $(obj).parent().next().css("display", "");
            }
            else {
                $(obj).attr("state", 0);
                $(obj).parent().next().css("display", "none");
                $(obj).attr("innerHTML", $("#invisibleActionText").attr("value"));
            }
        }

        function showStatusInfo() {
            var obj = document.getElementById("showStatusInfoElem");
            if ($(obj).attr("state") == 0) {
                $(obj).attr("state", 1);
                $(obj).attr("innerHTML", $("#visibleStatusText").attr("value"));
                $(obj).parent().next().css("display", "");
            }
            else {
                $(obj).attr("state", 0);
                $(obj).parent().next().css("display", "none");
                $(obj).attr("innerHTML", $("#invisibleStatusText").attr("value"));
            }
        }
    </script>
    <input type="hidden" id="visibleActionText" value="<%# CommonResources.HideManagerActionInfo %>" />
    <input type="hidden" id="invisibleActionText" value="<%# CommonResources.ShowManagerActionInfo %>" />
    <input type="hidden" id="visibleStatusText" value="<%# CommonResources.HideManagerStatusInfo %>" />
    <input type="hidden" id="invisibleStatusText" value="<%# CommonResources.ShowManagerStatusInfo %>" />
    <div class="helpInfoLink">
       <a href="javascript:showActionInfo()" state="0" id="showActionInfoElem" ><%# CommonResources.ShowManagerActionInfo %></a>
    </div>
    <div id="legend" style="display:none">
          <div class="legend">
               <asp:Image ID="payimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/pay.png" AlternateText="<%# CommonResources.Pay %>" /> - <%= CommonResources.BuyingManager_Pay %>
          </div>
          <div class="legend">    
               <asp:Image id="cancelimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/cancel.png" AlternateText="<%# CommonResources.Abandon %>" /> - <%= CommonResources.BuyingManager_Cancel %>
          </div>
          <div class="legend">
               <asp:Image id="completeimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/finish.png" AlternateText="<%# CommonResources.GoodsGot %>" /> - <%= CommonResources.BuyingManager_Complete %>
          </div>
          <div class="legend">
               <asp:Image ID="conflictimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/complain.png" AlternateText="<%# CommonResources.Complain %>" /> - <%= CommonResources.BuyingManager_Complain %>
          </div>
          <div class="legend">
               <asp:Image ID="editimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/edit.png" AlternateText="<%# CommonResources.EditDemand %>" /> - <%= CommonResources.EditDemand %>
          </div>
          <div class="legend">
               <asp:Image ID="selectimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png" AlternateText="<%# CommonResources.Select %>" /> - <%= CommonResources.BuyingManager_Select %>
          </div>
          <div class="legend">
               <asp:Image ID="rejectimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png" AlternateText="<%# CommonResources.Decline %>" /> - <%= CommonResources.BuyingManager_Decline %>
          </div>
          <div class="legend">
               <asp:Image ID="deleteimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/delete.png" AlternateText="<%# CommonResources.Delete %>" /> - <%= CommonResources.SellingManager_Delete %>
          </div>
          <div class="legend">
               <asp:Image ID="feedbackimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/feedback.png" AlternateText="<%# CommonResources.PersonalAccount_Office_LeaveFeedback %>" /> - <%= CommonResources.BuyingManager_FeedBack %>
          </div>
    </div>     
    <div class="helpInfoLink">
       <a href="javascript:showStatusInfo()" state="0" id="showStatusInfoElem" ><%# CommonResources.ShowManagerStatusInfo %></a>
    </div>  
    <div id="statelegend" style="display:none">
            <div class="legend">
                <p style='<%# String.Format("color : {0}", GT.BO.Implementation.Offers.SellingFacade.GetStatusColor((GT.Global.Offers.TransactionPhase)1)) %>'><%# Dictionaries.Instance.GetTransactionPhaseNameById(1) %></p>  <%# Dictionaries.Instance.GetTransactionPhaseById(1)[TransactionPhaseFields.LocalizedDescription] %>
            </div>
            <div class="legend">
                <p style='<%# String.Format("color : {0}", GT.BO.Implementation.Offers.SellingFacade.GetStatusColor((GT.Global.Offers.TransactionPhase)2)) %>'><%# Dictionaries.Instance.GetTransactionPhaseNameById(2) %></p>  <%# Dictionaries.Instance.GetTransactionPhaseById(2)[TransactionPhaseFields.LocalizedDescription] %>
            </div>
            <div class="legend">
                <p style='<%# String.Format("color : {0}", GT.BO.Implementation.Offers.SellingFacade.GetStatusColor((GT.Global.Offers.TransactionPhase)3)) %>'><%# Dictionaries.Instance.GetTransactionPhaseNameById(3) %></p>  <%# Dictionaries.Instance.GetTransactionPhaseById(3)[TransactionPhaseFields.LocalizedDescription] %>
            </div>
            <div class="legend">
                <p style='<%# String.Format("color : {0}", GT.BO.Implementation.Offers.SellingFacade.GetStatusColor((GT.Global.Offers.TransactionPhase)4)) %>'><%# Dictionaries.Instance.GetTransactionPhaseNameById(4) %></p>  <%# Dictionaries.Instance.GetTransactionPhaseById(4)[TransactionPhaseFields.LocalizedDescription] %>
            </div>
            <div class="legend">
                <p style='<%# String.Format("color : {0}", GT.BO.Implementation.Offers.SellingFacade.GetStatusColor((GT.Global.Offers.TransactionPhase)5)) %>'><%# Dictionaries.Instance.GetTransactionPhaseNameById(5) %></p>  <%# Dictionaries.Instance.GetTransactionPhaseById(5)[TransactionPhaseFields.LocalizedDescription] %>
            </div>
    </div>
  </div>
</asp:Content>
