using System.Web;
using System.Web.Services;
using GT.Web.Security;

namespace GT.Web.Services
{
    public class BaseWebService : WebService
    {
        private CredentialsInformation _credentials = null;

        public BaseWebService()
        {
            if (HttpContext.Current != null && HttpContext.Current.User != null)
            {
                _credentials = new CredentialsInformation(User ?? HttpContext.Current.User);
            }
        }

        public CredentialsInformation Credentials
        {
            get
            {
                return _credentials;
            }
            set
            {
                _credentials = value;
            }
        }
    }
}
