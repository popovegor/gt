using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using GT.BO.Implementation.MessageSystem;
using System.ComponentModel;

namespace GT.Web.Site.Controls
{
  public partial class UserCorrespondence : System.Web.UI.UserControl
  {

    private Message[] _сorrespondence = null;

    public Guid SenderId
    {
      get;
      set;
    }

    public Guid RecipientId
    {
      get;
      set;
    }

    protected Message[] Correspondence
    {
      get
      {
        if (_сorrespondence == null)
        {
          _сorrespondence = MessageFacade.GetCorrespondenceAsCollection(SenderId, RecipientId);
        }
        return _сorrespondence;
      }
    }

    protected override void OnInit(EventArgs e)
    {
      base.OnInit(e);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void gvCorrespondence_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      (sender as GridView).PageIndex = e.NewPageIndex;
    }
  }
}