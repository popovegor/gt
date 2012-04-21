using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.Offers;
using GT.Global.Entities;

namespace GT.Web.Site.Controls
{
  public partial class Offer : System.Web.UI.UserControl
  {
    private Lazy<BaseOffer> _offer = null;

    public EntityType OfferType { get; set; }
    
    public static string GetCssClassCategory(BaseOffer offer)
    {
      var cssCategory = "category-misc";
      if (offer != null)
      {
        switch (offer.ProductCategoryId)
        {
          case 1:
            cssCategory = "category-character";
            break;
          case 2:
            cssCategory = "category-currency";
            break;
          case 3:
            cssCategory = "category-armory";
            break;
        }
      }
      return cssCategory;
    }
    


    public BaseOffer OfferData
    {
      get
      {
        if(_offer == null)
        {
          switch(OfferType)
          {
            case EntityType.BuyingOffer:
              _offer = new Lazy<BaseOffer>(()
                => BuyingFacade.GetOfferById(OfferId), true);
             break;
            case EntityType.SellingOffer:
             _offer = new Lazy<BaseOffer>(()
               => SellingFacade.GetOfferById(OfferId), true);
             break;
          }
        }
        return _offer.Value;
      }
      set
      {
        _offer = new Lazy<BaseOffer>(() => value, true);
      }
    }

    private string _name = null;
    public string Title
    {
      get
      {
        if (_name == null)
        {
          _name = string.Empty;
          if (OfferData != null)
          {
            _name = OfferData.Title;
          }
        }
        return _name;
      }
      set
      {
        _name = value;
      }
    }

    public int OfferId
    {
      get;
      set;
    }

    public bool ShowNewWindow { get; set; }

    public bool ShowProductCategory { get; set; }

    public bool ShowDetailsLink { get; set; }


    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}