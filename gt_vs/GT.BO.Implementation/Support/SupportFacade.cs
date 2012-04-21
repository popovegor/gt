using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.DA.Support;

namespace GT.BO.Implementation.Support
{
  public static class SupportFacade
  {
    public static SupportFeedback AddFeedback(SupportFeedback fb)
    {
      return new SupportFeedback().Load<SupportFeedback>(
        SupportDataAdapter.AddFeedback(fb));
    }
  }
}
