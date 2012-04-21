
 
 
 
 
 


 
using GT.Global.Localization;

namespace GT.DA.Dictionaries
{
	public static class WebMoneyMessageFields
	{
		public const string WebMoneyMessageId = "WebMoneyMessageId";
		public const string Retcode = "Retcode";
		public const string Type = "Type";
		public const string Message = "Message";
		public static string LocalizedMessage
		{
			get {return Localizator.GetLocalizedFieldName("Message");}
		}
		public const string MessageRu = "MessageRu";
		public const string Description = "Description";
	}
}