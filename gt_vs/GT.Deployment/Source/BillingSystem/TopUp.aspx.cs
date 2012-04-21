using System;
using GT.BO.Implementation.BillingSystem;
using GT.Web.UI.Pages;
using GT.Global.BillingSystem;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using Resources;
using GT.BO.Implementation.Payments;

namespace GT.Web.Site.BillingSystem
{
  public partial class TopUp : BasePage
  {
    const string SUCCESS = "ED520C27-E210-44be-AB7C-05681FA134E7";
    const string FAIL = "5108C228-FCEF-4ee2-B5EA-053EE65ED1D7";
    const decimal MINIMUM = 1 / 100;

    const string MERCHANT_URL = @"https://merchant.webmoney.ru/lmi/payment.asp";

    protected void Page_Load(object sender, EventArgs e)
    {
      if (Request.QueryString["result"] != null)
      {
        if (String.Compare(Request.QueryString["result"], SUCCESS, false) == 0)
        {
          lblError.Text = CommonResources.PaymentSuccessful;
        }
        else if (String.Compare(Request.QueryString["result"], FAIL, false) == 0)
        {
          lblError.Text = CommonResources.PaymentFail;
        }

        lblError.Visible = true;
      }

      DataBind();
    }

    protected void btnTopUp_Click(object sender, EventArgs e)
    {
      decimal amount = TypeConverter.ToDecimal(txtAmount.Text, 0);
      if (amount > MINIMUM)
      {
        Transfer t = BillingSystemFacade.AddTransfer(TransferFactory.CreateRealSourceToUser(RealMoneySourceType.WebMoney, Credentials.UserId, amount, string.Empty));
        if (t != null)
        {
          string script = String.Format(@"var number = document.getElementById('number'); number.value = {0}; " +
                                        @"var amount = document.getElementById('amount'); amount.value = {1}; " +
                                        @"var f = document.forms['aspnetForm']; f.action = '{2}'; " +
                                        @"var purse = document.getElementById('purse'); purse.value = '{3}'; " +
                                        @"var desc = document.getElementById('description'); desc.value = '{4}'; " +
                                        @"f.submit();", t.TransferId, amount, MERCHANT_URL, WebMoneyManager.Configuration.Purse, CommonResources.TopUpPaymentDescription);

          ClientScript.RegisterStartupScript(this.GetType(), "WMMerchantPostBack", script, true);
        }
      }
      else
      {
        lblError.Text = String.Format(CommonResources.PaymentAmountError, MINIMUM.ToString());
      }
    }
  }
}
