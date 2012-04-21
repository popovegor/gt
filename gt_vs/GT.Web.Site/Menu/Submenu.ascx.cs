using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Menu
{
  public partial class Submenu : System.Web.UI.UserControl
  {
    public class ContentContainer : Control, INamingContainer
    {
      internal ContentContainer()
      { }
    }

    [TemplateContainer(typeof(ContentContainer))]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    public ITemplate Content
    {
      get;
      set;
    }

    protected void Page_Init()
    {
      if (Content != null)
      {
        var c = new ContentContainer();
        Content.InstantiateIn(c);
        phContent.Controls.Add(c);
      }
    }
  
    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}