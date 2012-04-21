using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using NUnit.Framework;
using GT.BO.Implementation.Users;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.Users
{
  public class UsersFacadeHelper
  {
    /// <summary>
    /// Returns with checking of users count
    /// </summary>
    /// <returns></returns>
    public static KeyValuePair<MembershipUser, MembershipUser> GetPairRandomUsers()
    {
      Assert.GreaterOrEqual(UsersFacade.GetAllUsers().Count(), 2);
      return new KeyValuePair<MembershipUser, MembershipUser>(UsersFacade.GetAllUsers().ToArray()[0], UsersFacade.GetAllUsers().ToArray()[1]);
    }

    /// <summary>
    /// Returns a random User object with checking
    /// </summary>
    /// <returns></returns>
    [Timeout(10000)]
    public static MembershipUser GetRandomUser(IEnumerable<Guid> exceptedUsers)
    {
      IEnumerable<Guid> e = exceptedUsers ?? new List<Guid>();
      Assert.GreaterOrEqual(UsersFacade.GetAllUsers().Count(), 1 + e.Count());
      Random rnd = new Random((int)DateTime.Now.Ticks);
      Func<MembershipUser> getRandomUser = delegate { return UsersFacade.GetAllUsers().ToArray()[rnd.Next(0, UsersFacade.GetAllUsers().Count())]; };
      MembershipUser u = null;
      int i = 0;
      int j = 0;
      do
      {
        i++;
        //iteration algorithm
        if (i >= 10 && j < UsersFacade.GetAllUsers().Count())
        {
          u = UsersFacade.GetAllUsers().ToArray()[j];
          j++;
        }
        else //random algorithm
        {
          u = getRandomUser();
        }

      } while (e.Contains(u.UserId()));

      return u;
    }
  }
}
