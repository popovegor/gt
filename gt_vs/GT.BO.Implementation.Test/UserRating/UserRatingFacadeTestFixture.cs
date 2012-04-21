using System;
using System.Diagnostics;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Test.Offers;
using GT.BO.Implementation.UserRating;
using GT.BO.Implementation.UserRating.SearchFilters;
using GT.BO.Implementation.Users;
using GT.Global.UserRating;
using NUnit.Framework;
using System.Linq;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.UserRating
{
  [TestFixture]
  public class UserRatingFacadeTestFixture
  {
    public static Feedback AddOnCancelSubmittedOffer()
    {
      int historyId = 0;
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);
      SellingFacade.CancelConfirmedOffer(ref o, out historyId);

      Assert.AreEqual(0
        , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(1
        , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));


      UserDynamics bdForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);
      UserDynamics bdForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      Guid key = Guid.NewGuid();
      Feedback v = FeedbackFactory.CreateBuyerToSeller(
          buyer.UserId(), o.SellerId, FeedbackType.Negative, string.Format("Test {0}", key), historyId);
      Feedback nv = UserRatingFacade.LeaveFeedback(v);
      UserDynamics adForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);
      UserDynamics adForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      Assert.AreEqual(bdForSeller.FeedbacksNegative + 1, adForSeller.FeedbacksNegative);
      Assert.AreEqual(bdForBuyer.FeedbacksForOthers + 1, adForBuyer.FeedbacksForOthers);
      Assert.AreEqual(bdForSeller.FeedbacksAsSeller + 1, adForSeller.FeedbacksAsSeller);
      Assert.IsTrue(v.Compare(nv));

      Assert.AreEqual(0
        , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(0
        , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      return nv;
    }

    /// <summary>
    /// Creates new Vote object with checking
    /// </summary>
    /// <returns></returns>
    public static Feedback AddOnCancelAcceptedOffer()
    {
      int historyId = 0;
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out historyId);
      SellingFacade.CancelOfferAccepted(ref o, o.SellerId, out historyId);

      Assert.AreEqual(1
      , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(0
      , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));


      UserDynamics bdForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      var bdForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);

      Guid key = Guid.NewGuid();
      Feedback v = FeedbackFactory.CreateSellerToBuyer(
          o.SellerId, buyer.UserId(), FeedbackType.Neutral, string.Format("Test {0}", key), historyId);
      Feedback nv = UserRatingFacade.LeaveFeedback(v);
      UserDynamics adForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      UserDynamics adForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);
      Assert.AreEqual(bdForBuyer.FeedbacksNeutral + 1, adForBuyer.FeedbacksNeutral);
      Assert.AreEqual(bdForSeller.FeedbacksForOthers + 1, adForSeller.FeedbacksForOthers);
      Assert.AreEqual(bdForBuyer.FeedbacksAsBuyer + 1, adForBuyer.FeedbacksAsBuyer);

      Assert.AreEqual(0
       , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(0
      , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));
      Assert.IsTrue(v.Compare(nv));
      return nv;
    }


    public static Feedback AddOnFinishOffer()
    {
      int historyId = 0;
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.FinishOffer(out o, ref seller, ref buyer, out historyId);

      Assert.AreEqual(1
        , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(1
       , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      UserDynamics bdForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      UserDynamics bdForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);

      Guid key = Guid.NewGuid();
      Feedback v = FeedbackFactory.CreateSellerToBuyer(
          o.SellerId, buyer.UserId(), FeedbackType.Positive, string.Format("Test {0}", key), historyId);
      Feedback nv = UserRatingFacade.LeaveFeedback(v);
      UserDynamics adForBuyer = UsersFacade.GetDynamicsForUser(buyer.UserId());
      UserDynamics adForSeller = UsersFacade.GetDynamicsForUser(o.SellerId);
      Assert.AreEqual(bdForBuyer.FeedbacksPositive + 1, adForBuyer.FeedbacksPositive);
      Assert.AreEqual(bdForBuyer.FeedbacksAsBuyer + 1, adForBuyer.FeedbacksAsBuyer);
      Assert.AreEqual(bdForSeller.FeedbacksForOthers + 1, adForSeller.FeedbacksForOthers);
      Assert.AreEqual(bdForSeller.FeedbacksAsBuyer, adForSeller.FeedbacksAsBuyer);
      Assert.IsTrue(v.Compare(nv));
      Assert.AreEqual(0
       , UserRatingFacade.GetUnusedForUser(o.SellerId).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      Assert.AreEqual(1
       , UserRatingFacade.GetUnusedForUser(buyer.UserId()).Count(uf => uf.SellingHistoryId.Equals(historyId)));

      return nv;
    }

    [Test]
    public void TestAddOnCancelAcceptedOffer()
    {
      var v = AddOnCancelAcceptedOffer();
    }

    [Test]
    public void TestOnCancelSubmittedOffer()
    {
      var v = AddOnCancelSubmittedOffer();
    }

    [Test]
    public void TestAddOnFinishOffer()
    {
      var v = AddOnFinishOffer();
    }

    [Test]
    public void TestGetById()
    {
      Feedback v = AddOnCancelAcceptedOffer();
      Feedback nv = UserRatingFacade.GetFeedbackById(v.FeedbackId);
      Assert.IsTrue(v.Compare(nv));
    }

    [Test]
    public void TestSearchByFromUserId()
    {
      var v = AddOnCancelAcceptedOffer();
      var f = new FeedbackSearchFilter();
      f.FromUserId = v.FromUserId;
      var feedbacks = UserRatingFacade.SearchFeedbacks(f);
      Assert.IsTrue(Array.Exists(feedbacks, e => e.FromUserId.Equals(v.FromUserId)));
    }

    [Test]
    public void TestSearchByFeedbackTypes()
    {
      var v = AddOnCancelAcceptedOffer();
      var f = new FeedbackSearchFilter();
      f = new FeedbackSearchFilter();
      f.FeedbackTypeCollection.Add(v.FeedbackTypeId);
      f.FeedbackTypeCollection.Add((int)FeedbackType.Positive);
      var feedbacks = UserRatingFacade.SearchFeedbacks(f);
      Assert.IsTrue(Array.Exists(feedbacks, e => f.FeedbackTypeCollection.Contains(e.FeedbackTypeId)));
    }

    [Test]
    public void TestSearchByToSellerId()
    {
      var v = AddOnCancelAcceptedOffer();
      var f = new FeedbackSearchFilter();
      f.ToBuyerId = v.ToUserId;
      var feedbacks = UserRatingFacade.SearchFeedbacks(f);
      Assert.IsTrue(Array.Exists(feedbacks, e => e.ToUserId.Equals(v.ToUserId)));
    }

    [Test]
    public void TestSearchByToBuyerId()
    {
      var v = AddOnCancelSubmittedOffer();
      var f = new FeedbackSearchFilter();
      f.ToSellerId = v.ToUserId;
      var feedbacks = UserRatingFacade.SearchFeedbacks(f);
      Assert.IsTrue(Array.Exists(feedbacks, e => e.ToUserId.Equals(v.ToUserId)));
    }
  }
}
