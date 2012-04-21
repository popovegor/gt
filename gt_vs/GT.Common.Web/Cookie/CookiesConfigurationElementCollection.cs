using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace GT.Common.Web.Cookie
{
  internal class CookiesConfigurationElementCollection : ConfigurationElementCollection
  {
    protected override ConfigurationElement CreateNewElement()
    {
      return new CookiesConfigurationElement();
    }

    protected override object GetElementKey(ConfigurationElement element)
    {
      return (element as CookiesConfigurationElement).Key;
    }
    
    public CookiesConfigurationElement this[string key]
    {
      get
      {
        return this.BaseGet(key) as CookiesConfigurationElement;
      }
    }
  }
}
