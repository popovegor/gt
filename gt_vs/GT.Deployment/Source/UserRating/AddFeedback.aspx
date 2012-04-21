<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="AddFeedback.aspx.cs" Inherits="GT.Web.Site.UserRating.AddFeedback" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/UserRatingService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <div id="addFeedback" runat="server" class="addFeedback">
    <dl class="edit">
      <dt>
        <asp:Literal runat="server" ID="ltrToUser" Text="<%$ Resources:CommonResources, UserRating_AddFeedback_User %>" />:</dt>
      <dd>
        <asp:Label runat="server" ID="lblToUser" Text="<%# UsersFacade.GetUser(ToUserId).UserName  %>" />
      </dd>
      <dt>
        <asp:Literal runat="server" ID="ltrRating" Text="<%$ Resources:CommonResources, UserRating_AddFeedback_Rating %>" />:</dt>
      <dd>
        <asp:RadioButtonList runat="server" ID="rblFeedbackType" DataSource="<%# FeedbackTypes %>" DataTextField="<%# FeedbackTypeFields.LocalizedName %>" DataValueField="<%# FeedbackTypeFields.FeedbackTypeId %>" CssClass="type" RepeatDirection="Horizontal" AppendDataBoundItems="false" AutoPostBack="false" RepeatLayout="Flow" />
      </dd>
      <dt>
        <asp:Literal runat="server" ID="ltrComment" Text="<%$ Resources:CommonResources, UserRating_AddFeedback_Comment %>" />:</dt>
      <dd>
        <asp:TextBox runat="server" ID="txtComment" CssClass="comment" TextMode="MultiLine"  Rows="10" />
        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%$ Resources:CommonResources, UserRating_AddFeedback_Comment_Error %>" ID="rfvComment" InitialValue="" ControlToValidate="txtComment" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceComment" TargetControlID="rfvComment" PopupPosition="TopLeft" />
        <%-- <span class="requiredFieldAsterisk">*</span>--%>
      </dd>
    </dl>
  </div>
  <div class="actions">
    <gt:Button CausesValidation="true" runat="server" Text="<%# Resources.CommonResources.Add %>" ID="btnAdd" OnClientClick="return false;" />
    <gt:Button runat="server" Text="<%# Resources.CommonResources.Close %>" ID="btnClose" OnClientClick="return false;" UseSubmitBehavior="false" />
  </div>

  <script language="javascript" type="text/javascript">
    //<![CDATA[
    var _feedback = new GT.BO.Implementation.UserRating.Feedback();

    Sys.Application.add_load(function() {
      $addHandler($get("<%= btnClose.ClientID %>"), "click", btnClose_onClick);
      $addHandler($get("<%= btnAdd.ClientID %>"), "click", btnAdd_onClick);
      $addHandler($get("<%=addFeedback.ClientID %>"), "keypress", function(event) {
        WebForm_FireDefaultButton(event.rawEvent, "<%= btnAdd.ClientID %>");
      });
    });

    Sys.Application.add_unload(function() {
      $clearHandlers($get("<%= btnClose.ClientID %>"));
      $clearHandlers($get("<%= btnAdd.ClientID %>"));
      $clearHandlers($get("<%=addFeedback.ClientID %>"));
    });

    function btnAdd_onClick(domEvent) {
      debugger;
      if (Page_IsValid) {
        DomManager.disable($get("<%= btnAdd.ClientID %>"));
        _feedback.ToUserId = "<%= ToUserId %>";
        _feedback.Comment = $get("<%= txtComment.ClientID %>").value;
        _feedback.FeedbackTypeId = DomManager.findFirstSelectedValue($get("<%= rblFeedbackType.ClientID %>"));
        _feedback.SellingHistoryId = "<%= SellingHistoryId %>";
        GT.Web.Site.WebServices.Ajax.UserRatingService.AddFeedback(
                    _feedback
                    , feedback_onAddSuccess
                    , feedback_onAddFailure);
      }
      window.doCancelEvent(domEvent);
    };

    function feedback_onAddSuccess(result, context, methodName) {
      alert(result);
      PopupManager.close(true);
    };

    function feedback_onAddFailure(error, context, methodName) {
      alert(error.get_message());
      DomManager.enable($get("<%= btnAdd.ClientID %>"));
    };

    function btnClose_onClick(domEvent) {
      if (window.confirm("<%= Resources.CommonResources.WindowCloseConfirmation %>")) {
        window.close();
      }
      window.doCancelEvent(domEvent);
    };

    //]]>
  </script>

</asp:Content>
