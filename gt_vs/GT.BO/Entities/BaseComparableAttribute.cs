using System;

namespace GT.BO.Entities
{
    [Serializable]
    [AttributeUsage(AttributeTargets.Field | AttributeTargets.Property, Inherited = true)]
    public class BaseComparableAttribute : Attribute
    {

    }
}
