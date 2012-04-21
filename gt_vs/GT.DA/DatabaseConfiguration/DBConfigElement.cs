using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;

namespace GT.DA.DatabaseConfiguration
{
    public class DBConfigElement : NamedConfigurationElement
    {
        private const string BROKER_TOKEN = "enableBroker";
        
        public DBConfigElement()
        {
        }

        public DBConfigElement(string p_sDatabaseName, bool p_bEnableBroker)
        {
            Name = p_sDatabaseName;
            EnableBroker = p_bEnableBroker;
        }

        [ConfigurationProperty(BROKER_TOKEN, IsRequired = true)]
        public bool EnableBroker
        {
            get { return (bool) this[BROKER_TOKEN]; }
            set { this[BROKER_TOKEN] = value; }
        }
    }
}