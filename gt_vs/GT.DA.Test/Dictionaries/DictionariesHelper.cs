using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using NUnit.Framework;
using GT.Common.Types;
using GT.DA.Dictionaries;

namespace GT.DA.Test.Dictionaries
{
  public static class DictionariesHelper
  {
    /// <summary>
    /// Returns a random dictionary entry Id
    /// </summary>
    /// <returns></returns>
    public static int GetRandomDictionaryEntryId(DictionaryTypes type, string entryIdFieldName)
    {
      DataTable dic = GT.DA.Dictionaries.Dictionaries.Instance.GetDictionary(type);
      int count = dic.Rows.Count;
      Assert.GreaterOrEqual(count, 1);
      Random rnd = new Random((int)DateTime.Now.Ticks);
      int id = TypeConverter.ToInt32(dic.Rows[rnd.Next(0, count - 1)][entryIdFieldName], 0);
      Assert.GreaterOrEqual(id, 1);
      return id;
    }

    public static T GetRandomDictionaryEntryId<T>(DictionaryTypes type, string entryIdFieldName)
      where T : struct
    {
      return TypeConverter.ToEnumMember<T>(GetRandomDictionaryEntryId(type, entryIdFieldName));
    }
  }
}
