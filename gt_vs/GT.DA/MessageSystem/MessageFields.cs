
 
 
 
 
 


 
using GT.Global.Localization;

namespace GT.DA.MessageSystemystem
{
	public static class MessageFields
	{
		public const string MessageId = "MessageId";
		public const string SenderId = "SenderId";
		public const string RecipientId = "RecipientId";
		public const string Body = "Body";
		public static string LocalizedBody
		{
			get {return Localizator.GetLocalizedFieldName("Body");}
		}
		public const string BodyRu = "BodyRu";
		public const string Unread = "Unread";
		public const string CreateDate = "CreateDate";
		public const string Deleted = "Deleted";
		public const string SenderName = "SenderName";
		public const string RecipientName = "RecipientName";
		public const string ConversationId = "ConversationId";
	}
}
