using System;
namespace GT.Ajax.Controls.Configuration
{
  public interface IAjaxControlConfigurationSection
  {
    string UploadDirectoryPath { get; set; }
    string[] AllowedFileExtensions {get;}
  }
}
