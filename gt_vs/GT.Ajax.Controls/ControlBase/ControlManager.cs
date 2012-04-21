using System;
using System.IO;
using System.Reflection;
using System.Web;
using System.Web.UI;
using GT.Common.Web.WebUtils;

namespace GT.Ajax.Controls.ControlBase
{
  public enum ControlResourceType
  {
    Css,
    Js
  }

  public class ControlManager
  {
    private Control m_ctlOwner;

    private Browser m_browser;
    private ScriptManager m_ScriptManager;
    private string m_sDefaultStyle = string.Empty;

    public ControlManager(Control p_ctl)
      : this(p_ctl, true)
    {
    }

    public ControlManager(Control p_ctl, bool p_bAttachEvents)
    {
      m_ctlOwner = p_ctl;
      if (p_bAttachEvents)
      {
        if (m_ctlOwner.Page != null)
          m_ctlOwner.Page.PreRender += Page_PreRender;
        else
          m_ctlOwner.Load += m_ctlOwner_Load;
      }
    }

    public Browser Browser
    {
      get
      {
        if (m_browser == null)
          m_browser = Browser.Create(m_ctlOwner.Page.Request, m_ctlOwner.Page.Session);
        return m_browser;
      }
    }

    public ScriptManager ScriptManager
    {
      get
      {
        EnsureScriptManager();
        return m_ScriptManager;
      }
    }

    public string DefaultStyle
    {
      get
      {
        if (m_sDefaultStyle == string.Empty)
          m_sDefaultStyle = GetControlResource(ControlResourceType.Css);
        return m_sDefaultStyle;
      }
    }

    public void RenderScripts()
    {
      ScriptReference scr = GetDefaultReference();
      if (scr != null)
        ScriptManager.Scripts.Add(scr);

      if (m_ctlOwner is IGTAjaxControl)
      {
        string sScript = ((IGTAjaxControl)m_ctlOwner).GetInitScriptCall();
        if (!string.IsNullOrEmpty(sScript))
          ScriptManager.RegisterStartupScript(m_ctlOwner.Page, m_ctlOwner.GetType(),
                                              m_ctlOwner.ID + "_InitScript",
                                              sScript, true);
      }
    }

    public string GetCombinedID(string p_sChildControlID)
    {
      return string.Format("{0}_{1}", m_ctlOwner.ID, p_sChildControlID);
    }

    public string GetControlResource(ControlResourceType p_type)
    {
      string sResource = string.Empty;
      try
      {
        using (StreamReader sr =
            new StreamReader(Assembly.GetExecutingAssembly().GetManifestResourceStream(
                                 GetResourceName(p_type))))
        {
          sResource = sr.ReadToEnd();
        }
      }
      catch
      {
      }
      return sResource;
    }

    public ScriptReference GetDefaultReference()
    {
      string sScript = GetResourceName(ControlResourceType.Js);
      if (!string.IsNullOrEmpty(sScript) &&
          Assembly.GetExecutingAssembly().GetManifestResourceInfo(sScript) != null)
        return new ScriptReference(sScript, Assembly.GetExecutingAssembly().GetName().Name);
      return null;
    }

    public ScriptManager EnsureScriptManager()
    {
      if (m_ScriptManager == null)
        m_ScriptManager = ScriptManager.GetCurrent(m_ctlOwner.Page);
      if (m_ScriptManager == null)
        throw new HttpException("Script Manager not found on current page!");
      return m_ScriptManager;
    }

    public void RegisterClientScriptResource(string p_sResourceName)
    {
      ScriptManager.RegisterClientScriptResource(m_ctlOwner, m_ctlOwner.GetType(),
          string.Format("{0}.{1}", Assembly.GetExecutingAssembly().GetName().Name,
                           p_sResourceName));
    }

    private string GetResourceName(ControlResourceType p_type)
    {
      string sResourceExtension = p_type.ToString().ToLower();
      return string.Format("{0}.{1}.{2}", Assembly.GetExecutingAssembly().GetName().Name,
                           m_ctlOwner.GetType().Name, sResourceExtension);
    }

    private void m_ctlOwner_Load(object sender, EventArgs e)
    {
      m_ctlOwner.Page.PreRender += new EventHandler(Page_PreRender);
      m_ctlOwner.PreRender += new EventHandler(Page_PreRender);
    }

    private void Page_PreRender(object sender, EventArgs e)
    {
      /*if (m_ctlOwner.Visible &&
          JSEnabled)*/
      RenderScripts();
    }
  }
}