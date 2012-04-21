using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.DA.Dictionaries;

namespace GT.Web.Site.Controls
{
  public partial class Server : System.Web.UI.UserControl
  {
  
    public int ServerId
    {
      get;
      set;
    }
    
    
    public string _name = null;
    
    public string Name 
    {
      get
      {
        if(_name == null)
        {
          _name = Dictionaries.Instance.GetGameServerNameById(ServerId);
        }
        return _name;
      }
    }
    
    public bool ShowNewWindow {get;set;}
  
    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}