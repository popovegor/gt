using System;
using System.Web.Security;
using System.Web.UI;
using GT.Common.Cryptography;
using GT.Common.Types;
using GT.Localization.Resources;
using GT.Web.UI.Pages;
using GT.Global.Security;
using System.Linq;
using GT.Web.Security;
using Microsoft.Security.Application.SecurityRuntimeEngine;

namespace GT.Web.Site.Authentication
{
  [SupressAntiXssEncoding()]
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
              if (Roles.FindUsersInRole(RolesSettings.NonactivatedUser, mu.UserName).Length == 1)
              {
                Roles.RemoveUserFromRole(mu.UserName, RolesSettings.NonactivatedUser);
              }
              if (Roles.FindUsersInRole(RolesSettings.User, mu.UserName).Length == 0)
              {
                Roles.AddUserToRole(mu.UserName, RolesSettings.User);
              }
              var profile = CustomProfileProvider.GetProfileByUserKey(mu.UserId());
              if (profile != null)
              {
                profile.EmailMessageNotification = true;
                profile.Save();
              }
              Roles.DeleteCookie();
              result.Text = string.Format(CommonResources.ConfirmationResultAprove, "/Office");
            }
          }
        }
      }

      DataBind();
    }
  }
}
