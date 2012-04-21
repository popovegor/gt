using System;
using System.Configuration;
using GT.Common;
using GT.Common.Cryptography;
using GT.Common.Exceptions;
using GT.Common.Web.Exceptions;
using GT.ImageGenerator.Cache;
using GT.ImageGenerator.Configuration;
using GT.ImageGenerator.GeneratedImages;
using GT.ImageGenerator.Serialization;
using GT.ImageGenerator.Web;

namespace GT.ImageGenerator
{
    public static class GeneratedImageManager
    {
        private static readonly object _lockObject = new object();
        private static ImageSectionHandler m_config = null;
        
        public static void InitializeCache()
        {
            CacheManager.Initialize();
        }

        public static void DisposeCache()
        {
            CacheManager.Dispose();
        }

        public static ImageSectionHandler Configuration
        {
            get
            {
                if (m_config == null)
                {
                    lock (_lockObject)
                    {
                        if (m_config == null)
                        {
                            ImageSectionHandler config =
                                (ImageSectionHandler)
                                ConfigurationManager.GetSection(ImageSectionHandler.SECTION_NAME);
                            if (config != null)
                            {
                                if (string.IsNullOrEmpty(config.Path))
                                    config.Path = GeneratedImageHandler.HANDLER_NAME;
                            }
                            else
                                config =
                                    new ImageSectionHandler(GeneratedImageHandler.HANDLER_NAME, string.Empty,
                                                            string.Empty);
                            m_config = config;
                        }
                    }
                }
                return m_config;
            }
        }

        public static string GetLink(GeneratedImageBase p_image)
        {
            string sLink = GeneratedImageSerializer.Serialize(p_image);
            string sHash = GetHash(sLink);
            ProcessCache(sHash, p_image);
            if (CacheManager.Contains(sHash))
                return CacheManager.GetLink(sHash);
            return Configuration.Path + sLink;
        }

        public static GeneratedImageBase GetImageByLink(string p_sLink)
        {
            return GetObjectByLink(p_sLink);
        }

        private static GeneratedImageBase GetObjectByLink(string p_sLink)
        {
            if (string.IsNullOrEmpty(p_sLink) ||
                p_sLink.IndexOf("?") == -1)
                throw AssistLogger.Log<ExceptionHolder>(
                    new ArgumentException(string.Format("Invalid link: {0}", p_sLink), "p_sLink"));
            string sLink = p_sLink;
            if (!p_sLink.StartsWith("?"))
                sLink = p_sLink.Substring(p_sLink.IndexOf("?"));

            string sHash = GetHash(sLink);
            GeneratedImageBase image = null;
            try
            {
                image = GeneratedImageSerializer.Deserialize(sLink);
                ProcessCache(sHash, image);
            }
            catch (Exception e)
            {
                throw AssistLogger.Log<WebExceptionHolder>(
                    new ArgumentException(string.Format("Cannot deserialize string: {0}", p_sLink), e));
            }
            return image;
        }

        private static void ProcessCache(string p_sHash, GeneratedImageBase p_image)
        {
            if (p_image != null &&
                p_image.Cache)
            {
                if (!CacheManager.Contains(p_sHash))
                {
                    lock (_lockObject)
                    {
                        CacheManager.Add(p_sHash, p_image);
                    }
                }
            }
        }

        public static string GetHash(string p_str)
        {
            return Hash.ReadableHash(Hash.SHA1, p_str);
        }

        public static void ClearCache()
        {
            lock (_lockObject)
            {
                CacheManager.Dispose();
            }
        }
    }
}