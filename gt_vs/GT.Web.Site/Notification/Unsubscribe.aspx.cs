using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Pages;
using GT.Global.Notification;
using GT.Common.Types;
using GT.Web.Site.PersonalAccount;
using System.Web.Profile;
using GT.Web.Security;

namespace GT.Web.Site.Notification
{
  public partial class Unsubscribe : BasePage
  {

    protected Guid UserId
    {
      get
      {
        return TypeConverter.ToGuid(Request.QueryString[UnsubscribeParams.UserId]);
      }
    }

    protected UnsubscribeParams.Notification NotificationType
    {
      get
      {
        return TypeConverter.ToEnumMember<UnsubscribeParams.Notification>(Request.QueryString[UnsubscribeParams.NotificationType], UnsubscribeParams.Notification.Email);
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      if (UserId != Guid.Empty)
      {
        if (NotificationType != UnsubscribeParams.Notification.None)
        {
          var profile = CustomProfileProvider.GetProfileByUserKey(UserId);
          if (profile != null)
          {
            switch (NotificationType)
            {
              case UnsubscribeParams.Notification.Email:
                profile.EmailMessageNotification = false;
                break;
            }
            profile.Save();
          }
        }
      }
      DataBind();
    }
  }
}
