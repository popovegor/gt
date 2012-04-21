<%@ Page Language="C#" MasterPageFile="~/MasterPages/TwoColumns.Master" AutoEventWireup="true" CodeBehind="ViewSelling.aspx.cs" Inherits="GT.Web.Site.Offers.ViewSelling" EnableViewState="true" %>

<%@ Import Namespace="GT.DA.Offers" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Import Namespace="GT.Common.Types" %>

<%@ Register Src="~/Controls/SellingImageViewer.ascx" TagName="SellingImageViewer" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Button.ascx" TagName="Button" TagPrefix="gt" %>
<%@ Register Src="~/Controls/User.ascx" TagName="User" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Game.ascx" TagName="Game" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Server.ascx" TagName="Server" TagPrefix="gt" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>

<%@ Register Src="~/Menu/Submenu.ascx" TagName="Submenu" TagPrefix="gt" %>
<%@ Register Src="~/Menu/SubmenuItem.ascx" TagName="SubmenuItem" TagPrefix="gt"
 %>


<asp:Content ContentPlaceHolderID="cphSidebar" ID="cntSidebar" runat="server">
  <gt:Submenu runat="server" ID="sm" Visible="<%# Offer != null && Offer.SellerId != Credentials.UserId  %>" >
      <Content>
        <noindex>
        <gt:SubmenuItem CssClass="send-message" runat="server" ID="smiSendMessage" NavigateUrl='<%# Offer != null ? String.Format("/Users/User/{0}/Conversation", Offer.SellerId)  : string.Empty%>' Text='<%# CommonResources.SendMessageToSeller %>' />
        </noindex>
      </Content>
    </gt:Submenu>
