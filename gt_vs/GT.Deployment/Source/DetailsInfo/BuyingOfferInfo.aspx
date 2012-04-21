<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/PopupPage.Master" AutoEventWireup="true" CodeBehind="BuyingOfferInfo.aspx.cs" Inherits="GT.Web.Site.DetailsInfo.BuyingOfferInfo" EnableViewState="true" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.Common.Types" %>
<%@ Import Namespace="Resources" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cphContent" runat="server">
    <asp:Label ID="errLbl" runat="server" Visible="false" CssClass="error"></asp:Label>
    <asp:panel ID="info" runat="server">
        <table class="detailView">
            <tr>
                <td>
                   <b><%= CommonResources.Title %>:</b>
                </td>
                <td>
                   <asp:Label ID="name" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                   <b><%= CommonResources.Game %>:</b>
                </td>
                <td>
                   <asp:HyperLink ID="game" runat="server"></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                   <b><%= CommonResources.Server %>:</b>
                </td>
                <td>
                   <asp:HyperLink ID="server" runat="server"></asp:HyperLink>
                </td>
            </tr>
            <tr>
                <td>
                   <b><%= CommonResources.Buyer %>:</b>
                </td>
                <td>
                   <asp:HyperLink ID="buyer" runat="server"></asp:HyperLink>
                   <asp:Label ID="buyerId" runat="server" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                   <b><%= CommonResources.CreatedOn %>:</b>
                </td>
                <td>
                   <asp:Label ID="dateCreation" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                  <b><%= CommonResources.Price %>:</b>
                </td>
                <td>
                   <asp:Label ID="price" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                   <b><%= CommonResources.Description %>:</b>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                   <asp:Label ID="description" runat="server"></asp:Label>
                </td>
            </tr>
            <tr id="trAction" runat="server" style="display:none">
                <td colspan="2">
                   <asp:Label ID="actionLbl" runat="server"></asp:Label>
                 </td>
            </tr>
            <tr>
                <td colspan="2">
                   <asp:DropDownList ID="forSuggesting" runat="server" style="display:none" ></asp:DropDownList>
                   <gt:Button ID="btnOne" runat="server" Visible="false" OnClick="btnOne_Click" />
                   <gt:Button ID="btnTwo" runat="server" Visible="false" OnClick="btnTwo_Click" />
                </td>
            </tr>
            <tr>
                <td colspan="2">
                   <asp:Label ID="sellersTitle" runat="server" Text='<%# CommonResources.SuggestedOffers + ":" %>' Visible="false"></asp:Label>
                   <asp:GridView ID="sellers" runat="server" Visible="false" CellSpacing="2" GridLines="None" AutoGenerateColumns="false" 
                                      AllowPaging="false" OnRowDataBound="suggested_RowDataBound">
                            <Columns>
                                <asp:TemplateField Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="suggestedIdLbl" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:HyperLink ID="buyer" runat="server" Text="<%# TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.Title]) %>" 
                                         NavigateUrl='<%# string.Concat("./OfferInfo.aspx?id=", (Container.DataItem as DataRow)[SellingOfferFields.SellingId]) %>'
                                         onclick='<%# string.Concat("if (window.PopupManager) {PopupManager.Open(ViewOfferInfo, {OfferID : ", TypeConverter.ToString((Container.DataItem as DataRow)[SellingOfferFields.SellingId]), "}); return false;} return true;") %>'
                                         ></asp:HyperLink>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                       <div class="offerbtns">
                                        <asp:ImageButton ID="btn1" runat="server" AlternateText="<%# CommonResources.Select %>" ToolTip="<%# CommonResources.Select %>"
                                                        ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png" OnClick="btn1_Click" />
                                        <asp:ImageButton ID="btn2" runat="server" AlternateText="<%# CommonResources.Decline %>" ToolTip="<%# CommonResources.Decline %>"
                                                        ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png" OnClick="btn2_Click" />
                                       </div>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
        </table>
    </asp:panel>
</asp:Content>
