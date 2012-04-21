using System;
using System.Data;
using System.Diagnostics;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Global.UserRating;
using NUnit.Framework;

namespace GT.DA.Test.Dictionaries
{
  [TestFixture]
  public class DictionariesTestFixture
  {
    [Test]
    public void TestAllDictionaries()
    {
      foreach (DictionaryTypes type in Enum.GetValues(typeof(DictionaryTypes)))
      {
        if (type != DictionaryTypes.None)
        {
          Trace.WriteLine(type);
          DataTable dic = GT.DA.Dictionaries.Dictionaries.Instance.GetDictionary(type);
          Assert.IsNotNull(dic);
          Assert.IsTrue(dic.Rows.Count > 0);
          foreach (var dv in dic.AsEnumerable())
          {
            switch (type)
            {
              case DictionaryTypes.FeedbackType:
                var enumByName = TypeConverter.ToEnumMember<FeedbackType>(dv[FeedbackTypeFields.LocalizedName].ToString());
                var enumByValue = TypeConverter.ToEnumMember<FeedbackType>((int)dv[FeedbackTypeFields.FeedbackTypeId]);
                Assert.AreEqual(enumByName, enumByValue);
                break;
            }
          }
        }
      }
    }

    [TestCase(Result = 61)]
    public int TestGetDefaultTimeZone()
    {
      return GT.DA.Dictionaries.Dictionaries.Instance.GetDefaultTimeZone();
    }

    [TestCase(10, Result = "E. Australia Standard Time")]
    [TestCase(30, Result = "Sri Lanka Standard Time")]
    [TestCase(1000, ExpectedException = typeof(NullReferenceException))]
    public string TestGetTimeZoneInfoById(int id)
    {
      return GT.DA.Dictionaries.Dictionaries.Instance.GetTimeZoneInfoById(id).Id;
    }
    
    [TestCase(2, Result=0.008)]
    public decimal TestGetRealMoneySourceCommissionById(int realSourceId)
    {
      return GT.DA.Dictionaries.Dictionaries.Instance.GetRealMoneySourceCommissionById(realSourceId);
    }
  }
}
