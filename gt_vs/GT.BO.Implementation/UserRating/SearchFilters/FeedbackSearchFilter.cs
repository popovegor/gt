using System;
using System.Collections.Generic;
using System.Xml.Serialization;
using GT.BO.Entities;

namespace GT.BO.Implementation.UserRating.SearchFilters
{

    [XmlRoot("vsf")]
    public class FeedbackSearchFilter : BaseEntity
    {
        [XmlAttribute("fuid")]
        public Guid FromUserId = Guid.Empty;

        [XmlAttribute("tuid")]
        public Guid ToUserId = Guid.Empty;
        
        [XmlAttribute("tbid")]
        public Guid ToBuyerId = Guid.Empty;

        [XmlAttribute("tsid")]
        public Guid ToSellerId = Guid.Empty;

        [XmlAttribute("c")]
        public int Count = int.MaxValue;
        
        [XmlArray("ftc")]
        [XmlArrayItem("ftid")]
        public List<int> FeedbackTypeCollection = new List<int>();

        public override int Id
        {
          get
          {
            return 0;
          }
          set
          {
            //
          }
        }
    }
}
