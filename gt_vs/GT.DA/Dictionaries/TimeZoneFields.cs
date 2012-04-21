
 
 
 
 
 


 
using GT.Global.Localization;

namespace GT.DA.Dictionaries
{
	public static class TimeZoneFields
	{
		public const string TimeZoneId = "TimeZoneId";
		public const string DotNetTimeZoneId = "DotNetTimeZoneId";
		public const string Name = "Name";
		public static string LocalizedName
		{
			get {return Localizator.GetLocalizedFieldName("Name");}
		}
		public const string NameRu = "NameRu";
		public const string Offset = "Offset";
	}
}