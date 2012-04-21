using System;
using System.Data;
using System.Linq;
using System.Threading;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.BO.Implementation.Test.Users;
using GT.BO.Implementation.Users;
using GT.DA.Dictionaries;
using GT.DA.Test.Dictionaries;
using GT.Global.Offers;
using NUnit.Framework;
using GT.BO.Implementation.Test.BillingSystem;
using GT.Global.BillingSystem;
using GT.BO.Implementation.BillingSystem;
using GT.Web.Security;

namespace GT.BO.Implementation.Test.Offers
{
  [TestFixture]
  public class BuyingFacadeTestFixture
  {
    /// <summary>
    /// Adds new BuyingOffer object in the database with checking
    /// </summary>
    /// <returns>Returns the added BuyingOffer object</returns>
    private static Buying AddOffer(int? productCategoryId)
    {
      var buyer = UsersFacadeHelper.GetRandomUser(null);
      int serverId = DictionariesHelper.GetRandomDictionaryEntryId(DictionaryTypes.GameServer, GameServerFields.GameServerId);

      Guid key = Guid.NewGuid();

      Buying bo = new Buying();
      bo.BuyerId = buyer.UserId();
      bo.GameServerId = serverId;
      bo.Title = string.Format("Test add: title {0}", key);
      bo.Description = string.Format("Test add: description {0}", key);
      bo.Price = new Random((int)DateTime.Now.Ticks).Next(1, 10);
      bo.ProductCategoryId = productCategoryId.HasValue == true 
        ? productCategoryId.Value 
        : DictionariesHelper.GetRandomDictionaryEntryId(DictionaryTypes.ProductCategory, ProductCategoryFields.ProductCategoryId);
      if (bo.ProductCategoryId == 4)
      {
        bo.ProductCategoryMisc = "test product category";
      }
      int historyId = 0;
      Buying nbo = BuyingFacade.AddOffer(bo, out historyId);

      Assert.IsNotNull(nbo);

      Assert.GreaterOrEqual(historyId, 1);
      Assert.GreaterOrEqual(nbo.BuyingOfferId, 1);
      Assert.AreEqual(bo.BuyerId, nbo.BuyerId);
      Assert.AreEqual(bo.GameServerId, nbo.GameServerId);
      Assert.AreEqual(bo.Title, nbo.Title);
      Assert.AreEqual(bo.Description, nbo.Description);
      Assert.AreEqual(bo.Price, nbo.Price);
      Assert.AreNotEqual(nbo.CreateDate, DateTime.MinValue);
      Assert.AreEqual(bo.ProductCategoryId, nbo.ProductCategoryId);
      Assert.AreEqual(bo.ProductCategoryMisc, nbo.ProductCategoryMisc);
      return nbo;
    }

    [TestAttribute]
    public void TestGetOfferById()
    {
      Buying expected = AddOffer(null);
      Buying actual = BuyingFacade.GetOfferById(expected.BuyingOfferId);

      Assert.AreEqual(expected.ToXmlString(), actual.ToXmlString());
    }

    [TestAttribute, TestCase(null), TestCase(4)]
    public void TestAddOffer(int? productCategoryId)
    {
      AddOffer(productCategoryId);
    }

    [TestAttribute, TestCase(null), TestCase(4)]
    public void TestUpdateOffer(int? productCategoryId)
    {
      Buying bo = AddOffer(productCategoryId);
      Guid key = Guid.NewGuid();
      bo.Description = string.Format("Test update: description {0}", key);
      bo.Title = string.Format("Test update: title {0}", key);
      bo.Price = new decimal(new Random((int)DateTime.Now.Ticks).Next(0, 10));
      int historyId = 0;
      Buying ubo = BuyingFacade.UpdateOffer(bo, out historyId);
      Assert.GreaterOrEqual(historyId, 1);
      Assert.IsNotNull(ubo);
      Assert.AreEqual(bo.BuyingOfferId, ubo.BuyingOfferId);
      Assert.AreEqual(bo.BuyerId, ubo.BuyerId);
      Assert.AreEqual(bo.GameServerId, ubo.GameServerId);
      Assert.AreEqual(bo.Title, ubo.Title);
      Assert.AreEqual(bo.Description, ubo.Description);
      Assert.AreEqual(bo.Price, ubo.Price);
      Assert.AreEqual(bo.ProductCategoryId, ubo.ProductCategoryId);
    }

    [TestAttribute]
    public void DeleteOffer()
    {
      Buying bo = AddOffer(null);
      int historyId;
      BuyingFacade.DeleteOffer(bo.BuyerId, bo.BuyingOfferId, out historyId);
      Assert.GreaterOrEqual(historyId, 1);
      foreach (Buying lbo in BuyingFacade.GetOffersForUser(bo.BuyerId))
      {
        Assert.AreNotEqual(lbo.BuyingOfferId, bo.BuyingOfferId);
      }
    }

    [TestAttribute]
    public void TestGetOffersForUser()
    {
      foreach (var u in UsersFacade.GetAllUsers())
      {
        foreach (Buying o in BuyingFacade.GetOffersForUser(u.UserId()))
        {
          Assert.AreEqual(o.BuyerId, u.UserId());
        }
      }
    }

