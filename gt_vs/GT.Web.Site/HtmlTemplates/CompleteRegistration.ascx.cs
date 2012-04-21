using System;

namespace GT.Web.Site.HtmlTemplates
{
	public partial class CompleteRegistration : System.Web.UI.UserControl
	{

		private string m_sLogin = string.Empty;
		public string Login
		{
			get { return m_sLogin;}
			set { m_sLogin = value; }
		}

		private string m_sPassword = string.Empty;
		public string Password
		{
			get { return m_sPassword; }
			set { m_sPassword = value; }
		}

        private string m_sCode = String.Empty;
        public string Code
        {
            get { return m_sCode; }
            set { m_sCode = value; }
        }

        private string m_Host;
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

		protected void Page_Load( object sender, EventArgs e )
		{
		}
	}
}