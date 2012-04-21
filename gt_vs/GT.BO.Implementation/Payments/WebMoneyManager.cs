using GT.BO.Implementation.Payments.Configuration;
using System.Configuration;
using GT.BO.Implementation.Users;
using WebMoney.XmlInterfaces;
using WebMoney.XmlInterfaces.Responses;
using GT.BO.Implementation.BillingSystem;
using WebMoney.XmlInterfaces.BasicObjects;
using System;
using GT.Global.BillingSystem;
using GT.DA.Dictionaries;
using System.Xml;
using WebMoney.XmlInterfaces.Serialization;
using WebMoney.XmlInterfaces.Exceptions;
using System.Net.Mail;
using GT.Common.Net.Mail;
using GT.BO.Implementation.Helpers;
using System.Collections.Generic;
using System.Linq;
using System.Web.Security;

namespace GT.BO.Implementation.Payments
{
    public enum WebMoneyMessagesTypes
    {
        Common = 4,
        X1 = 1,
        X2 = 2,
        Merchant = 3
    }

    public class WebMoneyManager : BasePaymentSystem
    {
        static readonly string TOPUP = Dictionaries.Instance.GetWebMoneyMessageLocalized(1, (int)WebMoneyMessagesTypes.Common);
        static readonly string DRAWOUT = Dictionaries.Instance.GetWebMoneyMessageLocalized(2, (int)WebMoneyMessagesTypes.Common);
        static readonly string ADDRESS = Dictionaries.Instance.GetWebMoneyMessageLocalized(3, (int)WebMoneyMessagesTypes.Common);

        static WebMoneySectionHandler s_Config;
        public static WebMoneySectionHandler Configuration
        {
            get
            {
                if (s_Config == null)
                {
                    s_Config = (WebMoneySectionHandler)ConfigurationManager.GetSection(WebMoneySectionHandler.SECTION_NAME);
                }

                return s_Config;
            }
        }

        public static bool UpdateMerchantTransferStatus(int transferId)
        {
            MerchantOperationFilter mof = new MerchantOperationFilter(Purse.Parse(Configuration.Purse), (ulong)transferId);
            try
            {
                ExistentMerchantOperation emo = mof.Submit();

                if (emo != null)
                {
                    GT.BO.Implementation.BillingSystem.WebMoneyTransfer wm = new GT.BO.Implementation.BillingSystem.WebMoneyTransfer();
                    wm.TransferId = transferId;
                    wm.Description = emo.Description;
                    wm.WmInvoiceId = (int)emo.InvoiceId;
                    wm.WmTransferId = (int)emo.OperationId;
                    wm.SourcePurse = emo.SourcePurse.ToString();
                    wm.TargetPurse = WebMoneyManager.Configuration.Purse;
                    wm.TelepatPhone = emo.TelepatPhone.ToString();
                    long l;
                    if (long.TryParse(emo.PaymerNumber, out l))
                    {
                        wm.PaymerNumber = l;
                    }

                    wm.PaymerEmail = emo.PaymerEmail.ToString();
                    int casher;
                    if (int.TryParse(emo.CashierNumber.ToString(), out casher))
                    {
                        wm.ATMWmTransId = casher;
                    }

                    wm.RetCode = 0;

                    WebMoneyTransferFacade.Add(wm);

                    BillingSystemFacade.CompleteTransfer(transferId);
                    return true;
                }
            }
            catch (WmException wm)
            {
                if (wm.Number != -8)
                {
                    throw wm;
                }
            }

            return false;
        }

