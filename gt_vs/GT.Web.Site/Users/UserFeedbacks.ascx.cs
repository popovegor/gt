using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Implementation.UserRating;
using GT.Web.UI.Controls;

namespace GT.Web.Site.Users
{
  public partial class UserFeedbacks : BaseControl
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    
    public Feedback[] Feedbacks
    {
      get;set;
    }
  }
}