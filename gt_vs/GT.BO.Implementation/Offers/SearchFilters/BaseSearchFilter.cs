using System.ComponentModel;
using System.Xml.Serialization;
using GT.BO.Entities;
using System;

namespace GT.BO.Implementation.Offers.SearchFilters
{
  [XmlRoot("sf")]
  public class BaseSearchFilter : BaseEntity
  {
    [XmlAttribute("gn")]
    public string GameName { get; set; }

    [XmlAttribute("gsn")]
    public string GameServerName { get; set; }

    [XmlAttribute("t")]
    public string Title { get; set; }

    [XmlAttribute("d")]
    public string Description { get; set; }

    [DefaultValue(0)]
    [XmlAttribute("gid")]
    public int GameId { get; set; }

    [DefaultValue(0)]
    [XmlAttribute("gsid")]
    public int GameServerId { get; set; }

    [XmlAttribute("u")]
    public Guid UserId { get; set; }

    [XmlAttribute("productCategory")]
    public int ProductCategoryId { get; set; }

    public override int Id
    {
      get { return 0; }
      set
      { ;}
    }
  }
}
