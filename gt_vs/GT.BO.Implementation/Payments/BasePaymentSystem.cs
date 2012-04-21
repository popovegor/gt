using System;
using GT.BO.Implementation.Users;
using GT.Global.BillingSystem;
using GT.BO.Implementation.BillingSystem;
using System.Web.Security;

namespace GT.BO.Implementation.Payments
{
  public abstract class BasePaymentSystem
  {
    protected MembershipUser m_User;
    protected RealMoneySource m_MoneySource;

    public virtual Transfer TopUp(decimal amount)
    {
      return BillingSystemFacade.AddTransfer(TransferFactory.CreateRealSourceToUser((RealMoneySourceType)m_MoneySource.RealMoneySourceId, (Guid)m_User.ProviderUserKey, amount, string.Empty));
    }

    public virtual Transfer DrawOut(decimal amount)
    {
      return BillingSystemFacade.AddTransfer(TransferFactory.CreateUserToRealSource(m_MoneySource, (Guid)m_User.ProviderUserKey, amount, string.Empty));
    }

    public RealMoneySource RealMoneySource
    {
      get
      {
        return m_MoneySource;
      }
    }
  }
}