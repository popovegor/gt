using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Globalization;

namespace GT.Global.Localization
{
  public class Localizator
  {  
    public static Languages CurrentLauguage
    {
      get
      {
        switch (Thread.CurrentThread.CurrentUICulture.TwoLetterISOLanguageName)
        {
          case "ru":
            return Languages.Ru;
          case "en":
          default:
            return Languages.En;
          case "zn":
            return Languages.Zh;
        }
      }
    }

    public static string GetLocalizedFieldName(string fieldName)
    {
      var localizedFieldName = fieldName;
      switch (CurrentLauguage)
      {
        case Languages.Ru:
          localizedFieldName = GetLocalizedName(fieldName, Languages.Ru);
          break;
      }
      return localizedFieldName;
    }

    //TODO: perhaps the best way to get localized prop is using .net reflection 
    public static string GetLocalizedProperty(string property, string propertyRu, string propertyZn)
    {
      var localizedProperty = property;
      switch (CurrentLauguage)
      {
        case Languages.None:
        case Languages.En:
        default:
          localizedProperty = property;
          break;
        case Languages.Ru:
          localizedProperty = propertyRu;
          break;
        case Languages.Zh:
          localizedProperty = propertyZn;
          break;
      }
      if (true == string.IsNullOrEmpty(localizedProperty))
      {
        localizedProperty = property;
      }
      return localizedProperty;
    }

    public static string GetLocalizedName(string name, Languages lang)
    {
      switch (lang)
      {
        case Languages.None:
        case Languages.En:
        default:
          return name;
        case Languages.Ru:
          return string.Concat(name, "Ru");
        case Languages.Zh:
          return string.Concat(name, "Zn");
      }
    }
  }
}
