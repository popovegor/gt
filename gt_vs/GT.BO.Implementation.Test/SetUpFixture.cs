using GT.BO.Implementation.Test.BillingSystem;
using GT.Web.Security.Test;
using NUnit.Framework;

namespace GT.BO.Implementation.Test
{
    [SetUpFixture]
    public class SetUpFixture
    {
        [SetUp]
        public void SetUp()
        {
            CreateTestUsers(2);
            BillingSystemFacadeHelper.EnsurePositiveBalance();
        }

        private void CreateTestUsers(int number)
        {
            for (int i = 0; i < number; i++)
            {
                CustomMembershipProviderTestFixture.CreateRandomUser();
            }
        }

        [TearDown]
        public void TearDown()
        {
        }
    }
}
