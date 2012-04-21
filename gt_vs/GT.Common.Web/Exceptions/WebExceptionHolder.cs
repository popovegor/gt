using System;
using System.Web;
using GT.Common.Exceptions;

namespace GT.Common.Web.Exceptions
{
    public class WebExceptionHolder : ExceptionHolder
    {
        public WebExceptionHolder(Exception p_ex) : base(p_ex)
        {
        }

        public string Path
        {
            get { return Data["PathInfo"].ToString(); }
        }

        protected override void FillExtendedProperties()
        {
            base.FillExtendedProperties();
            if (m_InnerException.GetType() == typeof(HttpUnhandledException) &&
                InnerException != null)
            {
                string sCode = InnerException.Message.GetHashCode().ToString();
                sCode = (sCode.Length > 4) ? sCode.Substring(0, 4) : sCode;
                Data["Code"] = sCode;
            }
            if (HttpContext.Current != null)
            {
                Data.Add("RawUrl", HttpContext.Current.Request.RawUrl);
                Data.Add("AbsoluteUri", HttpContext.Current.Request.Url.AbsoluteUri);
                Data.Add("PathInfo", HttpContext.Current.Request.RawUrl);
                Data.Add("Browser", HttpContext.Current.Request.UserAgent);
                Data.Add("UrlReferrer", (HttpContext.Current.Request.UrlReferrer != null) ? 
                    HttpContext.Current.Request.UrlReferrer.AbsoluteUri : string.Empty);
                Data.Add("UserHostAddress", HttpContext.Current.Request.UserHostAddress);
            }
        }
    }
}