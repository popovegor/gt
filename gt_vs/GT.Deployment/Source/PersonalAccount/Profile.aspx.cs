using System;
using GT.Web.UI.Pages;
using GT.Web.Site.MasterPages;
using Resources;
using GT.DA.Dictionaries;

namespace GT.Web.Site.PersonalAccount
{
  public partial class Profile : GT.Web.UI.Pages.BasePage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
      if (string.IsNullOrEmpty(Credentials.Profile.TimeZone) == false)
      {
        ddlTimeZone.SelectedValue = Credentials.Profile.TimeZone;
      }
      else
      {
        ddlTimeZone.SelectedValue = Dictionaries.Instance.GetDefaultTimeZone().ToString();
      }
    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
    }
  }
}
