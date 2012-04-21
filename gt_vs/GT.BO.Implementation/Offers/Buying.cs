using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.Offers;
using System.ComponentModel;
using GT.DA.Dictionaries;

namespace GT.BO.Implementation.Offers
{
  [Serializable]
  [XmlRoot("buying")]
  public class Buying : BaseOffer
  {
    [BaseSourceMapping(BuyingOfferFields.BuyerId)]
    [XmlAttributeAttribute("buyerId")]
    public Guid BuyerId
    {
      get { return OwnerId; }
      set { OwnerId = value; }
    }

    [XmlIgnore]
    public int BuyingOfferId
    {
      get
      {
        return Id;
      }
      set
      {
        Id = value;
      }
    }

    public Buying()
      : base()
    {

    }
  }
}
