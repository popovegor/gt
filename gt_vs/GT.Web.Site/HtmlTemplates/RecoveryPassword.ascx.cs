using System;

namespace GT.Web.Site.HtmlTemplates
{
    public partial class RecoveryPassword : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private string m_sLogin = string.Empty;
        public string Login
        {
            get { return m_sLogin; }
            set { m_sLogin = value; }
        }

        private string m_sPassword = string.Empty;
        public string Password
        {
            get { return m_sPassword; }
            set { m_sPassword = value; }
        }
    }
}