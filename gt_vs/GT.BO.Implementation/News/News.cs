using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using System.ComponentModel;
using GT.Global.Localization;
using GT.DA.News;

namespace GT.BO.Implementation.News
{
  [XmlRoot("n")]
  public class News : BaseEntity
  {
    [XmlAttribute("nid")]
    [BaseSourceMapping(NewsFields.NewsId)]
    [DefaultValue(0)]
    public int NewsId
    {
      get;
      set;
    }
  
    [XmlAttribute("title")]
    [BaseSourceMapping(NewsFields.Title)]
    [DefaultValue("")]
    [BaseComparable]
    public string Title
    {
      get;
      set;
    }
  
    [XmlAttribute("titleru")]
    [BaseSourceMapping(NewsFields.TitleRu)]
    [DefaultValue("")]
    [BaseComparable]
    public string TitleRu
    {
      get;
      set;
    }
  
    [XmlIgnore]
    [BaseComparable]
    public string LocalizedTitle
    {
      get
      {
        return Localizator.GetLocalizedProperty(Title, TitleRu, string.Empty);
      }
    }
  
    [XmlAttribute("body")]
    [BaseSourceMapping(NewsFields.Body)]
    [DefaultValue("")]
    [BaseComparable]
    public string Body
    {
      get;
      set;
    }
  
    [XmlAttribute("bodyru")]
    [BaseSourceMapping(NewsFields.BodyRu)]
    [DefaultValue("")]
    [BaseComparable]
    public string BodyRu
    {
      get;
      set;
    }
  
    [XmlIgnore]
    [BaseComparable]
    public string LocalizedBody
    {
      get
      {
        return Localizator.GetLocalizedProperty(Body, BodyRu, string.Empty);
      }
    }
  
    [XmlAttribute("cd")]
    [BaseSourceMapping(NewsFields.CreateDate)]
    public DateTime CreateDate
    {
      get;
      set;
    }
 
    public override int Id
    {
      get { return NewsId; }
      set { NewsId = value; }
    }

    public News() { }
  }
}
