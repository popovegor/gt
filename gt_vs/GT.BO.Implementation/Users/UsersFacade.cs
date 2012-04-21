using System;
using GT.DA.Users;
using System.Web.Security;
using System.Linq;
using System.Collections.Generic;
using GT.Web.Security;
using GT.Global.Security;

namespace GT.BO.Implementation.Users
{
    public static class UsersFacade
    {
        //public static void ReloadCache()
        //{
        //    UserCache.Instance.ReloadCache();
        //}

        public static MembershipUser GetUser(Guid userId)
        {
           return Membership.GetUser(userId as object);
        }

        public static MembershipUser GetUser(string userName)
        {
          return Membership.GetUser(userName);
        }

        public static IEnumerable<MembershipUser> GetAllUsers()
        {
            return Membership.GetAllUsers().Cast<MembershipUser>()
              .Where(m => m.UserId() != MembershipSettings.SystemUserKey);
        }

        public static UserDynamics GetDynamicsForUser(Guid userId)
        {
            return new UserDynamics().Load<UserDynamics>(UserDataAdapter.GetDynamicsForUser(userId));
        }
    }
}
