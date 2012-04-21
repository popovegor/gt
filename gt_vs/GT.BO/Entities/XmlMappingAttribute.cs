using System;
using System.Collections.Generic;
using System.Text;
using GT.Common.Xml;

namespace GT.BO.Entities
{
    public class XmlMappingAttribute : BaseMappingAttribute
    {
        public XmlMappingAttribute(string fieldName)
            : base(fieldName)
        { }

        public override object Convert(object v, Type targetType)
        {
            return XmlSerializationHelper.Deserialize(v.ToString(), targetType);
        }
    }
}
