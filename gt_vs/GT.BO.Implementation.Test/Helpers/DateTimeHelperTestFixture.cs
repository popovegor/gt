using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using GT.BO.Implementation.Helpers;
using System.Collections;

namespace GT.BO.Implementation.Test.Helpers
{
  [TestFixture]
  public class DateTimeHelperTestFixture
  {
  
    public DateTime now = DateTime.Now;
  
    public IEnumerable UtcToLocalTestCases
    {
      get
      {
        yield return new TestCaseData(
          new DateTime(2010, 12, 1, 5, 45, 23, 120), 64) //0
            .Returns(new DateTime(2010, 12, 1, 5, 45, 23, 120));
        yield return new TestCaseData(
          new DateTime(2010, 12, 1, 5, 45, 23, 120), 68) //-2
            .Returns(new DateTime(2010, 12, 1, 3, 45, 23, 120));
        yield return new TestCaseData(
          new DateTime(2010, 12, 1, 17, 45, 23, 120), 17) //+8
            .Returns(new DateTime(2010, 12, 2, 1, 45, 23, 120));
          
        /*yield return new TestCaseData(
          new DateTime(now.Ticks, DateTimeKind.Local), 68) //-2 + (-local time)
          .Returns(now.AddHours(-2 - TimeZoneInfo.Local.BaseUtcOffset.TotalHours 
            - (TimeZoneInfo.Local.IsDaylightSavingTime(now) == true ? 1 : 0)));*/
      }
    }  
      
    [Test]
    [TestCaseSource("UtcToLocalTestCases")]
    public DateTime TestUtcToLocal(DateTime dt, int timeZoneId)
    {
      return dt.UtcToLocal(timeZoneId);
    }
  }
}
