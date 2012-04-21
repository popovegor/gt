using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Users;
using GT.DA.Dictionaries;
using GT.Global.Entities;

namespace GT.BO.Implementation.BillingSystem
{
    [XmlRoot("tp")]
    public class TransferParticipant : BaseEntity
    {
        [XmlAttribute("tpid")]
        [BaseSourceMapping("TransferParticipantId")]
        public int TransferParticipantId = 0;

        [XmlAttribute("uid")]
        [BaseSourceMapping("UserId")]
        public Guid UserId 
        {
          set;get;
        }

        [XmlAttribute("soid")]
        [BaseSourceMapping("SellingOfferId")]
        public int SellingOfferId = 0;

        [XmlAttribute("rmsid")]
        [BaseSourceMapping("RealMoneySourceId")]
        public int RealMoneySourceId = 0;

        [XmlIgnore]
        public EntityType ActualEntityType
        {
            get
            {
                if (UserId != Guid.Empty)
                {
                    return EntityType.User;
                }
                if (SellingOfferId != 0)
                {
                    return EntityType.SellingOffer;
                }
                if (RealMoneySourceId != 0)
                {
                    return EntityType.RealMoneySource;
                }
                return EntityType.None;
            }
        }

        public virtual string ActualEntityName
        {
            get
            {
                switch (ActualEntityType)
                {
                    case EntityType.User:
                        return UsersFacade.GetUser(UserId).UserName;
                    case EntityType.SellingOffer:
                        return SellingFacade.GetOfferByTransferParticipantId(TransferParticipantId).Title;
                    case EntityType.RealMoneySource:
                        return Dictionaries.Instance.GetRealMoneySourceNameById(RealMoneySourceId);
                }
                return string.Empty;
            }
        }

        public override int Id
        {
          get
          {
            return TransferParticipantId;
          }
          set
          {
            TransferParticipantId = value;
          }
        }
    }
}
