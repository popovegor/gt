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
using Resources;
using GT.BO.Implementation.Payments;
using GT.BO.Implementation.Users;
using System.Text.RegularExpressions;

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
            if (amount > WebMoneyManager.MINIMUM)
            {
                if (Regex.IsMatch(purse.Text, "^[0-9]{12}$"))
                {
                    UserDynamics ud = UsersFacade.GetDynamicsForUser(Credentials.UserId);
                    if (ud.MoneyAvailable >= amount)
                    {
                        WebMoneyManager wmm = new WebMoneyManager(UsersFacade.GetUser(Credentials.UserId), null, "R" + purse.Text);
                        Transfer t = wmm.DrawOut(amount);
                        if (t == null)
                        {
                            lblError.Text = CommonResources.NotEnougtMoney;
                        }
                        else if (t.Status == TransferStatus.Refused)
                        {
                            WebMoney wm = WebMoneyFacade.GetByTransferId(t.TransferId).OrderByDescending(p => p.CreateDate).FirstOrDefault();
                            if (wm != null)
                            {
                                switch (wm.RetCode)
                                {
                                    case (int)WebMoneyDrawOutRetCodes.AmountMustMoreZero:
                                        lblError.Text = "Amount must be more zero";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.WmidNotFound:
                                        lblError.Text = "WMID not found";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.TooMuchForTargetPurse:
                                        lblError.Text = "Amount is too much for target purse";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.PurseTypeMustBeSame:
                                        lblError.Text = "Wrong purse type";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.PurseNotSupportDirectTransfer:
                                        lblError.Text = "Your purse is not support direct transfers";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.PayerIsNotAuthorizedForOperation:
                                        lblError.Text = "Your purse is not supported transfer operation";
                                        break;

                                    case (int)WebMoneyDrawOutRetCodes.ParamErrorPursedest:
                                        lblError.Text = "Wrong purse format";
                                        break;

                                    default:
                                        lblError.Text = "Error. Contact with administrator";
                                        break;

                                }
                            }
                            else
                            {
                                lblError.Text = "Error. Contact with administrator";
                            }
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
                lblError.Text = String.Format(CommonResources.PaymentAmountError, WebMoneyManager.MINIMUM.ToString());
            }
        }
    }
}
