using System.Collections.Specialized;
using GT.Common.Types;

namespace GT.Common.Web.JS
{
	/// <summary>
	/// Summary description for JSONObject.
	/// </summary>
	public class JSONObject : NameValueCollection
	{
		public JSONObject()
		{
		}

		public string GetJSONVariable(string p_sVariableName)
		{
			return string.Format("var {0} = {1};", p_sVariableName, JSONString);
		}

		public string JSONString
		{
			get
			{
				string sReturn = string.Empty;
				foreach (string  key in Keys)
				{
					if (sReturn != string.Empty)
						sReturn += ",";
					sReturn += string.Format("{0}: '{1}'", key, TypeConverter.ToString(this[key]));
				}
				sReturn = sReturn.TrimEnd(new char[] {','});
				return "{" + sReturn + "}";
			}
		}
	}
}