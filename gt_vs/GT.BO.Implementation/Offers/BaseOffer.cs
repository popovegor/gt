using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Entities;
using GT.DA.Offers;
using System.Xml.Serialization;
using System.ComponentModel;
using GT.DA.Dictionaries;
using GT.Global.Offers;

namespace GT.BO.Implementation.Offers
{
  [XmlRoot("o")]
  [Serializable]
  public class BaseOffer : BaseEntity
  {
    [XmlAttributeAttribute("id")]
    [BaseSourceMapping(BuyingOfferFields.BuyingOfferId, SellingOfferFields.SellingId)]
    public override int Id
    {
      get;
      set;
    }
    
    [XmlIgnore]
    public Guid OwnerId
    {
      get;
      set;
    }

    [XmlAttributeAttribute("gameServerId")]
    [BaseSourceMapping(BuyingOfferFields.GameServerId, SellingOfferFields.GameServerId)]
    public int GameServerId
    {
      get;
      set;
    }

    [XmlAttributeAttribute("title")]
    [BaseSourceMapping(BuyingOfferFields.Title, SellingOfferFields.Title)]
    [DefaultValue("")]
    public string Title
    {
      get;
      set;
    }

    [XmlAttributeAttribute("description")]
    [BaseSourceMapping(BuyingOfferFields.Description, SellingOfferFields.Description)]
    [DefaultValue("")]
    public string Description
    {
      get;set;
    }

    [XmlAttributeAttribute("price")]
    [BaseSourceMapping(BuyingOfferFields.Price, SellingOfferFields.Price)]
    [DefaultValueAttribute(0.0)]
    public decimal Price { get; set; }

    [XmlAttributeAttribute("createDate")]
    [BaseSourceMapping(BuyingOfferFields.CreateDate, SellingOfferFields.CreateDate)]
    public DateTime CreateDate { get; set; }

    [XmlAttributeAttribute("updateDate")]
    [BaseSourceMapping(BuyingOfferFields.ModifyDate, SellingOfferFields.ModifyDate)]
    public DateTime ModifyDate { get; set; }

    [XmlAttribute("productCategoryId")]
    [BaseSourceMapping(BuyingOfferFields.ProductCategoryId, SellingOfferFields.ProductCategoryId)]
    [BaseComparable]
    public int ProductCategoryId
    {
      get;
      set;
    }

    [XmlAttribute("productCategoryMisc")]
    [BaseSourceMapping(BuyingOfferFields.ProductCategoryMisc)]
    [BaseComparable]
    [DefaultValue("")]
    public string ProductCategoryMisc
    {
      get;
      set;
    }

    [XmlIgnore]
    public string ProductCategoryName
    {
      get
      {
        return ProductCategoryId != Dictionaries.Instance.GetProductCategoryMiscId
          ? Dictionaries.Instance.GetProductCategoryNameById(ProductCategoryId)
          : ProductCategoryMisc;
      }
    }
    
    public BaseOffer()
    {
      ProductCategoryMisc = string.Empty;
      Title = string.Empty;
      Description = string.Empty;
      ProductCategoryMisc = string.Empty;
      ModifyDate = DateTime.MinValue;
      CreateDate = DateTime.MinValue;
    }
  }
}
