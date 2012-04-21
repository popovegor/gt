using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using GT.Web.Security;
using GT.Web.Services;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for ProfilesService
  /// </summary>
  [WebService(Namespace = "http://gameismoney.ru/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ToolboxItem(false)]
  [ScriptService]
  public class ProfilesService : BaseWebService
  {

    // Returns a dictionary containing a name-value
    // pair for all profile properties enabled for
    // read access found on the current users profile.
    [WebMethod]
    public IDictionary<string, object> GetAllPropertiesForCurrentUser()
    {
      return GetPropertiesForCurrentUser(null);
    }

    // Given an array of one or more property names,
    // returns a dictionary containing a name-value pair
    // for each corresponding property found on the current
    // users profile that are enabled for read access.
    [WebMethod]
    public IDictionary<string, object> GetPropertiesForCurrentUser(string[] properties)
    {
      IDictionary<string, object> result = new Dictionary<string, object>();
      CustomUserProfile p = Credentials.Profile;
      foreach (SettingsProperty prop in CustomUserProfile.Properties)
      {
        if (properties == null
            || properties.Length <= 0
            || Array.Exists<string>(properties, delegate(string v) { return v == prop.Name; }))
        {
          result.Add(new KeyValuePair<string, object>(prop.Name, p[prop.Name]));
        }
      }
      return result;
    }

    // Given a dictionary with one or more name-value pairs,
    // sets the values onto the corresponding properties of
    // the current users profile. The method returns the count 
    // of properties that were able to be updated.
    [WebMethod]
    public int SetPropertiesForCurrentUser(IDictionary<string, object> values)
    {
      int count = 0;
      CustomUserProfile p = Credentials.Profile;
      foreach (KeyValuePair<string, object> v in values)
      {
        p[v.Key] = GT.Common.Types.TypeConverter.TryConvert(v.Value, p[v.Key].GetType());
        count++;
      }
      p.Save();
      return count;
    }
  }
}
