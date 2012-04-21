using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Reflection;
using System.Xml;
using GT.Common.Reflection;
using GT.Common.Xml;
using System.Linq;
using System.Xml.Serialization;

namespace GT.BO.Entities
{
  [Serializable]
  public abstract class BaseEntity
  {
    private readonly Lazy<Dictionary<MemberInfo, BaseSourceMappingAttribute>> _mappingMembers
      = new Lazy<Dictionary<MemberInfo, BaseSourceMappingAttribute>>();

    private readonly Lazy<Dictionary<MemberInfo, BaseComparableAttribute>> _comparableMembers
      = new Lazy<Dictionary<MemberInfo, BaseComparableAttribute>>();

    //private readonly Lazy<Dictionary<MemberInfo, EntityIdAttribute>> _idMembers
    //  = new Lazy<Dictionary<MemberInfo, EntityIdAttribute>>();

    private static object _lock = new object();

    protected Dictionary<MemberInfo, BaseSourceMappingAttribute> MappingMembers
    {
      get
      {
        return _mappingMembers.Value;
      }
    }

    protected Dictionary<MemberInfo, BaseComparableAttribute> ComparableMembers
    {
      get
      {
        return _comparableMembers.Value;
      }
    }

    public BaseEntity()
    {
      _comparableMembers = new Lazy<Dictionary<MemberInfo, BaseComparableAttribute>>(()
        => ReflectionHelper.GetMembersWithCustomAttribute<BaseComparableAttribute>(this), true);

      _mappingMembers = new Lazy<Dictionary<MemberInfo, BaseSourceMappingAttribute>>(()
        => ReflectionHelper.GetMembersWithCustomAttribute<BaseSourceMappingAttribute>(this), true);

      //_idMembers = new Lazy<Dictionary<MemberInfo, EntityIdAttribute>>(()
      //  => ReflectionHelper.GetMembersWithCustomAttribute<EntityIdAttribute>(this), true);
    }

    public virtual XmlDocument ToXmlDocument()
    {
      return Serialize();
    }

    public virtual string ToXmlString()
    {
      return Serialize().InnerXml;
    }

    //public virtual BaseEntity Load(XmlDocument xml)
    //{
    //    return XmlSerializationHelper
    //}

    public virtual T Load<T>(string xml)
        where T : BaseEntity
    {
      return XmlSerializationHelper.Deserialize<T>(xml);
    }

    public virtual BaseEntity Load(DataRow dr)
    {
      if (null == dr)
      {
        return null;
      }
      else
      {
        foreach (KeyValuePair<MemberInfo, BaseSourceMappingAttribute> f in MappingMembers)
        {
          var fieldName = f.Value.FieldNames.FirstOrDefault(fn
            => true == dr.Table.Columns.Contains(fn));
          if (string.IsNullOrEmpty(fieldName) == false)
          {
            switch (f.Key.MemberType)
            {
              case MemberTypes.Field:
                (f.Key as FieldInfo).SetValue(this
                    , f.Value.Convert(dr[fieldName]
                    , (f.Key as FieldInfo).FieldType));
                break;
              case MemberTypes.Property:
                (f.Key as PropertyInfo).SetValue(this
                    , f.Value.Convert(dr[fieldName]
                    , (f.Key as PropertyInfo).PropertyType), null);
                break;
              default:
                throw new NotSupportedException(
                    string.Format("The type[{0}] of the MemberInfo object is not supported", f.Key.MemberType));
            }
          }
        }
        return this;
      }
    }

    public virtual T Load<T>(DataRow dr)
        where T : BaseEntity
    {
      return Load(dr) as T;
    }

    public bool Compare(BaseEntity entity)
    {
      Debug.WriteLine(entity.ToXmlString());
      Debug.WriteLine(this.ToXmlString());
      bool result = false;
      if (null != entity)
      {
        Type x = this.GetType();
        Type y = entity.GetType();
        foreach (KeyValuePair<MemberInfo, BaseComparableAttribute> cm in entity.ComparableMembers)
        {
          object xValue = null;
          object yValue = null;
          switch (cm.Key.MemberType)
          {

            case MemberTypes.Field:
              xValue = x.GetField(cm.Key.Name).GetValue(this);
              yValue = y.GetField(cm.Key.Name).GetValue(entity);
              break;
            case MemberTypes.Property:
              xValue = x.GetProperty(cm.Key.Name).GetValue(this, null);
              yValue = y.GetProperty(cm.Key.Name).GetValue(entity, null);
              break;
            default:
              throw new NotSupportedException(
                  string.Format("The type[{0}] of the MemberInfo object is not supported", cm.Key.MemberType));
          }
          result = null != xValue && null != yValue && xValue.Equals(yValue);
          if (false == result)
          {
            Debug.WriteLine(string.Format("Property '{0}': {1} != {2}", cm.Key.Name, xValue, yValue));
            break;
          }
        }
      }
      return result;
    }

    private XmlDocument Serialize()
    {
      return XmlSerializationHelper.SerializeToXmlDocument(this);
    }

    [XmlIgnore]
    public abstract int Id
    {
      get;
      set;
    }
  }
}