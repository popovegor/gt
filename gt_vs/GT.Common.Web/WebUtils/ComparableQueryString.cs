using System;
using System.Collections.Specialized;

namespace GT.Common.Web.WebUtils
{
    public class ComparableQueryString : IEquatable<NameValueCollection>
    {
        private readonly NameValueCollection baseQueryString;

        public ComparableQueryString(NameValueCollection p_baseQueryString)
        {
            baseQueryString = p_baseQueryString;
        }

        public NameValueCollection BaseQueryString
        {
            get { return baseQueryString; }
        }

        #region IEquatable<NameValueCollection> Members

        public bool Equals(NameValueCollection other)
        {
            if (other.AllKeys.Length != baseQueryString.AllKeys.Length)
                return false;
            return IsIncludedTo(other);
        }

        #endregion

        public bool IsIncludedTo(NameValueCollection other)
        {
            foreach (string sKey in baseQueryString.AllKeys)
                if (other[sKey] == null ||
                    (other[sKey] != null &&
                     other[sKey] != baseQueryString[sKey]))
                    return false;
            return true;
        }

        public bool KeysEquals(NameValueCollection other)
        {
            if (other.AllKeys.Length != baseQueryString.AllKeys.Length)
                return false;
            return IsKeysIncludedTo(other);
        }

        public bool IsKeysIncludedTo(NameValueCollection other)
        {
            foreach (string sKey in baseQueryString.AllKeys)
                if (other[sKey] == null)
                    return false;
            return true;
        }

        public int GetEqualityIndex(NameValueCollection other)
        {
            int iReturn = 0;
            foreach (string key in baseQueryString.AllKeys)
            {
                if (other[key] != null)
                {
                   iReturn++;
                   if(other[key].Equals(baseQueryString[key], StringComparison.InvariantCultureIgnoreCase))
                   {
                    iReturn++;
                   }
                }
            }
            return iReturn;
        }
    }
}