<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="AddMessage.aspx.cs" Inherits="GT.Web.Site.MessageSystem.AddMessage" %>

<%@ Import Namespace="GT.Web.Site.WebServices.Ajax" %>
<%@ Import Namespace="Resources" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference Path="~/WebServices/Ajax/MessageSystemService.asmx" InlineScript="false" />
    </Services>
  </asp:ScriptManagerProxy>
  <div id="addMessage" runat="server">
    <dl class="edit">
      <dt>
        <%= CommonResources.Recipient %>:</dt>
      <dd>
        <gt:User runat="server" ID="ulRecipient" UserId="<%# RecipientId %>" />
        <%--<asp:TextBox ID="txtRecipient" Width="200" runat="server" />
                <span class="requiredFieldAsterisk">*</span>
                <ajaxToolkit:AutoCompleteExtender CompletionSetCount="10" CompletionInterval="100"
                    MinimumPrefixLength="1" ServiceMethod="GetRecipientList" TargetControlID="txtRecipient"
                    ServicePath="~/WebServices/Ajax/MessageSystemService.asmx" runat="server" ID="aceRecipient" />
                <asp:RequiredFieldValidator ID="rfvRecipient" Display="None" ErrorMessage="<%$  Resources:CommonResources, RecipientEmpty %>"
                    ControlToValidate="txtRecipient" SetFocusOnError="true" runat="server" />
                <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceRecipient" TargetControlID="rfvRecipient" />--%>
      </dd>
      <dt>
        <%= CommonResources.Subject %>: </dt>
      <dd>
        <asp:TextBox runat="server" ID="txtSubject" Width="400" />
        <span class="requiredFieldAsterisk">*</span>
        <asp:RequiredFieldValidator ID="rfvSubject" Display="None" ErrorMessage="<%$  Resources:CommonResources, SubjectEmpty %>" ControlToValidate="txtSubject" SetFocusOnError="true" runat="server" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceSubject" TargetControlID="rfvSubject" PopupPosition="BottomLeft" />
      </dd>
      <dt>
        <%= CommonResources.Body %>: </dt>
      <dd>
        <asp:TextBox runat="server" ID="txtBody" TextMode="MultiLine" Rows="10" Columns="60" />
        <span class="requiredFieldAsterisk">*</span>
        <asp:RequiredFieldValidator ID="rfvBody" Display="None" ErrorMessage="<%$  Resources:CommonResources, BodyEmpty %>" ControlToValidate="txtBody" SetFocusOnError="true" runat="server" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceBody" TargetControlID="rfvBody" PopupPosition="TopLeft" />
      </dd>
    </dl>
  </div>
  <div class="actions">
    <gt:Button runat="server" ID="btnAdd" Text="<%$  Resources:CommonResources, Add %>" CausesValidation="true" OnClientClick="return false;" UseSubmitBehavior
    ="true" />
    <gt:Button runat="server" ID="btnClose" Text="<%$  Resources:CommonResources, Close %>" CausesValidation="false" OnClientClick="return false;" UseSubmitBehavior="false" />
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[ 

    Sys.Application.add_load(function() {
      $addHandler($get("<%= btnClose.ClientID %>"), "click", btnClose_onClick);
      $addHandler($get("<%= btnAdd.ClientID %>"), "click", btnAdd_onClick);
      $addHandler($get("<%=addMessage.ClientID %>"), "keypress", function(event) {
        WebForm_FireDefaultButton(event.rawEvent, "<%= btnAdd.ClientID %>");
      });
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get("<%= btnClose.ClientID %>"));
      $clearHandlers($get("<%= btnAdd.ClientID %>"));
      $clearHandlers($get("<%=addMessage.ClientID %>"));
    });

    function message_onAddSuccess(result, context, methodName) {
      alert(result);
      PopupManager.close(true);
    };

    function message_onAddFailure(error, context, methodName) {
      alert(error.get_message());
      DomManager.enable($get("<%= btnAdd.ClientID %>"));
    };

    function btnAdd_onClick(domEvent) {
      Page_ClientValidate();
      if (Page_IsValid) {
        DomManager.disable($get("<%= btnAdd.ClientID %>"));
        var recipient = "<%= RecipientId %>";
        var subject = $get("<%= txtSubject.ClientID %>").value;
        var body = $get("<%= txtBody.ClientID %>").value;
        GT.Web.Site.WebServices.Ajax.MessageSystemService.AddMessage(
                    recipient, subject, body
                    , message_onAddSuccess
                    , message_onAddFailure);
      }
      window.doCancelEvent(domEvent);
    };

    function btnClose_onClick(domEvent) {
      if (window.confirm("<%= CommonResources.WindowCloseConfirmation %>")) {
        window.close();
      }
      window.doCancelEvent(domEvent);
    };

    //]]>
  </script>

</asp:Content>
