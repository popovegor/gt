using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace GT.Common.Web.ControlUtils
{
    public class Controls
    {
        public const string ON_CLICK = "onclick";
        public const string ON_CLIENT_CLICK = "OnClientClick";

        public static void AddAttribute(Control p_ctl, string p_sAttributeName, string p_sAttributeValue)
        {
            AddAttribute(p_ctl, p_sAttributeName, p_sAttributeValue, true, true);
        }

        public static void AddAttribute(Control p_ctl, string p_sAttributeName, string p_sAttributeValue, 
            bool p_bCheckIfExists, bool p_bAppendExisting)
        {
            if (p_ctl != null)
            {
                string sValue = GetAttribute(p_ctl, p_sAttributeName);
                SetAttribute(p_ctl, p_sAttributeName, MakeAttributeValue(sValue, p_sAttributeValue, p_bCheckIfExists,
                                                                         p_bAppendExisting));
            }
        }

        public static void AddOnClientClick(Control p_ctl, string p_sScript)
        {
            AddOnClientClick(p_ctl, p_sScript, true, true);
        }

        public static void AddOnClientClick(Control p_ctl, string p_sScript,
            bool p_bCheckIfExists, bool p_bAppendExisting)
        {
            if (p_ctl != null && 
                p_ctl is IButtonControl)
            {
                string sValue = Types.TypeConverter.ToString(Reflection.ReflectionHelper.GetPropertyValue(p_ctl, ON_CLIENT_CLICK));
                Reflection.ReflectionHelper.SetPropertyValue(p_ctl, ON_CLIENT_CLICK,
                                                            MakeAttributeValue(sValue, p_sScript,
                                                                               p_bCheckIfExists, p_bAppendExisting));
            }
            else
                AddAttribute(p_ctl, ON_CLICK, p_sScript);
        }

        public static string GetOnClientClick(Control p_ctl)
        {
            if (p_ctl != null &&
                p_ctl is IButtonControl)
                return Types.TypeConverter.ToString(Reflection.ReflectionHelper.GetPropertyValue(p_ctl, ON_CLIENT_CLICK));
            else
                return GetAttribute(p_ctl, ON_CLICK);
        }

        private static string MakeAttributeValue(string p_sOldValue, string p_sNewValue, 
            bool p_bCheckIfExists, bool p_bAppendExisting)
        {
            if (!string.IsNullOrEmpty(p_sOldValue) &&
                !(p_bCheckIfExists && p_sOldValue.IndexOf(p_sNewValue) != -1) &&
                p_bAppendExisting)
                p_sOldValue = p_sNewValue + p_sOldValue;
            else
                p_sOldValue = p_sNewValue;
            return p_sOldValue;
        }

        public static string GetAttribute(Control p_ctl, string p_sAttributeName)
        {
            if (p_ctl is WebControl)
                return ((WebControl)p_ctl).Attributes[p_sAttributeName];
            else if (p_ctl is HtmlControl)
                return ((HtmlControl)p_ctl).Attributes[p_sAttributeName];
            return string.Empty;
        }

        public static void SetAttribute(Control p_ctl, string p_sAttributeName,
            string p_sAttributeValue)
        {
            if (p_ctl is WebControl)
                ((WebControl)p_ctl).Attributes[p_sAttributeName] = p_sAttributeValue;
            else if (p_ctl is HtmlControl)
                ((HtmlControl)p_ctl).Attributes[p_sAttributeName] = p_sAttributeValue;
        }

    }
}
