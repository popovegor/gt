using System.Configuration;
using Microsoft.Practices.EnterpriseLibrary.Common.Configuration;

namespace GT.DA.DatabaseConfiguration
{
    public class DatabaseSectionHandler : ConfigurationSection
    {
        private const string COLLECTION_NAME = "databases";
        public const string SECTION_NAME = "databaseConfiguration";

        [ConfigurationProperty(COLLECTION_NAME, IsRequired = false)]
        public NamedElementCollection<DBConfigElement> DataBases
        {
            get { return (NamedElementCollection<DBConfigElement>) base[COLLECTION_NAME]; }
        }
    }
}