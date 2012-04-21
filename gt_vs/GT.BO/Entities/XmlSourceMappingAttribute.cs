using System;
using GT.Common.Xml;

namespace GT.BO.Entities
{
    public class XmlSourceMappingAttribute : BaseSourceMappingAttribute
    {
        public XmlSourceMappingAttribute(string fieldName)
            : base(fieldName)
        { }

        public override object Convert(object v, Type targetType)
        {
            return XmlSerializationHelper.Deserialize(v.ToString(), targetType);
        }
    }
}
