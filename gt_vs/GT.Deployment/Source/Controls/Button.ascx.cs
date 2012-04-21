using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace GT.Web.Site.Controls
{
  public partial class Button : UserControl
  {

    public bool UseSubmitBehavior
    {
      get
      {
        return btn.UseSubmitBehavior;
      }
      set
      {
        btn.UseSubmitBehavior = value;
      }
    }

    public string CssClass
    {
      get
      {
        return button.Attributes["class"];
      }
      set
      {
        button.Attributes["class"] = string.Format("button {0}", value);
      }
    }

    public bool CausesValidation
    {
      get
      {
        return btn.CausesValidation;
      }
      set
      {
        btn.CausesValidation = value;
      }
    }

    public new string ID
    {
      get
      {
        return btn.ID;
      }
      set
      {
        btn.ID = value;
      }
    }

    public new string ClientID
    {
      get
      {
        return btn.ClientID;
      }
    }

    public string OnClientClick
    {
      get
      {
        return btn.OnClientClick;
      }
      set
      {
        btn.OnClientClick = value;
      }
    }

    public string ToolTip
    {
      get
      {
        return btn.ToolTip;
      }
      set
      {
        btn.ToolTip = value;
      }
    }

    public string CommandName
    {
      get
      {
        return btn.CommandName;
      }
      set
      {
        btn.CommandName = value;
      }
    }

    public string ValidationGroup
    {
      get
      {
        return btn.ValidationGroup;
      }
      set
      {
        btn.ValidationGroup = value;
      }
    }

    public string Text
    {
      get
      {
        return btn.Text;
      }
      set
      {
        btn.Text = value;
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    public string CommandArgument
    {
      get
      {
        return btn.CommandArgument;
      }
      set
      {
        btn.CommandArgument = value;
      }
    }

    public string PostBackUrl
    {
      get
      {
        return btn.PostBackUrl;
      }
      set
      {
        btn.PostBackUrl = value;
      }
    }

    public bool Enabled
    {
      get
      {
        return btn.Enabled;
      }
      set
      {
        btn.Enabled = false;
      }
    }

    public event EventHandler Click 
    {
      add
      {
        btn.Click += value;
      }
      remove
      {
        btn.Click -= value;
      }
    }
    
  }
}