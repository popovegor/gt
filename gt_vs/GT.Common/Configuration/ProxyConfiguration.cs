using System.Configuration;

namespace GT.Common.Configuration
{
    public class ProxyConfiguration : CredentialsSectionBase
    {
        public const string URL_TOKEN = "url";

        public ProxyConfiguration()
        {
        }

        public ProxyConfiguration(string p_sUrl, string p_sUserName, string p_sPassword, string p_sDomain)
            : base (p_sUserName, p_sPassword, p_sDomain)
        {
            Url = p_sUrl;
        }

        public override bool IsEmpty
        {
            get
            {
                return base.IsEmpty &&
                       string.IsNullOrEmpty(Url);
            }
        }

        [ConfigurationProperty(URL_TOKEN, DefaultValue = "",
            IsRequired = true)]
        [StringValidator(InvalidCharacters = "\"#$%&'*,;<>?[^`{|} ")]
        public string Url
        {
            get { return (string) this[URL_TOKEN]; }
            set { this[URL_TOKEN] = value; }
        }
    }
}