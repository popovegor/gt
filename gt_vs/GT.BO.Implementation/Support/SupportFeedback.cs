using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.Support;

namespace GT.BO.Implementation.Support
{
  [XmlRoot("feedback")]
  [Serializable]
  public class SupportFeedback : BaseEntity
  {
    [XmlAttribute("feedbackId")]  
    [BaseSourceMapping(SupportFeedbackFields.FeedbackId)]
    public override int Id  
    {
      get;
      set;  
    }
  
    [XmlAttribute("userName")]
    [BaseSourceMapping(SupportFeedbackFields.UserName)]
    [BaseComparable]
    public string UserName
    {
      get;
      set;
    }

    [XmlAttribute("userEmail")]
    [BaseSourceMapping(SupportFeedbackFields.UserEmail)]
    [BaseComparable]
    public string UserEmail
    {
      get;
      set;
    }

    [XmlAttribute("message")]
    [BaseSourceMapping(SupportFeedbackFields.Message)]
    [BaseComparable]
    public string Message
    {
      get;
      set;
    }
  }
}
