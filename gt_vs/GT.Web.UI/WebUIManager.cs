using System.Configuration;
using GT.Common.Patterns;
using GT.Web.UI.Configuration;

namespace GT.Web.UI
{
    public class WebUIManager : Singleton<WebUIManager>
    {
        private const string WEB_UI_SECTION_NAME = "webUIConfiguration";

        private readonly HtmlTemplateSystemSection m_oHtmlSystemSection;

        public HtmlTemplateSystemSection GetHtmlSystemSection()
        {
            return m_oHtmlSystemSection;
        }

        private string GetSectionPath(string p_sSectionName)
        {
            return string.Format("{0}/{1}", WEB_UI_SECTION_NAME, p_sSectionName);
        }

        private string HtmlSystemSectionPath
        {
            get { return GetSectionPath(HtmlTemplateSystemSection.SECTION_NAME); }
        }

        public WebUIManager()
        {
            m_oHtmlSystemSection =
                (ConfigurationManager.GetSection(HtmlSystemSectionPath) as HtmlTemplateSystemSection);
        }
    }
}
