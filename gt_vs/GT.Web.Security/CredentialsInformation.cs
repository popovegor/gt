using System;
using System.Security.Principal;
using System.Web;
using System.Web.Security;

namespace GT.Web.Security
{
    public class CredentialsInformation
    {
        private IPrincipal _user = null;
        private MembershipUser _membershipUser = null;
        
        public CredentialsInformation() : this(HttpContext.Current)
        {
          
        }

        public CredentialsInformation(HttpContext context) : this(context != null ? context.User : null)
        {
        }

        public CredentialsInformation(IPrincipal user)
        {
            _user = user;
        }

        public MembershipUser User
        {
            get
            {
                if (null == _membershipUser)
                {
                    string userName = UserName;
                    if (string.IsNullOrEmpty(userName) == false)
                    {
                        _membershipUser = Membership.GetUser(userName, true);
                    }
                }
                return _membershipUser;
            }
        }

        public bool IsLoggedIn
        {
            get
            {
                return AuthenticationHelper.IsLoggedInUser(_user);
            }
        }

        public string UserName
        {
            get
            {
                return AuthenticationHelper.GetUserName(_user);
            }
        }

        public Guid UserId
        {
            get
            {
                MembershipUser user = User;
                if (user != null)
                {
                    return (Guid)_membershipUser.ProviderUserKey;
                }
                return Guid.Empty;
            }
        }

        public CustomUserProfile Profile
        {
            get
            {
                return (HttpContext.Current != null ? HttpContext.Current.Profile : null) as CustomUserProfile;
            }
        }
        
        public bool IsInRole(string role)
        {
          return _user != null && true == _user.IsInRole(role);
        }
    }
}
