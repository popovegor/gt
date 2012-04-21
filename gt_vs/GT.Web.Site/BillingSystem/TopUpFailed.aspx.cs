using System;
using GT.BO.Implementation.BillingSystem;
using GT.Web.UI.Pages;
using GT.Global.BillingSystem;
using CommonResources = GT.Localization.Resources.CommonResources;

namespace GT.Web.Site.BillingSystem
{
    public partial class TopUpFailed : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string LMI_PAYMENT_NO = Request.Form["LMI_PAYMENT_NO"];
                int tId;
                if (!string.IsNullOrEmpty(LMI_PAYMENT_NO) && int.TryParse(LMI_PAYMENT_NO, out tId))
                {
                    Transfer transfer = BillingSystemFacade.GetTransferById(tId);
                    if (transfer != null && transfer.FromTransferParticipant.ActualEntityType == GT.Global.Entities.EntityType.RealMoneySource &&
                        transfer.FromTransferParticipant.RealMoneySourceId == (int)RealMoneySourceType.WebMoney && transfer.ToTransferParticipant.ActualEntityType == GT.Global.Entities.EntityType.User &&
                        transfer.ToTransferParticipant.UserId == Credentials.UserId && transfer.Status == TransferStatus.Pending)
                    {
                        BillingSystemFacade.RefuseTransfer(tId, CommonResources.PaymentFail);
                        lblError.Visible = true;
                    }
                }
            }

            DataBind();
        }
    }
}
