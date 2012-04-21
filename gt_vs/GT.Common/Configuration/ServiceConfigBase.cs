using System.Configuration;

namespace GT.Common.Configuration
{
    public abstract class ServiceConfigBase : ConfigurationSection
    {
        public const string SECTION_NAME = "serviceConfig";

        public abstract string SectionGroupName { get; }

        [ConfigurationProperty("Proxy")]
        public ProxyConfiguration Proxy
        {
            get { return (ProxyConfiguration) this["Proxy"]; }
            set { this["Proxy"] = value; }
        }

        public static ServiceConfigBase GetServiceConfig(string p_sSectionGroupName)
        {
            if (!string.IsNullOrEmpty(p_sSectionGroupName))
                return
                    (ServiceConfigBase)
                    ConfigurationManager.GetSection(string.Format("{0}/{1}", p_sSectionGroupName, SECTION_NAME));
            return (ServiceConfigBase)
                   ConfigurationManager.GetSection(SECTION_NAME);
        }
    }
}