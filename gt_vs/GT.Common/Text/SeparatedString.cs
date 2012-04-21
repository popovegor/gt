using System.Data;
using System.Text;
using GT.Common.Types;

namespace GT.Common.Text
{
	/// <summary>
	/// Summary description for SeparatedString.
	/// </summary>
	public class SeparatedString
	{
		private readonly string m_sSeparator = string.Empty;
		private int m_iCount = 0;
		private string m_sPrefix = string.Empty;
		private readonly StringBuilder m_stringBuilder;

		public string Separator
		{
			get { return m_sSeparator; }
		}

		public string Prefix
		{
			get { return m_sPrefix; }

			set { m_sPrefix = value; }
		}

		public override string ToString()
		{
			if (m_stringBuilder.ToString().Length > 0)
				return m_sPrefix + m_stringBuilder.ToString();
			else
				return "";
		}

		public SeparatedString() : this(",")
		{
		}

		public SeparatedString(string p_sSeparator) : this(p_sSeparator, string.Empty)
		{
		}

		public SeparatedString(string p_sSeparator, string p_sPrefix)
		{
			m_sSeparator = p_sSeparator;
			m_sPrefix = p_sPrefix;
			m_iCount = 0;
			m_stringBuilder = new StringBuilder();
		}

		public void Add(string p_sElement)
		{
			Add(p_sElement, false);
		}

		public void Add(string p_sElement, bool p_bIgnoreEmpty)
		{
			if (p_bIgnoreEmpty && TypeConverter.IsNullOrEmpty(p_sElement))
				return;
			if (m_iCount++ > 0)
				m_stringBuilder.Append(m_sSeparator);
			m_stringBuilder.Append(p_sElement);
		}

        public int Length
	    {
	        get
	        {
	            return m_stringBuilder.Length;
	        }
	    }

		public static string GlueStrings(string[] strings, string p_sSeparator)
		{
			SeparatedString separatedString = new SeparatedString(p_sSeparator);
			for (int i = 0; i < strings.Length; i++)
				separatedString.Add(strings[i]);
			return separatedString.ToString();
		}

		public static string GlueRows(DataView p_dv, string p_sColumnName, string p_sSeparator)
		{
			SeparatedString separatedString = new SeparatedString(p_sSeparator);
			foreach (DataRowView drv in p_dv)
				separatedString.Add(drv.Row[p_sColumnName].ToString());
			return separatedString.ToString();
		}
	}
}