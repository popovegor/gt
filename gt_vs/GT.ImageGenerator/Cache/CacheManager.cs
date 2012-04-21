using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Runtime.Remoting.Messaging;
using System.Web.Hosting;
using GT.Common;
using GT.Common.Exceptions;
using GT.ImageGenerator.Configuration;
using GT.ImageGenerator.GeneratedImages;

namespace GT.ImageGenerator.Cache
{
  internal static class CacheManager
  {
    private static readonly object _lockObject = new object();
    private static readonly object _fileSystemLock = new object();
    private static readonly Dictionary<string, string> m_files = new Dictionary<string, string>();
    private static volatile bool m_bIsInitialized = false;
    private static FileSystemWatcher m_watcher;
    private static string m_sPath = string.Empty;

    private delegate void AsyncSaveImage(string p_sKey, GeneratedImageBase p_image);

    static CacheManager()
    {
      AppDomain.CurrentDomain.DomainUnload += CurrentDomain_DomainUnload;
    }

    static void CurrentDomain_DomainUnload(object sender, EventArgs e)
    {
      Dispose();
    }

    public static void Initialize()
    {
      Initialize(HostingEnvironment.MapPath(GeneratedImageManager.Configuration.StoragePath));
    }

    internal static void Initialize(string p_sPhysicalPath)
    {
      if (!m_bIsInitialized)
      {
        lock (_lockObject)
          if (!m_bIsInitialized)
          {
            if (!string.IsNullOrEmpty(p_sPhysicalPath))
            {
              if (Directory.Exists(p_sPhysicalPath) == false)
              {
                Directory.CreateDirectory(p_sPhysicalPath);
              }
              InitializeWatcher(p_sPhysicalPath);
              GetFiles(p_sPhysicalPath);
              m_sPath = p_sPhysicalPath;
              m_bIsInitialized = true;
            }
            else
              throw new ConfigurationErrorsException(
                  string.Format("{0} is not configured.", ImageSectionHandler.SECTION_NAME));
          }
      }
    }

    public static void Dispose()
    {
      m_watcher.Changed -= m_watcher_Changed;
      m_watcher.Dispose();
      m_sPath = string.Empty;
      lock (_lockObject)
      {
        m_files.Clear();
        m_bIsInitialized = false;
      }
    }

    public static int Count
    {
      get
      {
        lock (_lockObject)
          return m_files.Count;
      }
    }

    public static bool Contains(string p_sKey)
    {
      if (!string.IsNullOrEmpty(p_sKey))
        lock (_lockObject)
          return m_files.ContainsKey(p_sKey);
      return false;
    }

    public static void Add(string p_sKey, GeneratedImageBase p_image)
    {
      if (!string.IsNullOrEmpty(p_sKey) &&
          p_image != null)
      {
        AsyncSaveImage del = SaveImage;
        string sFileName =
            string.Format("{0}.{1}", p_sKey, p_image.ContentType.Substring(p_image.ContentType.IndexOf('/') + 1));
        del.BeginInvoke(sFileName,
                        p_image, EndSaveImage, new KeyValuePair<string, string>(p_sKey, sFileName));
      }
    }

    public static string GetLink(string p_sHash)
    {
      if (Contains(p_sHash))
        lock (_lockObject)
          return
              string.Format("{0}/{1}", GeneratedImageManager.Configuration.StoragePath,
                            Path.GetFileName(m_files[p_sHash]));
      return string.Empty;
    }

    private static void InitializeWatcher(string p_sPath)
    {
      m_watcher = new FileSystemWatcher();
      m_watcher.Path = p_sPath;
      m_watcher.NotifyFilter = NotifyFilters.LastAccess | NotifyFilters.LastWrite
                               | NotifyFilters.FileName;
      m_watcher.Filter = "*.*";
      m_watcher.IncludeSubdirectories = true;
      m_watcher.Changed += m_watcher_Changed;
      m_watcher.Created += m_watcher_Changed;
      m_watcher.Deleted += m_watcher_Changed;
      m_watcher.EnableRaisingEvents = true;
    }

    private static void m_watcher_Changed(object sender, FileSystemEventArgs e)
    {
      if (e.ChangeType != WatcherChangeTypes.Deleted)
        ChangeFile(e.FullPath);
      else
        lock (_lockObject)
          m_files.Remove(Path.GetFileNameWithoutExtension(e.FullPath));
    }

    private static void GetFiles(string p_sPath)
    {
      string[] sFileList = Directory.GetFiles(p_sPath);
      if (sFileList.Length > 0)
        foreach (string file in sFileList)
          ChangeFile(file);
    }

    private static void ChangeFile(string p_sFileName)
    {
      lock (_lockObject)
      {
        string sKey = Path.GetFileNameWithoutExtension(p_sFileName);
        if (!(m_files.ContainsKey(sKey)
              && m_files[sKey] == p_sFileName))
          m_files[sKey] = p_sFileName;
      }
    }

    private static void SaveImage(string p_sFileName, GeneratedImageBase p_image)
    {
      try
      {
        string sFullPath = Path.Combine(m_sPath, p_sFileName);
        lock (_lockObject)
        {
          if (File.Exists(sFullPath))
          {
            lock (_fileSystemLock)
            {
              File.Delete(sFullPath);
            }
          }

          using (MemoryStream stream = new MemoryStream())
          {
            p_image.Save(stream, true);
            lock (_fileSystemLock)
            {
              using (FileStream fs = new FileStream(sFullPath, FileMode.CreateNew, FileAccess.Write, FileShare.Write))
              {
                stream.WriteTo(fs);
              }
            }
          }
        }
      }
      catch (Exception e)
      {
        AssistLogger.Log<ExceptionHolder>(e);
      }
    }

    private static void EndSaveImage(IAsyncResult p_result)
    {
      AsyncResult res = (AsyncResult)p_result;
      KeyValuePair<string, string> pair = (KeyValuePair<string, string>)res.AsyncState;
      AsyncSaveImage del = (AsyncSaveImage)res.AsyncDelegate;
      del.EndInvoke(p_result);
      lock (_lockObject)
      {
        if (!m_files.ContainsKey(pair.Key))
        {
          m_files.Add(pair.Key, pair.Value);
        }
      }
    }
  }
}