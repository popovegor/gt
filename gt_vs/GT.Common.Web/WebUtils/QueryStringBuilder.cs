using System;
using System.Text;
using System.Web;
using GT.Common.Types;

namespace GT.Common.Web.WebUtils
{
	/// <summary>
	/// Summary description for QueryStringBuilder.
	/// </summary>
	public class QueryStringBuilder
	{
		const string PARAM = "&{0}=";
		
		private readonly StringBuilder m_sbQueryString;
		
		public QueryStringBuilder() : this(string.Empty, true)
		{
		}
		
		public QueryStringBuilder(bool p_bStartWithSearch) : this(string.Empty, p_bStartWithSearch)
		{
		}
		
		public QueryStringBuilder(string p_sUrl, bool p_bStartWithSearch)
		{
			if (!p_sUrl.EndsWith("?") && p_bStartWithSearch)
				p_sUrl += "?";
			m_sbQueryString = new StringBuilder(p_sUrl);	
		}
		
		public void Add(string p_sParamName, string p_sParamValue, bool p_bHtmlEncode)
		{
			if (p_bHtmlEncode)
				p_sParamValue = HttpUtility.HtmlEncode(p_sParamValue);
			Add(p_sParamName, p_sParamValue);
		}
		
		public void Add(string p_sParamName, string p_sParamValue)
		{
			if (!TypeConverter.IsNullOrEmpty(p_sParamName) &&
				!TypeConverter.IsNullOrEmpty(p_sParamValue))
			{
				m_sbQueryString.AppendFormat(PARAM, p_sParamName);
				m_sbQueryString.Append(p_sParamValue);
			}
		}
		
		public override string ToString()
		{
			return m_sbQueryString.ToString();
		}

        public static string RemoveQueryStringVariableFromUrl(string p_sUrl, string p_sQSVar)
        {
            int iPosQ = p_sUrl.IndexOf('?');
            if (iPosQ >= 0)
            {
                string sSeparator = "&";
                string sQuest = "?";
                string sToken = sSeparator + p_sQSVar + "=";
                RemoveQueryStringVariableFromUrl(ref p_sUrl, iPosQ, sToken, sSeparator, sSeparator.Length);
                sToken = sQuest + p_sQSVar + "=";
                RemoveQueryStringVariableFromUrl(ref p_sUrl, iPosQ, sToken, sSeparator, sQuest.Length);
                sSeparator = HttpUtility.UrlEncode("&");
                sQuest = HttpUtility.UrlEncode("?");
                sToken = sSeparator + HttpUtility.UrlEncode(p_sQSVar + "=");
                RemoveQueryStringVariableFromUrl(ref p_sUrl, iPosQ, sToken, sSeparator, sSeparator.Length);
                sToken = sQuest + HttpUtility.UrlEncode(p_sQSVar + "=");
                RemoveQueryStringVariableFromUrl(ref p_sUrl, iPosQ, sToken, sSeparator, sQuest.Length);
            }
            return p_sUrl;
        }

        private static void RemoveQueryStringVariableFromUrl(ref string p_sUrl, int p_iPosQ, string p_sToken, 
            string p_sSeparator, int p_iLenAtStartToLeave)
        {
            for (int i = p_sUrl.LastIndexOf(p_sToken, StringComparison.Ordinal); i >= p_iPosQ; i = p_sUrl.LastIndexOf(p_sToken, StringComparison.Ordinal))
            {
                int iStartIndex = p_sUrl.IndexOf(p_sSeparator, i + p_sToken.Length, StringComparison.Ordinal) + p_sSeparator.Length;
                if (iStartIndex < p_sSeparator.Length || 
                    iStartIndex >= p_sUrl.Length)
                    p_sUrl = p_sUrl.Substring(0, i);
                else
                    p_sUrl = p_sUrl.Substring(0, i + p_iLenAtStartToLeave) + p_sUrl.Substring(iStartIndex);
            }
        }

 

 

	}
}
