using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using Resources;
using GT.Web.UI.Pages;

namespace GT.Web.Site.DetailsInfo
{
  public partial class UserInfo : BasePage
  {
    private Guid? _userId = null;

    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
      { 
        InitInfo();
      }
    }

    UserDynamics _dynamics;
    protected UserDynamics Dynamics
    {
        get
        {
            if (null == _dynamics)
            {
                if (UserId.HasValue)
                {
                    _dynamics = UsersFacade.GetDynamicsForUser(UserId.Value);
                }
                else
                {
                    _dynamics = new UserDynamics();
                }
            }
            return _dynamics;
        }
    }

    protected Guid? UserId
    {
      get
      {
        if (_userId.HasValue == false)
        {
          var userIdFromQuery = Request.QueryString["UserID"];
          if (null != userIdFromQuery)
          {
            _userId = new Guid(userIdFromQuery);
          }
          else
          {
            _userId = Guid.Empty;
          }
        }
        return _userId;
      }
    }

    protected void InitInfo()
    {
      if (UserId.HasValue)
      {
        User u = UsersFacade.GetUser(UserId.Value);
        if (u != null)
        {
          UserNameValue.Text = u.UserName;

          //UserDynamics ud = UsersFacade.GetDynamicsForUser(UserId.Value);
          //if (ud != null)
          //{
          //  UserSellsCountValue.Text = ud.DealsTotal.ToString();
          //}

          MembershipUser mu = Membership.GetUser(u.UserName);
          if (mu != null)
          {
            UserRegistrDateValue.Text = mu.CreationDate.ToString();
            LastVisitDateValue.Text = mu.LastLoginDate.ToString();
          }

          return;
        }
      }

      info.Visible = false;
      err.Visible = true;
      err.Text = CommonResources.UserInfoUnavailable;
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }
  }
}
