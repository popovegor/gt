using System;
using NUnit.Framework;
using GT.BO.Implementation.BillingSystem;
using System.Diagnostics;
using GT.Global.BillingSystem;
using GT.BO.Implementation.Payments;

namespace GT.BO.Implementation.Test.BillingSystem
{
    [TestFixture]
    public class WebMoneyFacadeTestFixture
    {
        [TestAttribute]
        public void TestAddItem()
        {
            WebMoneyTransfer wm = WebMoneyTransferFacade.Add(CreateWM());
            Assert.GreaterOrEqual(wm.Id, 0);
            Trace.WriteLine(string.Format("The added webmoneyItem ID : {0}", wm.Id));
        }

        public static WebMoneyTransfer CreateWM()
        {
            Transfer t = BillingSystemFacadeHelper.AddTransferFromUserToRealSource((RealMoneySourceType?)RealMoneySourceType.WebMoney, null, null);
            WebMoneyTransfer wm = new WebMoneyTransfer();
            wm.TransferId = t.TransferId;
            wm.WmInvoiceId = new Random((int)DateTime.Now.Ticks).Next(10, 20);
            wm.WmTransferId = new Random((int)DateTime.Now.Ticks).Next(10, 20);
            wm.TargetPurse = WebMoneyManager.Configuration.Purse;
            return wm;
        }
    }
}
