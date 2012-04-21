using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;
using GT.Common.Test.Properties;
using GT.Common.Drawing;
using System.Drawing;
using System.IO;

namespace GT.Common.Test.Drawing
{
  [TestFixture]
  class ExtensionsTestFixture
  {
    [Test]
    public void TestBitmapToBytes()
    {
      var data = Resources.Image1.ToBytes();
      Assert.IsNotNull(data);
    }
    
    [Test]
    public void TestBytesToBitmap()
    {
      var data = Resources.Image1.ToBytes();
      var bm = data.ToBitmap();
      Assert.AreEqual(Resources.Image1.Size, bm.Size); 
    }
  }
}
