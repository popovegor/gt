<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="TransferViewer.aspx.cs" Inherits="GT.Web.Site.BillingSystem.TransferViewer" %>

<%@ Import Namespace="GT.Global.BillingSystem" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Import Namespace="GT.Global.Entities" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/UsersService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <div id="transfers">
  <asp:GridView ID="gvTransfers" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvTransfers_PageIndexChanging" DataSource="<%# Transfers %>" CssClass="grid transfers" EnableViewState="false">
    <PagerStyle CssClass="pager" />
    <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
    <%--<AlternatingRowStyle CssClass="grid-alternative-row" />--%>
    <Columns>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-left" ItemStyle-CssClass="grid-item-left">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-CssClass="from">
      <HeaderTemplate>
        <%# GT.Localization.Resources.CommonResources.From %>
      </HeaderTemplate>
        <ItemTemplate>
          <gt:EntityMultiView Entity='<%# Eval("FromTransferParticipant.ActualEntityType") %>' runat="server" ID="emvFrom">
            <gt:DefaultView ID="dvFrom" runat="server"><span>
              <%# Eval("FromTransferParticipant.ActualEntityName")%></span> </gt:DefaultView>
            <gt:UserView ID="uvFrom" runat="server">
              <gt:User runat="server" ID="ulFrom" UserName='<%#  Eval("FromTransferParticipant.ActualEntityName")%>' UserId='<%#  Eval("FromTransferParticipant.UserId")%>' ShowUserCard="true" />
            </gt:UserView>
          </gt:EntityMultiView>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-CssClass="to">
      <HeaderTemplate>
        <%# GT.Localization.Resources.CommonResources.To %>
      </HeaderTemplate>
        <ItemTemplate>
          <gt:EntityMultiView Entity='<%# Eval("ToTransferParticipant.ActualEntityType") %>' runat="server" ID="emvTo">
            <gt:DefaultView ID="dvTo" runat="server"><span>
              <%# Eval("ToTransferParticipant.ActualEntityName")%></span> </gt:DefaultView>
            <gt:UserView ID="uvTo" runat="server">
              <gt:User runat="server" ID="ulTo" UserName='<%#  Eval("ToTransferParticipant.ActualEntityName")%>' UserId='<%#  Eval("ToTransferParticipant.UserId")%>' MeSubstitution="false" ShowUserCard="true" />
            </gt:UserView>
          </gt:EntityMultiView>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-CssClass="amount" ItemStyle-CssClass="amount">
      <HeaderTemplate>
        <%# GT.Localization.Resources.CommonResources.Amount %>
      </HeaderTemplate>
        <ItemTemplate><span>
          <%#  Eval("Amount", "{0:#.##}")%>
        </span></ItemTemplate>
      </asp:TemplateField>
      <%--<asp:TemplateField>
      <HeaderTemplate>
        <%# GT.Localization.Resources.CommonResources.BillingSystem_TransferViewer_Note %>
      </HeaderTemplate>
        <ItemTemplate><span>
          <%#  Eval("Note")%>
        </span></ItemTemplate>
      </asp:TemplateField>--%>
      <asp:TemplateField HeaderStyle-CssClass="status">
      <HeaderTemplate>
        <%# GT.Localization.Resources.CommonResources.BillingSystem_TransferViewer_Status %>
      </HeaderTemplate>
      <ItemStyle CssClass="status" />
        <ItemTemplate><span>
          <%# GT.DA.Dictionaries.Dictionaries.Instance.GetTransferStatusNameById((int)Eval("StatusId") )%>
        </span>
        <div class="date">
          <%# (DateTime)Eval("StatusModifyDate") != DateTime.MinValue ? ((DateTime)Eval("StatusModifyDate")).UtcToLocal(CommonResources.DateFormat): string.Empty%>
        </div>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderStyle-CssClass="date">
      <HeaderTemplate>
      <%# GT.Localization.Resources.CommonResources.CreatedOn %>
      </HeaderTemplate>
        <ItemTemplate><span>
          <%#  ((DateTime)Eval("CreateDate")).UtcToLocal(CommonResources.DateFormat)%>
        </span></ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="grid-header-right" ItemStyle-CssClass="grid-item-right">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
    </Columns>
    <EmptyDataRowStyle CssClass="grid-empty" />
    <EmptyDataTemplate>
      <%# string.Format(GT.Localization.Resources.CommonResources.NoTransfersFound, "/Office/TopUp") %>
    </EmptyDataTemplate>
  </asp:GridView>
  </div>
</asp:Content>
