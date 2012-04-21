using System;
using System.Reflection;
using System.Web;
using GT.Common.Web.Exceptions;

namespace GT.Common.Web.WebUtils
{
    public static class CacheUtils
    {
        public static bool IsResponseCached(HttpResponse p_response)
        {
            try
            {
                bool bHasCachePolicy =
                    (bool)
                    typeof (HttpResponse).InvokeMember("HasCachePolicy",
                                                       BindingFlags.Instance | BindingFlags.GetProperty |
                                                       BindingFlags.NonPublic | BindingFlags.DeclaredOnly, null,
                                                       p_response,
                                                       null);
                HttpCacheability cacheability =
                    (HttpCacheability)
                    typeof (HttpCachePolicy).InvokeMember("GetCacheability",
                                                          BindingFlags.Instance | BindingFlags.NonPublic |
                                                          BindingFlags.InvokeMethod, null, p_response.Cache, null);
                return bHasCachePolicy && (cacheability != (HttpCacheability.Public | HttpCacheability.Private));
            }
            catch (Exception e)
            {
                AssistLogger.Log<WebExceptionHolder>(e);
            }
            return false;
        }
    }
}