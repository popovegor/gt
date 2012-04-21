using System;
using System.Web.Security;
using System.Web.UI;
using GT.Common.Cryptography;
using GT.Common.Types;
using Resources;
using GT.Web.UI.Pages;

namespace GT.Web.Site.Authentication
{
    public partial class Confirmation : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            result.Text = CommonResources.ConfirmationDefault;

            if (!Page.IsPostBack && Request.QueryString["code"] != null)
            {
                Guid id = TypeConverter.ToGuid(Request.QueryString["code"]);
                if (id != Guid.Empty)
                {
                    MembershipUser mu = Membership.GetUser(id);
                    if (mu != null)
                    {
                        if (Request.QueryString["mail"] != null && Request.QueryString["checker"] != null)
                        {
                            if (string.Compare(Request.QueryString["checker"], Hash.ReadableHash(Hash.MD5, Request.QueryString["mail"] + Request.QueryString["code"])) == 0)
                            {
                                mu.Email = Request.QueryString["mail"];
                                Membership.UpdateUser(mu);
                                result.Text = String.Format(CommonResources.ConfirmationResultChangeMail, mu.Email);
                            }
                        }
                        else
                        {
                            mu.IsApproved = true;
                            Membership.UpdateUser(mu);
                            result.Text = CommonResources.ConfirmationResultAprove;
                        }
                    }
                }
            }
        }
    }
}
