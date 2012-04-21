using System;
using System.Web.UI;
using GT.Global.Cookies;

namespace GT.Web.Site.MasterPages
{
    public partial class StandardPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString[GT.Global.Masters.StandartMasterQueries.LANGUAGE] != null)
            {
                SetLanguage(Request.QueryString[GT.Global.Masters.StandartMasterQueries.LANGUAGE]);
            }
        }

        protected string GetLanguageUrl()
        {
            if (Request.QueryString.Count == 0)
            {
                return String.Format("{0}?{1}=", Request.Url.PathAndQuery, GT.Global.Masters.StandartMasterQueries.LANGUAGE);
            }
            else
            {
                return String.Format("{0}&{1}=", Request.Url.PathAndQuery, GT.Global.Masters.StandartMasterQueries.LANGUAGE);
            }
        }

        protected void SetLanguage(string language)
        {
            switch (language)
            {
                case "ru":
                    Response.Cookies[CookiesFields.CULTURE].Value = "ru-ru";
                    break;
                    
                case "en":
                    Response.Cookies[CookiesFields.CULTURE].Value = "en-us";
                    break;

                case "cn":
                    Response.Cookies[CookiesFields.CULTURE].Value = "zh-cn";
                    break;
            }

            string url = Request.Url.ToString();
            string forRemove = String.Format("{0}={1}", GT.Global.Masters.StandartMasterQueries.LANGUAGE, language);
            Response.Redirect(url.Remove(url.IndexOf(forRemove) - 1, forRemove.Length + 1));
        }

        public bool LoginIsShown
        {
            get
            {
                return login.Visible;
            }
            set
            {
                login.Visible = value;
            }
        }
    }
}
