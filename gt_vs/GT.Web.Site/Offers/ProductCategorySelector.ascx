<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ProductCategorySelector.ascx.cs" Inherits="GT.Web.Site.Offers.ProductCategorySelector" %>
<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<asp:DropDownList runat="server" ID="ddlProductType" AppendDataBoundItems="false" DataSource="<%# GetProductCategories() %>" DataTextField="Value" DataValueField="Key" CausesValidation="true" AutoPostBack="false" />
<asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%# CommonResources.Offers_ProductCategoryNotSelected %>" ID="rfvProductType" ControlToValidate="ddlProductType" />
<ajaxToolkit:ValidatorCalloutExtender runat="server" ID="cveProductType" TargetControlID="rfvProductType" PopupPosition="Right" />
<asp:TextBox runat="server" ID="txtProductCategoryMisc" AutoPostBack="false" TextMode="SingleLine" CausesValidation="true" EnableViewState="false" />
<%--<ajaxToolkit:TextBoxWatermarkExtender runat="server" ID="tbweProductCategoryMisc" TargetControlID="txtProductCategoryMisc" WatermarkText="<%# CommonResources.Offers_EnterProductCategory %>" />--%>
<asp:RequiredFieldValidator runat="server" ControlToValidate="txtProductCategoryMisc" ID="rfvProductCategoryMisc" SetFocusOnError="true" Display="None" ErrorMessage='<%# CommonResources.Offers_ProductCategoryNoEntered %>' />
<ajaxToolkit:ValidatorCalloutExtender ID="vceProductCategoryMisc" TargetControlID="rfvProductCategoryMisc" runat="server" PopupPosition="Right" />

<script language="javascript" type="text/javascript">
  //<![CDATA[
  $(function() {
    var txtCategoryMisc = $("#<%# txtProductCategoryMisc.ClientID %>");
    var rfvCategoryMisc = $("#<%= rfvProductCategoryMisc.ClientID %>")[0];
    var vceCategoryMisc = $find("<%#vceProductCategoryMisc.ClientID %>");
    $("#<%# ddlProductType.ClientID %>").change(function(event) {
      switch ($(this).val()) {
        case "<%# Dictionaries.Instance.GetProductCategoryMiscId %>": //misc
          txtCategoryMisc.show();
          ValidatorEnable(rfvCategoryMisc, true);
          break;
        default:
          txtCategoryMisc.hide();
          ValidatorEnable(rfvCategoryMisc, false);
          vceCategoryMisc.hide();
          break;
      }
    });
  });
  //]]>
</script>

