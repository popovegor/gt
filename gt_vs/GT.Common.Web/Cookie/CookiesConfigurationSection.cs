using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace GT.Common.Web.Cookie
{
  internal class CookiesConfigurationSection : ConfigurationSection
  {
    public const string SectionName = "cookiesConfiguration";
    private const string cookiesCollectionName = "cookies";
  
    public CookiesConfigurationSection()
    {
    }

    [ConfigurationProperty(cookiesCollectionName, IsDefaultCollection = false, IsRequired = true)]
    [ConfigurationCollection(typeof(CookiesConfigurationElementCollection),
      AddItemName = "add",
      ClearItemsName = "clear",
      RemoveItemName = "remove")]
    public CookiesConfigurationElementCollection Cookies
    {
      get
      {
        return (CookiesConfigurationElementCollection)base[cookiesCollectionName];
      }
    }
  }
}
