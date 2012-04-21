<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="SellingManager.aspx.cs" Inherits="GT.Web.Site.Offers.SellingManager" EnableEventValidation="false" EnableViewState="true" %>

<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Offer.ascx" TagName="Offer" TagPrefix="gt" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server" EnableViewState="true">
    <script language="javascript" type="text/javascript">
        //<![CDATA[
        
        function validateKey(obj) {
            var offerId =  $(obj).next().attr("value");
            var code = $(obj).prev().attr("value");
            if (code.length > 0 && offerId > 0) {
                
                GT.Web.Site.WebServices.Ajax.SellingService.ValidateOfferKey(offerId, code, validatekeyCallback, null, obj);
            }
        }
    
        function validatekeyCallback(res, context) {
            if (res != null) {
                $(res).insertBefore($(context).prev());
            }
        }
        
        //]]>
    </script>
  <div id="sellingmanager">
      <asp:ScriptManagerProxy ID="smpMain" runat="server">
        <Services>
          <asp:ServiceReference InlineScript="true" Path="~/WebServices/Ajax/SellingService.asmx" />
        </Services>
      </asp:ScriptManagerProxy>
    <div>
      <asp:Label ID="errLblSeller" runat="server" Visible="false"></asp:Label>
    </div>
    <div>
      <asp:GridView ID="gvSeller" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvSeller_PageIndexChanging" OnRowDataBound="gvSeller_RowDataBound" CssClass="grid offers" EnableViewState="true">
        <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
        <AlternatingRowStyle CssClass="grid-alternative-row" />
        <Columns>
          <asp:TemplateField HeaderText="&nbsp;" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
            <ItemTemplate></ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField Visible="false">
            <ItemTemplate>
              <asp:Label ID="lblIdSeller" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId])%>"></asp:Label>
              <asp:Label ID="lblBuyerId" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.BuyerId])  %>"></asp:Label>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
            <HeaderStyle CssClass="game" />
            <ItemStyle CssClass="separator" />
            <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Game %>
            </HeaderTemplate>
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
          <asp:TemplateField >
          <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Title %>
            </HeaderTemplate>
            <HeaderStyle CssClass="title" />
            <ItemTemplate>
              <div>
                <gt:Offer runat="server" ID="sel" OfferType="SellingOffer" OfferId="<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>" Title="<%#  TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>" ShowNewWindow="true" />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField >
          <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Buyer %>
            </HeaderTemplate>
            <HeaderStyle CssClass="buyer" />
            <ItemStyle CssClass="separator" />
            <ItemTemplate>
               <gt:User runat="server" ShowUserCard="true" ID="uSeller" UserId="<%# TypeConverter.ToGuid((Container.DataItem as DataRow)[SellingOfferFields.BuyerId]) %>" ShowNewWindow="true" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Price %>
            </HeaderTemplate>
            <HeaderStyle CssClass="price" />
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblPriceSeller" Text='<%# string.Format("{0:0.##}", TypeConverter.ToDecimal((Container.DataItem as DataRow)[SellingOfferFields.Price])) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
  <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Delivery %>
            </HeaderTemplate>
            <HeaderStyle CssClass="delivery" />
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblDeliveryTimeSeller" Text='<%# TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.DeliveryTime], SellingOfferParams.DefaultDeliveryTime) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.State %>
            </HeaderTemplate>
            <HeaderStyle Width="100" HorizontalAlign="center" VerticalAlign="Middle" />
            <ItemTemplate>
              <div>
                <asp:Label runat="server" ID="lblStatusSeller" Text='<%# Dictionaries.Instance.GetTransactionPhaseNameById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId])) %>' ToolTip='<%# TypeConverter.ToString(Dictionaries.Instance.GetTransactionPhaseById(TypeConverter.ToInt32((Container.DataItem as DataRow)[SellingOfferFields.TransactionPhaseId]))[TransactionPhaseFields.LocalizedDescription]) %>' />
              </div>
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
          <HeaderTemplate>
              <%# GT.Localization.Resources.CommonResources.Date %>
            </HeaderTemplate>
            <HeaderStyle CssClass="date" />
            <ItemTemplate>
              <asp:Label runat="server" ID="lblUpdateSeller" Text='<%# string.Format("{0:f}", ((DateTime)(Container.DataItem as DataRow)[SellingOfferFields.ModifyDate]).UtcToLocal()) %>' />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
            <HeaderStyle Width="100" VerticalAlign="Middle" HorizontalAlign="Center" />
            <ItemTemplate>
              <asp:TextBox runat="Server" ID="txtBoxValid" Visible='false'></asp:TextBox>
              &nbsp;&nbsp;&nbsp;
              <asp:Button runat="server" ID="btnValid" Text='<%# CommonResources.SellingManager_ValidateDealKey %>' OnClientClick="validateKey(this);return false;" Visible='false' />
              <input type="hidden" value="<%# (Container.DataItem as DataRow)[SellingOfferFields.SellingId] %>" id="hiddenid" />
            </ItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField>
            <HeaderTemplate>
              <%# CommonResources.Actions %>
            </HeaderTemplate>
            <HeaderStyle Width="200"  />
            <ItemTemplate>
              <div class="offerbtns">
                <asp:ImageButton runat="server" ID="btnZeroSeller" Visible="false" AlternateText="<%# GT.Localization.Resources.CommonResources.EditOffer %>" ToolTip="<%# GT.Localization.Resources.CommonResources.EditOffer %>" ImageUrl="~/App_Themes/Tutynin/Images/actions/edit.png" OnClientClick='<%# string.Format("window.location.href = \"/Office/Selling/Edit/{0}\"; return false;", (Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>' />
                <asp:ImageButton runat="server" ID="btnOneSeller" OnClick="btnOneSeller_Click" />
                <asp:ImageButton runat="server" ID="btnTwoSeller" OnClick="btnTwoSeller_Click" />
                <asp:ImageButton runat="server" ID="btnThreeSeller" AlternateText='<%# GT.Localization.Resources.CommonResources.Delete %>' ToolTip='<%# GT.Localization.Resources.CommonResources.Delete %>' ImageUrl="~/App_Themes/Tutynin/Images/actions/delete.png" OnClick="btnThreeSeller_Click" />
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
            <asp:Label runat="server" ID="lblNoSellerOffers" Text="<%# GT.Localization.Resources.CommonResources.NoMySellOffers %>" />
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
    <div id="helpInfoLink">
       <a href="javascript:showActionInfo()" state="0" id="showActionInfoElem" ><%# CommonResources.ShowManagerActionInfo %></a>
    </div>
    <div id="legend" style="display:none">
            <div class="legend">
                    <asp:Image ID="editimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/edit.png" AlternateText="<%# CommonResources.EditOffer %>" /> - <%= CommonResources.SellingManager_Edit %>
            </div>
            <div class="legend">    
                    <asp:Image id="selectimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png" AlternateText="<%# CommonResources.Select %>" /> - <%= CommonResources.SellingManager_Select%>
            </div>
            <div class="legend">
                    <asp:Image id="declineimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png" AlternateText="<%# CommonResources.Decline %>" /> - <%= CommonResources.SellingManager_Decline%>
            </div>
            <div class="legend">
                    <asp:Image ID="cancelimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/cancel.png" AlternateText="<%# CommonResources.Cancel %>" /> - <%= CommonResources.SellingManager_Cancel %>
            </div>
            <div class="legend">
                    <asp:Image ID="conflictimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/complain.png" AlternateText="<%# CommonResources.Complain %>" /> - <%= CommonResources.SellingManager_Complain %>
            </div>
            <div class="legend">
                    <asp:Image ID="deleteimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/delete.png" AlternateText="<%# CommonResources.Delete%>" /> - <%= CommonResources.SellingManager_Delete %>
            </div>
            <div class="legend">
                    <asp:Image ID="feedbackimg" runat="server" ImageUrl="~/App_Themes/Tutynin/Images/actions/feedback.png" AlternateText="<%# CommonResources.PersonalAccount_Office_LeaveFeedback %>" /> - <%= CommonResources.SellingManager_FeedBack %>
            </div>
    </div>        
    <div id="helpInfoLink">
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
