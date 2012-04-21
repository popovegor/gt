using System.Configuration;

namespace GT.Web.UI.Configuration
{
    public class HtmlTemplateSystemSection : ConfigurationSection
    {
        public const string SECTION_NAME = "htmlTemplateSystem";

        private const string HTML_TEMPLATES_PATH_TOKEN = "htmlTemplatesPath";
        
        public HtmlTemplateSystemSection()
        {
        }

        public HtmlTemplateSystemSection(string p_sHtmlTemplatesPath)
        {
            HtmlTemplatesPath = p_sHtmlTemplatesPath;
        }

        [ConfigurationProperty(HTML_TEMPLATES_PATH_TOKEN, IsRequired = true)]
        public string HtmlTemplatesPath
        {
            get { return (string)this[HTML_TEMPLATES_PATH_TOKEN]; }
            set { this[HTML_TEMPLATES_PATH_TOKEN] = value; }
        }
    }
}
