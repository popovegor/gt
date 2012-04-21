using System;
using System.Collections.Generic;
using System.Text;
using GT.Common.Types;

namespace GT.BO.Entities
{
    [Serializable]
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, Inherited=true)]
    public class BaseMappingAttribute : Attribute
    {
        public string FieldName = string.Empty;

        public BaseMappingAttribute(string fieldName)
        {
            FieldName = fieldName;
        }

        public virtual object Convert(object v, Type targetType)
        {
            return TypeConverter.TryConvert(v, targetType);
        }
    }
}
