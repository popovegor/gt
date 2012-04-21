<%@ Page Language="C#" MasterPageFile="~/MasterPages/Standard.Master" AutoEventWireup="true" CodeBehind="WantToBuy.aspx.cs" Inherits="GT.Web.Site.Offers.WantToBuy" %>
<%@ Import Namespace="GT.Localization.Resources" %>

<asp:Content ID="Content3" ContentPlaceHolderID="cphContent" runat="server">
   <div id="want-to-buy" class="want-to">
    <div class="first-way">
      <h2>
        <%# string.Format(CommonResources.WantToBuy_FirstWay_Title, "/Selling")%>
      </h2>
      <p class="">
        <%# string.Format(CommonResources.WantToBuy_FirstWay_Description, "/Selling")%>
      </p>
    </div>
    <div class="second-way">
      <h2>
        <%# string.Format(CommonResources.WantToBuy_SecondWay_Title, "/Office/Buying/Add")%>
      </h2>
      <p>
        <%# string.Format(CommonResources.WantToBuy_SecondWay_Description, "/Office/Buying/Add", "/Office")%>
      </p>
    </div>
  </div>
</asp:Content>
