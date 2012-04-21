using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using GT.BO.Implementation.BillingSystem;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Test.Offers;
using GT.BO.Implementation.Test.Users;
using GT.BO.Implementation.Users;
using GT.DA.Dictionaries;
using GT.DA.Test.Dictionaries;
using NUnit.Framework;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.BillingSystem
{
  [TestFixture]
  public class BillingSystemFacadeTestFixture
  {

    [TestFixtureSetUp]
    public void SetUp()
    {
      for (int i = 0; i < 5; i++)
      {
        Selling o;
        MembershipUser seller = null, buyer = null;
        int historyId;
        SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out historyId);
      }
    }

    [Test]
    public void TestAddTransferFailures()
    {
      var source = BillingSystemFacade.GetRealMoneySource(GT.Global.BillingSystem.RealMoneySourceType.WebMoney);
      var user = UsersFacadeHelper.GetRandomUser(null);
      var amount = source.MinTransferAmount;
      var t = TransferFactory.CreateUserToRealSource(source, user.UserId(), amount, string.Empty);
      var resultCode = 0;
      BillingSystemFacade.AddTransfer(t, out resultCode);
      Assert.AreEqual(-4, resultCode);
    }

    [Test]
    public void TestAcknowledgeOurCommissionReceipt()
    {
      var at = BillingSystemFacadeHelper.AddTransferFromUserToRealSource(
        GT.Global.BillingSystem.RealMoneySourceType.WebMoney, null, null);
      Assert.IsFalse(at.OurCommissionRecieved);
      var nt = BillingSystemFacade.AcknowledgeOurCommissionReceipt(at.TransferId);
      Assert.IsFalse(nt.OurCommissionRecieved);
      BillingSystemFacade.CompleteTransfer(at.TransferId);
      var nnt = BillingSystemFacade.AcknowledgeOurCommissionReceipt(at.TransferId);
      Assert.IsTrue(nnt.OurCommissionRecieved);
    }

    [Test]
    public void TestRefuseTransfer()
    {
      var t = BillingSystemFacadeHelper.AddTransferFromUserToRealSource(GT.Global.BillingSystem.RealMoneySourceType.WebMoney, null, null);
      var bd = UsersFacade.GetDynamicsForUser(t.FromTransferParticipant.UserId);
      var rt = BillingSystemFacade.RefuseTransfer(t.TransferId);
      Assert.IsTrue(rt.Status == GT.Global.BillingSystem.TransferStatus.Refused);
      var ad = UsersFacade.GetDynamicsForUser(t.FromTransferParticipant.UserId);
      Assert.AreEqual(bd.MoneyAvailable + t.Amount, ad.MoneyAvailable);
    }

    [TestAttribute]
    public void TestAddTransferRealMoneyToAllUsers()
    {
      BillingSystemFacadeHelper.EnsurePositiveBalance();
    }

    [TestAttribute]
    public void TestAddTransferUserToUser()
    {
      KeyValuePair<MembershipUser, MembershipUser> participants = UsersFacadeHelper.GetPairRandomUsers();
      //before the transfer

      UserDynamics tdd = UsersFacade.GetDynamicsForUser(participants.Value.UserId());
      UserDynamics fdd = UsersFacade.GetDynamicsForUser((Guid)participants.Key.ProviderUserKey);

      //after the transfer 
      decimal amount = new decimal(10.05);
      Transfer nt = BillingSystemFacade.AddTransfer(TransferFactory.CreateUserToUser(
          participants.Key.UserId(), participants.Value.UserId(), amount
          , string.Format("test {0}", Guid.NewGuid())));
      UserDynamics ntdd = UsersFacade.GetDynamicsForUser(participants.Value.UserId());
      UserDynamics nfdd = UsersFacade.GetDynamicsForUser(participants.Key.UserId());

      Assert.IsNotNull(nt);
      Assert.GreaterOrEqual(nt.TransferId, 1);
      Assert.AreEqual(nt.Amount, amount);
      Assert.AreEqual(participants.Value.UserId(), nt.ToTransferParticipant.UserId);
      Assert.AreEqual(participants.Key.UserId(), nt.FromTransferParticipant.UserId);
      Assert.AreEqual(fdd.MoneyAvailable - amount, nfdd.MoneyAvailable);
      Assert.AreEqual(tdd.MoneyAvailable + amount, ntdd.MoneyAvailable);

      Trace.WriteLine(nt.ToXmlString());
    }

    [TestAttribute]
    public void TestAddTransferBuyerToOffer()
    {
      Selling o;
      var seller = UsersFacadeHelper.GetRandomUser(null);
      var buyer = UsersFacadeHelper.GetRandomUser(new[] {seller.UserId()});
      UserDynamics bd = UsersFacade.GetDynamicsForUser(buyer.UserId()); // buyer dynamics
      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);
      var nbd = UsersFacade.GetDynamicsForUser(buyer.UserId()); // new buyer dynamics
      Assert.AreEqual(o.Price, nbd.MoneyBlocked - bd.MoneyBlocked);
      Assert.AreEqual(o.Price, bd.MoneyAvailable - nbd.MoneyAvailable);
    }
    
    [Test]
    public void TestAddTransferOfferToSeller()
    {

      Selling o;
      var seller = UsersFacadeHelper.GetRandomUser(null);
      var buyer = UsersFacadeHelper.GetRandomUser(new[] { seller.UserId() });
    
      //offer to seller
      var sd = UsersFacade.GetDynamicsForUser(seller.UserId()); // seller dynamics
      var bd = UsersFacade.GetDynamicsForUser(buyer.UserId());
      SellingFacadeHelper.FinishOffer(out o, ref seller, ref buyer);
      var nsd = UsersFacade.GetDynamicsForUser(seller.UserId()); // new seller dynamics
      var nbd = UsersFacade.GetDynamicsForUser(buyer.UserId()); // new buyer dynamics

      Assert.AreEqual(o.Price, nsd.MoneyAvailable - sd.MoneyAvailable); //
      Assert.AreEqual(o.Price, bd.MoneyAvailable - nbd.MoneyAvailable); //
      Assert.AreEqual(bd.MoneyBlocked, nbd.MoneyBlocked);
    }

    [TestAttribute]
    public void GetTransfersForUser()
    {
      foreach (MembershipUser u in UsersFacade.GetAllUsers())
      {
        IEnumerable<Transfer> transfers = BillingSystemFacade.GetTransfersForUser(u.UserId());
        foreach (Transfer t in transfers)
        {
          Assert.IsTrue(t.FromTransferParticipant.UserId == u.UserId()
              || t.ToTransferParticipant.UserId == u.UserId());
        }
      }
    }
  }
}
