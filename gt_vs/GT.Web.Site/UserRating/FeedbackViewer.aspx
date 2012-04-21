<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.Master"
  AutoEventWireup="true" CodeBehind="FeedbackViewer.aspx.cs" Inherits="GT.Web.Site.UserRating.FeedbackViewer" %>

<%@ Import Namespace="GT.DA.UserRating" %>
<%@ Import Namespace="GT.DA.Dictionaries" %>
<%@ Import Namespace="GT.BO.Implementation.Users" %>
<%@ Import Namespace="GT.Global.UserRating" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>

<%@ Register Src="~/Menu/Submenu.ascx" TagName="Submenu" TagPrefix="gt" %>
<%@ Register Src="~/Menu/SubmenuItem.ascx" TagName="SubmenuItem" TagPrefix="gt" %>

<asp:Content ContentPlaceHolderID="cphSidebar" ID="cntSidebar" Visible="true" runat="server">
  <div>
    
    <gt:Submenu runat="server" ID="sm">
      <Content>
        <gt:SubmenuItem runat="server" ID="smiAll" NavigateUrl='<%# "/Office/Feedbacks" %>' Text='<%#  string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_All, Dynamics.FeedbacksTotal) %>' />
        <%-- <gt:SubmenuItem runat="server" ID="smiFeedback" NavigateUrl="<%# GetUrlForSection(UserCardParams.Data.Feedbacks) %>" Text="<%# CommonResources.Users_UserCard_Feedbacks %>" />--%>
        <gt:SubmenuItem runat="server" ID="smiAsBuyer" NavigateUrl='<%# string.Concat("/Office/Feedbacks?", FeedbackFilterParams.AsBuyer, "=true") %>' Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_AsBuyer, Dynamics.FeedbacksAsBuyer) %>'  />
        <gt:SubmenuItem runat="server" ID="smiAsSeller" NavigateUrl='<%# string.Concat("/Office/Feedbacks?", FeedbackFilterParams.AsSeller, "=true") %>' Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_AsSeller, Dynamics.FeedbacksAsSeller) %>'  />
        <gt:SubmenuItem runat="server" ID="smiForOthers" NavigateUrl='<%# string.Concat("/Office/Feedbacks?", FeedbackFilterParams.ForOthers, "=true") %>' Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_ForOthers, Dynamics.FeedbacksForOthers) %>'  />
      </Content>
    </gt:Submenu>
  
   <%-- <ul id="submenu">
      <li class="highlight">
        <asp:HyperLink NavigateUrl='<%# "~/Office/Feedbacks" %>' Text='<%#  string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_All, Dynamics.FeedbacksTotal) %>'
          runat="server" ID="hplAll" />
      </li>
      <li>
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/Office/Feedbacks?", FeedbackFilterParams.AsBuyer, "=true") %>'
          Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_AsBuyer, Dynamics.FeedbacksAsBuyer) %>' runat="server"
          ID="hplAsBuyer" />
      </li>
      <li>
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/Office/Feedbacks?", FeedbackFilterParams.AsSeller, "=true") %>'
          Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_AsSeller, Dynamics.FeedbacksAsSeller) %>' runat="server"
          ID="hplAsSeller" />
      </li>
      <li class="separator">
      </li>
      <li class="highlight">
        <asp:HyperLink NavigateUrl='<%# string.Concat("~/Office/Feedbacks?", FeedbackFilterParams.ForOthers, "=true") %>'
          Text='<%# string.Format("{0} ({1})", GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_ForOthers, Dynamics.FeedbacksForOthers) %>' runat="server"
          ID="hplForOthers" />
      </li>
    </ul>--%>
  </div>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="feedbacks">
  <asp:ScriptManagerProxy runat="server" ID="smpMain">
  </asp:ScriptManagerProxy>
  <asp:GridView runat="server" ID="gvFeedbacks" AllowPaging="true" AllowSorting="false"
    AutoGenerateColumns="false" PageSize="20" DataSource="<%# Feedbacks %>" OnPageIndexChanging="gvFeedbacks_PageIndexChanging"
    GridLines="None" CssClass="grid feedbacks" OnRowDataBound="gv_RowDataBound">
    <PagerStyle CssClass="pager" />
    <PagerSettings Mode="NumericFirstLast" />
    <%--<AlternatingRowStyle CssClass="grid-alternative-row" />--%>
    <Columns>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
        <ItemTemplate>
          &nbsp;
        </ItemTemplate>
      </asp:TemplateField>
     <%-- <asp:TemplateField HeaderStyle-Width="50">
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_Date %>" />
        </HeaderTemplate>
        <ItemTemplate>
          <asp:Label runat="server" Text="<%# ((DateTime)Eval(FeedbackFields.CreateDate)).UtcToLocal() %>" />
        </ItemTemplate>
      </asp:TemplateField>--%>
      <asp:TemplateField>
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_FromUser %>" />
        </HeaderTemplate>
        <HeaderStyle CssClass="user" />
        <ItemStyle CssClass="user" />
        <%--2--%>
        <ItemTemplate>
          <p>
          <gt:User runat="server" ID="u" UserId="<%# Eval(FeedbackFields.FromUserId) %>" ShowUserCard="true" />
          <%--<asp:HyperLink runat="server" ID="hplFromUser" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", TypeConverter.ToString(Eval(FeedbackFields.FromUserId))) %>'
            Text="<%# UsersFacade.GetUser((Guid)Eval(FeedbackFields.FromUserId)).UserName %>"
            onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + TypeConverter.ToString(Eval(FeedbackFields.FromUserId)) + "\"}); return false;} return true;" %>' />--%>
            </p>
            <p class="date">
              <%# ((DateTime)Eval(FeedbackFields.CreateDate)).UtcToLocal(GT.Localization.Resources.CommonResources.DateFormat) %>
            </p>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField Visible="false">
        <HeaderStyle CssClass="user" />
        <ItemStyle CssClass="user" />
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_ForUser %>" />
        </HeaderTemplate>
        <%--3--%>
        <ItemTemplate>
          <p>
          <gt:User runat="server" ID="u" UserId='<%# Eval(FeedbackFields.ToUserId) %>' ShowUserCard="true" />
          <%--<asp:HyperLink runat="server" ID="hplFromUser" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", TypeConverter.ToString(Eval(FeedbackFields.FromUserId))) %>'
            Text="<%# UsersFacade.GetUser((Guid)Eval(FeedbackFields.FromUserId)).UserName %>"
            onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + TypeConverter.ToString(Eval(FeedbackFields.FromUserId)) + "\"}); return false;} return true;" %>' />--%>
            </p>
            <%--<p class="date">
              <%# ((DateTime)Eval(FeedbackFields.CreateDate)).UtcToLocal() %>
            </p>
          <asp:HyperLink runat="server" ID="hplForUser" NavigateUrl='<%# string.Concat("~/DetailsInfo/UserInfo.aspx?UserId=", TypeConverter.ToString(Eval(FeedbackFields.ToUserId))) %>'
            Text="<%# UsersFacade.GetUser((Guid)Eval(FeedbackFields.ToUserId)).UserName %>"
            onclick='<%# "if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"" + TypeConverter.ToString(Eval(FeedbackFields.ToUserId)) + "\"}); return false;} return true;" %>' />--%>
        </ItemTemplate>
      </asp:TemplateField>
      <%--4--%>
      <asp:TemplateField>
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_Rating %>" />
        </HeaderTemplate>
        <ItemStyle CssClass="rating" />
        <HeaderStyle CssClass="rating" />
        <ItemTemplate>
          <asp:Label runat="server" ID="lblRating" Text="&nbsp;" CssClass='<%# Eval("FeedbackType") %>' ToolTip='<%# Dictionaries.Instance.GetFeedbackTypeNameById((int)Eval(FeedbackFields.FeedbackTypeId)) %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField>
        <ItemStyle CssClass="comment" />
        <HeaderStyle CssClass="comment" />
        <HeaderTemplate>
          <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.UserRating_FeedbackViewer_Comment %>" />
        </HeaderTemplate>
        <%--5--%>
        <ItemTemplate>
          <asp:Label runat="server" ID="lblComment" Text='<%# Eval(FeedbackFields.Comment) %>' />
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
        <ItemTemplate>
          &nbsp;
        </ItemTemplate>
      </asp:TemplateField>
    </Columns>
    <EmptyDataRowStyle CssClass="grid-empty" />
    <EmptyDataTemplate>
      <asp:Literal runat="server" Text="<%# GT.Localization.Resources.CommonResources.NoFeedbacks %>"
        ID="noFeedbacks" />
    </EmptyDataTemplate>
  </asp:GridView>
  </div>
</asp:Content>
