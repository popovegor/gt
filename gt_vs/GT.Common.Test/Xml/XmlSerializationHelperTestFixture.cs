using System.Data;
using System.Diagnostics;
using GT.Common.Xml;
using NUnit.Framework;

namespace GT.Common.Test.Xml
{
    [TestFixture]
    public class XmlSerializationHelperTestFixture
    {

        /*public class SerializedPair<K, V>
        {

            [XmlElement("Key")]
            public K Key { get; set; }
            [XmlElement("Value")]
            public V Value { get; set; }

            public SerializedPair(K key, V value)
            {
                Key = key;
                Value = value;
            }

            public SerializedPair()
            { }
        }

        [XmlRoot("Collection")]
        public class SerializedArrayListOfPair
        {
            public SerializedArrayListOfPair()
            {
                Collection = new ArrayList();
            }

            [XmlArray("Values", Namespace = "")]
            [XmlArrayItem("Pair", Namespace = "", DataType = "", Type = typeof(SerializedPair<int, ATI.Common.Trace.Category>))]
            public ArrayList Collection
            {
                get;
                set;
            }
        }

        [XmlRoot("Collection", Namespace = "")]
        public class SerializedArrayList
        {

            public SerializedArrayList()
            {
                Collection = new ArrayList();
            }

            [XmlArray("Values", Namespace = "")]
            [XmlArrayItem("Value", Namespace = "", DataType = "", Type=typeof(int))]
            public virtual ArrayList Collection
            {
                get;
                set;
            }

            public void Add(object value)
            {
                Collection.Add(value);
            }
        }

        [Test]
        public void TestSerializedArrayListOfPair()
        {
            SerializedArrayListOfPair value = new SerializedArrayListOfPair();
            value.Collection.Add(new SerializedPair<int, ATI.Common.Trace.Category>(1, Trace.Category.General));
            string expectedValue = "<Collection><Values><Pair><Key>1</Key><Value>General</Value></Pair></Values></Collection>";
            string actualValue = XmlSerializationHelper.Serialize(value);
            System.Diagnostics.Trace.WriteLine(actualValue);
            Assert.AreEqual(expectedValue, actualValue);
        }


        [Test]
        public void TestSerializedArrayListOfInt()
        {
            SerializedArrayList value = new SerializedArrayList();
            value.Add(1);
            string expectedValue = "<Collection><Values><Value>1</Value></Values></Collection>";
            string actualValue = XmlSerializationHelper.Serialize(value);
            System.Diagnostics.Trace.WriteLine(actualValue);
            Assert.AreEqual(expectedValue, actualValue);
        }

        [Test]
        public void TestSerializeListOfInt()
        {
            string expectedValue = "<ArrayOfInt><int>12</int><int>1</int></ArrayOfInt>";
            List<int> value = new List<int>(new[] { 12, 1 });
            bool omitXmlDeclaration = true;
            string actualValue = XmlSerializationHelper.Serialize<List<int>>(value, omitXmlDeclaration);
            Assert.AreEqual(expectedValue, actualValue);
        }

        [Test]
        public void TestSerializeListOfString()
        {
            string expectedValue = "<ArrayOfString><string>12</string><string>1</string></ArrayOfString>";
            List<string> value = new List<string>(new[] { "12", "1" });
            bool omitXmlDeclaration = true;
            string actualValue = XmlSerializationHelper.Serialize<List<string>>(value, omitXmlDeclaration);
            Assert.AreEqual(expectedValue, actualValue);
        }

        [Test]
        public void TestSerializeEmptyList()
        {
            string expectedValue = "<ArrayOfString />";
            List<string> value = new List<string>();
            bool omitXmlDeclaration = true;
            string actualValue = XmlSerializationHelper.Serialize<List<string>>(value, omitXmlDeclaration);
            Assert.AreEqual(expectedValue, actualValue);
        }

        [Test]
        public void TestSerializeEmpty()
        {
            string expectedValue = null;
            List<string> value = null;
            bool omitXmlDeclaration = true;
            string actualValue = XmlSerializationHelper.Serialize<List<string>>(value, omitXmlDeclaration);
            Assert.AreEqual(expectedValue, actualValue);
        }*/

        public abstract class Base
        {
            public Base()
            { }
        }

        public class A : Base
        {

            private string _m = "M";

            public string M
            {
                get { return _m; }
                set { _m = value;}
            }

            public A()
                : base()
            { }
        }


        [TestCase("<A><M>C</M></A>")]
        public void TestDeserilaize(string xml)
        {
            A actual = XmlSerializationHelper.Deserialize<A>(xml);
            Assert.AreEqual(actual.M, "C");
        }


        [TestAttribute]
        public void TestSerializeObject()
        {
            Base a = new A();
            string actual = "<A><M>M</M></A>";
            string expected = XmlSerializationHelper.SerializeToXmlString(a);
            Trace.WriteLine(expected);
            Assert.AreEqual(expected, actual);
        }


        [TestAttribute]
        public void TestSerializeDataSet()
        {
            DataSet ds = new DataSet("DataSet");
            //Table 1
            ds.Tables.Add(new DataTable("Table"));
            ds.Tables[0].Columns.Add("col1", typeof(int));
            ds.Tables[0].Columns.Add("col2", typeof(int));
            DataRow dr = ds.Tables[0].NewRow();
            dr["col1"] = 1;
            dr["col2"] = 2;
            ds.Tables[0].Rows.Add(dr);
            //Table 2
            ds.Tables.Add(new DataTable("Table1"));
            ds.Tables[1].Columns.Add("col1_col1", typeof(int));
            ds.Tables[1].Columns.Add("col2", typeof(int));
            dr = ds.Tables[1].NewRow();
            dr["col1_col1"] = 1;
            ds.Tables[1].Rows.Add(dr);
            ds.Relations.Add(new DataRelation("table_table1", ds.Tables[0].Columns[0], ds.Tables[1].Columns[0], true));
            ds.AcceptChanges();
            string actualXml = XmlSerializationHelper.SerializeDataTable(ds.Tables[0], true);
            string expectedXml = "<DataSet><Table><col1>1</col1><col2>2</col2></Table><Table1><col1_col1>1</col1_col1></Table1></DataSet>";
            Trace.Write(actualXml);
            Assert.AreEqual(actualXml, expectedXml);
        }
    }
}
