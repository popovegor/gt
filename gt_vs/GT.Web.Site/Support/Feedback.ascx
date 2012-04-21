<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Feedback.ascx.cs" Inherits="GT.Web.Site.Support.Feedback" EnableViewState="false" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Import Namespace="GT.Global.Localization" %>
<asp:ScriptManagerProxy runat="server" ID="smp">
  <Services>
    <asp:ServiceReference Path="~/WebServices/Ajax/SupportService.asmx" InlineScript="true" />
  </Services>
</asp:ScriptManagerProxy>
<div id="support-feedback-btn">
  <a href="#" title="<%= CommonResources.Support_Feedback_Title %>" class="<%= Localizator.CurrentLauguage.ToString() %>">&nbsp;</a>
</div>
<div id="support-feedback">
  <div class="feedback-title">
    <span>
      <%= CommonResources.Support_Feedback_Title %></span> <a href="#" title="<%= CommonResources.Close %>" id="support-feedback-close">&nbsp;</a>
  </div>
  <div class="feedback-body">
    <p>
      <%= CommonResources.Support_Feedback_Appeal%></p>
    <table rules="none" class="key-value">
      <tr>
        <td class="key" colspan="2">
          <%= CommonResources.Support_Feedback_Name%>:
        </td>
        <td class="value">
          <asp:TextBox runat="server" Text="" ID="txtName" AutoCompleteType="FirstName" Width="250px" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <%= CommonResources.Support_Feedback_Email%>:
        </td>
        <td class="required">
          *
        </td>
        <td class="value">
          <asp:TextBox runat="server" ID="txtEmail" AutoCompleteType="Email" Text="" Width="250px" />
          <ajaxToolkit:TextBoxWatermarkExtender runat="server" TargetControlID="txtEmail" WatermarkText="<%# CommonResources.Support_Feedback_EmailWatermark %>" ID="tbweEmail" WatermarkCssClass="textBoxWatermark" />
          <asp:RequiredFieldValidator runat="server" ID="rfvEmail" ControlToValidate="txtEmail" ErrorMessage="<%# CommonResources.Support_Feedback_EmailRequired %>" Display="None" SetFocusOnError="true" ValidationGroup="<%# ValidationGroupName %>" Enabled="false" />
          <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceEmail" TargetControlID="rfvEmail" />
          <asp:CustomValidator ValidationGroup="<%# ValidationGroupName %>" ValidateEmptyText="true" ClientValidationFunction="ControlValidator.ValidateEmail" ID="cvEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="<%# CommonResources.Support_Feedback_EmailFormat %>" Text="" Display="none" Enabled="false" />
          <ajaxToolkit:ValidatorCalloutExtender ID="vceEmailCustom" runat="server" TargetControlID="cvEmail" />
        </td>
      </tr>
      <tr>
        <td class="key">
          <%= CommonResources.Support_Feedback_Feedback%>:
        </td>
        <td class="required">
          *
        </td>
        <td class="value">
          <asp:TextBox TextMode="MultiLine" runat="server" ID="txtFeedback" Text="" Rows="10" Width="100%" />
          <asp:RequiredFieldValidator runat="server" ID="rfvFeedback" ControlToValidate="txtFeedback" ErrorMessage="<%# CommonResources.Support_Feedback_FeedbackRequired %>" Display="None" SetFocusOnError="true" ValidationGroup="<%# ValidationGroupName %>" Enabled="false" />
          <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceFeedback" PopupPosition="TopRight" TargetControlID="rfvFeedback" />
        </td>
      </tr>
    </table>
  </div>
  <div class="feedback-actions">
    <gt:Button runat="server" ID="btnSend" ValidationGroup="<%# ValidationGroupName %>" CausesValidation="true" UseSubmitBehavior="false" ToolTip="<%# CommonResources.Support_Feedback_Send %>" Text="<%# CommonResources.Support_Feedback_Send %>" OnClick="btnSend_Click" />
    &nbsp;<i><%= CommonResources.Support_Feedback_Promise%></i>
  </div>
</div>

<script language="javascript" type="text/javascript">
  //<![CDATA[
  var fb = new GT.BO.Implementation.Support.SupportFeedback();

  function enabledValidators(action) { //action : boolean
    ControlValidator.enableValidator("<%=vceEmail.ClientID %>", action);
    ControlValidator.enableValidator("<%=vceEmailCustom.ClientID %>", action);
    ControlValidator.enableValidator("<%=vceFeedback.ClientID %>", action);
  }

  $(function() {
    var feedback = $('#support-feedback');
    feedback.jqm({
    onShow: function(hash) { enabledValidators(true); hash.w.show() }
      , onHide: function(hash) { enabledValidators(false); hash.o.remove(); hash.w.hide(); }
    });
    feedback.jqmAddTrigger($('#support-feedback-btn a'));
    feedback.jqmAddTrigger($('#feedback'));
    feedback.jqmAddClose($('#support-feedback-close'));

    var send = $get("<%= btnSend.ClientID %>");
    send.onclick = function(event) {
      window.cancelEvent(event);
      Page_ClientValidate("<%= ValidationGroupName %>");
      if (Page_IsValid) {
        $(send).attr('disabled', true);
        $(send).val("<%= CommonResources.Support_Feedback_Sending %>");
        var name = $("#<%= txtName.ClientID %>");
        fb.UserName = name.val();

        var email = $("#<%= txtEmail.ClientID %>");
        fb.UserEmail = email.val();

        var msg = $("#<%= txtFeedback.ClientID %>");
        fb.Message = msg.val();

        GT.Web.Site.WebServices.Ajax.SupportService.AddFeedback(
          fb
          , function(result) { //success
            alert(result);
            feedback.jqmHide();
            name.val("");
            email.val("");
            msg.val("");
            $(send).val("<%# CommonResources.Support_Feedback_Send %>");
            $(send).attr('disabled', false);
          }
          , function(error) { ; }); //failure
      }
    };
  });
  //>]]
</script>

