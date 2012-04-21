using System;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.XPath;
using System.Xml.Xsl;

namespace GT.Common.Xml.Xsl
{
    public static class XslTransformationHelper
    {
        public static string Transform(IXPathNavigable source, string xslFileFullPath)
        {
            XslCompiledTransform t = CreateTransform(xslFileFullPath);
            return TransformInternal(source, t); 
        }

        public static string Transform(IXPathNavigable source, IXPathNavigable stylesheet)
        {
            XslCompiledTransform t = CreateTransform(stylesheet);
            return TransformInternal(source, t);
        }

        private static string TransformInternal(IXPathNavigable source, XslCompiledTransform transform)
        {
            string result = string.Empty;

            using (StringWriter sw = new StringWriter())
            {
                using (XmlWriter xw = XmlWriter.Create(sw))
                {
                    transform.Transform(source, null, xw);
                }
                result = sw.ToString();
            }
            return result;
        }

        public static string Transform(DataTable dt, Encoding encoding, string xslFileFullPath)
        {
            XslCompiledTransform t = CreateTransform(xslFileFullPath);
            return TarnsformInternal(dt, encoding, t);
        }

        public static string Transform(DataTable dt, Encoding encoding, IXPathNavigable stylesheet)
        {
            XslCompiledTransform t = CreateTransform(stylesheet);
            return TarnsformInternal(dt, encoding, t);
        }

        private static string TarnsformInternal(DataTable dt, Encoding encoding, XslCompiledTransform transform)
        {
            Encoding e = encoding ?? Encoding.Default;
            XmlDocument doc = new XmlDocument();
            using (StringWriter sw = new StringWriter())
            {
                XmlWriterSettings set = new XmlWriterSettings();
                set.Encoding = e;
                using (XmlWriter xw = XmlWriter.Create(sw, set))
                {
                    dt.WriteXml(xw, false);
                    doc.LoadXml(sw.ToString());
                }
            }

            return TransformInternal(doc, transform);
        }

        private static XslCompiledTransform CreateTransform(IXPathNavigable stylesheet)
        {
            XslCompiledTransform t = new XslCompiledTransform();
            t.Load(stylesheet);
            return t;
        }

        private static XslCompiledTransform CreateTransform(string stylesheetUri)
        {
            XslCompiledTransform t = new XslCompiledTransform();
            t.Load(new Uri(stylesheetUri).ToString());
            return t;
        }
    }
}
