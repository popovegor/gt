<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="UserFeedbacks.ascx.cs" Inherits="GT.Web.Site.Users.UserFeedbacks" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Web.UI.Pages" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.Users" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Global.UserRating" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>


      <%if (Feedbacks.Length <= 0) {%>
        <p class="uc-feedbacks-empty">
          <%= CommonResources.Users_UserCard_FeedbacksNo%>
        </p>
      <%} else { %>
      
      <ul>
      <% foreach(var fb in Feedbacks) {
        var u = (GT.Web.Site.Controls.User)LoadControl("~/Controls/User.ascx");
        u.UserId = fb.FromUserId;
        u.ShowUserCard = true;
      %>
      
        <li class="<%= string.Concat("uc-feedback-", fb.FeedbackType.ToString().ToLower()) %>">
          <table rules="none">
            <tbody>
              <tr>
                <td class="uc-feedbacks-user">
                  <p style="position:relative">
                    <ins></ins>
                  <%= u.GenerateHtml() %>
                  </p>
                </td>
                <td rowspan="2" class="uc-feedbacks-comment">
                  <%--<q lang="<%= System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName %>"><%= fb.Comment %></q>--%>
                  <%= fb.Comment %>
                </td>
              </tr>
              <tr>
                <td class="uc-feedbacks-date">
                  <%= fb.CreateDate.UtcToLocal().ToString(CommonResources.Users_UserCard_DateFormat) %>
                </td>
              </tr>
            </tbody>
          </table>
         <%-- <p class="uc-feedbacks-user"><ins></ins> 
          <%= u.GenerateHtml() %>
        </p>
        <p class="uc-feedbacks-date">
          <%= fb.CreateDate.UtcToLocal().ToString(CommonResources.Users_UserCard_DateFormat) %>
        </p>

        <p class="uc-feedbacks-comment">
          <q lang="<%= System.Threading.Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName %>"><%= fb.Comment %></q>
        </p>--%>
        
        </li>
      <%} %>
      </ul>
      
  <%} %>
        
