using System.Text;
using System.Web;

namespace GT.Common.Web.JS
{
	public class JSBuilder
	{
		private readonly StringBuilder m_sbScript;
		private int m_iIndent;
		public const string BEGIN_SCRIPT = "\r\n<script type=\"text/javascript\">\r\n";
		public const string END_SCRIPT = "</script>\r\n";
        public const string CRLF = "\r\n";

		public JSBuilder()
		{
			m_iIndent = 0;
			m_sbScript = new StringBuilder();
		}

		public void IncreaseIndent()
		{
			m_iIndent++;
		}

		public void DecreaseIndent()
		{
			if (m_iIndent > 0)
				m_iIndent--;
		}

		public void Write(string p_s)
		{
			m_sbScript.Append(GetTabs());
			m_sbScript.Append(p_s);
			m_sbScript.Append(CRLF);
		}

		public void Writeln()
		{
			Write("");
		}

		public void WriteI(string p_s)
		{
			IncreaseIndent();
			Write(p_s);
		}

		public void WriteD(string p_s)
		{
			DecreaseIndent();
			Write(p_s);
		}

		public void WriteT(string p_s)
		{
			IncreaseIndent();
			Write(p_s);
			DecreaseIndent();
		}

		public void Begin()
		{
			Write("{");
			IncreaseIndent();
		}

		public void End()
		{
			DecreaseIndent();
			Write("}");
		}

		public string Script
		{
			get { return BEGIN_SCRIPT + m_sbScript.ToString() + END_SCRIPT; }
		}

		public override string ToString()
		{
			return m_sbScript.ToString();
		}

		private string GetTabs()
		{
			string sTabs = "";
			for (int i = 0; i < m_iIndent; i++)
				sTabs += "\t";
			return sTabs;
		}

        public void RemoveLast(char p_ch)
        {
            if (m_sbScript[m_sbScript.Length - 1] == p_ch)
                m_sbScript.Remove(m_sbScript.Length - 1, 1);
            if (m_sbScript[m_sbScript.Length - CRLF.Length - 1] == p_ch)
                m_sbScript.Remove(m_sbScript.Length - CRLF.Length - 1, 1);
        }

		public static string JSStringEncode(string p_s)
		{
			if (p_s == null)
				return "";
			else
				return p_s.Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\n", "\\n").Replace("\r", "\\r");
		}

		public static string HTMLJSEncode(object p_value)
		{
			if (p_value == null)
				return "";
			else
				return HttpUtility.HtmlEncode(JSStringEncode(p_value.ToString()));
		}
	}
}