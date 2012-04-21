using System.Configuration;

namespace GT.BO.Implementation.Payments.Configuration
{
    public class WebMoneySectionHandler : ConfigurationSection
    {
        private const string SELLER_PURSE = "purse";
        private const string SECRET_KEY = "key";

        public const string SECTION_NAME = "webMoneyConfig";

        [ConfigurationProperty(SELLER_PURSE, IsRequired = true)]
        public string Purse
        {
            get { return (string)this[SELLER_PURSE]; }
            set { this[SELLER_PURSE] = value; }
        }

        [ConfigurationProperty(SECRET_KEY, IsRequired = true)]
        public string Key
        {
            get { return (string)this[SECRET_KEY]; }
            set { this[SECRET_KEY] = value; }
        }
    }
}