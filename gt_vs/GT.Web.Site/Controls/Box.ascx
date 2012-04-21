<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Box.ascx.cs" Inherits="GT.Web.Site.Controls.Box" %>
<asp:Panel runat="server" CssClass='<%# string.Concat("box ", CssClass) %>' ID="pnlBox">
  <div class="title">
    <div class="titleInner">
      <div>
        <asp:PlaceHolder ID="phTitle" runat="server"></asp:PlaceHolder>
      </div>
    </div>
  </div>
  <%--<div class="mediator">
    <div class="mediatorInner">
    </div>
  </div>--%>
  <div class="content">
    <%--<div class="contentInner">--%>
      <asp:PlaceHolder ID="phContent" runat="server"></asp:PlaceHolder>
    <%--</div>--%>
  </div>
  <%--<div class="footer">
    <div class="footerInner">
      <div>
      </div>
    </div>
  </div>--%>
</asp:Panel>
