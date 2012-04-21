using System;
using System.IO;
using System.Text;
using System.Web;
using System.Web.UI;

namespace GT.Web.UI.HtmlTemplateSystem
{
    public class HtmlTemplate<TemplateType>
    where TemplateType : Control
    {

        #region Consts
        public const string TEMPLATE_PATH_FORMAT = @"{0}{1}.ascx";
        #endregion

        #region Properties & Members
        private string m_sTemplatePath = string.Empty;
        public string TemplatePath
        {
            get { return m_sTemplatePath; }
            protected set { m_sTemplatePath = value; }
        }

        private TemplateType m_oTemplate = null;
        public TemplateType Template
        {
            get { return m_oTemplate; }
            protected set { m_oTemplate = value; }
        }
        #endregion

        #region Constructors
        private HtmlTemplate(string p_sTemplatePath)
        {
            m_sTemplatePath = p_sTemplatePath;
            m_oTemplate = LoadTemplate();
        }

        public HtmlTemplate()
            : this(GetHtmlTemplatePath())
        { }
        #endregion

        private static string GetHtmlTemplatePath()
        {
            return string.Format(TEMPLATE_PATH_FORMAT,
                VirtualPathUtility.AppendTrailingSlash(WebUIManager.Instance.GetHtmlSystemSection().HtmlTemplatesPath),
                (typeof(TemplateType) as Type).Name);

        }

        protected TemplateType LoadTemplate()
        {
            Page oWebPage = new Page();
            return (TemplateType)oWebPage.LoadControl(TemplatePath);
        }

        public string GenerateHtml()
        {
            StringBuilder sb = new StringBuilder();
            using (StringWriter sw = new StringWriter(sb))
            {
                using (HtmlTextWriter htw = new HtmlTextWriter(sw))
                {
                    m_oTemplate.DataBind();
                    m_oTemplate.RenderControl(htw);
                }
            }
            return sb.ToString();
        }
    }
}
