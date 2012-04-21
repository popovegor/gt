using System;
using System.ComponentModel;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.Dictionaries;
using GT.Global.BillingSystem;
using GT.DA.BillingSystem;

namespace GT.BO.Implementation.BillingSystem
{
  [XmlRoot("t")]
  public class Transfer : BaseEntity
  {
    [XmlAttribute("tid")]
    [BaseSourceMapping(TransferFields.TransferId)]
    public int TransferId = 0;

    [XmlAttribute("a")]
    [BaseSourceMapping(TransferFields.Amount)]
    [DefaultValue(0)]
    [BaseComparable]
    public decimal Amount { get; set; }

    [XmlAttribute("cd")]
    [BaseSourceMapping(TransferFields.CreateDate)]
    public DateTime CreateDate { get; set; }

    [XmlAttribute("n")]
    [BaseSourceMapping(TransferFields.Note)]
    [DefaultValue("")]
    [BaseComparable]
    public string Note { get; set; }

    [XmlElement("ftp", typeof(TransferParticipant))]
    [XmlSourceMapping("FromTransferParticipant")]
    [DefaultValue(null)]
    public TransferParticipant FromTransferParticipant { get; set; }

    [XmlElement("ttp", typeof(TransferParticipant))]
    [XmlSourceMapping("ToTransferParticipant")]
    [DefaultValue(null)]
    public TransferParticipant ToTransferParticipant { get; set; }

    [XmlAttribute("sid")]
    [BaseSourceMapping(TransferFields.StatusId)]
    [BaseComparable]
    public int StatusId { get; set; }

    [XmlIgnore]
    [BaseComparable]
    public TransferStatus Status
    {
      get
      {
        return GT.Common.Types.TypeConverter.ToEnumMember<TransferStatus>(StatusId);
      }
      set
      {
        StatusId = (int)value;
      }
    }

    //[XmlAttribute("CompletionDate")]
    [XmlIgnore]
    [BaseSourceMapping(TransferFields.StatusModifyDate)]
    public DateTime StatusModifyDate { get; set; }

    [XmlAttribute("c")]
    [BaseSourceMapping(TransferFields.Commission)]
    [BaseComparable]
    public decimal Commission { get; set; }

    [XmlAttribute("oc")]
    [BaseSourceMapping(TransferFields.OurCommission)]
    [BaseComparable]
    public decimal OurCommission { get; set; }

    [XmlAttribute("ocr")]
    [BaseSourceMapping(TransferFields.OurCommissionRecieved)]
    [BaseComparable]
    public bool OurCommissionRecieved { get; set; }

    public override int Id
    {
      get { return TransferId; }
      set { TransferId = value; }
    }
  }
}
