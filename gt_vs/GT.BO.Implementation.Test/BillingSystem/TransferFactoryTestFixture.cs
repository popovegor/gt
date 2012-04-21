using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using GT.BO.Implementation.Test.Users;
using GT.DA.Test.Dictionaries;
using GT.DA.Dictionaries;
using GT.BO.Implementation.BillingSystem;
using GT.Global.BillingSystem;
using GT.BO.Implementation.Offers;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.BO.Implementation.Test.Offers;
using GT.BO.Implementation.Helpers;
using GT.Web.Security;
using Moq;

namespace GT.BO.Implementation.Test.BillingSystem
{
  [TestFixture]
  public class TransferFactoryTestFixture
  {
    [Test]
    public void TestCreateRealSourceToUser()
    {
        var user = UsersFacadeHelper.GetRandomUser(null);
        var source = DictionariesHelper.GetRandomDictionaryEntryId<RealMoneySourceType>(
          DictionaryTypes.RealMoneySource, RealMoneySourceFields.RealMoneySourceId);
        var amount = new decimal(10);
        var note = "stuff";
        var t = TransferFactory.CreateRealSourceToUser(source, user.UserId(), amount, note);
        Assert.AreEqual(amount, t.Amount);
        Assert.AreEqual(note, t.Note);
        Assert.AreEqual(TransferStatus.Pending, t.Status);
    }

    [Test]
    public void TestCreateUserToRealSource()
    {
      decimal com = new decimal(0.2); // commision in fractions
      decimal ourCom = new decimal(0.3); //our commission in fractions
      var source = new Mock<RealMoneySource>();
      var sourceType = DictionariesHelper.GetRandomDictionaryEntryId<RealMoneySourceType>(
       DictionaryTypes.RealMoneySource, RealMoneySourceFields.RealMoneySourceId);
      source.Setup(s => s.Commission).Returns(com);
      source.Setup(s => s.OurCommission).Returns(ourCom);
      var user = UsersFacadeHelper.GetRandomUser(null);
      var amount = new decimal(100);
      var note = "stuff";
      var t = TransferFactory.CreateUserToRealSource(source.Object, user.UserId(), amount, note);
      Assert.AreEqual(amount, t.Amount);
      Assert.AreEqual(note, t.Note);
      decimal ourCommission = (amount * ourCom).ToMoney();
      Assert.IsTrue(ourCommission.Equals(t.OurCommission));
      decimal remainderAfterUs = amount - ourCommission;
      decimal commission = (remainderAfterUs - remainderAfterUs / (1 + com)).ToMoney();
      Assert.AreEqual(commission, t.Commission);
      Assert.AreEqual(TransferStatus.Pending, t.Status);
    }

    [Test]
    public void TestCreateBuyerToOffer()
    {
      var buyer = UsersFacadeHelper.GetRandomUser(null);
      Selling s = new Selling();
      s.Price = new decimal(100);
      var note = "stuff";
      var t = TransferFactory.CreateBuyerToOffer(buyer.UserId(), s, note);
      Assert.AreEqual(s.Price, t.Amount);
      Assert.AreEqual(note, t.Note);
      Assert.AreEqual(TransferStatus.Completed, t.Status);
    }

    [Test]
    public void TestCreateOfferToSeller()
    {
      var seller = UsersFacadeHelper.GetRandomUser(null);
      Selling s = new Selling();
      s.Price = new decimal(100);
      var note = "stuff";
      var t = TransferFactory.CreateOfferToSeller(s, seller.UserId(), note);
      Assert.AreEqual(s.Price, t.Amount);
      Assert.AreEqual(note, t.Note);
      Assert.AreEqual(TransferStatus.Completed, t.Status);
    }
  }
}
