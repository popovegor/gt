using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using GT.Common.Web.WebUtils;

namespace GT.Web.Security
{
    public class AuthenticationHelper
    { 
        public static string GetUserName(IPrincipal user)
        {
            if (IsLoggedInUser(user))
            {
                return user.Identity.Name;
            }
            return string.Empty;
        }

        public static bool IsLoggedInUser(IPrincipal p_oUser)
        {
            return (p_oUser != null && p_oUser.Identity != null && p_oUser.Identity.IsAuthenticated);
            
        }

        public static FormsAuthenticationTicket AddUserDataToTicket(FormsAuthenticationTicket p_source,
                                                                    string p_sUserData)
        {
            if (p_source != null)
                return new FormsAuthenticationTicket(
                    2, p_source.Name, p_source.IssueDate, p_source.Expiration,
                    p_source.IsPersistent, p_sUserData, p_source.CookiePath);
            return null;
        }

        public static void SetTicket(HttpResponse p_response, FormsAuthenticationTicket p_ticket)
        {
            if (p_response != null &&
                p_ticket != null)
            {
                string ticketEncrypted = FormsAuthentication.Encrypt(p_ticket);
                HttpCookie cookie = new HttpCookie(FormsAuthentication.FormsCookieName,
                                                   ticketEncrypted);
                cookie.HttpOnly = true;
                cookie.Path = FormsAuthentication.FormsCookiePath;
                cookie.Secure = FormsAuthentication.RequireSSL;
                if (p_ticket.IsPersistent)
                    cookie.Expires = p_ticket.Expiration;

                if (!string.IsNullOrEmpty(
                         Array.Find<string>(p_response.Cookies.AllKeys,
                                            delegate(string p_str) { return (p_str == cookie.Name); })))
                    p_response.Cookies.Remove(cookie.Name);
                p_response.Cookies.Add(cookie);
            }
        }

        public static string GetLoginUrl(string p_sReturnUrl)
        {
            string sUrl = FormsAuthentication.LoginUrl;
            if (sUrl.IndexOf('?') >= 0)
                sUrl = QueryStringBuilder.RemoveQueryStringVariableFromUrl(sUrl, "ReturnUrl");
            
            int iIndex = sUrl.IndexOf('?');
            if (iIndex < 0)
                sUrl += "?";
            else if (iIndex < (sUrl.Length - 1))
                sUrl += "&";
            return string.Format("{0}ReturnUrl={1}", sUrl, HttpUtility.UrlEncode(p_sReturnUrl));
        }
    }
}