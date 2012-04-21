
 
 
 
 
 


 
using GT.Global.Localization;

namespace GT.DA.Dictionaries
{
	public static class MessageTemplateFields
	{
		public const string MessageTemplateId = "MessageTemplateId";
		public const string Name = "Name";
		public const string Subject = "Subject";
		public static string LocalizedSubject
		{
			get {return Localizator.GetLocalizedFieldName("Subject");}
		}
		public const string SubjectRu = "SubjectRu";
		public const string Body = "Body";
		public static string LocalizedBody
		{
			get {return Localizator.GetLocalizedFieldName("Body");}
		}
		public const string BodyRu = "BodyRu";
	}
}