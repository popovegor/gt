using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.ComponentModel;

namespace GT.Web.Site.Controls
{
  public partial class Box : System.Web.UI.UserControl
  {
    private ITemplate _content = null;
    private ITemplate _title = null;
    private string _cssClass = string.Empty;

    public class BoxContainer : Control, INamingContainer
    {
      internal BoxContainer()
      { }
    }

    public class TitleContainer : Control, INamingContainer
    {
      internal TitleContainer()
      { }
    }
    
    public string CssClass
    {
      get { return _cssClass; }
      set { _cssClass = value; }
    }

    [TemplateContainer(typeof(TitleContainer))]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    public ITemplate Title
    {
      get
      {
        return _title;
      }
      set
      {
        _title = value;
      }
    }

    [TemplateContainer(typeof(BoxContainer))]
    [PersistenceMode(PersistenceMode.InnerProperty)]
    public ITemplate Content
    {
      get
      {
        return _content;
      }
      set
      {
        _content = value;
      }
    }

    protected void Page_Init()
    {
      if (_content != null)
      {
        BoxContainer c = new BoxContainer();
        Content.InstantiateIn(c);
        phContent.Controls.Add(c);
      }
      if (_title != null)
      {
        TitleContainer t = new TitleContainer();
        Title.InstantiateIn(t);
        phTitle.Controls.Add(t);
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }
  }
}