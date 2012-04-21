using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using GT.Common.Reflection;
using GT.Common.Types;

namespace GT.Common.Web.WebUtils
{
    public static class PageUtils
    {
        public const string BODY_END = "</body>";

        public delegate bool ControlAction(Control p_ctl);

        private static readonly object _lockObject = new object();
        private static readonly Dictionary<string, List<string>> m_cachedControls = new Dictionary<string, List<string>>();

        public static string GetUniqueKey(Page p_page)
        {
            return p_page.Request.Url.ToString().GetHashCode().ToString();
        }

        public static Control FindControlByString(Page p_page, string p_str, out int p_iStrIndex)
        {
            Control ctl = null;
            p_iStrIndex = -1;
            foreach (Control control in p_page.Controls)
            {
                p_iStrIndex = -1;
                if (control != null)
                {
                    if (control is LiteralControl)
                    {
                        string sText = ((LiteralControl) control).Text;
                        if (!string.IsNullOrEmpty(sText))
                        {
                            p_iStrIndex = sText.IndexOf(p_str);
                            if (p_iStrIndex == -1)
                                p_iStrIndex = sText.IndexOf(p_str.ToUpper());
                            if (p_iStrIndex != -1)
                            {
                                ctl = control;
                                break;
                            }
                        }
                    }
                    else if (control is HtmlGenericControl &&
                             ((HtmlGenericControl)control).TagName.ToUpper() == "BODY")
                    {
                        ctl = control;
                        break;
                    }
                }
            }
            return ctl;
        }
        
        

        public static void RewriteScriptReferences(Page p_page)
        {
            List<string> includes = new List<string>();
            ForeachControl<ScriptManager, ScriptManagerProxy>(p_page, delegate(Control p_ctl)
                       {
                           ScriptReferenceCollection scripts = (ScriptReferenceCollection) ReflectionHelper.GetPropertyValue(p_ctl, "Scripts");
                           foreach (ScriptReference script in scripts)
                           {
                               if (
                                   script.Path.StartsWith(
                                       "~"))
                                   script.Path =
                                       script.Path.Substring
                                           (1);
                               if (!includes.Contains(script.Path))
                                   includes.Add(script.Path);
                           }
                           scripts.Clear();
                           if (p_ctl is ScriptManager)
                               ((ScriptManager) p_ctl).LoadScriptsBeforeUI =true;
                           
                           p_page.PreRenderComplete += delegate(object sender,EventArgs e)
                                   {
                                       foreach (string include in includes)
                                       {
                                           if(include.Length > 0)
                                               ScriptManager.RegisterClientScriptInclude(p_page, p_page.GetType(), Guid.NewGuid().ToString(), include);
                                       }
                                       
                                   };
                           return true;
                       });
        }

        public static void ChangeInputClasses(Page p_page)
        {
            ForeachControl<HtmlControl, CheckBox, RadioButton>(p_page, delegate(Control p_ctl)
                                                             {
                                                                 if (p_ctl is HtmlControl)
                                                                 {
                                                                     HtmlControl ctl = (HtmlControl) p_ctl;
                                                                     if (ctl.TagName.ToUpper() == "INPUT")
                                                                     {
                                                                         string sType =
                                                                             TypeConverter.ToString(
                                                                                 ctl.Attributes["type"]);
                                                                         if (!string.IsNullOrEmpty(sType))
                                                                         {
                                                                             string sClass =
                                                                                 TypeConverter.ToString(
                                                                                     ctl.Attributes["class"]);
                                                                             sClass += (sClass.Length > 0
                                                                                            ? " "
                                                                                            : string.Empty) + sType;
                                                                             ctl.Attributes["class"] = sClass;
                                                                         }
                                                                     }
                                                                 }
                                                                 else
                                                                 {
                                                                     string sClass = string.Empty;
                                                                     if (p_ctl is CheckBox)
                                                                         sClass = "checkbox";
                                                                     else if (p_ctl is RadioButton)
                                                                         sClass = "radio";
                                                                     string sCssClass =
                                                                                 TypeConverter.ToString(
                                                                                     ((WebControl)p_ctl).CssClass);
                                                                             sCssClass += (sCssClass.Length > 0
                                                                                            ? " "
                                                                                            : string.Empty) + sClass;
                                                                             ((WebControl)p_ctl).CssClass = sCssClass;
                                                                 }
                                                                 return true;
                                                             });
        }

        public static void ForeachControl<T>(Page p_page, ControlAction p_delegate)
                where T : Control
        {
            string sKey = GetUniqueKey(p_page);
            ForeachControl<T>(sKey, p_page, p_delegate);
        }

