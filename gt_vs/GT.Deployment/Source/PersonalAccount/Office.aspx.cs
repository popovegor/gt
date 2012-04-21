using System;
using GT.BO.Implementation.Users;
using GT.Web.UI.Pages;
using System.Data;
using GT.BO.Implementation.UserRating;
using System.Collections.Generic;
using GT.BO.Implementation.MessageSystem;
using System.Linq;
using System.Xml;
using GT.Common.Xml.Xsl;

namespace GT.Web.Site.PersonalAccount
{
  public partial class Office : BasePage
  {
    private UserDynamics _dynamics = null;
    private DataTable _unapprovedFeedbacks = null;
    private Message[] _lastMessages = null;
    private DataTable _lastFeedbacks = null;

    protected int LastMessageDisplayCount
    {
      get
      {
        return 5;
      }
    }

    protected int LastFeedbacksCount
    {
      get
      {
        return 5;
      }
    }

    protected UserDynamics Dynamics
    {
      get
      {
        if (null == _dynamics)
        {
          _dynamics = UsersFacade.GetDynamicsForUser(this.Credentials.UserId);
        }
        return _dynamics;
      }
    }
    
    protected DataTable UnapprovedFeedbacks
    {
      get
      {
        if(_unapprovedFeedbacks == null)
        {
          _unapprovedFeedbacks = UserRatingFacade.GetUnapprovedForUserAsDataTable(Credentials.UserId);
        }
        return _unapprovedFeedbacks;
      }
    }

    protected Message[] LastMessages
    {
      get
      {
        if(_lastMessages == null)
        {
          _lastMessages = MessageFacade.SearchAsCollection(new MessageSearchFilter(Credentials.UserId, LastMessageDisplayCount));
        }
        return _lastMessages;
      }
    }
    
    protected DataTable LastFeedbacks
    {
      get
      {
        if (_lastFeedbacks == null)
        {
          _lastFeedbacks = UserRatingFacade.GetFeedbacksForUser(Credentials.UserId, LastFeedbacksCount);
        }
        return _lastFeedbacks;
      }
    }
    
    //protected string LastMessagesContent
    //{
    //  get
    //  {
    //    if (LastMessages != null && LastMessages.Rows.Count > 0)
    //    {
    //      LastMessages.TableName = "Message";
    //      XmlDocument xml = new XmlDocument();
    //      using (XmlReader xr = XmlReader.Create(Server.MapPath("~/XsltTemplates/Messages/View.xslt")))
    //      {
    //        xml.Load(xr);
    //      }
    //      return XslTransformationHelper.Transform(LastMessages, null, xml);
    //    }
    //    return string.Empty;
    //  }
    //}

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected override void OnPreRender(EventArgs e)
    {
      base.OnPreRender(e);
      DataBind();
    }
  }
}
