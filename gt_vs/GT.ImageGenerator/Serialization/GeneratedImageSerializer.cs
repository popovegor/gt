using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Reflection;
using System.Text;
using System.Web;
using GT.Common;
using GT.Common.Cryptography;
using GT.Common.Exceptions;
using GT.Common.Reflection;
using GT.Common.Text;
using GT.Common.Types;
using GT.ImageGenerator.GeneratedImages;

namespace GT.ImageGenerator.Serialization
{
    internal sealed class GeneratedImageSerializer
    {
        private static object _lockObject = new object();
        private static readonly Dictionary<int, Type> m_types;

        static GeneratedImageSerializer()
        {
            lock (_lockObject)
            {
                Type[] types = Assembly.GetExecutingAssembly().GetTypes();
                m_types = new Dictionary<int, Type>(types.Length);
                foreach (Type type in types)
                {
                    if (type.IsSubclassOf(typeof (GeneratedImageBase)) &&
                        !type.IsAbstract)
                    {
                        object instance = null;
                        try
                        {
                            instance = type.InvokeMember(null,
                                                         BindingFlags.Public |
                                                         BindingFlags.NonPublic |
                                                         BindingFlags.Instance |
                                                         BindingFlags.
                                                             CreateInstance,
                                                         null,
                                                         null, null);
                        }
                        catch (Exception e)
                        {
                            AssistLogger.Log<ExceptionHolder>(new Exception(string.Format("Cannot reflect type {0}", type), e));
                        }

                        if (instance != null)
                        {
                            int iUniqueID = (int) ReflectionHelper.GetPropertyValue(instance, "UniqueID");
                            if (!m_types.ContainsKey(iUniqueID))
                                m_types.Add(iUniqueID, type);
                            else
                                AssistLogger.Log<ExceptionHolder>(
                                    new Exception(
                                        string.Format(
                                            "Duplicate key in dictionary. Key: {0}, type 1: {1}, type 2: {2}",
                                            iUniqueID, m_types[iUniqueID], type)));
                        }
                    }
                }
            }
        }

        private class SerializablePropertyInfo : IEquatable<SerializablePropertyInfo>
        {
            public readonly string PropertyName;
            public readonly string SerializedPropertyName;
            public readonly bool Encrypt;
            public readonly SerializeDelegate SerializeMethod;
            public readonly DeserializeDelegate DeserializeMethod;

            public SerializablePropertyInfo(Type PropertyType, string PropertyName,
                                            string SerializedPropertyName, bool Encrypt)
            {
                this.PropertyName = PropertyName;
                this.SerializedPropertyName = SerializedPropertyName;
                this.Encrypt = Encrypt;
                SerializeMethod = Converter.GetSerializationMethod(PropertyType);
                DeserializeMethod = Converter.GetDeserializationMethod(PropertyType);
            }

            public string Serialize(object oTarget)
            {
                object oPropValue = ReflectionHelper.GetPropertyValue(oTarget, PropertyName);
                string sValue = (oPropValue == null) ? string.Empty : SerializeMethod(oPropValue);
                if (!string.IsNullOrEmpty(sValue) && 
                    Encrypt)
                    using(TripleDES trd = new TripleDES(GeneratedImageManager.Configuration.Password))
                        sValue = trd.Encrypt(sValue);
                return string.Format("{0}={1}", SerializedPropertyName, HttpUtility.UrlEncode(sValue));
            }

            public void Deserialize(object oTarget, string p_sValue)
            {
                if (!string.IsNullOrEmpty(p_sValue) &&
                    Encrypt)
                    using (TripleDES trd = new TripleDES(GeneratedImageManager.Configuration.Password))
                        p_sValue = trd.Decrypt(p_sValue);
                ReflectionHelper.SetPropertyValue(oTarget, PropertyName,
                                                 string.IsNullOrEmpty(p_sValue) ? null : DeserializeMethod(p_sValue));
            }

            public bool Equals(SerializablePropertyInfo other)
            {
                return other.PropertyName == PropertyName &&
                       other.SerializedPropertyName == SerializedPropertyName;
            }
        }

        private static readonly Dictionary<string, List<SerializablePropertyInfo>> m_maps =
            new Dictionary<string, List<SerializablePropertyInfo>>();

