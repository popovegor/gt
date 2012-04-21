using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.Global.Entities;
using System.ComponentModel;

namespace GT.Web.UI.Controls
{
  [ToolboxData("<{0}:UserView runat=\"server\"></{0}:UserView")]
  public class UserView : View
  {
  }

  [ToolboxData("<{0}:DefaultView runat=\"server\"></{0}:DefaultView>")]
  public class DefaultView : View
  {
  }

  [ToolboxData("<{0}:EntityMultiView runat=\"server\"></{0}:EntityMultiView>")]
  [ParseChildren(typeof(View))]
  public class EntityMultiView : MultiView
  {

    [DefaultValue(EntityType.None)]
    public EntityType Entity
    {
      get;
      set;
    }

    protected bool IsAppropriateView(View p_ctlView)
    {
      if (p_ctlView is UserView && Entity == EntityType.User)
      {
        return true;
      }
      if (p_ctlView is DefaultView)
      {
        return true;
      }
      return false;
    }

    protected override void OnInit(EventArgs e)
    {
      EnableViewState = false;
      base.OnInit(e);
    }

    protected override void DataBindChildren()
    {
      for (int i = Views.Count - 1; i >= 0; i--)
      {
        if (!IsAppropriateView(Views[i]))
        {
          Views.RemoveAt(i);
        }
      }
      foreach (View v in Views)
      {
        if (IsAppropriateView(v))
        {
          SetActiveView(v);
        }
      }
      base.DataBindChildren();
    }
  }
}
