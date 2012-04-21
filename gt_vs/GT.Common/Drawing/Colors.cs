using System.Drawing;

namespace GT.Common.Drawing
{
    public class Colors
    {
        public static string ColorString(Color p_color)
        {
            return p_color.ToArgb().ToString("x").Substring(2);
        }

        public static string HtmlColorString(Color p_color)
        {
            return "#" + ColorString(p_color);
        }

        public static Color FromColorString(string p_sColor)
        {
            if (!string.IsNullOrEmpty(p_sColor))
            {
                p_sColor = p_sColor.Trim();
                if (!p_sColor.StartsWith("#"))
                    p_sColor = "#" + p_sColor;
                try
                {
                    return ColorTranslator.FromHtml(p_sColor);
                }
                catch
                {
                }
            }
            return Color.Empty;
        }
    }
}