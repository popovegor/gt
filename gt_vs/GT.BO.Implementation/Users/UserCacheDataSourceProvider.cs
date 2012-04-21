using System;
using System.Collections.Generic;
using System.Web.Security;
using GT.BO.Caching.DataSource;
using GT.BO.Caching.Loading;
using GT.Common;
using GT.Common.Exceptions;
using GT.Global.Security;

namespace GT.BO.Implementation.Users
{
    internal class UserCacheDataSourceProvider : CacheDataSourceProvider
    {
        public override bool LoadData<DataType>(CacheLoadContext<DataType> loadContext)
        {
            MembershipUserCollection muc = Membership.GetAllUsers();
            List<_User> users = new List<_User>();
            int index = 0;
            foreach (MembershipUser mu in muc)
            {
                if ((Guid)mu.ProviderUserKey != MembershipSettings.SystemUserKey)
                {
                    _User u = new _User(mu);
                    users.Add(u);
                    index++;
                }
            }
            loadContext.Data = (users.ToArray() as DataType);
            return true;
        }

        public override void HandleDataLoadingException(Exception p_ex)
        {
            AssistLogger.Log<ExceptionHolder>(p_ex);
        }

        public override void Dispose()
        {
        }
    }
}
