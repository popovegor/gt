<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="LeaveFeedback.aspx.cs" Inherits="GT.Web.Site.UserRating.LeaveFeedback" %>

<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <%--<asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/UserRatingService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>--%>
  <div id="leave-feedback">
    <asp:MultiView runat="server" ID="mv" ActiveViewIndex="0">
    <asp:View runat="server" ID="vDefault">
      <dl class="edit">
      <dt>
        <asp:Label runat="server" ID="ltrToUser" Text="<%# GT.Localization.Resources.CommonResources.UserRating_LeaveFeedback_User %>" />:</dt>
      <dd>
      <gt:User ID="u" runat="server" UserId="<%# UnusedFeedback != null ? UnusedFeedback.ToUserId : Guid.Empty %>" ShowNewWindow="true" ShowUserCard="true" />
      </dd>
      <dt>
        <asp:Label runat="server" ID="ltrRating" Text="<%# GT.Localization.Resources.CommonResources.UserRating_LeaveFeedback_Rating %>" />:</dt>
      <dd>
        <asp:RadioButtonList runat="server" ID="rblFeedbackType" DataSource="<%# Offer != null ? FeedbackTypes : null %>" DataTextField="<%# FeedbackTypeFields.LocalizedName %>" DataValueField="<%# FeedbackTypeFields.FeedbackTypeId %>" CssClass="type" RepeatDirection="Horizontal" AppendDataBoundItems="false" AutoPostBack="false" RepeatLayout="Flow" />
      </dd>
      <dt>
        <asp:Label runat="server" ID="ltrComment" Text="<%# GT.Localization.Resources.CommonResources.UserRating_LeaveFeedback_Comment %>" />:</dt>
      <dd>
        <asp:TextBox runat="server" ID="txtComment" CssClass="comment" TextMode="MultiLine"  Rows="10" Columns="80" />
        <asp:RequiredFieldValidator runat="server" SetFocusOnError="true" Display="None" ErrorMessage="<%# GT.Localization.Resources.CommonResources.UserRating_LeaveFeedback_Comment_Error %>" ID="rfvComment" InitialValue="" ControlToValidate="txtComment" />
        <ajaxToolkit:ValidatorCalloutExtender runat="server" ID="vceComment" TargetControlID="rfvComment" PopupPosition="TopRight" />
        <%-- <span class="required-field">*</span>--%>
      </dd>
    </dl>
    <div class="actions">
    <gt:Button CausesValidation="true" runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_LeaveFeedback_Leave %>" ID="btnLeave" OnClick="btnLeave_Click" />
    <gt:Button runat="server" Text="<%# GT.Localization.Resources.CommonResources.Cancel %>" ID="btnCancel" UseSubmitBehavior="false" />
  </div>
  <script type="text/javascript" language="javascript">
    //<![CDATA[
    $(function() {
    
      
    
      //cancel
      $("#<%= btnCancel.ClientID %>").click(function(event) {
        if ("<%= ReturnUrl %>" != "") {
          window.location.href = "<%= ReturnUrl %>";
        } else {
          window.back();
        }
        window.cancelEvent(event);
      });
    });
  //]]>
  </script>
    </asp:View>
    <asp:View runat="server" ID="vFailure">
      <span class="errorText"><%= CommonResources.UserRating_LeaveFeedback_Failure %></span>
    </asp:View>
    </asp:MultiView>
    
    
  </div>
</asp:Content>
