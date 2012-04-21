using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using GT.Common.Exceptions;

namespace GT.Common.IO
{
    public static class FileSystem
    {
        private const string CODE_BASE_PREFIX = "file:///";

        public static void DeleteDirectory(string p_sDirectoryName, bool p_bRecursive)
        {
            try
            {
                Directory.Delete(p_sDirectoryName, p_bRecursive);
            }
            catch (Exception ex)
            {
                AssistLogger.Log<ExceptionHolder>(ex);
            }
        }

        public static string GetAssemblyPath()
        {
            return GetFilePath(null, null);
        }

        public static string GetFilePath(string p_sFileName)
        {
            return GetFilePath(Assembly.GetExecutingAssembly(), p_sFileName);
        }

        public static string GetFilePath(Assembly p_asm, string p_sFileName)
        {
            string sCodeBase =
                (p_asm ?? Assembly.GetExecutingAssembly()).CodeBase.Replace(CODE_BASE_PREFIX, string.Empty);
            string sPath = Path.GetDirectoryName(Path.GetFullPath(sCodeBase.Replace("/", "\\")));
            return string.IsNullOrEmpty(p_sFileName) ? sPath : Path.Combine(sPath, p_sFileName);
        }

        public static ICollection<string> SafeGetFiles(string p_sPath, string p_sMask)
        {
            return SafeGetFiles(p_sPath, p_sMask, true);
        }

        public static ICollection<string> SafeGetFiles(string p_sPath, string p_sMask, bool p_bShouldLog)
        {
            if (string.IsNullOrEmpty(p_sPath))
                p_sPath = GetAssemblyPath();
            if (string.IsNullOrEmpty(p_sMask))
                p_sMask = "*.*";
            List<string> list = new List<string>();
            InnerSafeGetFiles(p_sPath, p_sMask, p_bShouldLog, list);
            return list;
        }

        private static void InnerSafeGetFiles(string p_sPath, string p_sMask, bool p_bShouldLog, List<string> p_coll)
        {
            try
            {
                p_coll.AddRange(Directory.GetFiles(p_sPath, p_sMask, SearchOption.AllDirectories));
            }
            catch (Exception e)
            {
                if (p_bShouldLog)
                    AssistLogger.Log<ExceptionHolder>(e);
                try
                {
                    foreach (string directory in Directory.GetDirectories(p_sPath))
                        InnerSafeGetFiles(directory, p_sMask, p_bShouldLog, p_coll);
                    p_coll.AddRange(Directory.GetFiles(p_sPath, p_sMask, SearchOption.TopDirectoryOnly));
                }
                catch (Exception ex)
                {
                    if (p_bShouldLog)
                        AssistLogger.Log<ExceptionHolder>(ex);
                }
                
            }
        }
    }
}