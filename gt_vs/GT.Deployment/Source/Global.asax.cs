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
      if (Context.Request.Cookies[CookiesFields.CULTURE] != null)
      {
        Thread.CurrentThread.CurrentCulture = new CultureInfo(Context.Request.Cookies[CookiesFields.CULTURE].Value);
        Thread.CurrentThread.CurrentUICulture = new CultureInfo(Context.Request.Cookies[CookiesFields.CULTURE].Value);
      }
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