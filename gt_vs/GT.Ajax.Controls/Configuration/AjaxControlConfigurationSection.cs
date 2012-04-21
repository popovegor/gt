using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace GT.Ajax.Controls.Configuration
{
  public class AjaxControlConfigurationSection : ConfigurationSection, IAjaxControlConfigurationSection
  {

    public static IAjaxControlConfigurationSection Section { get; private set; }

    static AjaxControlConfigurationSection()
    {
      Section = ConfigurationManager.GetSection(SectionName) as AjaxControlConfigurationSection;
    }

    private AjaxControlConfigurationSection()
    {
    }

    private static string SectionName
    {
      get
      {
        return "ajaxControlConfiguration";
      }
    }

    private static class PropertieNames
    {
      public const string UploadDirectoryPath = "uploadDirectoryPath";
      public const string AllowedFileExtensions = "allowedFileExtensions";
    }

    [ConfigurationProperty(PropertieNames.UploadDirectoryPath, IsRequired = false, DefaultValue = "~/Uploads/")]
    public string UploadDirectoryPath
    {
      get { return (string)this[PropertieNames.UploadDirectoryPath]; }
      set { this[PropertieNames.UploadDirectoryPath] = value; }
    }

    public string[] AllowedFileExtensions
    {
      get
      {
        return AllowedFileExtensionsAsString.Split(" ".ToCharArray(), StringSplitOptions.RemoveEmptyEntries);
      }
    }

    [ConfigurationProperty(PropertieNames.AllowedFileExtensions, IsRequired = false, DefaultValue = "jpeg png jpg gif")]
    public string AllowedFileExtensionsAsString
    {
      get { return (string)this[PropertieNames.AllowedFileExtensions]; }
      set { this[PropertieNames.AllowedFileExtensions] = value; }
    }
  }
}