        public static void UpdateOutgoingInvoices(DateTime startDate, List<Transfer> transfers)
        {
            startDate = (DateTime.Now - startDate).Days > 88 ? DateTime.Now.AddMonths(-3) : startDate;
            
            OutgoingInvoiceFilter oif = new OutgoingInvoiceFilter(Purse.Parse(Configuration.Purse),
                                                                  WmDateTime.Parse(startDate.ToString("dd.MM.yyyy HH:mm:ss")),
                                                                  WmDateTime.Parse(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss")));

            ExistentOutgoingInvoice[] eoi = oif.Submit();
            if (eoi != null)
            {
                foreach (ExistentOutgoingInvoice inv in eoi)
                {
                    if (inv.State == InvoiceState.Paid && inv.OrderId != 0)
                    {
                        Transfer t = transfers.Where(p => p.TransferId == (int)inv.OrderId).SingleOrDefault();
                        if (t != null)
                        {
                            GT.BO.Implementation.BillingSystem.WebMoneyTransfer wm = new GT.BO.Implementation.BillingSystem.WebMoneyTransfer();
                            wm.TransferId = t.TransferId;
                            wm.Description = inv.Description;
                            wm.TargetPurse = inv.TargetPurse.ToString();
                            wm.SourcePurse = inv.SourcePurse != null ? inv.SourcePurse.Value.ToString() : null;
                            wm.WmInvoiceId = (int)inv.Id;
                            wm.WmTransferId = (int)inv.OperationId;
                            wm.TransDate = ((DateTime)inv.UpdateTime).ToUniversalTime();
                            wm.RetCode = 0;
                            WebMoneyTransferFacade.Add(wm);
                            BillingSystemFacade.CompleteTransfer(t.TransferId);
                            transfers.Remove(t);
                        }
                    }
                }
            }
        }


        public static void UpdateTransferStatus(DateTime startDate, List<Transfer> transfers)
        {
            startDate = (DateTime.Now - startDate).Days > 88 ? DateTime.Now.AddMonths(-3) : startDate;

            TransferFilter tf = new TransferFilter(Purse.Parse(Configuration.Purse),
                                                                  WmDateTime.Parse(startDate.ToString("dd.MM.yyyy HH:mm:ss")),
                                                                  WmDateTime.Parse(DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss")));

            ExistentTransfer[] eoi = tf.Submit();
            if (eoi != null)
            {
                foreach (ExistentTransfer inv in eoi)
                {
                    Transfer t = transfers.Where(p => p.TransferId == (int)inv.TransferId).SingleOrDefault();
                    if (t != null)
                    {
                        GT.BO.Implementation.BillingSystem.WebMoneyTransfer wm = new GT.BO.Implementation.BillingSystem.WebMoneyTransfer();
                        wm.TransferId = t.TransferId;
                        wm.Description = inv.Description;
                        wm.TargetPurse = inv.TargetPurse.ToString();
                        wm.SourcePurse = inv.SourcePurse != null ? inv.SourcePurse.Number.ToString() : null;
                        wm.WmInvoiceId = (int)inv.Id;
                        wm.WmTransferId = (int)inv.TransferId;
                        wm.TransDate = ((DateTime)inv.UpdateTime).ToUniversalTime();
                        wm.RetCode = 0;
                        WebMoneyTransferFacade.Add(wm);
                        BillingSystemFacade.CompleteTransfer(t.TransferId);
                        transfers.Remove(t);

                        if (t.Commission != t.Commission)
                        {
                            MailMessage m = new MailMessage(SmtpManager.Instance.Config.SupportEmail,
                                                            SmtpManager.Instance.Config.Email4Errors,
                                                            "WEB MONEY ERROR COMMISSION",
                                                            String.Format("TransferId = {0}; WebMoneyId = {1}", t.TransferId, wm.Id));
                            SmtpManager.Instance.Send(m);
                        }
                    }
                }
            }
        }

        public static bool IsWmId(string wmid)
        {
            return WmId.TryParse(wmid) != null;
        }

        public static bool IsPurse(string purse)
        {
            return Purse.TryParse(purse) != null;
        } 
        
        WmId m_TargetWmId;
        Purse m_TargePurse;

        public WebMoneyManager(MembershipUser u)
        {
            m_User = u;
            m_MoneySource = BillingSystemFacade.GetRealMoneySource(RealMoneySourceType.WebMoney);
        }

        public WebMoneyManager(MembershipUser u, string wmId, string targetPurse)
            : this(u)
        {
            if (!String.IsNullOrEmpty(wmId))
            {
                WmId? id = WmId.TryParse(wmId);
                if (!id.HasValue)
                {
                    throw new ArgumentException();
                }

                m_TargetWmId = id.Value;
            }

            if (!String.IsNullOrEmpty(targetPurse))
            {
                Purse? p = Purse.TryParse(targetPurse);
                if (!p.HasValue)
                {
                    throw new ArgumentException();
                }

                m_TargePurse = p.Value;
            }
        }

        public override GT.BO.Implementation.BillingSystem.Transfer TopUp(decimal amount)
        {
            if (m_TargetWmId == null)
            {
                return null;
            }

            Transfer t = null;

            amount = amount.ToMoney();

            if (amount > 0)
            {
                t = base.TopUp(amount);
                if (t != null)
                {
                    OriginalInvoice oi = new OriginalInvoice((ulong)t.TransferId,
                                                             m_TargetWmId,
                                                             Purse.Parse(Configuration.Purse),
                                                             Amount.Parse(amount.ToString()),
                                                             new Info(TOPUP, false),
                                                             new Info(ADDRESS, false));

                    GT.BO.Implementation.BillingSystem.WebMoneyTransfer wm = new GT.BO.Implementation.BillingSystem.WebMoneyTransfer();
                    wm.TransferId = t.TransferId;
                    wm.TargetPurse = Configuration.Purse;

                    try
                    {
                        RecentInvoice ri = oi.Submit();
                        if (ri != null)
                        {
                            int? msgId = Dictionaries.Instance.GetWebMoneyMessageIdByRetcodeAndType(0, (int)WebMoneyMessagesTypes.X1);
                            if (msgId.HasValue)
                            {
                                wm.RetCode = msgId.Value;
                            }
                            wm.WmInvoiceId = (int)ri.Id;
                            wm.PayerWmid = ri.SourceWmId.ToString();
                            wm.Description = ri.Description;
                            wm.TransDate = ((DateTime)ri.CreateTime).ToUniversalTime();
                            WebMoneyTransferFacade.Add(wm);
                        }
                    }
                    catch (WmException ex)
                    {
                        string note = null;
                        int? messageId = Dictionaries.Instance.GetWebMoneyMessageIdByRetcodeAndType(ex.Number, (int)WebMoneyMessagesTypes.X1);
                        if (messageId != null)
                        {
                            wm.RetCode = messageId.Value;
                            wm.Description = ex.Message;
                            note = Dictionaries.Instance.GetWebMoneyMessageById(messageId.Value);
                        }
                        else
                        {
                            wm.Description = String.Format("retcode = {0}; {1}", ex.Number, ex.Message);
                            note = Dictionaries.Instance.GetWebMoneyDefaultSystemErrorMessage();
                        }

                        WebMoneyTransferFacade.Add(wm);
                        BillingSystemFacade.RefuseTransfer(t.TransferId, note);
                    }
                }
            }

            return t;
        }

        public override GT.BO.Implementation.BillingSystem.Transfer DrawOut(decimal amount)
        {
            if (m_TargePurse == null)
            {
                return null;
            }
            
            Transfer t = base.DrawOut(amount);
            if (t != null)
            {
                decimal newAmount = (t.Amount - t.Commission - t.OurCommission).ToMoney();

                OriginalTransfer ot = new OriginalTransfer((ulong)t.TransferId,
                                                            Purse.Parse(Configuration.Purse),
                                                            m_TargePurse,
                                                            Amount.Parse(newAmount.ToString()),
                                                            new Info(DRAWOUT, false),
                                                            0);

                GT.BO.Implementation.BillingSystem.WebMoneyTransfer wm = new GT.BO.Implementation.BillingSystem.WebMoneyTransfer();
                wm.TransferId = t.TransferId;
                wm.SourcePurse = Configuration.Purse;
                wm.TargetPurse = m_TargePurse.ToString();

                try
                {
                    RecentTransfer tr = ot.Submit();
                    if (tr != null)
                    {
                        int? msgId = Dictionaries.Instance.GetWebMoneyMessageIdByRetcodeAndType(0, (int)WebMoneyMessagesTypes.X2);
                        if (msgId.HasValue)
                        {
                            wm.RetCode = msgId.Value;
                        }

                        wm.WmTransferId = (int)tr.Id;
                        wm.WmInvoiceId = (int)tr.InvoiceId;
                        wm.Description = tr.Description != null ? tr.Description.ToString() : null;
                        wm.TransDate = ((DateTime)tr.CreateTime).ToUniversalTime();
                        wm.Commission = (decimal)tr.Commission;
                        wm = WebMoneyTransferFacade.Add(wm);
                        BillingSystemFacade.CompleteTransfer(t.TransferId);

                        if (wm.Commission != t.Commission)
                        {
                            MailMessage m = new MailMessage(SmtpManager.Instance.Config.SupportEmail,
                                                            SmtpManager.Instance.Config.Email4Errors,
                                                            "WEB MONEY ERROR COMMISSION",
                                                            String.Format("TransferId = {0}; WebMoneyId = {1}", t.TransferId, wm.Id));
                            SmtpManager.Instance.Send(m);
                        }
                    }
                }
                catch (WmException ex)
                {
                    string note = null;
                    int? messageId = Dictionaries.Instance.GetWebMoneyMessageIdByRetcodeAndType(ex.Number, (int)WebMoneyMessagesTypes.X2);
                    if (messageId != null)
                    {
                        wm.RetCode = messageId.Value;
                        wm.Description = ex.Message;
                        note = Dictionaries.Instance.GetWebMoneyMessageById(messageId.Value);
                    }
                    else
                    {
                        wm.Description = String.Format("retcode = {0}; {1}", ex.Number, ex.Message);
                        note = Dictionaries.Instance.GetWebMoneyDefaultSystemErrorMessage();
                    }

                    WebMoneyTransferFacade.Add(wm);
                    t = BillingSystemFacade.RefuseTransfer(t.TransferId, note);
                }
            }

            return t;
        }
    }
}