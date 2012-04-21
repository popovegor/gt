using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Implementation.Test.Users;
using GT.BO.Implementation.Users;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Test.BillingSystem;
using NUnit.Framework;
using GT.DA.Dictionaries;
using GT.Common.Types;
using GT.Global.Offers;
using System.Diagnostics;
using GT.BO.Implementation.Test.Properties;
using GT.Common.Drawing;
using System.Web.Security;
using GT.Web.Security;
using GT.DA.Test.Dictionaries;

namespace GT.BO.Implementation.Test.Offers
{
  static class SellingFacadeHelper
  {

    [Obsolete("Use the AcceptOffer method")]
    public static Selling CreateAcceptedOffer(out int historyAcceptedOfferId, out Guid sellerId, out Guid buyerId)
    {
      historyAcceptedOfferId = 0;
      //get a pair of random users
      KeyValuePair<MembershipUser, MembershipUser> users = UsersFacadeHelper.GetPairRandomUsers();

      sellerId = users.Key.UserId();
      buyerId = users.Value.UserId();

      //create an offer, select the offer by buyer and then accept it by seller
      Selling o = AddOffer(users.Key.UserId(), null);
      BillingSystemFacadeHelper.AddTransferRealSourceToUser(null, users.Value.UserId(), o.Price);
      SellingFacade.SelectOffer(o, users.Value.UserId());
      SellingFacade.AcceptOffer(ref o, users.Value.UserId(), out historyAcceptedOfferId);
      return o;
    }

    public static Selling AddOffer(Guid? userId, int? productCategoryId)
    {
      MembershipUser user = (true == userId.HasValue)
          ? UsersFacade.GetUser(userId.Value)
          : UsersFacadeHelper.GetRandomUser(null);
      Assert.IsNotNull(user);
      Selling o = new Selling();
      o.SellerId = user.UserId();
      o.GameServerId = TypeConverter.ToInt32(Dictionaries.Instance.GameServers.Rows[0][GameServerFields.GameServerId]);
      Random rnd = new Random((int)DateTime.Now.Ticks);
      o.Price = rnd.Next(1, 10);
      Guid g = Guid.NewGuid();
      o.Title = string.Format("Title {0}", g);
      o.Description = string.Format("Description {0}", g);
      o.TransactionPhase = TransactionPhase.Start;
      o.Image = new SellingImage() { Data = Resources.Image1.ToBytes(), ImageName = "Image1" };
      o.ProductCategoryId = productCategoryId.HasValue == true 
        ? productCategoryId.Value 
        : DictionariesHelper.GetRandomDictionaryEntryId(DictionaryTypes.ProductCategory,ProductCategoryFields.ProductCategoryId);
      if(o.ProductCategoryId == 4)
      {
        o.ProductCategoryMisc = "test product category";
      }
      int historyId;
      Selling no = SellingFacade.Add(o, out historyId);
      SellingImage nsi = SellingFacade.GetImageBySellingId(no.SellingId);
      Assert.AreEqual(o.Image.ImageName, nsi.ImageName);
      Assert.AreEqual(o.Image.Data.Length, nsi.Data.Length);
      Assert.AreEqual(no.SellingId, nsi.SellingId);
      Assert.IsNotNull(no);
      Assert.Greater(historyId, 0);
      Assert.GreaterOrEqual(no.SellingId, 1);
      Assert.AreEqual(no.DeliveryTime, 1);
      Assert.AreEqual(o.ProductCategoryId, no.ProductCategoryId);
      Assert.AreEqual(o.ProductCategoryMisc, no.ProductCategoryMisc);
      Trace.WriteLine(no.ToXmlString());
      return no;
    }

    public static void SelectOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer)
    {
      o = AddOffer(seller == null ? null : (Guid?)seller.UserId(), null);
      Assert.IsNotNull(o);

      if (seller == null)
      {
        seller = UsersFacade.GetUser(o.SellerId);
      }

      if (buyer == null)
      {
        buyer = UsersFacadeHelper.GetRandomUser(new[] { o.SellerId });
      }

      int res = SellingFacade.SelectOffer(o, buyer.UserId());
      Assert.AreEqual(res, 1);
      Dictionary<Guid, int> dic = SellingFacade.GetOfferBuyers(o.SellingId);
      Assert.IsTrue(dic.ContainsKey(buyer.UserId()));
      Assert.AreEqual(dic[buyer.UserId()], 1);
    }

    public static void AcceptOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer, out int history)
    {
      SelectOffer(out o, ref seller, ref buyer);
      int res = SellingFacade.AcceptOffer(ref o, buyer.UserId(), out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Accept);
      Trace.WriteLine(o.ToXmlString());
    }

    public static void ConfirmOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer)
    {
      int history;
      AcceptOffer(out o, ref seller, ref buyer, out history);
      int res = SellingFacade.ConfirmOffer(ref o, out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Submit);
      Trace.WriteLine(o.ToXmlString());
    }

    public static void FinishOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer)
    {
      int historyId = 0;
      FinishOffer(out o, ref seller, ref buyer, out historyId);
    }

    public static void FinishOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer, out int historyId)
    {
      ConfirmOffer(out o, ref seller, ref buyer);
      int res = SellingFacade.FinishOffer(ref o, out historyId);
      Assert.AreEqual(res, 1);
      Assert.Greater(historyId, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Finish);
      Trace.WriteLine(o.ToXmlString());
    }

    public static void ConflictOffer(out Selling o, ref MembershipUser seller, ref MembershipUser buyer)
    {
      ConfirmOffer(out o, ref seller, ref buyer);
      int history;
      int res = SellingFacade.ConflictOffer(ref o, seller.UserId(), out history);
      Assert.AreEqual(res, 1);
      Assert.Greater(history, 0);
      Assert.AreEqual(o.TransactionPhase, TransactionPhase.Conflict);
      Trace.WriteLine(o.ToXmlString());
    }

  }
}
