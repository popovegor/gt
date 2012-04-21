using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.Common.Types;
using GT.DA.UserRating;
using GT.Global.UserRating;

namespace GT.BO.Implementation.UserRating
{
  [XmlRoot("f")]
  public class Feedback : BaseEntity
  {
    [XmlAttribute("fid")]
    [BaseSourceMapping(FeedbackFields.FeedbackId)]
    public int FeedbackId
    { get; set; }

    [XmlAttribute("fuid")]
    [BaseSourceMapping(FeedbackFields.FromUserId)]
    [BaseComparable]
    public Guid FromUserId
    {
      get;
      set;
    }

    [XmlAttribute("tuid")]
    [BaseSourceMapping(FeedbackFields.ToUserId)]
    [BaseComparable]
    public Guid ToUserId
    {
      get;
      set;
    }

    [XmlIgnore]
    public FeedbackType FeedbackType
    {
      get
      {
        return TypeConverter.ToEnumMember<FeedbackType>(FeedbackTypeId);
      }
      set
      {
        FeedbackTypeId = (int)value;
      }
    }

    [XmlAttribute("ftid")]
    [BaseSourceMapping(FeedbackFields.FeedbackTypeId)]
    [BaseComparable]
    public int FeedbackTypeId
    { get; set; }

    [XmlAttribute("c")]
    [BaseSourceMapping(FeedbackFields.Comment)]
    [BaseComparable]
    public string Comment
    { get; set; }

    [XmlAttribute("shid")]
    [BaseSourceMapping(FeedbackFields.SellingHistoryId)]
    [BaseComparable]
    [System.ComponentModel.DefaultValue(0)]
    public int SellingHistoryId
    { get; set; }

    [XmlAttribute("cd")]
    [BaseSourceMapping(FeedbackFields.CreateDate)]
    public DateTime CreateDate
    { get; set; }

    public override int Id
    {
      get { return FeedbackId; }
      set { FeedbackId = value; }
    }
  }
}
