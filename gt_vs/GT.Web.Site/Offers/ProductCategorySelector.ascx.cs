using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Controls;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Localization.Resources;

namespace GT.Web.Site.Offers
{
  public partial class ProductCategorySelector : BaseControl
  {
    public int ProductCategoryId
    {
      get
      {
        return TypeConverter.ToInt32(ddlProductType.SelectedValue, 0);
      }
      set
      {
        if (value > 0)
        {
          ddlProductType.DataBind();
          ddlProductType.SelectedValue = TypeConverter.ToString(value);
        }
      }
    }

    public string ProductCategoryMisc
    {
      get
      {
        if (ProductCategoryId == Dictionaries.Instance.GetProductCategoryMiscId)
        {
          return txtProductCategoryMisc.Text;
        }
        else
        {
          return string.Empty;
        }
      }
      set
      {
        if (ProductCategoryId != Dictionaries.Instance.GetProductCategoryMiscId)
        {
          txtProductCategoryMisc.Style.Add(HtmlTextWriterStyle.Display, "none");
          rfvProductCategoryMisc.Enabled = false;
        }
        else
        {
          txtProductCategoryMisc.Text = value;
        }
      }
    }
    
    protected IEnumerable<KeyValuePair<string, string>> GetProductCategories()
    {
      var products = Dictionaries.Instance.GetProductCategoriesAsPairs().Select(
        p => new KeyValuePair<string, string>(TypeConverter.ToString(p.Key), p.Value));
      return new[] { new KeyValuePair<string, string>("", CommonResources.Offers_SelectProductCategory) }.Union(products);
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}