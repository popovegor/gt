using System;
using GT.DA.Dictionaries;
using GT.Web.Security;
using GT.Common.Types;
using System.Web;
using GT.Common.Web.Cookie;


namespace GT.BO.Implementation.Helpers
{
  public static class DateTimeHelper
  {
    public static string UtcToLocal(this DateTime date, string format)
    {
      return date.UtcToLocal().ToString(format);
    }
  
    public static DateTime UtcToLocal(this DateTime date)
    {
      DateTime d = date;
      if (HttpContext.Current != null)
      {
        d = UtcToLocal(date, HttpContext.Current);
      }
      return d;
    }

    public static DateTime UtcToLocal(this DateTime date, HttpContext context)
    {
      DateTime d = date;
      var tz = GetTimeZoneInfo(context);
      d = ConvertTime(date, tz);
      return d;
    }

    private static DateTime UtcToLocal(this DateTime date, CredentialsInformation credentials)
    {
      DateTime d = date;
      var tz = GetTimeZoneInfo(credentials);
      d = ConvertTime(date, tz);
      return d;
    }

    public static DateTime UtcToLocal(this DateTime date, int timeZoneId)
    {
      DateTime d = date;
      var tz = Dictionaries.Instance.GetTimeZoneInfoById(timeZoneId);
      d = ConvertTime(date, tz);
      return d;
    }

    private static DateTime ConvertTime(DateTime date, TimeZoneInfo tz)
    {
      DateTime d = date;
      if (null != tz)
      {
        switch (date.Kind)
        {
          case DateTimeKind.Utc:
          case DateTimeKind.Unspecified:
            d = TimeZoneInfo.ConvertTimeFromUtc(date, tz);
            break;
          case DateTimeKind.Local:
            d = TimeZoneInfo.ConvertTime(date, tz);
            break;
        }
      }
      return d;
    }

    private static TimeZoneInfo GetTimeZoneInfo(CredentialsInformation credentials)
    {
      TimeZoneInfo tz = null;
      if (credentials != null && credentials.Profile != null && string.IsNullOrEmpty(credentials.Profile.TimeZone) == false)
      {
        int timeZoneId = TypeConverter.ToInt32(credentials.Profile.TimeZone, int.MinValue);
        if (timeZoneId != int.MinValue)
        {
          tz = Dictionaries.Instance.GetTimeZoneInfoById(timeZoneId);
        }
      }
      return tz;
    }

    private static TimeZoneInfo GetTimeZoneInfo(HttpContext context)
    {
      TimeZoneInfo tz = null;
      if (context != null)
      {
        tz = GetTimeZoneInfo(new CredentialsInformation(context));
        if (null == tz)
        {
          int timeZoneId = TypeConverter.ToInt32(context.GetTimeZoneId(), int.MinValue);
          if (timeZoneId != int.MinValue)
          {
            tz = Dictionaries.Instance.GetTimeZoneInfoById(timeZoneId);
          }
        }
      }
      return tz;
    }
  }
}