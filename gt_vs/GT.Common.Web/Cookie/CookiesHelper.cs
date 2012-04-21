using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using GT.Common.Exceptions;

namespace GT.Common.Web.Cookie
{
  public static class CookiesHelper
  {
    public static bool ClearCookie(this HttpContext context, string name)
    {
      return context.UpsertCookie(name, string.Empty, DateTime.Now.AddDays(-10));
    }

    public static bool UpsertCookie(this HttpContext context, string name, string value, DateTime expirationDate)
    {
      var c = ((null != context.Request) ? context.Request.Cookies.Get(name) : null)
              ?? new HttpCookie(name);

      c.Value = value;
      c.Expires = expirationDate;

      if (null != context.Response)
      {
        context.Response.SetCookie(c);
        return true;
      }
      else
      {
        GT.Common.AssistLogger.Log<ExceptionHolder>(new NullReferenceException());
      }

      return false;
    }

    public static string GetCookie(this HttpContext context, string name)
    {
      if (null != context.Request)
      {
        HttpCookie c = context.Request.Cookies.Get(name);
        if (null != c)
        {
          return c.Value;
        }
      }
      else
      {
        GT.Common.AssistLogger.Log<ExceptionHolder>(new NullReferenceException());
      }
      return string.Empty;
    }
  }
}
