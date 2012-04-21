using System;
using System.Web.Security;
using NUnit.Framework;

namespace GT.Web.Security.Test
{
    [TestFixture]
    public class CustomMembershipProviderTestFixture
    {
        [TestAttribute]
        public void CreateUser()
        {
            CreateRandomUser();
        }

        public static MembershipUser CreateRandomUser() 
        {
            Guid key = Guid.NewGuid();
            string name = key.ToString();
            string password = key.ToString();
            string email = string.Format("email{0}@test.com", key);
            string question = key.ToString();
            string answer = key.ToString();
            MembershipCreateStatus status = MembershipCreateStatus.Success;
            MembershipUser u = Membership.CreateUser(name, password, email, question, answer, true, out status);
            Assert.IsTrue(MembershipCreateStatus.Success == status);
            Assert.AreEqual(name, u.UserName);
            Assert.AreEqual(email, u.Email);
            Assert.AreEqual(question, u.PasswordQuestion);
            Assert.IsTrue(Membership.ValidateUser(name, question));
            return u;
        }
    }
}
