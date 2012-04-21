using System;
using System.ComponentModel;
using System.Data;
using System.Diagnostics;
using System.Xml;
using GT.BO.Entities;
using GT.Common.Xml;
using NUnit.Framework;

namespace GT.BO.Test.Entities
{
    [TestFixture]
    public class EntityTestFixture
    {

        static object[] _entities = new object[] { new TestEntity() };

        #region nested types

        public class CustomMappingAttribute : BaseSourceMappingAttribute
        {
            public CustomMappingAttribute(string fieldName)
                : base(fieldName)
            { }

            public override object Convert(object v, Type targetType)
            {
                return GT.Common.Types.TypeConverter.ToString(v);
            }
        }

        public class TestEntity : BaseEntity
        {
            [BaseSourceMapping("EntityId")]
            public int EntityId = 0;

            [BaseSourceMapping("Value")]
            public string Value = string.Empty;

            [CustomMappingAttribute("Custom")]
            public string CustomValue;

            [XmlSourceMapping("Xml")]
            public string XmlValue = string.Empty;

            [BaseSourceMapping("PropertyValue")]
            [DefaultValue("")]
            [BaseComparable]
            public string PropertyValue { get; set; }


            public override int Id
            {
              get
              {
                return EntityId;
              }
              set
              {
                EntityId = value;
              }
            }
        }

        #endregion

        [TestAttribute, TestCaseSource("_entities")]
        public void TestEntityToXml(BaseEntity e)
        {
            XmlDocument xml = e.ToXmlDocument();
            Assert.IsNotNull(xml);
            Assert.IsNotNullOrEmpty(xml.InnerXml);
            Trace.WriteLine(xml.InnerXml);
        }

        [TestAttribute]
        public void TestEquals()
        {
            TestEntity expected = new TestEntity();
            expected.PropertyValue = "12";
            TestEntity actual = new TestEntity();
            actual.PropertyValue = "11";
            Assert.IsFalse(expected.Compare(actual));
            actual.PropertyValue = "12";
            Assert.IsTrue(expected.Compare(actual));
        }

        [TestAttribute]
        public void TestLoad()
        {
            DataTable entityTable = new DataTable("EntityTable");
            entityTable.Columns.Add("EntityId", typeof(int));
            entityTable.Columns.Add("Value", typeof(string));
            entityTable.Columns.Add("Custom", typeof(int));
            entityTable.Columns.Add("Xml", typeof(string));
            entityTable.Columns.Add("PropertyValue", typeof(string));
            entityTable.Rows.Add(1, "Entity", 2, "<string>string</string>", "1");
            entityTable.AcceptChanges();
            string entityAsXml = XmlSerializationHelper.SerializeDataTable(entityTable, true);
            Trace.WriteLine(entityAsXml);

            TestEntity entity = new TestEntity();
            DataRow entityRow = entityTable.Rows[0];
            entity.Load(entityRow);

            Assert.AreEqual(entity.EntityId, (int)entityRow["EntityId"]);
            Assert.AreEqual(entity.Value, (string)entityRow["Value"]);
            Assert.AreEqual(entity.CustomValue, "2");
            Assert.AreEqual(entity.XmlValue, "string");
            Assert.AreEqual(entity.PropertyValue, "1");
        }
    }
}
