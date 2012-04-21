<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master"
  AutoEventWireup="true" CodeBehind="FeedbackViewer.aspx.cs" Inherits="GT.Web.Site.UserRating.FeedbackViewer" %>

<%@ Import Namespace="GT.DA.UserRating" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.UserRating" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<asp:Content ContentPlaceHolderID="cphSidebar" ID="cntSidebar" Visible="true" runat="server">
  <div>
    <ul id="submenu">
      <li>
        <asp:HyperLink NavigateUrl='<%# "~/UserRating/FeedbackViewer.aspx" %>' Text='<%#  string.Format("{0} ({1})", Resources.CommonResources.UserRating_FeedbackViewer_All, Dynamics.FeedbacksTotal) %>'
          runat="server" ID="hplAll" />
      </li>
      <li>
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/UserRating/FeedbackViewer.aspx?", FeedbackFilterParams.AsBuyer, "=true") %>'
          Text='<%# string.Format("{0} ({1})", Resources.CommonResources.UserRating_FeedbackViewer_AsBuyer, Dynamics.FeedbacksAsBuyer) %>' runat="server"
          ID="hplAsBuyer" />
      </li>
      <li>
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/UserRating/FeedbackViewer.aspx?", FeedbackFilterParams.AsSeller, "=true") %>'
          Text='<%# string.Format("{0} ({1})", Resources.CommonResources.UserRating_FeedbackViewer_AsSeller, Dynamics.FeedbacksAsSeller) %>' runat="server"
          ID="hplAsSeller" />
      </li>
      <li>
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/UserRating/FeedbackViewer.aspx?", FeedbackFilterParams.ForOthers, "=true") %>'
          Text='<%# string.Format("{0} ({1})", Resources.CommonResources.UserRating_FeedbackViewer_ForOthers, Dynamics.FeedbacksForOthers) %>' runat="server"
          ID="hplForOthers" />
      </li>
    </ul>
  </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain">
  </asp:ScriptManagerProxy>
  <asp:GridView runat="server" ID="gvFeedbacks" AllowPaging="false" AllowSorting="false"
    AutoGenerateColumns="false" PageSize="10" DataSource="<%# Feedbacks %>" OnPageIndexChanging="gvFeedbacks_PageIndexChanging"
    GridLines="None" CssClass="grid feedbacks">
    <PagerSettings Mode="NumericFirstLast" />
    <AlternatingRowStyle CssClass="gridAlternative" />
    <Columns>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
        <ItemTemplate>
          <span>&nbsp;</span>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-Width="50">
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%$ Resources:CommonResources, UserRating_FeedbackViewer_Date %>" />
        </HeaderTemplate>
        <%--1--%>
        <ItemTemplate>
          <asp:Label runat="server" Text="<%# ((DateTime)Eval(FeedbackFields.CreateDate)).UtcToLocal() %>" />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-Width="200">
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%$ Resources:CommonResources, UserRating_FeedbackViewer_FromUser %>" />
        </HeaderTemplate>
        <%--2--%>
        <ItemTemplate>
          <asp:HyperLink runat="server" ID="hplFromUser" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", TypeConverter.ToString(Eval(FeedbackFields.FromUserId))) %>'
            Text="<%# UsersFacade.GetUser((Guid)Eval(FeedbackFields.FromUserId)).UserName %>"
            onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + TypeConverter.ToString(Eval(FeedbackFields.FromUserId)) + "\"}); return false;} return true;" %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="For User" Visible="false" HeaderStyle-Width="200">
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%$ Resources:CommonResources, UserRating_FeedbackViewer_ForUser %>" />
        </HeaderTemplate>
        <%--3--%>
        <ItemTemplate>
          <asp:HyperLink runat="server" ID="hplForUser" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", TypeConverter.ToString(Eval(FeedbackFields.ToUserId))) %>'
            Text="<%# UsersFacade.GetUser((Guid)Eval(FeedbackFields.ToUserId)).UserName %>"
            onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + TypeConverter.ToString(Eval(FeedbackFields.ToUserId)) + "\"}); return false;} return true;" %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <%--4--%>
      <asp:TemplateField HeaderStyle-Width="50">
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%$ Resources:CommonResources, UserRating_FeedbackViewer_Rating %>" />
        </HeaderTemplate>
        <ItemTemplate>
          <asp:Label runat="server" ID="lblRating" Text="<%# Dictionaries.Instance.GetFeedbackTypeNameById((int)Eval(FeedbackFields.FeedbackTypeId)) %>" />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField>
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%$ Resources:CommonResources, UserRating_FeedbackViewer_Comment %>" />
        </HeaderTemplate>
        <%--5--%>
        <ItemTemplate>
          <asp:Label runat="server" ID="lblComment" Text="<%# Eval(FeedbackFields.Comment) %>" />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
        <ItemTemplate>
          <span>&nbsp;</span>
        </ItemTemplate>
      </asp:TemplateField>
    </Columns>
    <EmptyDataRowStyle CssClass="gridEmpty" />
    <EmptyDataTemplate>
      <asp:Literal runat="server" Text="<%$ Resources:CommonResources, NoFeedbacks %>"
        ID="noFeedbacks" />
    </EmptyDataTemplate>
  </asp:GridView>
</asp:Content>
