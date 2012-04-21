using System.Web;
using System.Web.SessionState;

namespace GT.Common.Web.WebUtils
{
    public class SessionUtils
    {
        public static HttpSessionState CurrentSession
        {
            get
            {
                HttpSessionState session = null;
                try
                {
                    if (HttpContext.Current != null)
                        return HttpContext.Current.Session;
                }
                catch
                {}
                return session;
            }
        }
    }
}
