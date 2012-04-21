using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Web.Security;
using GT.BO.Implementation.Users;
using GT.Global.Security;
using NUnit.Framework;
using GT.BO.Implementation.Test.Offers;
using GT.BO.Implementation.Offers;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.Users
{
  [TestFixture]
  public class UsersFacadeTestFixture
  {
    [TestAttribute]
    public void TestGetDynamicDataForUser()
    {
      foreach (MembershipUser u in UsersFacade.GetAllUsers())
      {
        if (MembershipSettings.SystemUserKey != u.UserId())
        {
          UserDynamics dd = UsersFacade.GetDynamicsForUser(u.UserId());
          Assert.AreEqual(u.UserId(), dd.UserId);
          Assert.AreEqual(dd.MoneyTotal, dd.MoneyBlocked + dd.MoneyAvailable);
          Trace.WriteLine(dd.ToXmlString());
        }
      }
    }

    [TestAttribute]
    public void TestIndexer()
    {
      //UsersFacade.ReloadCache();
      foreach (MembershipUser mu in Membership.GetAllUsers())
      {
        if ((Guid)mu.ProviderUserKey != MembershipSettings.SystemUserKey)
        {
          MembershipUser u = UsersFacade.GetUser((Guid)mu.ProviderUserKey);
          Assert.AreEqual(mu.UserName, u.UserName);
          u = UsersFacade.GetUser(mu.UserName);
          Assert.AreEqual(mu.UserName, u.UserName);
          Trace.WriteLine(u);
        }
      }
    }

   

    [TestAttribute]
    public void TestDynamicsStartedDeals()
    {
      MembershipUser u = UsersFacadeHelper.GetRandomUser(null);
      UserDynamics ud = UsersFacade.GetDynamicsForUser(u.UserId());

      Selling o = SellingFacadeHelper.AddOffer(u.UserId(), null);
      UserDynamics ud2 = UsersFacade.GetDynamicsForUser(u.UserId());
      Assert.AreEqual(ud2.DealsStarted, ud.DealsStarted + 1);
      Assert.AreEqual(ud2.DealsTotal, ud.DealsTotal + 1);

      SellingFacade.DelStartOffer(o);

      UserDynamics ud3 = UsersFacade.GetDynamicsForUser(u.UserId());

      Assert.AreEqual(ud3.DealsTotal, ud.DealsTotal);
    }

    [TestAttribute]
    public void TestDynamicsAcceptedDeals()
    {
      int history;
      Selling o;
      MembershipUser seller = UsersFacadeHelper.GetRandomUser(null);
      MembershipUser buyer = UsersFacadeHelper.GetRandomUser(new[] { seller.UserId() });

      UserDynamics uds = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb = UsersFacade.GetDynamicsForUser(buyer.UserId());

      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out history);

      UserDynamics uds2 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb2 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds2.DealsSellerAccepted, uds.DealsSellerAccepted + 1);
      Assert.AreEqual(uds2.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb2.DealsBuyerAccepted, udb.DealsBuyerAccepted + 1);
      Assert.AreEqual(udb2.DealsTotal, udb.DealsTotal + 1);

      SellingFacade.CancelOfferAccepted(ref o, seller.UserId(), out history);

      UserDynamics uds3 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb3 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds3.DealsStarted, uds.DealsStarted + 1);
      Assert.AreEqual(uds3.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb3.DealsTotal, udb.DealsTotal);

      SellingFacade.DelStartOffer(o);

      UserDynamics uds4 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb4 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds4.DealsTotal, uds.DealsTotal);
      Assert.AreEqual(udb4.DealsTotal, udb.DealsTotal);
    }

    [TestAttribute]
    public void TestDynamicsSubmittedDeals()
    {
      Selling o;
      var seller = UsersFacadeHelper.GetRandomUser(null);
      var buyer = UsersFacadeHelper.GetRandomUser(new[] { seller.UserId() });

      UserDynamics uds = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb = UsersFacade.GetDynamicsForUser(buyer.UserId());

      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);

      UserDynamics uds2 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb2 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds2.DealsSellerSubmitted, uds.DealsSellerSubmitted + 1);
      Assert.AreEqual(uds2.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb2.DealsBuyerSubmitted, udb.DealsBuyerSubmitted + 1);
      Assert.AreEqual(udb2.DealsTotal, udb.DealsTotal + 1);

      SellingFacade.CancelConfirmedOffer(o);

      UserDynamics uds3 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb3 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds3.DealsStarted, uds.DealsStarted + 1);
      Assert.AreEqual(uds3.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb3.DealsTotal, udb.DealsTotal);

      SellingFacade.DelStartOffer(o);

      UserDynamics uds4 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb4 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds4.DealsTotal, uds.DealsTotal);
      Assert.AreEqual(udb4.DealsTotal, udb.DealsTotal);
    }

    [TestAttribute]
    public void TestDynamicsConflictedDeals()
    {
      Selling o;
      var seller = UsersFacadeHelper.GetRandomUser(null);
      var buyer = UsersFacadeHelper.GetRandomUser(new[] { seller.UserId() });

      UserDynamics uds = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb = UsersFacade.GetDynamicsForUser(buyer.UserId());

      SellingFacadeHelper.ConflictOffer(out o, ref seller, ref buyer);

      UserDynamics uds2 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb2 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds2.DealsSellerConflicted, uds.DealsSellerConflicted + 1);
      Assert.AreEqual(uds2.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb2.DealsBuyerConflicted, udb.DealsBuyerConflicted + 1);
      Assert.AreEqual(udb2.DealsTotal, udb.DealsTotal + 1);
    }

    [TestAttribute]
    public void TestDynamicsFinishedDeals()
    {
      Selling o;
      var seller = UsersFacadeHelper.GetRandomUser(null);
      var buyer = UsersFacadeHelper.GetRandomUser(new[] { seller.UserId() });

      UserDynamics uds = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb = UsersFacade.GetDynamicsForUser(buyer.UserId());

      SellingFacadeHelper.FinishOffer(out o, ref seller, ref buyer);

      UserDynamics uds2 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb2 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds2.DealsSellerFinished, uds.DealsSellerFinished + 1);
      Assert.AreEqual(uds2.DealsTotal, uds.DealsTotal + 1);

      Assert.AreEqual(udb2.DealsBuyerFinished, udb.DealsBuyerFinished + 1);
      Assert.AreEqual(udb2.DealsTotal, udb.DealsTotal + 1);

      SellingFacade.DelFinishOffer(o);

      UserDynamics uds4 = UsersFacade.GetDynamicsForUser(seller.UserId());
      UserDynamics udb4 = UsersFacade.GetDynamicsForUser(buyer.UserId());

      Assert.AreEqual(uds4.DealsTotal, uds.DealsTotal + 1);
      Assert.AreEqual(udb4.DealsTotal, udb.DealsTotal + 1);
    }
  }
}
