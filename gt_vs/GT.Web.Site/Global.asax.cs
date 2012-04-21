using System;
using GT.Common;
using GT.Common.Web.Exceptions;
using System.Threading;
using GT.Global.Cookies;
using System.Diagnostics;
using GT.ImageGenerator;
using GT.Common.Exceptions;
using System.Globalization;
using System.Web;
using GT.Common.Web.Cookie;
using GT.Common.Types;
using GT.BO.Implementation.MessageSystem;
using GT.Web.Site.Notification;

namespace GT.Web.Site
{
  public class Global : System.Web.HttpApplication
  {
    public override string GetVaryByCustomString(HttpContext context, string arg)
    {
      if (arg == "culture")
      {
        return context.GetCookie(GT.Global.Cookies.CookiesFields.CULTURE);
      }
      return string.Empty;
    }

    public void OnUnhandledException(object o, UnhandledExceptionEventArgs e)
    {
      Exception ex = e.ExceptionObject as Exception;
      if (null != ex)
      {
        throw GT.Common.AssistLogger.Log<ExceptionHolder>(ex);
      }
      else
      {
        throw new NullReferenceException((o ?? string.Empty).ToString());
      }
    }

    protected void Application_Start(object sender, EventArgs e)
    {
      AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(OnUnhandledException);

      GT.Common.AssistLogger.WriteInformation("Application load start.", GT.Common.AssistLogger.Category.General);

      var sw = new Stopwatch();
      sw.Start();
      try
      {
        GeneratedImageManager.InitializeCache();
        GT.Ajax.Controls.FileUploader.Initialize();
        MessageFacade.NotificationSender = new NotificationSender();
        sw.Stop();
      }
      catch (Exception ex)
      {
        GT.Common.AssistLogger.Log<ExceptionHolder>(ex, GT.Common.AssistLogger.Category.Cache);
      }
      GT.Common.AssistLogger.WriteInformation(string.Format("Application load finish. Elapsed time: {0} ms", sw.ElapsedMilliseconds)
        , GT.Common.AssistLogger.Category.General);
    }

    protected void Session_Start(object sender, EventArgs e)
    {
      // trick
      string sessionId = Session.SessionID;
    }

    protected void Application_BeginRequest(object sender, EventArgs e)
    {
      if (Request.Url.HostNameType == UriHostNameType.Dns)
      {
        int i = Request.Url.Host.LastIndexOf('.');
        if (i > 0 && i < Request.Url.Host.Length - 1)
        {
          string domain = Request.Url.Host.Substring(i + 1);
          switch (domain)
          {
            case "com":
              Thread.CurrentThread.CurrentCulture = new CultureInfo("en-us");
              Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-us");
              return;

            case "cn":
              Thread.CurrentThread.CurrentCulture = new CultureInfo("cn-zh");
              Thread.CurrentThread.CurrentUICulture = new CultureInfo("cn-zh");
              return;
          }
        }
      }

      //Thread.CurrentThread.CurrentCulture = new CultureInfo("en-us");
      //Thread.CurrentThread.CurrentUICulture = new CultureInfo("en-us");
      Thread.CurrentThread.CurrentCulture = new CultureInfo("ru-ru");
      Thread.CurrentThread.CurrentUICulture = new CultureInfo("ru-ru");
    }

    protected void Application_AuthenticateRequest(object sender, EventArgs e)
    {

    }

    protected void Application_Error(object sender, EventArgs e)
    {
      Exception ex = Server.GetLastError();
      if (ex != null)
      {
        Context.AddError(AssistLogger.Log<WebExceptionHolder>(ex));
      }
    }

    protected void Session_End(object sender, EventArgs e)
    {

    }

    protected void Application_End(object sender, EventArgs e)
    {

    }
  }
}