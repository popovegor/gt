using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace GT.Web.Site.Controls
{
  public partial class SellingImageViewer : System.Web.UI.UserControl
  {
  
    public delegate void SavedImageExistsDelegate();

    public event SavedImageExistsDelegate SavedImageExists;
  
    private string _imageUrl = string.Empty;

    public int SellingId { get; set; }

    [DefaultValue(100)]
    public int Width
    {
      get;
      set;
    }

    [DefaultValue(100)]
    public int Height
    {
      get;
      set;
    }

    public string ImageClientID
    {
      get
      {
        return image.ClientID;
      }
    }

    public string ImageAnchorClientID
    {
      get
      {
        return imageAnchor.ClientID;
      }
    }
  
    public bool ShowDelete { get; set; }

    protected string ImageUrl
    {
      get
      {
        if (string.IsNullOrEmpty(_imageUrl) == true)
        {
          var img = new ImageGenerator.GeneratedImages.GeneratedSellingImage();
          img.SellingId = SellingId;
          if (img.GeneratedImage == null)
          {
            imageAnchor.Style.Add(HtmlTextWriterStyle.Display, "none");
            //btnDeleteImage.Attributes.CssStyle.Add(HtmlTextWriterStyle.Display, "none");
          }
          else
          {
            _imageUrl = img.ImageUrl;
            if(SavedImageExists != null)
            {
              SavedImageExists();
            }
          }
        }
        return _imageUrl;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}