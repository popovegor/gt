using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.Offers;
using GT.Global.Offers;
using GT.DA.Dictionaries;

namespace GT.BO.Implementation.Offers
{
  [XmlRoot("selling")]
  [Serializable]
  public class Selling : BaseOffer
  {
    [XmlIgnore]
    public int SellingId
    {
      get { return Id; }
      set { Id = value; }
    }

    [BaseSourceMapping(SellingOfferFields.SellerId)]
    [XmlAttributeAttribute("sellerId")]
    public Guid SellerId
    {
      get { return OwnerId; }
      set { OwnerId = value; }
    }

    [BaseComparable]
    [XmlIgnore]
    public TransactionPhase TransactionPhase
    {
      get
      {
        return GT.Common.Types.TypeConverter.ToEnumMember<TransactionPhase>(TransactionPhaseId);
      }
      set
      {
        TransactionPhaseId = (int)value;
      }
    }

    [XmlAttribute("transactionPhaseId")]
    [BaseSourceMapping(SellingOfferFields.TransactionPhaseId)]
    [BaseComparable]
    public int TransactionPhaseId { get; set; }

    [XmlAttribute("deliveryTime")]
    [BaseSourceMapping(SellingOfferFields.DeliveryTime)]
    [BaseComparable]
    public int DeliveryTime { get; set; }

    [XmlIgnore]
    [BaseSourceMapping(SellingOfferFields.ValidKey)]
    [BaseComparable]
    public string ValidKey
    {
      get;
      set;
    }

    [XmlAttribute("buyerId")]
    [BaseSourceMapping(SellingOfferFields.BuyerId)]
    [BaseComparable]
    public Guid BuyerId
    {
      get;
      set;
    }

    [XmlElement("image")]
    public SellingImage Image { get; set; }

    public Selling()
    {
      DeliveryTime = SellingOfferParams.DefaultDeliveryTime;
      TransactionPhaseId = (int)SellingOfferParams.DefaultTransactionPhase;
      Price = SellingOfferParams.DefaultPrice;
    }

    public Selling(int id, Guid sellerId, decimal price, TransactionPhase phase)
      : this()
    {
      SellingId = id;
      OwnerId = sellerId;
      Price = price;
      TransactionPhase = phase;
    }
  }
}
