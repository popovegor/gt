using System;
using System.ComponentModel;
using System.Web.Script.Services;
using System.Web.Services;
using GT.BO.Implementation.Users;
using GT.Web.Services;
using GT.DA.Dictionaries;
using GT.Common.Web.Cookie;

namespace GT.Web.Site.WebServices.Ajax
{
  /// <summary>
  /// Summary description for UsersService
  /// </summary>
  [WebService(Namespace = "http://tempuri.org/")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [ToolboxItem(false)]
  [ScriptService]
  public class UsersService : BaseWebService
  {
    [WebMethod]
    public UserDynamics GetDynamics()
    {
      Guid userId = Credentials.UserId;
      return UsersFacade.GetDynamicsForUser(userId);
    }

    [WebMethod]
    public void SetTimeZone(int offset, bool dst)
    {
      int timeZoneId = 0;
      var tz = Dictionaries.Instance.GetTimeZoneInfoByOffset(offset, dst, out timeZoneId);
      if (tz != null && timeZoneId != int.MinValue)
      {
        Context.SetTimeZoneId(timeZoneId.ToString());
      }
    }
  }
}
