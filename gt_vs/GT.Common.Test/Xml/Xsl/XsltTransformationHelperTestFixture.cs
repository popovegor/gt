using System.Data;
using System.Diagnostics;
using System.Xml;
using GT.Common.Test.Properties;
using GT.Common.Xml.Xsl;
using NUnit.Framework;

namespace GT.Common.Test.Xml.Xsl
{
    [TestFixture]
    public class XslTransformationHelperTestFixture
    {
        [Test]
        public void TestTransform()
        {
            DataTable dt = new DataTable("dt");
            dt.Columns.Add("col1", typeof(string));
            dt.Columns.Add("col2", typeof(int));
            dt.Rows.Add("str", 1);
            dt.AcceptChanges();
            XmlDocument doc = new XmlDocument();
            doc.LoadXml(Resources.TransformDataTable);
            string expectedValue = "<?xml version=\"1.0\" encoding=\"utf-16\"?><b>str1</b>";
            string actualValue = XslTransformationHelper.Transform(dt, null, doc);
            Assert.AreEqual(expectedValue, actualValue);
            Trace.WriteLine(actualValue);
        }
    }
}
