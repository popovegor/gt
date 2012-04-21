using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Web.UI.Controls;
using System.ComponentModel;

namespace GT.Web.Site.PersonalAccount
{
  public partial class OfficeBlock : BaseControl
  {
    public class OfficeBlockContainer : Control, INamingContainer
    {
      internal OfficeBlockContainer()
      { }
    }

    [TemplateContainer(typeof(OfficeBlockContainer))]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    public ITemplate Content
    {
      get;
      set;
    }

    protected override void Page_Init(object sender, EventArgs e)
    {
      if (Content != null)
      {
        OfficeBlockContainer c = new OfficeBlockContainer();
        Content.InstantiateIn(c);
        phContent.Controls.Add(c);
      }
      //base.Page_Init(sender, e);
    }

    [DefaultValue("")]
    public string Title { get; set; }

    public string Url { get; set; }

    [DefaultValue("")]
    public string TitleImgClass { get; set; }

    [DefaultValue("")]
    public string TitleClass { get; set; }

    public bool AsLink { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {

    }


  }
}