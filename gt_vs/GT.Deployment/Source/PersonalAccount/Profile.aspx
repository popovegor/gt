<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="GT.Web.Site.PersonalAccount.Profile" %>

<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/ControlValidator.js" NotifyScriptLoaded="true" />
    </Scripts>
  </asp:ScriptManagerProxy>
  <div id="profile">
    <dl class="edit">
      <dt><asp:Literal runat="server" ID="ltrFirstName" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_FirstName %>" />: </dt>
      <dd>
        <asp:TextBox runat="server" Text='<%# Profile.FirstName %>' ID="txtFirstName" Width="200" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrLastName" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_LastName %>" />: </dt>
      <dd>
        <asp:TextBox runat="server" Text='<%# Profile.LastName %>' Width="200" ID="txtLastName" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrNickname" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_Nickname %>" />: </dt>
      <dd>
        <asp:TextBox runat="server" Text='<%# Profile.Nickname %>' Width="200" ID="txtNickname" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrICQ" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_ICQ %>  " />: </dt>
      <dd>
        <asp:TextBox runat="server" Text='<%# Profile.ICQ %>' Width="150" ID="txtICQ" />
        <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtICQ" ID="ftbeICQ" runat="server" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrPhone" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_Phone %>" />:</dt>
      <dd>
        <asp:TextBox runat="server" Width="100" Text='<%# Profile.Phone %>' ID="txtPhone" />
        <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbePhone" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPhone" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrMobilePhone" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_MobilePhone %>" />:</dt>
      <dd>
        <asp:TextBox runat="server" Width="100" Text='<%#Profile.MobilePhone %>' ID="txtMobilePhone" />
        <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeMobilePhone" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtMobilePhone" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrSkype" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_Skype %>" />:</dt>
      <dd>
        <asp:TextBox runat="server" Width="100" Text='<%#Profile.Skype %>' ID="txtSkype" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltrAddress" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_Address %>" />:</dt>
      <dd>
        <asp:TextBox TextMode="singleline" runat="server" Width="100%" Text='<%# Profile.Address %>' ID="txtAddress" />
      </dd>
      <dt><asp:Literal runat="server" ID="ltlTimeZone" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_TimeZone %>" />:</dt>
      <dd>
        <asp:DropDownList DataSource="<%# Dictionaries.Instance.TimeZones %>" TextMode="singleline" runat="server" AppendDataBoundItems="false" AutoPostBack="false" DataTextField="<%# TimeZoneFields.LocalizedName%>" DataValueField="<%# TimeZoneFields.TimeZoneId%>"  ID="ddlTimeZone" EnableViewState="false"/>
      </dd>
      <dt><asp:Literal runat="server" ID="ltrNote" Text="<%$ Resources:CommonResources, PersonalAccount_Profile_Note %>" />: </dt>
      <dd>
        <asp:TextBox runat="server" Width="100%" Text='<%# Profile.Note %>' ID="txtNote" TextMode="MultiLine" Rows="4" />
      </dd>
    </dl>
    <div class="actions">
      <gt:Button ID="btnSave" CausesValidation="true" runat="server" Text="<%$  Resources:CommonResources, PersonalAccount_Profile_Save %>" />
      <gt:Button runat="server" ID="btnClose" Text="<%$  Resources:CommonResources, Close %>" />
    </div>
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[ 

    function pageLoad() {
      $addHandler($get("<%= btnClose.ClientID %>"), "click", btnClose_onClick);
      $addHandler($get("<%= btnSave.ClientID %>"), "click", btnSave_onClick);
    }

    function pageUnload() {
      $clearHandlers($get("<%= btnClose.ClientID %>"));
      $clearHandlers($get("<%= btnSave.ClientID %>"));
    }

    function btnSave_onClick(domEvent) {
      debugger;
      DomManager.disable($get("<%= btnSave.ClientID %>"));
      Sys.Services.ProfileService.properties.FirstName = $get("<%= txtFirstName.ClientID %>").value;
      Sys.Services.ProfileService.properties.LastName = $get("<%= txtLastName.ClientID %>").value;

      Sys.Services.ProfileService.properties.Nickname = $get("<%= txtNickname.ClientID %>").value;
      Sys.Services.ProfileService.properties.ICQ = $get("<%= txtICQ.ClientID %>").value;
      Sys.Services.ProfileService.properties.Skype = $get("<%= txtSkype.ClientID %>").value;
      Sys.Services.ProfileService.properties.Phone = $get("<%= txtPhone.ClientID %>").value;
      Sys.Services.ProfileService.properties.MobilePhone = $get("<%= txtMobilePhone.ClientID %>").value;
      Sys.Services.ProfileService.properties.Address = $get("<%= txtAddress.ClientID %>").value;
      Sys.Services.ProfileService.properties.TimeZone = $('<%= string.Format("#{0} :selected", ddlTimeZone.ClientID) %>').val();
      Sys.Services.ProfileService.properties.Note = $get("<%= txtNote.ClientID %>").value;
      Sys.Services.ProfileService.save(null, profile_onSaveSuccess, profile_onSaveFailure);
      window.doCancelEvent(domEvent);
    }


    function profile_onSaveSuccess(result) {
      alert("<%=CommonResources.PersonalAccount_Profile_OnSaveSuccess%>");
      window.close();
    }

    function profile_onSaveFailure(error) {
      alert("<%= CommonResources.PersonalAccount_Profile_OnSaveFialure %>");
      DomManager.enable($get("<%= btnSave.ClientID %>"));
    }

    function btnClose_onClick(domEvent) {
      if (window.confirm("<%= CommonResources.WindowCloseConfirmation %>")) {
        window.close();
      }
      window.doCancelEvent(domEvent);
    }

    //]]>
  </script>

</asp:Content>
