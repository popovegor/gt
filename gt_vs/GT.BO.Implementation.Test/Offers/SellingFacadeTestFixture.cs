using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.BO.Implementation.Test.BillingSystem;
using GT.BO.Implementation.Test.Users;
using GT.BO.Implementation.Users;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Global.Offers;
using NUnit.Framework;
using GT.BO.Implementation.Test.Properties;
using System.IO;
using System.Drawing;
using GT.Common.Drawing;
using System.Web.Security;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.Offers
{
  [TestFixture]
  public class SellingFacadeTestFixture
  {
    [TestAttribute, TestCase(0, 4), TestCase(0, null)]
    public void TestAdd(out int id, int? productCategoryId)
    {
      id = SellingFacadeHelper.AddOffer(null, productCategoryId).SellingId;
    }

    [Test]
    public void TestDeleteMessage()
    {
      var s = SellingFacadeHelper.AddOffer(null, null);
      SellingFacade.DeleteSellingImage(s.SellerId, s.SellingId);
      var si = SellingFacade.GetImageBySellingId(s.SellingId);
      Assert.IsNull(si);
    }

    [TestAttribute, TestCase(4), TestCase(null)]
    public void TestUpdate(int? productCategoryId)
    {
      int id = 0;
      TestAdd(out id, productCategoryId);
      Selling o = SellingFacade.GetOfferById(id);
      Assert.IsNotNull(o);
      o.Price = 200;
      int historyId;
      o.Image = new SellingImage() { ImageName = "Image2", Data = Resources.Image2.ToBytes(), SellingId = o.SellingId };
      Selling uo = SellingFacade.Update(o, out historyId);
      Assert.AreEqual(o.Price, uo.Price);
      SellingImage usi = SellingFacade.GetImageBySellingId(o.SellingId);
      Assert.AreEqual(o.Image.Data, usi.Data);
      Assert.AreEqual(o.Image.ImageName, usi.ImageName);
      Assert.AreEqual(o.Image.SellingId, usi.SellingId);
      Assert.AreEqual(o.ProductCategoryId, uo.ProductCategoryId);
      Assert.AreEqual(o.ProductCategoryMisc, uo.ProductCategoryMisc);
      Assert.Greater(historyId, 0);
      Trace.WriteLine(uo.ToXmlString());
    }

    [TestAttribute]
    public void TestGetOffersForUser()
    {
      foreach (var u in UsersFacade.GetAllUsers())
      {
        foreach (Selling o in SellingFacade.GetOffersForUser(u.UserId()))
        {
          Assert.AreEqual(o.SellerId, u.UserId());
        }
      }
    }

    [TestAttribute]
    public void TestSelectOffer()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.SelectOffer(out o, ref seller, ref buyer);
    }

    [TestAttribute]
    public void TestAbandon()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.SelectOffer(out o, ref seller, ref buyer);
      int res = SellingFacade.AbandonOffer(o, buyer.UserId());
      Assert.AreEqual(res, 1);
      Dictionary<Guid, int> dic = SellingFacade.GetOfferBuyers(o.SellingId);
      Assert.IsTrue(dic.ContainsKey(buyer.UserId()));
      Assert.AreEqual(dic[buyer.UserId()], 3);
      Trace.WriteLine(o.ToXmlString());
    }

    [TestAttribute]
    public void TestReject()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.SelectOffer(out o, ref seller, ref buyer);
      int res = SellingFacade.RejectOffer(o, buyer.UserId());
      Assert.AreEqual(res, 1);
      Dictionary<Guid, int> dic = SellingFacade.GetOfferBuyers(o.SellingId);
      Assert.IsTrue(dic.ContainsKey(buyer.UserId()));
      Assert.AreEqual(dic[buyer.UserId()], 2);
      Trace.WriteLine(o.ToXmlString());
    }

    [TestAttribute]
    public void TestAcceptOffer()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      int history;
      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out history);
    }

    [TestAttribute]
    public void TestSubmitOffer()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);
    }

    [TestAttribute]
    public void TestCancelOfferAccept()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      int history;
      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out history);
      int res = SellingFacade.CancelOfferAccepted(ref o, buyer.UserId(), out history);
      Assert.AreEqual(1, res);
      Assert.Greater(history, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Start);
      Trace.WriteLine(o.ToXmlString());
    }

    [TestAttribute]
    public void TestCancelOfferSubmit()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);
      int history;
      int res = SellingFacade.CancelConfirmedOffer(ref o, out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Start);
      Trace.WriteLine(o.ToXmlString());
    }

    [TestAttribute]
    public void TestFinishOffer()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.FinishOffer(out o, ref seller, ref buyer);
    }

    [TestAttribute]
    public void TestConflictOffer()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.ConflictOffer(out o, ref seller, ref buyer);
    }

    [TestAttribute]
    public void TestDeleteStart()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.SelectOffer(out o, ref seller, ref buyer);
      int history;
      int res = SellingFacade.DelStartOffer(o, out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      o = SellingFacade.GetOfferById(o.SellingId);
      Assert.IsNull(o);
    }

    [TestAttribute]
    public void TestDeleteAccept()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      int history;
      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out history);
      int res = SellingFacade.DelFinishOffer(o, out history);
      Assert.AreEqual(res, -1);
      Assert.AreEqual(history, -1);
      o = SellingFacade.GetOfferById(o.SellingId);
      Assert.IsNotNull(o);
    }

    [TestAttribute]
    public void TestDeleteSubmit()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.ConfirmOffer(out o, ref seller, ref buyer);
      int history;
      int res = SellingFacade.DelFinishOffer(o, out history);
      Assert.AreEqual(res, -1);
      Assert.AreEqual(history, -1);
      o = SellingFacade.GetOfferById(o.SellingId);
      Assert.IsNotNull(o);
    }

    [TestAttribute]
    public void TestDeleteFinish()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      SellingFacadeHelper.FinishOffer(out o, ref seller, ref buyer);
      int history;
      int res = SellingFacade.DelFinishOffer(o, out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      o = SellingFacade.GetOfferById(o.SellingId);
      Assert.IsNull(o);
    }

    //[TestAttribute]
    //public void TestSelectHighPriceOffer()
    //{
    //  Selling o = SellingFacadeHelper.AddOffer(null);
    //  MembershipUser u = null;
    //  Assert.IsNotNull(o);
    //  u = UsersFacadeHelper.GetRandomUser(new[] { o.SellerId });
    //  o.Price = UsersFacade.GetDynamicsForUser(u.UserId()).MoneyAvailable + 1;
    //  SellingFacade.Update(o);

    //  int res = SellingFacade.SelectOffer(o, u.UserId());
    //  Assert.AreEqual(res, -2);
    //}

    /// <summary>
    /// Tests search of offers by various parameters
    /// </summary>
    [TestAttribute]
    public void TestSearchOffers()
    {
      Selling o = SellingFacadeHelper.AddOffer(null, null);
      SellingSearchFilter filter = new SellingSearchFilter();
      //#1 search by game server Id
      filter.GameServerId = o.GameServerId;
      DataSet ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr => new Selling().Load<Selling>(dr).GameServerId.Equals(o.GameServerId)));

      //#2 search by game Id
      int gameId = Dictionaries.Instance.GetGameIdByGameServerId(o.GameServerId);
      filter = new SellingSearchFilter();
      filter.GameId = gameId;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameIdByGameServerId(new Selling().Load<Selling>(dr).GameServerId).Equals(gameId)));

      //#3 search by game name 
      string gameName = Dictionaries.Instance.GetGameNameByGameServerId(o.GameServerId);
      filter = new SellingSearchFilter();
      filter.GameName = gameName;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameNameByGameServerId(new Selling().Load<Selling>(dr).GameServerId).Contains(gameName)));

      //#4 search by game server name
      string gameServerName = Dictionaries.Instance.GetGameServerNameById(o.GameServerId);
      filter = new SellingSearchFilter();
      filter.GameServerName = gameServerName;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameServerNameById(new Selling().Load<Selling>(dr).GameServerId).Contains(gameServerName)));

      //#5 search by title
      string title = o.Title;
      filter = new SellingSearchFilter();
      filter.Title = title;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Selling().Load<Selling>(dr).Title.Contains(title)));

      //#6 search by description
      string description = o.Description;
      filter = new SellingSearchFilter();
      filter.Description = description;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Selling().Load<Selling>(dr).Description.Contains(description)));

      //#7 search by sellerId
      var sellerId = o.SellerId;
      filter = new SellingSearchFilter();
      filter.UserId = sellerId;
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Selling().Load<Selling>(dr).SellerId == sellerId));
          
      //#8 search by productCategoryId
      var category = o.ProductCategoryId;
      filter = new SellingSearchFilter() {ProductCategoryId = o.ProductCategoryId};
      ds = SellingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => { var s = new Selling().Load<Selling>(dr); return s.ProductCategoryId == category || s.ProductCategoryId == 0;}));
    }

    [Test]
    public void TestGetOfferFromHistrory()
    {
      Selling o;
      MembershipUser seller = null, buyer = null;
      int historyId;
      SellingFacadeHelper.AcceptOffer(out o, ref seller, ref buyer, out historyId);
      Selling ho = SellingFacade.GetOfferFromHistory(historyId);
      Debug.WriteLine(o.ToXmlString());
      Debug.WriteLine(ho.ToXmlString());
      Assert.IsTrue(ho.Compare(o));
    }
  }
}
