using System;
using GT.Web.UI.Pages;
using GT.Global;
using GT.Common.Types;

namespace GT.Web.Site.Help
{
  public partial class Help : BasePage
  {

    protected HelpParams.Section SectionType
    {
      get
      {
        return TypeConverter.ToEnumMember<HelpParams.Section>(
          Request.QueryString[HelpParams.SectionType], HelpParams.Section.General);
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Page_LoadComplete(object sender, EventArgs e)
    {
      DataBind();
    }

    protected string GetUrlForSection(HelpParams.Section section)
    {
      return string.Format("/Help/{0}", section);
    }

  }
}
