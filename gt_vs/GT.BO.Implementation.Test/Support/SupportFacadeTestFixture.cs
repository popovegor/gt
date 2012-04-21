using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using GT.BO.Implementation.Support;

namespace GT.BO.Implementation.Test.Support
{
  [TestFixture]
  public class SupportFacadeTestFixture
  {
    [Test]
    public void AddFeedback()
    {
      var fb = new SupportFeedback();
      var guid = Guid.NewGuid();
      fb.UserEmail = guid.ToString() + "@email.com";
      fb.UserName = "test user" + guid.ToString();
      fb.Message = "message" + guid.ToString();
      var nfb = SupportFacade.AddFeedback(fb);
      Assert.IsTrue(fb.Compare(nfb));
    }
  }
}