    [TestAttribute]
    public void TestSuggestSellingOffer()
    {
      Buying bo = AddOffer(null);
      //find a suitable seller
      foreach (var u in UsersFacade.GetAllUsers())
      {
        //the seller is not a buyer
        if (u.UserId() != bo.BuyerId)
        {
          Selling o = SellingFacadeHelper.AddOffer(u.UserId(), null);
          //find a suitable selling offer
          foreach (Selling so in SellingFacade.GetOffersForUser(u.UserId()))
          {
            if (TransactionPhase.Start == so.TransactionPhase)
            {
              int buyingOfferId = bo.BuyingOfferId;
              int sellingOfferId = so.SellingId;
              BuyingFacade.SuggestSellingOffer(buyingOfferId, sellingOfferId);

              //checking of the suggested selling offers
              foreach (Selling sso in BuyingFacade.GetSuggestedSellingOffers(bo.BuyingOfferId))
              {
                if (true == sso.SellingId.Equals(so.SellingId)
                    && true == sso.SellerId.Equals(u.UserId())
                    && false == sso.SellerId.Equals(bo.BuyerId))
                {
                  return;
                  //the test has completed successfully
                }
              }
            }
          }
        }
      }
      //else there is no suitable data
      Assert.Fail();
    }

    /// <summary>
    /// Tests search of offers by various parameters
    /// </summary>
    [TestAttribute]
    public void TestSearchOffers()
    {
      Buying o = AddOffer(null);
      BuyingSearchFilter filter = new BuyingSearchFilter();
      //#1 search by game server Id
      filter.GameServerId = o.GameServerId;
      DataSet ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Buying().Load<Buying>(dr).GameServerId.Equals(o.GameServerId)));

      //#2 search by game Id
      int gameId = Dictionaries.Instance.GetGameIdByGameServerId(o.GameServerId);
      filter = new BuyingSearchFilter();
      filter.GameId = gameId;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameIdByGameServerId(new Buying().Load<Buying>(dr).GameServerId).Equals(gameId)));

      //#3 search by game name 
      string gameName = Dictionaries.Instance.GetGameNameByGameServerId(o.GameServerId);
      filter = new BuyingSearchFilter();
      filter.GameName = gameName;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameNameByGameServerId(new Buying().Load<Buying>(dr).GameServerId).Contains(gameName)));

      //#4 search by game server name
      string gameServerName = Dictionaries.Instance.GetGameServerNameById(o.GameServerId);
      filter = new BuyingSearchFilter();
      filter.GameServerName = gameServerName;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => Dictionaries.Instance.GetGameServerNameById(new Buying().Load<Buying>(dr).GameServerId).Contains(gameServerName)));

      //#5 search by title
      string title = o.Title;
      filter = new BuyingSearchFilter();
      filter.Title = title;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Buying().Load<Buying>(dr).Title.Contains(title)));

      //#6 search by description
      string description = o.Description;
      filter = new BuyingSearchFilter();
      filter.Description = description;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Buying().Load<Buying>(dr).Description.Contains(description)));

      //#7 search by sellerId
      var buyerId = o.BuyerId;
      filter = new BuyingSearchFilter();
      filter.UserId = buyerId;
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => new Buying().Load<Buying>(dr).BuyerId == buyerId));

      //#8 search by productCategoryId
      var category = o.ProductCategoryId;
      filter = new BuyingSearchFilter() { ProductCategoryId = o.ProductCategoryId };
      ds = BuyingFacade.SearchOffers(filter);
      Assert.GreaterOrEqual(ds.Tables[0].Rows.Count, 1);
      Assert.IsTrue(ds.Tables[0].Select().All(dr
          => { var b = new Buying().Load<Buying>(dr); return b.ProductCategoryId == category || b.ProductCategoryId == 0; }));
    }

    static void AddSuggested(out Buying bo, out Selling o)
    {
      bo = AddOffer(null);
      var seller = UsersFacadeHelper.GetRandomUser(new[] {bo.BuyerId});
      o = SellingFacadeHelper.AddOffer(seller.UserId(), null);
      o.GameServerId = bo.GameServerId;
      SellingFacade.Update(o);
      Thread.Sleep(1000);
      int res = BuyingFacade.AddSuggested(bo.BuyingOfferId, o.SellingId);
      Assert.AreEqual(res, 1);
    }

    [TestAttribute]
    public void TestAddSuggested()
    {
      Buying bo;
      Selling o;
      AddSuggested(out bo, out o);
    }

    // 4to s bablom u sdelok?
    [TestAttribute]
    public void TestAcceptSuggested()
    {
      Buying bo;
      Selling o;
      AddSuggested(out bo, out o);
      BillingSystemFacadeHelper.AddTransferRealSourceToUser(null, bo.BuyerId, o.Price);
      int res = BuyingFacade.AcceptSuggested(bo.BuyingOfferId, o.SellingId);
      Assert.AreEqual(res, 1);
    }

    [TestAttribute]
    public void TestCancelSuggested()
    {
      Buying bo;
      Selling o;
      AddSuggested(out bo, out o);
      int res = BuyingFacade.CancelSuggested(bo.BuyingOfferId, o.SellingId);
      Assert.AreEqual(res, 1);
    }
  }
}
