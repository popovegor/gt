using System;
using GT.Common.Text;
using NUnit.Framework;

namespace GT.Common.Test.Text
{
  [TestFixture]
  public class StringUtilsTestFixture
  {
    [Test]
    public void TestGetFormattedString()
    {
      string sFormat = "test:{0}";
      string sDelimiter = "x";
      object[] args = null;
      Assert.IsEmpty(StringUtils.GetFormattedString(sFormat, sDelimiter, args));
      args = new object[] { null, string.Empty, DBNull.Value };
      Assert.IsEmpty(StringUtils.GetFormattedString(sFormat, sDelimiter, args));
      args = new object[] { 1, 2, 3 };
      Assert.AreEqual("test:1x2x3", StringUtils.GetFormattedString(sFormat, sDelimiter, args));
      args = new object[] { null, 2, 3 };
      Assert.AreEqual("test:2x3", StringUtils.GetFormattedString(sFormat, sDelimiter, args));
      args = new object[] { 1, null, 3 };
      Assert.AreEqual("test:1x3", StringUtils.GetFormattedString(sFormat, sDelimiter, args));
      args = new object[] { 1, 2, null };
      Assert.AreEqual("test:1x2", StringUtils.GetFormattedString(sFormat, sDelimiter, args));
    }

    [TestCase("", new[] {"1", "2"}, Result="")]
    [TestCase("{0} test {1}", new[] { "1", "2" }, Result = "1 test 2")]
    [TestCase("{0} test {2}", new[] { "1", "2", "3" }, Result = "1 test 3")]
    [TestCase("{1} test {2}", new[] { "1", "2", "3" }, Result = "2 test 3")]
    [TestCase("{0} test {4}", new[] { "1", "2", "3" }, Result = "1 test ")]
    public string TestFormat(string format, string[] args)
    {
      return StringUtils.Format(format, args);
    }
  }
}
