using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Implementation.BillingSystem;
using GT.BO.Implementation.Users;
using GT.DA.Dictionaries;
using GT.DA.Test.Dictionaries;
using GT.BO.Implementation.Test.Users;
using NUnit.Framework;
using GT.Global.BillingSystem;
using GT.Common.Types;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.BillingSystem
{
  internal static class BillingSystemFacadeHelper
  {
    public static Transfer AddTransferFromUserToRealSource(RealMoneySourceType? realSourceId, Guid? user, decimal? amount)
    {
      var u = user ?? UsersFacadeHelper.GetRandomUser(null).UserId();
      var sourceType = realSourceId 
        ?? DictionariesHelper.GetRandomDictionaryEntryId<RealMoneySourceType>(
          DictionaryTypes.RealMoneySource, RealMoneySourceFields.RealMoneySourceId);
      var s = BillingSystemFacade.GetRealMoneySource(sourceType);
      var a = amount ?? new Random((int)DateTime.Now.Ticks).Next(10, 20);
      var n = string.Format("a test transfer from the user {0} to real source", u);
      var t = TransferFactory.CreateUserToRealSource(s, u, a, n);
      var at = BillingSystemFacade.AddTransfer(t);
      Assert.IsTrue(t.Compare(at));
      return at;
    }

    /// <summary>
    /// Add completed transfer 
    /// </summary>
    /// <param name="realMoneySourceId">if null then returns a random real money source</param>
    /// <param name="user">if null then returns a random user</param>
    /// <param name="amount">if null then returns random amount</param>
    public static Transfer AddTransferRealSourceToUser(RealMoneySourceType? realSourceId, Guid? user, decimal? amount)
    {
      realSourceId = realSourceId.HasValue
          ? realSourceId.Value
          : DictionariesHelper.GetRandomDictionaryEntryId<RealMoneySourceType>(DictionaryTypes.RealMoneySource, RealMoneySourceFields.RealMoneySourceId);
      user = user.HasValue
          ? user.Value
          : UsersFacadeHelper.GetRandomUser(null).UserId();
      amount = amount.HasValue
          ? amount.Value
          : new Random((int)DateTime.Now.Ticks).Next(10, 20);

      Guid key = Guid.NewGuid();
      string note = string.Format("Transfer a real money source to a user {0}", key);
      var udBeforeTransfer = UsersFacade.GetDynamicsForUser(user.Value);
      Transfer t = TransferFactory.CreateRealSourceToUser(realSourceId.Value, user.Value, amount.Value, note);
      Transfer nt = BillingSystemFacade.AddTransfer(t);
      var udAfterTransfer = UsersFacade.GetDynamicsForUser(user.Value);
      Assert.IsTrue(udAfterTransfer.Compare(udBeforeTransfer));
      Assert.IsTrue(t.Compare(nt));
      Assert.AreEqual(TransferStatus.Pending, nt.Status);
      var ct = BillingSystemFacade.CompleteTransfer(nt.TransferId);
      Assert.AreEqual(TransferStatus.Completed, ct.Status);
      var udAfterTransferComplete = UsersFacade.GetDynamicsForUser(user.Value);
      Assert.AreEqual(udBeforeTransfer.MoneyAvailable + amount, udAfterTransferComplete.MoneyAvailable);
      return nt;
    }

    public static void EnsurePositiveBalance()
    {
      //ensure that the balance of any user is positive
      Random rnd = new Random((int)DateTime.Now.Ticks);
      foreach (var u in UsersFacade.GetAllUsers())
      {
        Guid key = Guid.NewGuid();
        foreach (int id in Dictionaries.Instance.GetRealMoneySourceIds())
        {
          UserDynamics dd = UsersFacade.GetDynamicsForUser(u.UserId());
          decimal amount = (decimal)rnd.Next(10, 200) + new decimal(0.52);
          var source = TypeConverter.ToEnumMember<RealMoneySourceType>(id);
          //var t = TransferFactory.CreateRealSourceToUser(source, u.UserId, amount, string.Format("test {0}", key));
          var nt = AddTransferRealSourceToUser(source, u.UserId(), amount);
          //Transfer nt = CashflowFacade.AddTransfer(t);
          UserDynamics ndd = UsersFacade.GetDynamicsForUser(u.UserId());
          Assert.AreEqual(dd.MoneyAvailable + amount, ndd.MoneyAvailable);
          Assert.AreEqual(id, nt.FromTransferParticipant.RealMoneySourceId);
        }
      }
    }
  }
}
