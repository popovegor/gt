using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;
using GT.Ajax.Controls.Configuration;
using GT.Web.Security;
using System.IO;

namespace GT.Ajax.Controls
{
  [ToolboxData("<{0}:FileUploader runat=server></{0}:FileUploader>")]
  [ValidationProperty("FileName")]
  public class FileUploader : AsyncFileUpload
  {

    public static string GetFullFilePath(CredentialsInformation credentials, string fileName)
    {
      return Path.Combine(GetFullPath(credentials), fileName);
    }

    public static string GetFullPath(CredentialsInformation credentials)
    {
      return HttpContext.Current.Server.MapPath(GetFullVirtualPath(credentials));
    }
    
    public static string GetFullVirtualPath(CredentialsInformation credentials)
    {
      return Path.Combine(AjaxControlConfigurationSection.Section.UploadDirectoryPath, credentials.UserId.ToString());
    }

    public void SaveAs(CredentialsInformation credentials, string fileName)
    {
      if (Context != null)
      {
        if (null != credentials && null != credentials.UserId)
        {
          var fullPath = GetFullPath(credentials);
          if(Directory.Exists(fullPath) == false)
          {
            Directory.CreateDirectory(fullPath);
          }
          var fullFilePath = GetFullFilePath(credentials, fileName);
          base.SaveAs(fullFilePath);
        }
      }
    }

    public void SaveAs(CredentialsInformation credentials)
    {
      this.SaveAs(credentials, this.FileName);
    }

    public void RemoveFileFromSession()
    {
      var clientId = this.ClientID;
      if (null != Context)
      {
        var session = Context.Session;
        if (null != session && null != session.Keys)
        {
          var key = session.Keys.Cast<string>().FirstOrDefault(q => q.Contains(clientId));
          if (false == string.IsNullOrEmpty(key))
          {
            session.Remove(key);
          }
        }
      }
    }

    public static void Initialize()
    {
      if (HttpContext.Current != null && null != HttpContext.Current.Server)
      {
        var path = HttpContext.Current.Server.MapPath(AjaxControlConfigurationSection.Section.UploadDirectoryPath);
        if(Directory.Exists(path) == true)
        {
          Directory.Delete(path, true);
        }
      }
    }
  }
}