        private static List<SerializablePropertyInfo> GetObjectMap(GeneratedImageBase p_image)
        {
            List<SerializablePropertyInfo> list = null;
            if (!m_maps.TryGetValue(p_image.GetType().ToString(), out list))
            {
                Type type = p_image.GetType();
                List<SerializablePropertyInfo> newlist = new List<SerializablePropertyInfo>();
                while (type != null)
                {
                    foreach (
                        PropertyInfo property in
                            type.GetProperties(BindingFlags.Public | BindingFlags.Instance))
                    {
                        object[] attrs = property.GetCustomAttributes(typeof (QueryStringSerializableAttribute),
                                                                      true);
                        if (attrs != null &&
                            attrs.Length > 0 &&
                            attrs[0] != null &&
                            attrs[0] is QueryStringSerializableAttribute)
                        {
                            QueryStringSerializableAttribute attr = attrs[0] as QueryStringSerializableAttribute;
                            SerializablePropertyInfo info = new SerializablePropertyInfo(property.PropertyType,
                                                         property.Name,
                                                         attr.Name, attr.Encrypt);
                            if (!newlist.Contains(info))
                                newlist.Add(info);
                        }
                    }
                    type = type.BaseType;
                }
                lock (_lockObject)
                {
                    if (!m_maps.TryGetValue(p_image.GetType().ToString(), out list))
                    {
                        list = newlist;
                        m_maps.Add(p_image.GetType().ToString(), list);
                    }
                }
            }
            return list;
        }

        private static List<SerializablePropertyInfo> GetObjectMap(Type p_type, out GeneratedImageBase p_image)
        {
            List<SerializablePropertyInfo> list = null;
            p_image = (GeneratedImageBase) p_type.InvokeMember(null,
                                                               BindingFlags.DeclaredOnly |
                                                               BindingFlags.Public | BindingFlags.NonPublic |
                                                               BindingFlags.Instance | BindingFlags.CreateInstance, null,
                                                               null, null);
            if (!m_maps.TryGetValue(p_type.ToString(), out list))
                list = GetObjectMap(p_image);
            return list;
        }

        public static string Serialize(GeneratedImageBase p_image)
        {
            List<SerializablePropertyInfo> list = GetObjectMap(p_image);
            StringBuilder sbReturn = new StringBuilder();
            for (int i = 0; i < list.Count; ++i)
            {
                sbReturn.Append(i == 0 ? "?" : "&");
                sbReturn.Append(list[i].Serialize(p_image));
            }
            return sbReturn.ToString();
        }

        public static GeneratedImageBase Deserialize(string p_sQuery)
        {
            NameValueCollection query = HttpUtility.ParseQueryString(p_sQuery);
            //<PATCH> Cannot reproduce behavior.
            string[] keys = query.AllKeys;
            string amp = "amp;";
            for(int i = 0; i < keys.Length; ++i)
            {
                if (keys[i].StartsWith(amp))
                {
                    string sKey = keys[i];
                    string sValue = query[sKey];
                    query.Remove(sKey);
                    query.Set(sKey.Substring(amp.Length), sValue);
                }
            }
            //</PATCH>
            
            string sTypeName = query[GeneratedImageBase.TYPE_PROPERTY_NAME];
            if (string.IsNullOrEmpty(sTypeName))
                throw new ArgumentException("No type name specified in the query string",
                                            GeneratedImageBase.TYPE_PROPERTY_NAME);
            Type imageType = StringUtils.IsDigitString(sTypeName)
                                     ? m_types[TypeConverter.ToInt32(sTypeName)]
                                     : FindByTypeName(sTypeName);
            GeneratedImageBase image = null;
            List<SerializablePropertyInfo> list = GetObjectMap(imageType, out image);
            if (list != null &&
                image != null)
                foreach (SerializablePropertyInfo info in list)
                    info.Deserialize(image, query[info.SerializedPropertyName]);
            return image;
        }

        private static Type FindByTypeName(string p_sTypeName)
        {
            foreach (KeyValuePair<int, Type> pair in m_types)
                if (pair.Value.ToString() == p_sTypeName)
                    return pair.Value;
            return null;
        }
    }
}