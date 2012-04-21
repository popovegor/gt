using System;

namespace GT.Web.Site.HtmlTemplates
{
    public partial class ChangeEmailConfirmation : System.Web.UI.UserControl
    {
        string m_Email;
        public string Email
        {
            get { return m_Email; }
            set { m_Email = value; }
        }

        string m_Code;
        public string Code
        {
            get { return m_Code; }
            set { m_Code = value; }
        }

        string m_Checker;
        public string Checker
        {
            get { return m_Checker; }
            set { m_Checker = value; }
        }

        string m_Host;
        public string Host
        {
            get
            {
                return m_Host;
            }
            set
            {
                m_Host = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}