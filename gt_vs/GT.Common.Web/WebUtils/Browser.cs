using System;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.SessionState;
using GT.Common.Types;

namespace GT.Common.Web.WebUtils
{
	/// <summary>
	/// Summary description for Browser.
	/// </summary>
	public class Browser
	{
		public enum BrowserType
		{
			Unknown = 0,
			MSIE,
			Firefox,
			Opera,
			Netscape,
			Mozilla
		}

        public static Browser Create(HttpRequest p_request, HttpSessionState p_session)
        {
            string sKey = "Browser" + p_session.SessionID;
            if (!(p_session[sKey] is Browser))
                p_session[sKey] = new Browser(p_request);
            return p_session[sKey] as Browser;
        }
		
		private string m_sUserAgent = string.Empty;
		private BrowserType m_type = BrowserType.Unknown;
		private int m_iVersionMajor = 0;
		private int m_iVersionMinor = 0;
		
		private string m_sRegex = "(\\\\| |/){1}(?<VersionMajor>[\\d]+)\\.{1}(?<VersionMinor>[\\d]+)";
		
		private Browser(HttpRequest p_request)
		{
			m_sUserAgent = p_request.UserAgent;
            if (!string.IsNullOrEmpty(m_sUserAgent))
            {
                ProcessUserString();
                DetectVersion();
            }
		}

		public int VersionMajor
		{
			get { return m_iVersionMajor; }
		}

		public int VersionMinor
		{
			get { return m_iVersionMinor; }
		}
		
		public string VersionString
		{
			get { return m_iVersionMajor + "." + m_iVersionMinor; }
		}

		public BrowserType Type
		{
			get { return m_type; }
		}
		
		public string Name
		{
			get
			{
				switch(Type)
				{
					case BrowserType.Unknown:
						return string.Empty;
					case BrowserType.MSIE:
						return "Microsoft Internet Explorer";
					case BrowserType.Netscape:
						return "Netscape Browser";
					case BrowserType.Firefox:
						return "Mozilla Firefox";
					case BrowserType.Mozilla:
						return "Mozilla";
					default:
						return Type.ToString();
				}
			}
		}

	    public bool IsOldIE
	    {
	        get
	        {
	            return Type == BrowserType.MSIE && VersionMajor < 7;
	        }
	    }

		private void ProcessUserString()
		{
			if (m_sUserAgent.IndexOf(BrowserType.Opera.ToString()) != -1)
				m_type = BrowserType.Opera;
			else if (m_sUserAgent.IndexOf(BrowserType.Netscape.ToString()) != -1)
				m_type = BrowserType.Netscape;
			else if (m_sUserAgent.IndexOf(BrowserType.Firefox.ToString()) != -1)
				m_type = BrowserType.Firefox;
			else if (m_sUserAgent.IndexOf(BrowserType.MSIE.ToString()) != -1)
				m_type = BrowserType.MSIE;
			else if (m_sUserAgent.IndexOf(BrowserType.Mozilla.ToString()) != -1)
				m_type = BrowserType.Mozilla;
		}
		
		private void DetectVersion()
		{
			Regex RegexObj = new Regex(m_type.ToString() + m_sRegex);
			m_iVersionMajor = TypeConverter.ToInt32(RegexObj.Match(m_sUserAgent).Groups["VersionMajor"].Value);
			m_iVersionMinor = TypeConverter.ToInt32(RegexObj.Match(m_sUserAgent).Groups["VersionMinor"].Value);
		}
	}
}
