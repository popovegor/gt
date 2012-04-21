using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Configuration;
using NUnit.Framework;
using System.Diagnostics;
using GT.Global.Cookies;

namespace GT.Common.Web.Cookie
{
  public static class Cookies
  {
    private static CookiesConfigurationElementCollection _cookies = null;

    static Cookies()
    {
      _cookies = (ConfigurationManager.GetSection(CookiesConfigurationSection.SectionName) 
        as CookiesConfigurationSection).Cookies;
    }

    public static void SetTimeZoneId(this HttpContext context, string timeZoneId)
    {
      if(string.IsNullOrEmpty(timeZoneId) == false)
      {
        var config = _cookies[CookiesKeys.TimeZone];
        context.UpsertCookie(config.Name, timeZoneId, DateTime.Now.AddMinutes(config.ExpirationInMinutes));
      }
    }

    public static string GetTimeZoneId(this HttpContext context)
    {
      string tz = string.Empty;
      tz = context.GetCookie(_cookies[CookiesKeys.TimeZone].Name);
      return tz;
    }
  }
}
