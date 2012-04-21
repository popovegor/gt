using System;
using System.Collections.Generic;
using System.Text;

namespace GT.BO.Entities.DataSourceMapping
{
    [AttributeUsage(AttributeTargets.Field)]
    public class DataSourceMappingFieldAttribute : Attribute
    {
        public string FieldName = string.Empty;

        public DataSourceMappingFieldAttribute(string fieldName)
        {
            FieldName = fieldName;
        }
    }
}
