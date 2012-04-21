using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Controls
{
  public partial class RoundCornerBlock : System.Web.UI.UserControl
  {
    public class ContentContainer : Control, INamingContainer
    {
      internal ContentContainer()
      { }
    }

    public class TitleContainer : Control, INamingContainer
    {
      internal TitleContainer()
      { }
    }

    [TemplateContainer(typeof(TitleContainer))]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    public ITemplate Title
    {
      get;
      set;
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
      if (Title != null)
      {
        var t = new ContentContainer();
        Title.InstantiateIn(t);
        phTitle.Controls.Add(t);
      }
    }
    
    [CssClassProperty]
    public string CssClass
    {
      get;set;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}