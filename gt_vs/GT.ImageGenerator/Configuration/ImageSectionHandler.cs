using System.Configuration;
using GT.Common.Types;

namespace GT.ImageGenerator.Configuration
{
    public class ImageSectionHandler : ConfigurationSection
    {
        private const string PASSWORD_TOKEN = "password";
        private const string PATH_TOKEN = "path";
        private const string QUALITY_TOKEN = "quality";
        private const string STORAGE_PATH = "storagePath";
        public const string SECTION_NAME = "imageConfiguration";

        public ImageSectionHandler()
        {
        }

        public ImageSectionHandler(string p_sPath, string p_sPassword, string p_sStoragePath)
        {
            Path = p_sPath;
            Password = p_sPassword;
            StoragePath = p_sStoragePath;
        }

        [ConfigurationProperty(PATH_TOKEN, IsRequired = true)]
        public string Path
        {
            get { return (string) this[PATH_TOKEN]; }
            set { this[PATH_TOKEN] = value; }
        }

        [ConfigurationProperty(PASSWORD_TOKEN, IsRequired = true)]
        public string Password
        {
            get { return (string) this[PASSWORD_TOKEN]; }
            set { this[PASSWORD_TOKEN] = value; }
        }

        [ConfigurationProperty(STORAGE_PATH, IsRequired = true)]
        public string StoragePath
        {
            get { return (string)this[STORAGE_PATH]; }
            set { this[STORAGE_PATH] = value; }
        }

        [ConfigurationProperty(QUALITY_TOKEN, IsRequired = false)]
        public int Quality
        {
            get { return TypeConverter.ToInt32(this[QUALITY_TOKEN], 100); }
            set { this[QUALITY_TOKEN] = TypeConverter.ToString(value); }
        }
    }
}