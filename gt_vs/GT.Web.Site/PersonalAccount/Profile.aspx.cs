using System;
using GT.Web.UI.Pages;
using GT.Web.Site.MasterPages;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.DA.Dictionaries;

namespace GT.Web.Site.PersonalAccount
{
  public partial class Profile : BaseEditPage
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

    protected void btnSave_Click(object sender, EventArgs e)
    {
      Page.Validate();
      if (Page.IsValid == true)
      {
        Credentials.Profile.FirstName = txtFirstName.Text;
        Credentials.Profile.LastName = txtLastName.Text;
        Credentials.Profile.Nickname = txtNickname.Text;
        Credentials.Profile.ICQ = txtICQ.Text;
        Credentials.Profile.Skype = txtSkype.Text;
        Credentials.Profile.Phone = txtPhone.Text;
        Credentials.Profile.MobilePhone = txtMobilePhone.Text;
        Credentials.Profile.Address = txtAddress.Text;
        Credentials.Profile.TimeZone = ddlTimeZone.SelectedValue;
        Credentials.Profile.Note = txtNote.Text;
        Credentials.Profile.EmailMessageNotification = chkEmailNotification.Checked;
        Credentials.Profile.Save();
        Response.Redirect("~/Office",true);
      }
    }
  }
}
