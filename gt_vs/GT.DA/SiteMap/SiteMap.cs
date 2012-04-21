using System.Data;
using GT.BO.Caching;
using GT.BO.Caching.Loading;
using GT.BO.Caching.Management;
using GT.DA.Caching.Configuration;
using GT.Global.Caching;
using System.Threading;

namespace GT.DA.SiteMap
{
    public class SiteMap : DataSetCache<CacheConfigurator, SiteMapCacheDatabaseProvider, ReadOnlyDataSetCacheManager>
    {
        #region Singleton

        private SiteMap()
        {
        }

        public static SiteMap Instance
        {
            get { return Nested.instance; }
        }

        private class Nested
        {
            internal static readonly SiteMap instance = new SiteMap();

            static Nested()
            {
                instance._configurator = CacheConfigurationManager.GetConfigurationForType(CacheTypes.SiteMap);
                instance._dataSourceProvider = new SiteMapCacheDatabaseProvider();
                instance._manager = new ReadOnlyDataSetCacheManager();
            }
        }

        #endregion

        public const string CHILD_INDEX_COL = "ChildNodesIndex";
        public const string DESCRIPTION_COL_DEFAULT = "Description";
        public const string DESCRIPTION_COL_RU = "DescriptionRu";
        public const string DISPLAY_COL = "Display";
        public const string ID_COL = "ID";
        public const string JS_COL = "JavaScript";
        public const string NODEID_COL = "NodeID";
        public const string PAGE_ID_COL = "PageID";
        public const string PARENT_CHILD_REL = "ParentChild";
        public const string PARENT_COL = "Parent";
        public const string REMAPPING_REL = "Remapping";
        public const string ROLES_COL = "Roles";
        public const string THEME_COL = "ThemeName";
        public const string TITLE_COL_DEFAULT = "Title";
        public const string TITLE_COL_RU = "TitleRu";
        public const string TPL_NAME_COL = "TemplateName";
        public const string URL_COL = "Url";
        public const string KeyWords = "KeyWords";
        public const string KeyWordsRu = "KeyWordsRu";
        public const string PAGE_TITLE = "PageTitle";
        public const string PAGE_TITLE_RU = "PageTitleRu";

        protected override void PrepareData(CacheLoadContext<DataSet> loadContext)
        {
            loadContext.Data.Relations.Add(PARENT_CHILD_REL, new DataColumn[] { loadContext.Data.Tables[0].Columns[ID_COL] },
                               new DataColumn[] { loadContext.Data.Tables[0].Columns[PARENT_COL] }, false);
            loadContext.Data.Relations.Add(REMAPPING_REL, new DataColumn[] { loadContext.Data.Tables[0].Columns[ID_COL] },
                               new DataColumn[] { loadContext.Data.Tables[1].Columns[NODEID_COL] }, false);
        }
    }
}