<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" AutoEventWireup="true" CodeBehind="TransferViewer.aspx.cs" Inherits="GT.Web.Site.BillingSystem.TransferViewer" %>

<%@ Import Namespace="GT.Global.BillingSystem" %>
<%@ Import Namespace="GT.BO.Implementation.Helpers" %>

<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Import Namespace="GT.Global.Entities" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
  <asp:ScriptManagerProxy runat="server" ID="smpMain">
    <Services>
      <asp:ServiceReference InlineScript="false" Path="~/WebServices/Ajax/UsersService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <asp:GridView ID="gvTransfers" runat="server" AllowPaging="true" AutoGenerateColumns="false" GridLines="None" PagerStyle-Mode="NumericPages" PageSize="10" OnPageIndexChanging="gvTransfers_PageIndexChanging" DataSource="<%# Transfers %>" CssClass="grid transfers" EnableViewState="false">
    <PagerSettings Mode="NumericFirstLast" PageButtonCount="10" />
    <AlternatingRowStyle CssClass="gridAlternative" />
    <Columns>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="gridHeaderLeft" ItemStyle-CssClass="gridItemLeft">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, From %>" HeaderStyle-CssClass="from">
        <ItemTemplate>
          <gt:EntityMultiView Entity='<%# Eval("FromTransferParticipant.ActualEntityType") %>' runat="server" ID="emvFrom">
            <gt:DefaultView ID="dvFrom" runat="server"><span>
              <%# Eval("FromTransferParticipant.ActualEntityName")%></span> </gt:DefaultView>
            <gt:UserView ID="uvFrom" runat="server">
              <gt:User runat="server" ID="ulFrom" UserName='<%#  Eval("FromTransferParticipant.ActualEntityName")%>' UserId='<%#  Eval("FromTransferParticipant.UserId")%>' />
            </gt:UserView>
          </gt:EntityMultiView>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, To %>" HeaderStyle-CssClass="to">
        <ItemTemplate>
          <gt:EntityMultiView Entity='<%# Eval("ToTransferParticipant.ActualEntityType") %>' runat="server" ID="emvTo">
            <gt:DefaultView ID="dvTo" runat="server"><span>
              <%# Eval("ToTransferParticipant.ActualEntityName")%></span> </gt:DefaultView>
            <gt:UserView ID="uvTo" runat="server">
              <gt:User runat="server" ID="ulTo" UserName='<%#  Eval("ToTransferParticipant.ActualEntityName")%>' UserId='<%#  Eval("ToTransferParticipant.UserId")%>' />
            </gt:UserView>
          </gt:EntityMultiView>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, Amount %>" HeaderStyle-CssClass="amount" ItemStyle-CssClass="amount">
        <ItemTemplate><span>
          <%#  Eval("Amount", "{0:#.##}")%>
        </span></ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, BillingSystem_TransferViewer_Note %>">
        <ItemTemplate><span>
          <%#  Eval("Note")%>
        </span></ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, BillingSystem_TransferViewer_Status %>" HeaderStyle-CssClass="status">
      <ItemStyle CssClass="status" />
        <ItemTemplate><span>
          <%# GT.DA.Dictionaries.Dictionaries.Instance.GetTransferStatusNameById((int)Eval("StatusId") )%>
        </span>
        <div class="date">
          <%# (DateTime)Eval("StatusModifyDate") != DateTime.MinValue ?  ((DateTime)Eval("StatusModifyDate")).UtcToLocal().ToString() : string.Empty%>
        </div>
        </ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="<%$ Resources:CommonResources, CreatedOn %>" HeaderStyle-CssClass="date">
        <ItemTemplate><span>
          <%#  ((DateTime)Eval("CreateDate")).UtcToLocal()%>
        </span></ItemTemplate>
      </asp:TemplateField>
      <asp:TemplateField HeaderText="" HeaderStyle-CssClass="gridHeaderRight" ItemStyle-CssClass="gridItemRight">
        <ItemTemplate><span>&nbsp;</span> </ItemTemplate>
      </asp:TemplateField>
    </Columns>
    <EmptyDataRowStyle CssClass="gridEmpty" />
    <EmptyDataTemplate>
      <asp:Label  EnableViewState="false" runat="server" ID="lblNoTransfers" Text="<%$ Resources:CommonResources, NoTransfersFound %>" />
    </EmptyDataTemplate>
  </asp:GridView>
</asp:Content>