</asp:Content>
<asp:Content ID="cntMain" ContentPlaceHolderID="cphContent" runat="server" EnableViewState="true">
    <script language="javascript" type="text/javascript">
        //<![CDATA[
        
        function validateKey(obj) {
            var offerId =  $(obj).next().attr("value");
            var code = $(obj).prev().attr("value");
            if (code.length > 0 && offerId > 0) {
                
                GT.Web.Site.WebServices.Ajax.SellingService.ValidateOfferKey(offerId, code, validatekeyCallback, null, obj);
            }
        }
    
        function validatekeyCallback(res, context) {
            if (res != null) {
                $(res).insertBefore($(context).prev());
            }
        }
        
        //]]>
    </script>
  <asp:ScriptManagerProxy ID="smpMain" runat="server">
    <Scripts>
      <asp:ScriptReference Path="~/Scripts/jquery.imageZoom.js" />
    </Scripts>
    <Services>
          <asp:ServiceReference InlineScript="true" Path="~/WebServices/Ajax/SellingService.asmx" />
    </Services>
  </asp:ScriptManagerProxy>
  <asp:Label ID="errLbl" runat="server" Visible="false" CssClass="error"></asp:Label>
  <div id="sellingviewer">
      <asp:Panel ID="info" runat="server">
       <div id="top">
        <table class="detailView">
          <tr runat="server" id="category" visible="false" enableviewstate="false">
            <td style=" width:14em; padding-right:2em"><b><%= CommonResources.Offers_ProductCategory %></b></td>
            <td style="width:auto;"><asp:Label ID="lblProductCategory" runat="server"></asp:Label></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Title %></b></td>
            <td><asp:Label ID="name" runat="server"></asp:Label></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Game %></b></td>
            <td><gt:Game runat="server" ID="game" ShowNewWindow="true" /></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Server %></b></td>
            <td><gt:Server runat="server" ID="server" ShowNewWindow="true" /><asp:Label ID="sellerId" runat="server" Visible="false"></asp:Label></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Seller %></b></td>
            <td>
              <gt:User runat="server" ShowUserCard="true" ID="seller" ShowNewWindow="true" />
              <%--<noindex><asp:HyperLink runat="server" ID="writeSeller" Text="<%# CommonResources.SellingViewer_SendMessage %>" Font-Bold="true" /></noindex>--%>
              <asp:Label ID="buyerId" runat="server" Visible="false"></asp:Label>
            </td>
          </tr>
          <tr id="trBuyer" runat="server" style="display:none">
            <td><b><%= CommonResources.Buyer %></b></td>
            <td><gt:User runat="server" ShowUserCard="true" ID="buyerVal" ShowNewWindow="true" />
                <asp:HyperLink runat="server" ID="writeBuyer" Text="<%# CommonResources.SellingViewer_SendMessage %>" Font-Bold="true" Visible="false" ></asp:HyperLink>
            </td>
          </tr> 
          <tr>
            <td><b><%= CommonResources.CreatedOn %></b></td>
            <td><asp:Label ID="dateCreation" runat="server"></asp:Label></td>
          </tr>
          <tr id="trUpdate" runat="server" style="display:none">
            <td><b><%= CommonResources.UpdatedOn %></b></td>
            <td><asp:Label ID="dateUpdateVal" runat="server"></asp:Label></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Price %></b></td>
            <td><asp:Label ID="price" runat="server"></asp:Label></td>
          </tr>
          <tr>
            <td><b><%= CommonResources.Delivery %></b></td>
            <td><asp:Label ID="deliveryVal" runat="server"></asp:Label></td>
          </tr>
          <tr id="trStatus" runat="server" style="display:none">
            <td><b><%= CommonResources.State %></b></td>
            <td><asp:Label ID="statusVal" runat="server" ></asp:Label></td>
          </tr>
          <tr id="trKey" runat="server" style="display:none">
            <td><b><asp:Label ID="keyTxt" runat="server"></asp:Label></b></td>
            <td><b><asp:Label ID="keyVal" runat="server"></asp:Label></b>
                   <asp:TextBox ID="keyBox" runat="server" Visible="false"></asp:TextBox>
                   <asp:Button ID="keyBtn" runat="server" Visible="false" Text="<%# CommonResources.Validate %>" OnClientClick="validateKey(this);return false;" />
                   <input type="hidden" value="<%# SellingId %>" />
            </td>
          </tr>
        </table>
       </div>
       <div id="potential">
             <gt:Panel runat="server" ID="buyersTitle">
                   <Content><%= CommonResources.PotentialBuyers %></Content>
             </gt:Panel>
             <div id="text">
                <span><%= GetActionText() %></span>
             </div>
             <asp:GridView ID="buyers" runat="server" Visible="false" CellSpacing="2" GridLines="None" AutoGenerateColumns="false" AllowPaging="false"
                                EnableViewState="true" OnRowDataBound="buyers_RowDataBound" CssClass="detailView">
                    <Columns>
                      <asp:TemplateField Visible="false">
                        <ItemTemplate>
                          <asp:Label ID="buyerIdLbl" runat="server" Text="<%# (Container.DataItem as DataRow)[SellingOfferFields.BuyerId] %>"></asp:Label>
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField>
                        <ItemTemplate>
                          <gt:User runat="server" ShowUserCard="true" ID="buyer" ShowNewWindow="true" UserId="<%# (Container.DataItem as DataRow)[SellingOfferFields.BuyerId] %>" />
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField>
                        <ItemTemplate>
                          <asp:ImageButton ID="btn1" runat="server" AlternateText="<%# CommonResources.Select %>" ToolTip="<%# CommonResources.Select %>"
                                             OnClick="btn1_Click" ImageUrl="~/App_Themes/Tutynin/Images/actions/select.png" />
                        </ItemTemplate>
                      </asp:TemplateField>
                      <asp:TemplateField>
                        <ItemTemplate>
                          <asp:ImageButton ID="btn2" runat="server" AlternateText="<%# CommonResources.Decline %>" ToolTip="<%# CommonResources.Decline %>"
                                            ImageUrl="~/App_Themes/Tutynin/Images/actions/reject.png" OnClick="btn2_Click" />
                        </ItemTemplate>
                      </asp:TemplateField>
                    </Columns>
              </asp:GridView>
          </div>
          <div id="actions">
            <table class="detailView">
               <tr>
                    <td colspan="2" style="padding:0 !important">
                      <gt:Button ID="btnOne" runat="server" Visible="false" OnClick="btnOne_Click"  />&nbsp;&nbsp;
                      <gt:Button ID="btnTwo" runat="server" Visible="false" OnClick="btnTwo_Click" />
                    </td>
                </tr>
            </table>
          </div>
          <div class="description">
              <%--  <gt:Panel runat="server" ID="pnl">
                   <Content>--%><span class="description-title"><%= CommonResources.Description %></span> <%--</Content>
                </gt:Panel>--%>
                <div class="text">
                    <asp:Label style="white-space:pre-line" ID="description" runat="server" />
                </div>
                <div class="image">
                    <table class="detailView">
                      <tr runat="server" style="display:none" id="trImage">
                        <td>
                          <gt:SellingImageViewer runat="server" ID="sivImage" Visible="<%# SellingId.HasValue %>" SellingId="<%# SellingId.HasValue ? SellingId.Value : 0 %>" Width="100" Height="100" OnSavedImageExists="sivImage_SavedImageExists" />
                        </td>
                      </tr>
                    </table>
                </div>
          </div>
          <%--<gt:Conversation ID="conv" UserId="<%# UserId %>" runat="server" Visible="<%# UserId != Credentials.UserId %>" />--%>
      </asp:Panel>
  </div>
</asp:Content>
