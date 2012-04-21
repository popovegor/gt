using System;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace GT.Common.Collections
{
	/// <summary>
	/// Summary description for SerializerCollection.
	/// </summary>
	public class SerializerCollection : Dictionary<string, XmlSerializer>
	{
		private object _lockObject = new object();

        public readonly XmlSerializerNamespaces Namespaces = new XmlSerializerNamespaces();
		
		public SerializerCollection() : base()
		{
            Namespaces.Add(string.Empty, string.Empty);
		}

        public SerializerCollection(int p_capacity)
            : base(p_capacity)
        {
            Namespaces.Add(string.Empty, string.Empty);
        }
		
		public SerializerCollection(XmlSerializerNamespaces p_xn) : base()
		{
            Namespaces = p_xn;
		}
		
		public XmlSerializer this[Type p_type]
		{
			get
			{
				string sKey = p_type.FullName;
                lock (_lockObject)
                {
                    if (!ContainsKey(sKey))
                        Add(sKey, new XmlSerializer(p_type));
                }
                return base[sKey];
			}
		}
		
	}
}
