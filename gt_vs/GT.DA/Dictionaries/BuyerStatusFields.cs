
 
 
 
 
 


 
using GT.Global.Localization;

namespace GT.DA.Dictionaries
{
	public static class BuyerStatusFields
	{
		public const string BuyerStatusId = "BuyerStatusId";
		public const string Name = "Name";
		public static string LocalizedName
		{
			get {return Localizator.GetLocalizedFieldName("Name");}
		}
		public const string NameRu = "NameRu";
		public const string Description = "Description";
		public static string LocalizedDescription
		{
			get {return Localizator.GetLocalizedFieldName("Description");}
		}
		public const string DescriptionRu = "DescriptionRu";
	}
}