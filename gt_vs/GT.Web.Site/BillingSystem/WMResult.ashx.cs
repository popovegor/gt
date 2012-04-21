using System.Text;
using System.Security.Cryptography;
using System.Globalization;
using GT.Common.Types;
using GT.Common;
using GT.BO.Implementation.BillingSystem;
using GT.Global.BillingSystem;
using GT.BO.Implementation.Payments;
using System.Web;
using System;
using GT.BO.Implementation.Helpers;
using GT.DA.Dictionaries;

namespace GT.Web.Site.BillingSystem
{
    public class WMResult : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            if (null == context)
                throw new ArgumentNullException("context");

            if (null == context.Request.Form)
                return;

            string LMI_PREREQUEST = context.Request.Form["LMI_PREREQUEST"];
            string LMI_PAYMENT_NO = context.Request.Form["LMI_PAYMENT_NO"];
            string LMI_PAYMENT_AMOUNT = context.Request.Form["LMI_PAYMENT_AMOUNT"];
            string LMI_PAYEE_PURSE = context.Request.Form["LMI_PAYEE_PURSE"];

            int tId;

            AssistLogger.WriteInformation(String.Format("TransferId = {0} | PAYEE PURSE = {1} | AMOUNT = {2} | PAYER PURSE = {3} | PAYER WMID = {4} ",
                                                        LMI_PAYMENT_NO, LMI_PAYEE_PURSE, LMI_PAYMENT_AMOUNT,
                                                        context.Request.Form["LMI_PAYER_PURSE"],
                                                        context.Request.Form["LMI_PAYER_WM"]),
                                         AssistLogger.Category.WebMoney);

            if (string.Compare(LMI_PAYEE_PURSE, WebMoneyManager.Configuration.Purse, true) != 0)
            {
                throw new ArgumentException(
                    string.Format(CultureInfo.InvariantCulture, "Подмена кошелька (LMI_PAYEE_PURSE == {0})!",
                                  LMI_PAYEE_PURSE), "LMI_PAYEE_PURSE");
            }

            if (string.IsNullOrEmpty(LMI_PAYMENT_NO) || !int.TryParse(LMI_PAYMENT_NO, out tId))
                    throw new ArgumentException("Не задан или задан неверно номер платежа!", "LMI_PAYMENT_NO");

            Transfer transfer = BillingSystemFacade.GetTransferById(tId);
            if (transfer == null || transfer.FromTransferParticipant.ActualEntityType != GT.Global.Entities.EntityType.RealMoneySource ||
                    transfer.FromTransferParticipant.RealMoneySourceId != (int)RealMoneySourceType.WebMoney || transfer.Status != TransferStatus.Pending)
            {
                throw new ArgumentException("Неверно задан номер платежа", "LMI_PAYMENT_NO");
            }

            if (String.IsNullOrEmpty(LMI_PAYMENT_AMOUNT))
            {
                throw new ArgumentException("Не задана сумма платежа!", "LMI_PAYMENT_AMOUNT");
            }

            decimal amount = TypeConverter.ToDecimal(LMI_PAYMENT_AMOUNT.Replace('.', ',')).ToMoney();

            if (amount <= 0)
                    throw new ArgumentException("Не задана или задана неверно сумма платежа!", "LMI_PAYMENT_AMOUNT");

            if (string.Compare("1", LMI_PREREQUEST) == 0)
            {
                context.Response.Write("YES");
                return;
            }

            string LMI_MODE = context.Request.Form["LMI_MODE"];
            string LMI_PAYER_WM = context.Request.Form["LMI_PAYER_WM"];
            string LMI_SYS_INVS_NO = context.Request.Form["LMI_SYS_INVS_NO"];
            string LMI_SYS_TRANS_NO = context.Request.Form["LMI_SYS_TRANS_NO"];
            string LMI_SYS_TRANS_DATE = context.Request.Form["LMI_SYS_TRANS_DATE"];
            string LMI_PAYER_PURSE = context.Request.Form["LMI_PAYER_PURSE"];
            string LMI_HASH = context.Request.Form["LMI_HASH"];

