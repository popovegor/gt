using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace GT.Common.Web.Cookie
{
  internal class CookiesConfigurationElement : ConfigurationElement
  {
    private const string NamePropertyName = "name";
    private const string KeyPropertyName = "key";
    private const string ExpirationPropertyName = "expirationInMinutes";

    [ConfigurationProperty(KeyPropertyName, IsRequired = true, IsKey = true)]
    public string Key
    {
      get
      {
        return (string)base[KeyPropertyName];
      }
      set
      {
        base[KeyPropertyName] = value;
      }
    }

    [ConfigurationProperty(NamePropertyName, IsRequired = true, IsKey = false)]
    public string Name
    {
      get
      {
        return (string)base[NamePropertyName];
      }
      set
      {
        base[NamePropertyName] = value;
      }
    }

    [ConfigurationProperty(ExpirationPropertyName, IsRequired = false, DefaultValue = 10080)]
    public int ExpirationInMinutes
    {
      get
      {
        return (int)base[ExpirationPropertyName];
      }
      set
      {
        base[ExpirationPropertyName] = value;
      }
    }
  }
}
