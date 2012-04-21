using System;

namespace GT.Web.Site.Authentication
{
    public partial class SignInControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        string m_Css;
        public string CssClass
        {
            get
            {
                return m_Css;
            }
            set
            {
                m_Css = value;
            }
        }
    }
}