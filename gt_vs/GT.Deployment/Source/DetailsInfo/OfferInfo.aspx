<%@ Page Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="OfferInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.OfferInfo" Title="OfferInfo" EnableViewState="true" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="Resources" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Register Src="~/Controls/SellingImageViewer.ascx" TagName="SellingImageViewer" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server" EnableViewState="true">
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/jquery.imageZoom.js" />
    </Scripts>
  </asp:ScriptManagerProxy>
  <asp:Label ID="errLbl" runat="server" Visible="false" CssClass="error"></asp:Label>
  <asp:Panel ID="info" runat="server">
    <table class="detailView">
      <tr>
        <td><b><%= CommonResources.Title %>:</b></td>
        <td><asp:Label ID="name" runat="server"></asp:Label></td>
      </tr>
      <tr>
        <td><b><%= CommonResources.Game %>:</b></td>
        <td><asp:HyperLink ID="game" runat="server"></asp:HyperLink></td>
      </tr>
      <tr>
        <td><b><%= CommonResources.Server %>:</b></td>
        <td><asp:HyperLink ID="server" runat="server"></asp:HyperLink><asp:Label ID="sellerId" runat="server" Visible="false"></asp:Label></td>
      </tr>
      <tr>
        <td><b><%= CommonResources.Seller %>:</b></td>
        <td>
          <asp:HyperLink ID="seller" runat="server"></asp:HyperLink>
          <asp:Label ID="buyerId" runat="server" Visible="false"></asp:Label>
        </td>
      </tr>
      <tr id="trBuyer" runat="server" style="display:none">
        <td><b><%= CommonResources.Buyer %>:</b></td>
        <td><asp:HyperLink ID="buyerVal" runat="server" ></asp:HyperLink></td>
      </tr> 
      <tr>
        <td><b><%= CommonResources.CreatedOn %>:</b></td>
        <td><asp:Label ID="dateCreation" runat="server"></asp:Label></td>
      </tr>
      <tr id="trUpdate" runat="server" style="display:none">
        <td><b><%= CommonResources.UpdatedOn %>:</b></td>
        <td><asp:Label ID="dateUpdateVal" runat="server"></asp:Label></td>
      </tr>
      <tr>
        <td><b><%= CommonResources.Price %>:</b></td>
        <td><asp:Label ID="price" runat="server"></asp:Label></td>
      </tr>
      <tr>
        <td><b><%= CommonResources.Delivery %>:</b></td>
        <td><asp:Label ID="deliveryVal" runat="server"></asp:Label></td>
      </tr>
      <tr id="trStatus" runat="server" style="display:none">
        <td><b><%= CommonResources.State %>:</b></td>
        <td><asp:Label ID="statusVal" runat="server" ></asp:Label></td>
      </tr>
      <tr id="trKey" runat="server" style="display:none">
        <td><b><asp:Label ID="keyTxt" runat="server" Text='<%# CommonResources.Key + ":" %>'></asp:Label></b></td>
        <td><b><asp:Label ID="keyVal" runat="server"></asp:Label></b>
               <asp:TextBox ID="keyBox" runat="server" Visible="false"></asp:TextBox>
               <asp:Button ID="keyBtn" runat="server" Visible="false" Text="<%# CommonResources.Validate %>" OnClick="keyBtn_Click" />
        </td>
      </tr>
      <tr>
        <td colspan="2"><b><%= CommonResources.Description %>:</b></td>
      </tr>
      <tr>
        <td colspan="2"><asp:Label ID="description" runat="server"></asp:Label></td>
      </tr>
      <tr runat="server" style="display:none" id="trImage">
        <td>
          <b><%= CommonResources.DetailsInfo_OfferInfo_Image%>:</b>
        </td>
        <td>
          <gt:SellingImageViewer runat="server" ID="sivImage" Visible="<%# SellingId.HasValue %>" SellingId="<%# SellingId.Value %>" Width="100" Height="100" OnSavedImageExists="sivImage_SavedImageExists" />
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <gt:Button ID="btnOne" runat="server" Visible="false" OnClick="btnOne_Click"  />&nbsp;&nbsp;
          <gt:Button ID="btnTwo" runat="server" Visible="false" OnClick="btnTwo_Click" />
        </td>
        <%--<td>
          <asp:ImageButton ID="btnThree" runat="server" Visible="false" OnClick="btnThree_Click" AlternateText="<%$ Resources:CommonResources, Delete %>"
                           ToolTip="<%$ Resources:CommonResources, Delete %>" ImageUrl="../App_Themes/Tutynin/Images/actions/delete.png" />
        </td>--%>
      </tr>
      <tr>
        <td colspan="2">
          <b><asp:Label ID="buyersTitle" runat="server" Text='<%# CommonResources.PotentialBuyers + ":" %>' Visible="false"></asp:Label></b>
          <asp:GridView ID="buyers" runat="server" Visible="false" CellSpacing="2" GridLines="None" AutoGenerateColumns="false" AllowPaging="false"
                        EnableViewState="true" OnRowDataBound="buyers_RowDataBound">
            <Columns>
              <asp:TemplateField Visible="false">
                <ItemTemplate>
                  <asp:Label ID="buyerIdLbl" runat="server" Text="<%# (Container.DataItem as DataRow)[SellingOfferFields.BuyerId] %>"></asp:Label>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:HyperLink ID="buyer" runat="server" Text="<%# (Container.DataItem as DataRow)[SellingOfferFields.SellerName] %>" NavigateUrl='<%# string.Format("UserInfo.aspx?{0}={1}", GT.Global.DetailsInfo.UserInfoParams.USERID, (Container.DataItem as DataRow)[SellingOfferFields.BuyerId]) %>'
                                    onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewUserInfo, {UserID : \"", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.BuyerId]), "\"}); return false;} return true;") %>'></asp:HyperLink>
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:ImageButton ID="btn1" runat="server" AlternateText="<%# CommonResources.Select %>" ToolTip="<%# CommonResources.Select %>"
                                     OnClick="btn1_Click" ImageUrl="../App_Themes/Tutynin/Images/actions/select.png" />
                </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField>
                <ItemTemplate>
                  <asp:ImageButton ID="btn2" runat="server" AlternateText="<%# CommonResources.Decline %>" ToolTip="<%# CommonResources.Decline %>"
                                    ImageUrl="../App_Themes/Tutynin/Images/actions/reject.png" OnClick="btn2_Click" />
                </ItemTemplate>
              </asp:TemplateField>
            </Columns>
          </asp:GridView>
        </td>
      </tr>
    </table>
  </asp:Panel>
</asp:Content>
