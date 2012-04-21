using System;
using GT.Common.Types;

namespace GT.BO.Entities
{
    [Serializable]
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, Inherited=true)]
    public class BaseSourceMappingAttribute : Attribute
    {
        public string[] FieldNames = null;

        public BaseSourceMappingAttribute(params string[] fieldName)
        {
            FieldNames = fieldName;
        }

        public virtual object Convert(object v, Type targetType)
        {
            return TypeConverter.TryConvert(v, targetType);
        }
    }
}
