<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="EditSelling.aspx.cs" Inherits="GT.Web.Site.Offers.EditSelling" ValidateRequest="false" EnableEventValidation="false" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation" %>
<%@ Import Namespace="GT.Global.Offers" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/SellingImageViewer.ascx" TagName="SellingImageViewer" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/SellingService.asmx" />
    </Services>
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/jquery.imageZoom.js" />
    </Scripts>
  </asp:ScriptManagerProxy>
  <div id="editSelling" runat="server">
    <dl class="edit">
      <dt>
        <asp:Literal runat="server" Text="<%$ Resources:CommonResources, Game  %>" ID="ltrGame" />: </dt>
      <dd>
        <asp:DropDownList runat="server" ID="ddlGame" />
        <span class="requiredFieldAsterisk">*</span>
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddGame" TargetControlID="ddlGame" ServiceMethod="GetCascadingDropDownDictionary" Category="<%# DictionaryTypes.Game.ToString() %>" LoadingText="<%$ Resources:CommonResources, LoadingGameList %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" PromptText="<%$ Resources:CommonResources, SelectGame  %>" />
        <asp:RequiredFieldValidator runat="server" Display="None" ErrorMessage="<%$ Resources:CommonResources, GameNotSelected %>" SetFocusOnError="true" ID="rfvGame" InitialValue="" ControlToValidate="ddlGame" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceGame" TargetControlID="rfvGame" />
      </dd>
      <dt>
        <%= CommonResources.Server %>: </dt>
      <dd>
        <asp:DropDownList runat="server" ID="ddlServer" />
        <span class="requiredFieldAsterisk">*</span>
        <ajaxToolkit:CascadingDropDown runat="server" ID="cddServer" Category="<%# DictionaryTypes.GameServer.ToString() %>" ParentControlID="ddlGame" TargetControlID="ddlServer" ServiceMethod="GetCascadingDropDownDictionary" PromptText="<%$ Resources:CommonResources, SelectServer %>" ServicePath="~/WebServices/Ajax/DictionariesService.asmx" LoadingText="<%$ Resources:CommonResources, LoadingServerList %>" />
        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%$ Resources:CommonResources, ServerNotSelected %>" ID="rfvServer" InitialValue="" ControlToValidate="ddlServer" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceServer" TargetControlID="rfvServer" PopupPosition="TopLeft" />
      </dd>
      <dt>
        <%= CommonResources.Title %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="SingleLine" Width="250" ID="txtTitle" />
        <span class="requiredFieldAsterisk">*</span>
        <asp:RequiredFieldValidator ControlToValidate="txtTitle" ID="rfvTitle" ErrorMessage="<%$ Resources:CommonResources, TitleEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
        <ajaxToolkit:ValidatorCalloutExtender ID="vceTitle" TargetControlID="rfvTitle" runat="server" />
      </dd>
      <dt>
        <%= CommonResources.Price %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtPrice" MaxLength="4" Text="" />
        <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPrice" ID="ftbePrice" runat="server" />
        <span class="requiredFieldAsterisk">*</span>
        <asp:RequiredFieldValidator ControlToValidate="txtPrice" ID="rfvPrice" ErrorMessage="<%$ Resources:CommonResources, PriceEmpty %>" SetFocusOnError="true" Display="None" runat="server" />
        <ajaxToolkit:ValidatorCalloutExtender ID="vcePrice" TargetControlID="rfvPrice" runat="server" />
      </dd>
      <dt>
        <%= CommonResources.DeliveryTime %>:</dt>
      <dd>
        <asp:TextBox runat="server" TextMode="SingleLine" Width="50" ID="txtDeliveryTime" Text="" />
        <span>
          <%= CommonResources.Days %></span>
        <ajaxToolkit:FilteredTextBoxExtender runat="server" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtDeliveryTime" ID="ftbeDeliveryTime" />
      </dd>
      <dt>
        <%= CommonResources.Offers_EditSelling_Image %>: </dt>
      <dd>
        <asp:Panel runat="server" ID="pnlIUploadImage" CssClass="fileUploaderContainer">
          <gt:FileUploader runat="server" ID="fuImage" UploaderStyle="Modern" OnUploadedComplete="fuImage_UploadedComplete" OnUploadedFileError="fuImage_UploadedFileError" OnClientUploadError="fuImage_onClientUploadError" OnClientUploadComplete="fuImage_onClientUploadComplete" OnClientUploadStarted="fuImage_onClientUploadStarted" ThrobberID="imgUploading" ToolTip='<%# ImageValidationMessage %>' CssClass="fileUploader" />
          <asp:Image runat="server" SkinID="imgUploadingSkin" AlternateText="" Style="display: none" ID="imgUploading" />
          <div style="clear: both">
            <asp:Label runat="server" Text='<%# ImageValidationMessage %>' ID="lblImageComment" CssClass="comment imageValidationMessage" />
          </div>
        </asp:Panel>
        <asp:Panel runat="server" ID="pnlImage" CssClass="viewImage" Style="display: none">
          <gt:SellingImageViewer runat="server" ID="sivImage" SellingId="<%# Id %>" Width="100" Height="100" OnClientDelete="sivImage_onDelete" OnSavedImageExists="sivImage_SavedImageExists" />
          <div class="deleteImage">
            <asp:ImageButton AlternateText="<%# Resources.CommonResources.Controls_SellingImageViewer_DeleteImage  %>" ToolTip="<%# Resources.CommonResources.Controls_SellingImageViewer_DeleteImage  %>" ID="btnDeleteImage" runat="server" SkinID="btnDeleteSkin" />
          </div>
        </asp:Panel>
      </dd>
      <dt>
        <%= CommonResources.Description %>: </dt>
      <dd>
        <asp:TextBox runat="server" TextMode="MultiLine" Width="100%" ID="txtDescription" Rows="5" />
      </dd>
    </dl>
  </div>
  <div class="actions">
    <gt:Button CausesValidation="true" runat="server" Text='<%# EditPageMode == EditPageAction.Edit ? CommonResources.Update : CommonResources.Add %>' ID="btnEdit" Visible="<%# Offer.TransactionPhase == TransactionPhase.Start %>" />
    <gt:Button runat="server" Text="<%$ Resources:CommonResources, Close %>" ID="btnClose" UseSubmitBehavior="false" CausesValidation="false" />
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[

    var imageValidationException = Error.create("ImageValidationException", "imageValidationException");

    var _selling = null;

    Sys.Application.add_load(function() {
      _selling = new GT.BO.Implementation.Offers.Selling();
      _selling.SellingId = parseInt("<%= Id %>");
      $addHandler($get("<%= btnEdit.ClientID %>"), "click", btnEdit_onClick);
      $addHandler($get("<%= btnClose.ClientID %>"), "click", btnClose_onClick);
      $addHandler($get("<%= btnDeleteImage.ClientID %>"), "click", btnDeleteImage_onClick);
      $addHandler($get("<%=editSelling.ClientID %>"), "keypress", function(event) {
        WebForm_FireDefaultButton(event.rawEvent, "<%= btnEdit.ClientID %>");
      });
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get("<%= btnEdit.ClientID %>"));
      $clearHandlers($get("<%= btnClose.ClientID %>"));
      $clearHandlers($get("<%= btnDeleteImage.ClientID %>"));
      $clearHandlers($get("<%= editSelling.ClientID %>"));
    });

    function btnClose_onClick(domEvent) {
      if (window.confirm("<%= CommonResources.WindowCloseConfirmation %>")) {
        window.close();
      }
      window.doCancelEvent(domEvent);
    }

    function btnEdit_onClick(domEvent) {
      if (Page_IsValid) {
        DomManager.disable($get("<%= btnEdit.ClientID %>"));
        _selling.GameServerId = $get("<%= ddlServer.ClientID %>").value;
        _selling.Title = $get("<%= txtTitle.ClientID %>").value;
        _selling.Price = $get("<%= txtPrice.ClientID %>").value;
        _selling.Description = $get("<%= txtDescription.ClientID %>").value;
        _selling.DeliveryTime = $get("<%= txtDeliveryTime.ClientID %>").value;
        GT.Web.Site.WebServices.Ajax.SellingService.Upsert(
                    _selling
                    , offer_onOperationSuccess
                    , offer_onOperationFailure);
      }
      window.doCancelEvent(domEvent);
    }

    function offer_onOperationSuccess(result, context, methodName) {
      alert(result);
      var redirectUrl = "<%= RedirectUrl %>"
      if (String.isNullOrEmpty(redirectUrl) == false) {
        PopupManager.close(true, redirectUrl);
      }
      else {
        window.close();
      }
    }

    function offer_onOperationFailure(error, context, methodName) {
      alert(error.get_message());
      $("<%= btnEdit.ClientID %>").hide();
    }

    function fuImage_onClientUploadComplete(sender, args) {
      _selling.Image = new GT.BO.Implementation.Offers.SellingImage();
      _selling.Image.ImageName = args.get_fileName();
      var pnlImage = $('<%# string.Format("#{0}", pnlImage.ClientID) %>');
      if (pnlImage) {
        var newUrl = String.format("<%# GT.Ajax.Controls.FileUploader.GetFullVirtualPath(Credentials) %>/{0}", args.get_fileName());
        imageSellingViewer_updateUrl("<%# sivImage.ImageAnchorClientID %>", "<%# sivImage.ImageClientID %>", newUrl);
        resetSavedImageExists();
        pnlImage.show();
      }
    }

    function fuImage_onClientUploadError(sender, args) {
      _selling.Image = null;
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
      window.doCancelEvent(domEvent);
      var deletePermanently = false;
      if (typeof (savedImageExists) != "undefined" && savedImageExists == true) {
        deletePermanently = confirm("<%# Resources.CommonResources.Offers_EditSelling_DeleteImageConfirmation %>");
        if (deletePermanently == false) {
          return;
        }
        resetSavedImageExists();
      }
      var pnlImage = $('<%# string.Format("#{0}", pnlImage.ClientID) %>');
      if (pnlImage) {
        pnlImage.hide();
        if (_selling.Image && _selling.Image.ImageName) {
          _selling.Image.ImageName = null;
        }
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

</asp:Content>
