<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ContactInfo.ascx.cs" Inherits="GT.Web.Site.Controls.ContactInfo" %>
<%@ Import Namespace="GT.Localization.Resources" %>
<%@ Register Src="~/Controls/Panel.ascx" TagName="Panel" TagPrefix="gt" %>

<dl id="contact-info">
  <dt>
    <gt:Panel ID="pnlContect" runat="server">
      <content><span>
              <%= CommonResources.Default_ContactInfo %></span> </content>
    </gt:Panel>
  </dt>
  <dd>
    <div class="icq">
        <img src="http://web.icq.com/whitepages/online?icq=610359499&img=5" alt="icq" height="18" width="18" />
        <a href="http://www.icq.com/people/610359499/" target="_blank">610359499 </a></div>
      <div class="skype"><a id="A1" runat="server" href='<%# string.Format("callto:{0}", GT.Localization.Resources.CommonResources.Default_Skype) %>'>
        <%# CommonResources.Default_Skype %></a> </div>
        <div class="vk"><a href="http://vkontakte.ru/club19929212" target="_blank">группа вконтакте</a> </div>
      <div class="e-mail"><a href='<%# string.Format("mailto:{0}", GT.Localization.Resources.CommonResources.Default_Email) %>' target="_blank">
        <%#CommonResources.Default_Email %></a> </div>
      
      <div class="webmoney">
<a href="https://passport.webmoney.ru/asp/certview.asp?wmid=131984805864" target="_blank"><img alt="webmoney: 131984805864" src="/App_Themes/Tutynin/Images/brown_rus.gif" /></a><%--<a href="https://passport.webmoney.ru/asp/certview.asp?wmid=131984805864">webmoney</a>--%></div>
  </dd>
</dl>
