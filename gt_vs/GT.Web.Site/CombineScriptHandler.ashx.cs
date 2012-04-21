using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using GT.Common;

namespace GT.Web.Site
{
  public class CombineScriptHandler : IHttpHandler
  {
    public void ProcessRequest(HttpContext context)
    {
      if (!AjaxControlToolkit.ToolkitScriptManager.OutputCombinedScriptFile(context))
      {
        AssistLogger.WriteTraceInformation("ToolkitScriptManager.OutputCombinedScriptFile failed.", AssistLogger.Category.General.ToString());
      }
    }

    public bool IsReusable
    {
      get { return true; }
    }
  }
}