        public static void ForeachControl<T, U>(Page p_page, ControlAction p_delegate)
            where T : Control
            where U : Control
        {
            string sKey = GetUniqueKey(p_page);
            ForeachControl<T, U>(sKey, p_page, p_delegate);
        }

        public static void ForeachControl<T, U, V>(Page p_page, ControlAction p_delegate)
            where T : Control
            where U : Control
            where V : Control
        {
            string sKey = GetUniqueKey(p_page);
            ForeachControl<T, U, V>(sKey, p_page, p_delegate);
        }

        public static void ForeachControl(Page p_page, ControlAction p_delegate)
        {
            string sKey = GetUniqueKey(p_page);
            ForeachControl(sKey, p_page, p_delegate);
        }

        public static void ForeachControl<T>(string p_sUniqueKey, Control p_control, ControlAction p_delegate)
                where T : Control
        {
            foreach (Control control in GetControls<T>(p_sUniqueKey, p_control))
                if (!p_delegate(control))
                    break;
        }

        public static void ForeachControl<T, U>(string p_sUniqueKey, Control p_control, ControlAction p_delegate)
            where T : Control
            where U : Control
        {
            foreach (Control control in GetControls<T, U>(p_sUniqueKey, p_control))
                if (!p_delegate(control))
                    break;
        }

        public static void ForeachControl<T, U, V>(string p_sUniqueKey, Control p_control, ControlAction p_delegate)
            where T : Control
            where U : Control
            where V : Control
        {
            foreach (Control control in GetControls<T, U, V>(p_sUniqueKey, p_control))
                if (!p_delegate(control))
                    break;
        }

        public static void ForeachControl(string p_sUniqueKey, Control p_control, ControlAction p_delegate)
        {
            foreach (Control control in GetControls(p_sUniqueKey, p_control))
                if (!p_delegate(control))
                    break;
        }

        private static IEnumerable<Control> GetControls<T>(string p_sUniqueKey, Control p_control)
            where T : Control
        {
            ICollection<string> controlIDs = GetControlList(p_sUniqueKey, p_control);
            foreach (string controlID in controlIDs)
            {
                Control ctl = p_control.FindControl(controlID);
                if (ctl != null &&
                    ctl is T)
                    yield return ctl;
            }
        }

        private static IEnumerable<Control> GetControls<T, U, V>(string p_sUniqueKey, Control p_control)
            where T : Control 
            where U : Control
            where V: Control
        {
            ICollection<string> controlIDs = GetControlList(p_sUniqueKey, p_control);
            foreach (string controlID in controlIDs)
            {
                Control ctl = p_control.FindControl(controlID);
                if (ctl != null &&
                    (ctl is T || ctl is U || ctl is V) )
                    yield return ctl;
            }
        }

        private static IEnumerable<Control> GetControls<T, U>(string p_sUniqueKey, Control p_control)
            where T : Control
            where U : Control
        {
            ICollection<string> controlIDs = GetControlList(p_sUniqueKey, p_control);
            foreach (string controlID in controlIDs)
            {
                Control ctl = p_control.FindControl(controlID);
                if (ctl != null &&
                    (ctl is T || ctl is U))
                    yield return ctl;
            }
        }

        private static IEnumerable<Control> GetControls(string p_sUniqueKey, Control p_control)
        {
            ICollection<string> controlIDs = GetControlList(p_sUniqueKey, p_control);
            foreach (string controlID in controlIDs)
            {
                Control ctl = p_control.FindControl(controlID);
                if (ctl != null)
                    yield return p_control.FindControl(controlID);
            }
        }

        private static ICollection<string> GetControlList(string p_sUniqueKey, Control p_control)
        {
            List<string> controlIDs = null;
            if (!m_cachedControls.TryGetValue(p_sUniqueKey, out controlIDs))
                lock(_lockObject)
                    if (!m_cachedControls.TryGetValue(p_sUniqueKey, out controlIDs))
                    {
                        controlIDs = new List<string>();
                        GetControlList(p_control, controlIDs);
                        m_cachedControls.Add(p_sUniqueKey, controlIDs);
                    }
            return controlIDs;
        }

        private static void GetControlList(Control p_control, ICollection<string> p_controlIDs)
        {
            foreach (Control c in p_control.Controls)
            {
                p_controlIDs.Add(c.UniqueID);
                if (c.Controls.Count > 0)
                    GetControlList(c, p_controlIDs);
            }
        }
    }
}