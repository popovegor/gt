<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="GT.Web.Site.PersonalAccount.Profile" %>

<%@ Import Namespace="GT.Web.Security" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <div class="profile">
    <table rules="none" class="key-value">
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrFirstName" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_FirstName %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Text='<%# Profile.FirstName %>' ID="txtFirstName" Width="200" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrLastName" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_LastName %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Text='<%# Profile.LastName %>' Width="200" ID="txtLastName" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrNickname" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Nickname %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Text='<%# Profile.Nickname %>' Width="200" ID="txtNickname" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrICQ" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_ICQ %>  " />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Text='<%# Profile.ICQ %>' Width="150" ID="txtICQ" />
          <ajaxToolkit:FilteredTextBoxExtender FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtICQ" ID="ftbeICQ" runat="server" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrPhone" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Phone %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Width="100" Text='<%# Profile.Phone %>' ID="txtPhone" />
          <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbePhone" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtPhone" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrMobilePhone" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_MobilePhone %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Width="100" Text='<%#Profile.MobilePhone %>' ID="txtMobilePhone" />
          <ajaxToolkit:FilteredTextBoxExtender runat="server" ID="ftbeMobilePhone" FilterMode="ValidChars" FilterType="Numbers" TargetControlID="txtMobilePhone" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrSkype" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Skype %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Width="100" Text='<%#Profile.Skype %>' ID="txtSkype" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrAddress" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Address %>" />
        </td>
        <td class="value">
          <asp:TextBox TextMode="singleline" runat="server" Width="250" Text='<%# Profile.Address %>' ID="txtAddress" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltlTimeZone" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_TimeZone %>" />
        </td>
        <td class="value">
          <asp:DropDownList DataSource="<%# Dictionaries.Instance.TimeZones %>" TextMode="singleline" runat="server" AppendDataBoundItems="false" AutoPostBack="false" DataTextField="<%# TimeZoneFields.LocalizedName%>" DataValueField="<%# TimeZoneFields.TimeZoneId%>" ID="ddlTimeZone" EnableViewState="false" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <asp:Literal runat="server" ID="ltrNote" Text="<%# GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Note %>" />
        </td>
        <td class="value">
          <asp:TextBox runat="server" Width="500" Text='<%# Profile.Note %>' ID="txtNote" TextMode="MultiLine" Rows="6" Columns="40" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <%# CommonResources.PersonalAccount_Profile_Notification %>
        </td>
        <td class="value">
          <asp:CheckBox runat="server" Checked="<%# Credentials.Profile.EmailMessageNotification %>" ID="chkEmailNotification" AutoPostBack="false" Text='<%# CommonResources.PersonalAccount_Profile_EmailNotification + "." %>' />
        </td>
      </tr>
    </table>
    <div class="actions">
      <gt:Button ID="btnSave" CausesValidation="true" runat="server" Text="<%#  GT.Localization.Resources.CommonResources.PersonalAccount_Profile_Save %>" OnClick="btnSave_Click" />
      <gt:Button runat="server" ID="btnCancel" Text="<%#  GT.Localization.Resources.CommonResources.Cancel %>" />
    </div>

    <script language="javascript" type="text/javascript">
      //<![CDATA[
      $(function() {
        $("#<%= btnCancel.ClientID %>").click(function(event) {
          window.goBack(event);
        });
      });
      //]]>
    </script>

  </div>
</asp:Content>
