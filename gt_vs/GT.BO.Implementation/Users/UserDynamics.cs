using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.Users;

namespace GT.BO.Implementation.Users
{
  [XmlRoot("d")]
  public class UserDynamics : BaseEntity
  {
    [BaseSourceMapping(UserDynamicsFields.UserId)]
    [XmlAttribute("uid")]
    [BaseComparable]
    public Guid UserId = Guid.Empty;

    [BaseSourceMapping(UserDynamicsFields.DynamicsId)]
    [XmlAttribute("did")]
    [BaseComparable]
    public int DynamicDataId = 0;

    [BaseSourceMapping(UserDynamicsFields.MoneyAvailable)]
    [XmlAttribute("ma")]
    [BaseComparable]
    public decimal MoneyAvailable = 0;

    [BaseSourceMapping(UserDynamicsFields.MoneyBlocked)]
    [XmlAttribute("mb")]
    [BaseComparable]
    public decimal MoneyBlocked = 0;

    [BaseSourceMapping(UserDynamicsFields.MoneyTotal)]
    [XmlAttribute("mtot")]
    [BaseComparable]
    public decimal MoneyTotal = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsSellerFinished)]
    [XmlAttribute("dsf")]
    [BaseComparable]
    public int DealsSellerFinished = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsBuyerFinished)]
    [XmlAttribute("dbf")]
    [BaseComparable]
    public int DealsBuyerFinished = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsBuyerAccepted)]
    [XmlAttribute("dba")]
    [BaseComparable]
    public int DealsBuyerAccepted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsSellerAccepted)]
    [XmlAttribute("dsa")]
    [BaseComparable]
    public int DealsSellerAccepted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsStarted)]
    [XmlAttribute("dst")]
    [BaseComparable]
    public int DealsStarted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsSellerSubmitted)]
    [XmlAttribute("dssb")]
    [BaseComparable]
    public int DealsSellerSubmitted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsBuyerSubmitted)]
    [XmlAttribute("dbsb")]
    [BaseComparable]
    public int DealsBuyerSubmitted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsSellerConflicted)]
    [XmlAttribute("dsc")]
    [BaseComparable]
    public int DealsSellerConflicted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsBuyerConflicted)]
    [XmlAttribute("dbc")]
    [BaseComparable]
    public int DealsBuyerConflicted = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsSellerTotal)]
    [XmlAttribute("dstot")]
    [BaseComparable]
    public int DealsSellerTotal = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsBuyerTotal)]
    [XmlAttribute("dbtot")]
    [BaseComparable]
    public int DealsBuyerTotal = 0;

    [BaseSourceMapping(UserDynamicsFields.DealsTotal)]
    [XmlAttribute("dtot")]
    [BaseComparable]
    public int DealsTotal = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksPositive)]
    [XmlAttribute("fpos")]
    [BaseComparable]
    public int FeedbacksPositive = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksNegative)]
    [XmlAttribute("fneg")]
    [BaseComparable]
    public int FeedbacksNegative = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksNeutral)]
    [XmlAttribute("fnet")]
    [BaseComparable]
    public int FeedbacksNeutral = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksTotal)]
    [XmlAttribute("ftot")]
    [BaseComparable]
    public int FeedbacksTotal = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksForOthers)]
    [XmlAttribute("ffo")]
    [BaseComparable]
    public int FeedbacksForOthers = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksAsBuyer)]
    [XmlAttribute("fasb")]
    [BaseComparable]
    public int FeedbacksAsBuyer = 0;

    [BaseSourceMapping(UserDynamicsFields.FeedbacksAsSeller)]
    [XmlAttribute("fass")]
    [BaseComparable]
    public int FeedbacksAsSeller = 0;

    [BaseSourceMapping(UserDynamicsFields.MessagesIn)]
    [XmlAttribute("msgin")]
    [BaseComparable]
    public int MessagesIn
    {
      get;
      set;
    }

    [BaseSourceMapping(UserDynamicsFields.MessagesOut)]
    [XmlAttribute("msgout")]
    [BaseComparable]
    public int MessagesOut
    {
      get;
      set;
    }

    [BaseSourceMapping(UserDynamicsFields.MessagesTotal)]
    [XmlAttribute("msgtotal")]
    [BaseComparable]
    public int MessagesTotal
    {
      get;
      set;
    }

    [BaseSourceMapping(UserDynamicsFields.MessagesUnread)]
    [XmlAttribute("msgunread")]
    [BaseComparable]
    public int MessagesUnread
    {
      get;
      set;
    }

    [BaseSourceMapping(UserDynamicsFields.BuyingTotal)]
    [XmlAttribute("buytotal")]
    [BaseComparable]
    public int BuyingTotal
    {
      get;
      set;
    }

    [BaseSourceMapping(UserDynamicsFields.FeedbacksUnused)]
    [XmlAttribute("fdbunused")]
    [BaseComparable]
    public int FeedbacksUnused
    {
      get;
      set;
    }

    public override int Id
    {
      get { return DynamicDataId; }
      set
      {
        DynamicDataId = value;
      }
    }
  }
}
