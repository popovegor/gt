using System;

namespace GT.ImageGenerator.Serialization
{
    [AttributeUsage(AttributeTargets.Property)]
    public sealed class QueryStringSerializableAttribute : Attribute
    {
        private string m_sName = string.Empty;
        private bool m_bEncrypt = false;

        public QueryStringSerializableAttribute(string Name)
        {
            this.Name = Name;
        }

        public QueryStringSerializableAttribute(string Name, bool Encrypt) : 
            this(Name)
        {
            this.Encrypt = Encrypt;
        }

        public string Name
        {
            get { return m_sName; }
            set { m_sName = value; }
        }

        public bool Encrypt
        {
            get { return m_bEncrypt; }
            set { m_bEncrypt = value; }
        }
    }
}