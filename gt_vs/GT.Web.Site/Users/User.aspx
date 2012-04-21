<%@ Page Language="C#" MasterPageFile="~/MasterPages/User.Master" AutoEventWireup="true" EnableEventValidation="false" CodeBehind="User.aspx.cs" Inherits="GT.Web.Site.Users.User"  %>

<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.Users" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Global.UserRating" %>
<%@ Import Namespace="GT.Web.Security" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/UserFeedbacks.ascx" TagName="UserFeedbacks" TagPrefix="gt" %>
<%@ Register Src="~/Users/UserConversation.ascx" TagName="Conversation" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Box.ascx" TagName="Box" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Users/UserFeedbacks.ascx" TagName="Feedbacks" TagPrefix="gt" %>
 
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">

     
    <asp:MultiView runat="server" ID="mv" ActiveViewIndex="<%# (int)(Master.DataType) %>">
      <asp:View runat="server" ID="vInfo">
        
        <%--feedbacks--%>
        <div class="uc-feedbacks">
          <dl>
          <dt>
             <span><%= CommonResources.Users_UserCard_Feedbacks %></span>
          </dt>
          <dd>
            <gt:Feedbacks runat="server" ID="fdbs" Feedbacks="<%# Feedbacks %>" />
          </dd>
          </dl>
        </div>
        
        <%--<div class="uc-feedbacks">
        <h2><%= CommonResources.Users_UserCard_Feedbacks %></h2>
          <dl class="uc-feedbacks-negative">
            <dt>
             <span><%# CommonResources.Users_UserCard_FeedbacksNegative %></span> </dt>
            <dd>
              <gt:Feedbacks runat="server" ID="fd" Feedbacks="<%# GetFeedbacks(FeedbackType.Negative) %>" />
            </dd>
          </dl>
          <dl class="uc-feedbacks-positive" style="">
            <dt><span>
              <%= CommonResources.Users_UserCard_FeedbacksPositive%></span> </dt>
            <dd>
              <gt:Feedbacks runat="server" ID="fbPositive" Feedbacks="<%# GetFeedbacks(FeedbackType.Positive) %>" />
            </dd>
          </dl>
          <dl class="uc-feedbacks-neutral">
            <dt><span>
              <%# CommonResources.Users_UserCard_FeedbacksNeutral %></span> </dt>
            <dd>
              <gt:Feedbacks runat="server" ID="fbNeutral" Feedbacks="<%# GetFeedbacks(FeedbackType.Neutral) %>" />
            </dd>
          </dl>
        </div>--%>
       
      </asp:View>
      <asp:View runat="server" ID="vConversation">
        <gt:Conversation ID="conv" UserId="<%# UserId %>" runat="server" Visible="<%# UserId != Credentials.UserId %>" />
      </asp:View>
    </asp:MultiView>
</asp:Content>