            if (string.Compare("0", LMI_MODE) != 0)
                throw new ArgumentException("Попытка провести платеж в тестовом режиме!", "LMI_MODE");

            StringBuilder stringBuilder = new StringBuilder();

            stringBuilder.Append(LMI_PAYEE_PURSE);
            stringBuilder.Append(LMI_PAYMENT_AMOUNT);
            stringBuilder.Append(LMI_PAYMENT_NO);
            stringBuilder.Append(LMI_MODE);
            stringBuilder.Append(LMI_SYS_INVS_NO);
            stringBuilder.Append(LMI_SYS_TRANS_NO);
            stringBuilder.Append(LMI_SYS_TRANS_DATE);
            stringBuilder.Append(WebMoneyManager.Configuration.Key); // Секретный ключ
            stringBuilder.Append(LMI_PAYER_PURSE);
            stringBuilder.Append(LMI_PAYER_WM);

            string value = stringBuilder.ToString();

            string etaloneHash = GetMD5HashString(value);

            if (string.Compare(etaloneHash, LMI_HASH, true) != 0)
                throw new ArgumentException(
                    string.Format(CultureInfo.InvariantCulture, "Неверная подпись запроса (form == {0})!",
                                  context.Request.Form), "LMI_HASH");

            WebMoneyTransfer wm = new WebMoneyTransfer();
            wm.TransferId = transfer.TransferId;
            wm.WmInvoiceId = TypeConverter.ToInt32(LMI_SYS_INVS_NO);
            wm.WmTransferId = TypeConverter.ToInt32(LMI_SYS_TRANS_NO);
            wm.TargetPurse = WebMoneyManager.Configuration.Purse;
            wm.SourcePurse = LMI_PAYER_PURSE;

            int? msgId = Dictionaries.Instance.GetWebMoneyMessageIdByRetcodeAndType(0, (int)WebMoneyMessagesTypes.Merchant);
            if (msgId.HasValue)
            {
                wm.RetCode = msgId.Value;
            }

            wm.PayerWmid = LMI_PAYER_WM;
            wm.ATMWmTransId = TypeConverter.ToInt32(context.Request.Form["LMI_ATM_WMTRANSID"]);
            wm.CapitallerWmid = TypeConverter.ToInt32(context.Request.Form["LMI_CAPITALLER_WMID"]);
            wm.Description = context.Request.Form["LMI_PAYMENT_DESC"];
            wm.EuronoteEmail = context.Request.Form["LMI_EURONOTE_EMAIL"];
            wm.EuronoteNumber = TypeConverter.ToDecimal(context.Request.Form["LMI_EURONOTE_NUMBER"]);
            wm.PaymerEmail = context.Request.Form["LMI_PAYMER_EMAIL"];
            wm.PaymerNumber = TypeConverter.ToInt64(context.Request.Form["LMI_PAYMER_NUMBER"]);
            wm.TelepatOrderId = TypeConverter.ToInt32(context.Request.Form["LMI_TELEPAT_ORDERID"]);
            wm.TelepatPhone = context.Request.Form["LMI_TELEPAT_PHONENUMBER"];

            WebMoneyTransferFacade.Add(wm);

            BillingSystemFacade.CompleteTransfer(transfer.TransferId);
        }

        public static string GetMD5HashString(string value)
        {
            if (string.IsNullOrEmpty(value))
                throw new ArgumentNullException("value");

            byte[] baValue = Encoding.GetEncoding("windows-1251").GetBytes(value);

            MD5CryptoServiceProvider cryptoServiceProvider = new MD5CryptoServiceProvider();
            byte[] baHash = cryptoServiceProvider.ComputeHash(baValue);

            string result = BitConverter.ToString(baHash, 0).Replace("-", string.Empty);

            return result;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}
