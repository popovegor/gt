using System;
using GT.BO.Implementation.Offers;
using GT.ImageGenerator.Serialization;
using GT.Common.Drawing;
using GT.Common;
using GT.Common.Exceptions;
using System.ComponentModel;

namespace GT.ImageGenerator.GeneratedImages
{
  [Serializable]
  public class GeneratedSellingImage : SizedImageBase
  {
    [QueryStringSerializable("sid")]
    public int SellingId { get; set; }

    [QueryStringSerializable("in")]
    [DefaultValue("")]
    public string ImageName { get; set; }

    private SellingImage GetSellingImage()
    {
      return SellingFacade.GetImageBySellingId(SellingId);
    }

    protected override void Generate()
    {
      try
      {
        var image = GetSellingImage();
        if (null != image && null != image.Data)
        {
          ImageName = image.ImageName;
          _image = image.Data.ToBitmap();
        }
      }
      catch (Exception e)
      {
        AssistLogger.Log<ExceptionHolder>(e);
      }
    }
  }
}
