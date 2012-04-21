<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="EditSelling.aspx.cs" Inherits="GT.Web.Site.Offers.EditSelling" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/SellingImageViewer.ascx" TagName="SellingImageViewer" TagPrefix="gt" %>
<%@ Register Src="~/Offers/ProductCategorySelector.ascx" TagName="ProductCategorySelector" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/SellingService.asmx" />
    </Services>
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/jquery.imageZoom.js" />
    </Scripts>
  </asp:ScriptManagerProxy>
  <div id="edit-selling" class="edit-offer">
    <table class="key-value" rules="none">
      <tbody>
        <tr>
          <td class="key">
            <%# GT.Localization.Resources.CommonResources.Game  %>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value">
            <asp:DropDownList runat="server" ID="ddlGame" />
            <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" Category="<%# DictionaryTypes.Game.ToString() %>" LoadingText="<%# GT.Localization.Resources.CommonResources.LoadingGameList %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" PromptText="<%# GT.Localization.Resources.CommonResources.SelectGame  %>" />
            <asp:RequiredFieldValidator runat="server" Display="None" ErrorMessage="<%# GT.Localization.Resources.CommonResources.GameNotSelected %>" SetFocusOnError="true" ID="rfvGame" InitialValue="" ControlToValidate="ddlGame" />
            <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceGame" PopupPosition="Right" TargetControlID="rfvGame" />
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Server %>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value">
            <asp:DropDownList runat="server" ID="ddlServer" />
            <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" ParentControlID="ddlGame" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%# GT.Localization.Resources.CommonResources.SelectServer %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%# GT.Localization.Resources.CommonResources.LoadingServerList %>" />
            <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%# GT.Localization.Resources.CommonResources.ServerNotSelected %>" ID="rfvServer" InitialValue="" ControlToValidate="ddlServer" />
            <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceServer" TargetControlID="rfvServer" PopupPosition="Right" />
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Offers_ProductCategory %>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value product-category">
            <gt:ProductCategorySelector runat="server" ID="category" /> 
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Title %>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value">
            <asp:TextBox runat="server" MaxLength="100" TextMode="SingleLine" Width="450" ID="txtTitle" />
            <asp:RequiredFieldValidator ControlToValidate="txtTitle" ID="rfvTitle" ErrorMessage="<%# GT.Localization.Resources.CommonResources.TitleEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
            <ajaxToolkit:ValidatorCalloutExtender ID="vceTitle" TargetControlID="rfvTitle" runat="server" />
          </td>
        </tr>
        <tr>
          <td class="key">
            <%= CommonResources.Offers_Price%>
          </td>
          <td class="required">
            <span class="required-field">*</span>
          </td>
          <td class="value">
            <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtPrice" MaxLength="6" Text="" /><span>&nbsp;<%= CommonResources.Offers_Currency%>
            </span>
            <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPrice" ID="ftbePrice" runat="server" />
            <asp:RequiredFieldValidator ControlToValidate="txtPrice" ID="rfvPrice" ErrorMessage="<%# GT.Localization.Resources.CommonResources.PriceEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
            <ajaxToolkit:ValidatorCalloutExtender ID="vcePrice" TargetControlID="rfvPrice" runat="server" />
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
            <%= CommonResources.DeliveryTime %>
          </td>
          <td class="value">
            <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtDeliveryTime" Text="" />
            <span>
              <%= CommonResources.Days %></span>
            <ajaxToolkit:FilteredTextBoxExtender runat="server" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtDeliveryTime" ID="ftbeDeliveryTime" />
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
            <%= CommonResources.Offers_EditSelling_Image %>
          </td>
          <td class="value">
            <asp:Panel runat="server" ID="pnlIUploadImage" CssClass="fileUploaderContainer">
              <gt:FileUploader runat="server" ID="fuImage" UploaderStyle="Modern" OnUploadedComplete="fuImage_UploadedComplete" OnUploadedFileError="fuImage_UploadedFileError" OnClientUploadError="fuImage_onClientUploadError" OnClientUploadComplete="fuImage_onClientUploadComplete" OnClientUploadStarted="fuImage_onClientUploadStarted" ThrobberID="imgUploading" ToolTip='<%# ImageValidationMessage %>' CssClass="fileUploader" Width="400" />
              <asp:Image runat="server" SkinID="imgUploadingSkin" AlternateText="" Style="display: none" ID="imgUploading" />
              <div style="clear: both">
                <asp:Label runat="server" Text='<%# ImageValidationMessage %>' ID="lblImageComment" CssClass="imageValidationMessage field-description" />
              </div>
            </asp:Panel>
            <asp:Panel runat="server" ID="pnlImage" CssClass="viewImage" Style="display: none">
              <gt:SellingImageViewer runat="server" ID="sivImage" SellingId="<%# Id %>" Width="100" Height="100" OnClientDelete="sivImage_onDelete" OnSavedImageExists="sivImage_SavedImageExists" />
              <div class="deleteImage">
                <asp:ImageButton AlternateText="<%# GT.Localization.Resources.CommonResources.Controls_SellingImageViewer_DeleteImage  %>" ToolTip="<%# GT.Localization.Resources.CommonResources.Controls_SellingImageViewer_DeleteImage  %>" ID="btnDeleteImage" runat="server" SkinID="btnDeleteSkin" />
              </div>
            </asp:Panel>
          </td>
        </tr>
        <tr>
          <td class="key" colspan="2">
            <%= CommonResources.Description %>
          </td>
          <td class="value description">
            <asp:TextBox runat="server" TextMode="MultiLine" ID="txtDescription" Rows="10" />
            <p class="attention field-description">
              <%= GT.Localization.Resources.CommonResources.ContactWarning %>
            </p>
          </td>
        </tr>
        <tr style='<%= Credentials.Profile.EmailMessageNotification == true ? "display:none": string.Empty %>'>
          <td class="key" colspan="2">
            <%# CommonResources.Offers_Notification%>
          </td>
          <td class="value">
            <asp:CheckBox runat="server" Checked="<%# Credentials.Profile.EmailMessageNotification %>" ID="chkEmailNotification" AutoPostBack="false" Text='<%# CommonResources.Offers_EmailNotification + "." %>' />
            <%--<p><i><%# string.Format(CommonResources.Offers_NotificationNote, "/PersonalAccount/Profile.aspx", "/Office")%>.</i></p>--%>
          </td>
        </tr>
        <tr>
          <td class="key">
          </td>
          <td class="value" colspan="2">
          </td>
        </tr>
      </tbody>
    </table>
    <div class="actions">
      <gt:Button CausesValidation="true" runat="server" Text='<%# EditPageMode == EditPageAction.Edit ? CommonResources.Update : CommonResources.Add %>' ID="btnEdit" Visible="<%# Offer.TransactionPhase == TransactionPhase.Start %>" OnClick="btnEdit_Click" />
      <gt:Button runat="server" Text="<%# GT.Localization.Resources.CommonResources.Cancel %>" ID="btnCancel" UseSubmitBehavior="false" CausesValidation="false" />
    </div>
    <div>
      <br />
      <asp:Label runat="server" ID="lblError" CssClass="error" EnableViewState="false" />
    </div>

    <script language="javascript" type="text/javascript">
      //<![CDATA[

      var imageValidationException = Error.create("ImageValidationException", "imageValidationException");

      $(function() {
        $addHandler($get("<%= btnDeleteImage.ClientID %>"), "click", btnDeleteImage_onClick);
        var txt = $("#<%# txtDescription.ClientID %>");
        txt.textLimiter({ maxLength: 5000 });
        $("#<%# btnCancel.ClientID %>").click(function() {
          window.back();
        });
      });

      function isInt(x) {
        var y = parseInt(x);
        if (isNaN(y)) return false;
        return x == y && x.toString() == y.toString();
      }

      function fuImage_onClientUploadComplete(sender, args) {
        /*_selling.Image = new GT.BO.Implementation.Offers.SellingImage();
        _selling.Image.ImageName = args.get_fileName();*/
        var pnlImage = $('<%# string.Format("#{0}", pnlImage.ClientID) %>');
        if (pnlImage) {
          var newUrl = String.format("<%# GT.Ajax.Controls.FileUploader.GetFullVirtualPath(Credentials) %>/{0}", args.get_fileName());
          imageSellingViewer_updateUrl("<%# sivImage.ImageAnchorClientID %>", "<%# sivImage.ImageClientID %>", newUrl);
          resetSavedImageExists();
          pnlImage.show();
        }
      }

      function fuImage_onClientUploadError(sender, args) {
        /*_selling.Image = null;*/
        if (args.get_errorMessage() == imageValidationException.message) {
          //TODO: workaround for uploading incorrect files
        }
        else {
          //TODO:handle other errors
        }
      }

      function fuImage_onClientUploadStarted(sender, args) {
        if (Page_ClientValidate("ImageValidationGroup") == false) {
          throw (imageValidationException);
        }
      }

      function fuImage_validateImageExtensions(control, args) {
        args.IsValid = true;
        if (args.Value && String.isNullOrEmpty(args.Value) == false) {
          args.IsValid = args.Value.toLowerCase().match(/<%= ImageValidationRegularExpression %>/);
        }
      }

      function resetSavedImageExists() {
        if (typeof (savedImageExists) != "undefined") {
          savedImageExists = false;
        }
      }

      function btnDeleteImage_onClick(domEvent) {
        window.cancelEvent(domEvent);
        var deletePermanently = false;
        if (typeof (savedImageExists) != "undefined" && savedImageExists == true) {
          deletePermanently = confirm("<%# GT.Localization.Resources.CommonResources.Offers_EditSelling_DeleteImageConfirmation %>");
          if (deletePermanently == false) {
            return;
          }
          resetSavedImageExists();
        }
        var pnlImage = $('<%# string.Format("#{0}", pnlImage.ClientID) %>');
        if (pnlImage) {
          pnlImage.hide();
          /*if (_selling.Image && _selling.Image.ImageName) {
          _selling.Image.ImageName = null;
          }*/
        }
        if (deletePermanently) {
          GT.Web.Site.WebServices.Ajax.SellingService.DeleteSellingImage(
          "<%# Id %>"
          , image_onDeleteSuccess
          , image_onDeleteFailure);
        }
      }

      function image_onDeleteSuccess(result, context, methodName) {
        //alert(result);
      }

      function image_onDeleteFailure(error, context, methodName) {

      }

      //]]>
    </script>

  </div>
</asp:Content>
