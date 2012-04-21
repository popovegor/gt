<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="RoundCornerBlock.ascx.cs" Inherits="GT.Web.Site.Controls.RoundCornerBlock" %>

<div class='<%= "round-corner-block " + CssClass  %>'>
<div class="rcb-title">
  <asp:PlaceHolder ID="phTitle" runat="server"></asp:PlaceHolder>
</div>
<div class="rcb-content">
  <asp:PlaceHolder ID="phContent" runat="server"></asp:PlaceHolder>  
</div>

<i class="round-corner lt"></i>
<i class="round-corner rt"></i>
<i class="round-corner lb"></i>
<i class="round-corner rb"></i>
</div>