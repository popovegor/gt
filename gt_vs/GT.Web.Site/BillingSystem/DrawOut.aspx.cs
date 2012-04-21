using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.Common.Types;
using GT.BO.Implementation.BillingSystem;
using GT.Global.BillingSystem;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.BO.Implementation.Payments;
using GT.BO.Implementation.Users;
using System.Text.RegularExpressions;
using GT.DA.Dictionaries;

namespace GT.Web.Site.BillingSystem
{
    public partial class DrawOut : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtAmount.Attributes.Add("onChange", "CalcFactAmount()");
            DataBind();
        }

        protected void btnDrawOut_Click(object sender, EventArgs e)
        {
            decimal amount = TypeConverter.ToDecimal(txtAmount.Text, 0);
            WebMoneyManager wmm = new WebMoneyManager(UsersFacade.GetUser(Credentials.UserId), null, "R" + purse.Text);
            if (amount > 0)
            {
                if (Regex.IsMatch(purse.Text, "^[0-9]{12}$"))
                {
                    UserDynamics ud = UsersFacade.GetDynamicsForUser(Credentials.UserId);
                    if (ud.MoneyAvailable >= amount)
                    {
                        Transfer t = wmm.DrawOut(amount);
                        if (t == null)
                        {
                            lblError.Text = CommonResources.NotEnougtMoney;
                        }
                        else if (t.Status == TransferStatus.Refused)
                        {
                            lblError.Text = t.Note;
                        }
                        else if (t.Status == TransferStatus.Completed)
                        {
                            lblError.Text = CommonResources.PaymentSuccessful;
                        }
                    }
                    else
                    {
                        lblError.Text = CommonResources.NotEnougtMoney;
                    }
                }
                else
                {
                    lblError.Text = CommonResources.PurseInvalid;
                }
            }
            else
            {
                lblError.Text = String.Format(CommonResources.PaymentAmountError, 0);
            }
        }
    }
}
