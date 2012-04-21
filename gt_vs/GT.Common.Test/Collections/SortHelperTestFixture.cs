using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using System.Collections;
using GT.Common.Collections;

namespace GT.Common.Test.Collections
{
  [TestFixture]
  public class SortHelperTestFixture
  {
    public static IEnumerable IntComparerTestData
    {
      get
      {
        yield return new TestCaseData(new[] {1, 2, 3}).Returns(new[] {3, 2, 1});
        yield return new TestCaseData(new[] { 2, 10, 3, 1 }).Returns(new[] { 10, 3, 2, 1 });
        //yield return new TestCaseData(12).Returns(6);
        //yield return new TestCaseData(12).Returns(3);
      }
    }  

  
    [TestCaseSource("IntComparerTestData")]
    [Test]
    public int[] TestIntComparerDesc(int[] data)
    {
      var lst = new SortedList<int, int>(new SortHelper.ComparerDesc<int>());
      foreach(var d in data)
      {
        lst.Add(d, d);
      }
      return lst.Keys.ToArray();
    }
  }
}
