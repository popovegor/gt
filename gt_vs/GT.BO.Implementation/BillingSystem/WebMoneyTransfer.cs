using System;
using System.Xml.Serialization;
using GT.BO.Entities;
using GT.DA.BillingSystem;
using System.ComponentModel;

namespace GT.BO.Implementation.BillingSystem
{
  [XmlRoot("wm")]
  public class WebMoneyTransfer : BaseEntity
  {
    [XmlAttribute("id")]
    [BaseSourceMapping(WebMoneyFields.Id)]
    public int WebMoneyTransferId { get; set; }

    [XmlAttribute("tid")]
    [BaseSourceMapping(WebMoneyFields.TransferId)]
    [BaseComparable]
    public int TransferId { get; set; }

    [XmlAttribute("wmiid")]
    [BaseSourceMapping(WebMoneyFields.WmInvoiceId)]
    [BaseComparable]
    public int WmInvoiceId = 0;

    [XmlAttribute("wmtid")]
    [BaseSourceMapping(WebMoneyFields.WmTransferId)]
    [BaseComparable]
    public int WmTransferId = 0;

    [XmlAttribute("tp")]
    [BaseSourceMapping(WebMoneyFields.TargetPurse)]
    [BaseComparable]
    public string TargetPurse { get; set; }

    [XmlAttribute("sp")]
    [BaseSourceMapping(WebMoneyFields.SourcePurse)]
    [BaseComparable]
    public string SourcePurse { get; set; }

    [XmlAttribute("pn")]
    [BaseSourceMapping(WebMoneyFields.PaymerNumber)]
    [BaseComparable]
    public long PaymerNumber { get; set; }

    [XmlAttribute("cwmid")]
    [BaseSourceMapping(WebMoneyFields.CapitallerWmid)]
    [BaseComparable]
    public decimal CapitallerWmid { get; set; }

    [XmlAttribute("en")]
    [BaseSourceMapping(WebMoneyFields.EuronoteNumber)]
    [BaseComparable]
    public decimal EuronoteNumber { get; set; }

    [XmlAttribute("pwmid")]
    [BaseSourceMapping(WebMoneyFields.PayerWmid)]
    [BaseComparable]
    public string PayerWmid { get; set; }

    [XmlAttribute("pe")]
    [BaseSourceMapping(WebMoneyFields.PaymerEmail)]
    [BaseComparable]
    public string PaymerEmail { get; set; }

    [XmlAttribute("ee")]
    [BaseSourceMapping(WebMoneyFields.EuronoteEmail)]
    [BaseComparable]
    public string EuronoteEmail { get; set; }

    [XmlAttribute("telp")]
    [BaseSourceMapping(WebMoneyFields.TelepatPhone)]
    [BaseComparable]
    public string TelepatPhone { get; set; }

    [XmlAttribute("toid")]
    [BaseSourceMapping(WebMoneyFields.TelepatOrderId)]
    [BaseComparable]
    public int TelepatOrderId { get; set; }

    [XmlAttribute("d")]
    [BaseSourceMapping(WebMoneyFields.Description)]
    [BaseComparable]
    public string Description { get; set; }

    [XmlAttribute("atm")]
    [BaseSourceMapping(WebMoneyFields.ATMWmTransId)]
    [BaseComparable]
    public int ATMWmTransId { get; set; }

    [XmlAttribute("tdate")]
    [BaseSourceMapping(WebMoneyFields.TransDate)]
    public DateTime TransDate = new DateTime(1900, 1, 1);

    [XmlAttribute("rc")]
    [BaseSourceMapping(WebMoneyFields.RetCode)]
    [BaseComparable]
    public int RetCode = 0;

    [XmlAttribute("com")]
    [BaseSourceMapping(WebMoneyFields.Commission)]
    [DefaultValue(0)]
    [BaseComparable]
    public decimal Commission { get; set; }

    [XmlAttribute("cd")]
    [BaseSourceMapping(WebMoneyFields.CreateDate)]
    public DateTime CreateDate
    {
      get;
      set;
    }

    public override int Id
    {
      get
      {
        return WebMoneyTransferId;
      }
      set
      {
        WebMoneyTransferId = value;
      }
    }
  }
}
