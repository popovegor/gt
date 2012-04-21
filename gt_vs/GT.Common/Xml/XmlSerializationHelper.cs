using System;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace GT.Common.Xml
{
    public static class XmlSerializationHelper
    {
        public static T Deserialize<T>(string sourceXml)
        {
            return (T)Deserialize(sourceXml, typeof(T));
        }

        public static object Deserialize(string sourceXml, Type targetType)
        {
            XmlSerializer ser = new XmlSerializer(targetType);
            using (StringReader sr = new StringReader(sourceXml))
            {
                using (XmlReader xr = XmlReader.Create(sr))
                {
                    return ser.Deserialize(xr);
                }
            }  
        }

        public static string SerializeDataTable(DataTable dt, bool omitXmlDeclaration)
        {
            string xml = null;
            using (StringWriter sw = new StringWriter())
            {
                XmlWriterSettings xws = new XmlWriterSettings();
                //if (encoding != null)
                //{
                //    xws.Encoding = encoding;
                //}
                xws.OmitXmlDeclaration = omitXmlDeclaration;
                using (XmlWriter xw = XmlWriter.Create(sw, xws))
                {
                    dt.WriteXml(xw, XmlWriteMode.IgnoreSchema, true);
                    xml = sw.ToString();
                }
            }

            return xml;
        }

        public static string SerializeToXmlString(object value)
        {
            return Serialize(value, true);
        }

        public static XmlDocument SerializeToXmlDocument(object value)
        {
            XmlDocument xml = new XmlDocument();
            xml.LoadXml(Serialize(value, true, null));
            return xml;
        }

        public static string Serialize(object value, bool omitXmlDeclaration)
        {
            return Serialize(value, omitXmlDeclaration, null);
        }

        public static string Serialize(object value, bool omitXmlDeclaration, Encoding encoding)
        {
            string xml = null;
            if (value != null)
            {
                XmlSerializer ser = new XmlSerializer(value.GetType(), string.Empty);
                using (StringWriter sw = new StringWriter())
                {
                    XmlWriterSettings xws = new XmlWriterSettings();
                    if (encoding != null)
                    {
                        xws.Encoding = encoding;
                    }
                    xws.OmitXmlDeclaration = omitXmlDeclaration;
                    using (XmlWriter xw = XmlWriter.Create(sw, xws))
                    {
                        XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
                        ns.Add(string.Empty, string.Empty);
                        ser.Serialize(xw, value, ns);
                        xml = sw.ToString();
                    }
                }
            }
            return xml;
        }
    }
}
