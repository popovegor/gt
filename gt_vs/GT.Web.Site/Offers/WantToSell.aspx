<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="WantToSell.aspx.cs" Inherits="GT.Web.Site.Offers.WantToSell" %>

<%@ Import Namespace="GT.Localization.Resources" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server">
  <div id="want-to-sell" class="want-to">
    <div class="first-way">
      <h2>
        <%# string.Format(CommonResources.WantToSell_FirstWay_Title,"/Buying")%>
      </h2>
      <p class="">
        <%# string.Format(CommonResources.WantToSell_FirstWay_Description, "/Buying")%>
      </p>
    </div>
    <div class="second-way">
      <h2>
        <%# string.Format(CommonResources.WantToSell_SecondWay_Title, "/Office/Selling/Add")%>
      </h2>
      <p>
        <%# string.Format(CommonResources.WantToSell_SecondWay_Description, "/Office/Selling/Add", "/Office")%>
      </p>
    </div>
  </div>
</asp:Content>
