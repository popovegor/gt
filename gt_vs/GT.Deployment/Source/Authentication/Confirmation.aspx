<%@ Page Language="C#" MasterPageFile="~/MasterPages/StandardPage.Master" 
         AutoEventWireup="true" CodeBehind="Confirmation.aspx.cs"
         Inherits="GT.Web.Site.Authentication.Confirmation" %>

<asp:Content ID="cntContent" ContentPlaceHolderID="cphContent" runat="server">
    <div style="text-align:center; margin-top: 50px;">
            <asp:Label ID="result" runat="server"></asp:Label>
    </div>
</asp:Content>