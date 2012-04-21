using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Drawing;
using System.ComponentModel;
using System.IO;

namespace GT.Common.Drawing
{
  public static class Extensions
  {
    public static byte[] ToBytes(this Bitmap bm)
    {
      byte[] bytes = (byte[])TypeDescriptor.GetConverter(bm).ConvertTo(bm, typeof(byte[]));
      return bytes;
    }
    
    public static Bitmap ToBitmap(this byte[] data)
    {
      Bitmap bm = null;
      using (MemoryStream ms = new MemoryStream())
      {
        ms.Write(data, 0, data.Length);
        bm = (Bitmap.FromStream(ms) as Bitmap);
      }
      return bm;
    }
  }
}
