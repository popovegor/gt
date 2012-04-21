using System;
using System.Web.UI;
using GT.Common.Types;

namespace GT.Common.Web.WebUtils
{
	/// <summary>
	/// Summary description for ViewStateUtils.
	/// </summary>
	public class ViewStateUtils
	{
		public static object GetPageViewStateProperty(Page p_page, StateBag p_ViewState, string p_sPropertyName, string p_sFormPropertyName, Type p_TargetType)
		{
			if (p_page.IsPostBack)
				return GetValue(p_page.Request.Form[p_sFormPropertyName], p_TargetType);
			else
				return GetValue(p_ViewState[p_sPropertyName], p_TargetType);
		}
		
		private static object GetValue(object p_obj, Type p_TargetType)
		{
			if (p_TargetType == typeof(int))
				return TypeConverter.ToInt32(p_obj);
			else if (p_TargetType == typeof(decimal))
				return TypeConverter.ToDecimal(p_obj);
			else if (p_TargetType == typeof(bool))
				return TypeConverter.ToBool(p_obj);
			else if (p_TargetType == typeof(DateTime))
				return TypeConverter.ToDateTime(p_obj);
			else
				return TypeConverter.ToString(p_obj);
		}
	}
}
