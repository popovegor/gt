using GT.Common.Text;

namespace GT.Common.Web.JS
{
	/// <summary>
	/// Summary description for JSFunctionCallBuilder.
	/// </summary>
	public class JSFunctionCallBuilder
	{
		private SeparatedString functionCall;

		public bool UseSingleQuote = false;

		public string Quote
		{
			get { return UseSingleQuote ? "'" : "\""; }
		}

		public JSFunctionCallBuilder(string p_sFunctionName) : this(p_sFunctionName, false)
		{
		}

		public JSFunctionCallBuilder(string p_sFunctionName, bool p_bUseSingleQuote)
		{
			UseSingleQuote = p_bUseSingleQuote;
			functionCall = new SeparatedString(", ", p_sFunctionName + "(");
		}

		public void Add(string p_sParameter)
		{
			Add(p_sParameter, false);
		}

		public void Add(string p_sParameter, bool p_bString)
		{
			if (p_bString)
				p_sParameter = Quote + JSBuilder.JSStringEncode(p_sParameter) + Quote;
			functionCall.Add(p_sParameter);
		}

		public override string ToString()
		{
			return ToString(true);
		}

        public string ToString(bool p_bEndWithSemocolon)
        {
            return functionCall.ToString() + ")" + (p_bEndWithSemocolon ? ";" : string.Empty);
        }

		public string Script
		{
			get { return JSBuilder.BEGIN_SCRIPT + ToString() + JSBuilder.END_SCRIPT; }
		}
	}
}