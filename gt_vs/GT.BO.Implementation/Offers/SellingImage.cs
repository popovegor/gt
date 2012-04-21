using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Entities;
using System.Xml.Serialization;
using GT.DA.Offers;
using System.Drawing;
using System.ComponentModel;

namespace GT.BO.Implementation.Offers
{
  [XmlRoot("si")]
  [Serializable]
  public class SellingImage : BaseEntity
  {
    [XmlAttribute("siid")]
    [BaseSourceMapping(SellingImageFields.SellingImageId)]
    [DefaultValue(0)]
    public int SellingImageId { get; set; }

    [XmlAttribute("sid")]
    [BaseSourceMapping(SellingImageFields.SellingId)]
    [BaseComparable]
    [DefaultValue(0)]
    public int SellingId { get; set; }

    [XmlAttribute("d")]
    [BaseSourceMapping(SellingImageFields.Image)]
    [BaseComparable]
    public byte[] Data { get; set; }

    [XmlAttribute("in")]
    [BaseSourceMapping(SellingImageFields.ImageName)]
    [BaseComparable]
    public string ImageName { get; set; }

    [XmlIgnore]
    public bool IsEmpty
    {
      get
      {
        return Data != null && Data.Length > 0;
      }
    }

    public override int Id
    {
      get
      {
        return SellingImageId;
      }
      set
      {
        SellingImageId = value;
      }
    }
  }
}
