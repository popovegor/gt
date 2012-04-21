using System.Configuration;

namespace GT.Common.Configuration
{
    public abstract class CredentialsSectionBase : ConfigurationElement
    {
        public const string DOMAIN_TOKEN = "domain";
        public const string PASSWORD_TOKEN = "password";
        public const string USER_NAME_TOKEN = "userName";

        public static bool IsNullOrEmpty(CredentialsSectionBase p_cred)
        {
            return !(p_cred != null && !p_cred.IsEmpty);
        }

        public CredentialsSectionBase()
        {
        }

        public CredentialsSectionBase(string p_sUserName, string p_sPassword, string p_sDomain)
        {
            UserName = p_sUserName;
            Password = p_sPassword;
            Domain = p_sDomain;
        }

        public virtual bool IsEmpty
        {
            get
            {
                return string.IsNullOrEmpty(UserName) &&
                       string.IsNullOrEmpty(Password) &&
                       string.IsNullOrEmpty(Domain);
            }
        }

        [ConfigurationProperty(USER_NAME_TOKEN, DefaultValue = "", IsRequired = false)]
        public string UserName
        {
            get { return (string) this[USER_NAME_TOKEN]; }
            set { this[USER_NAME_TOKEN] = value; }
        }

        [ConfigurationProperty(PASSWORD_TOKEN, DefaultValue = "", IsRequired = false)]
        public string Password
        {
            get { return (string) this[PASSWORD_TOKEN]; }
            set { this[PASSWORD_TOKEN] = value; }
        }

        [ConfigurationProperty(DOMAIN_TOKEN, DefaultValue = "", IsRequired = false)]
        public string Domain
        {
            get { return (string) this[DOMAIN_TOKEN]; }
            set { this[DOMAIN_TOKEN] = value; }
        }
    }
}