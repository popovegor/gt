using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.Global
{
  public static class HelpParams
  { 
    public const string SectionType = "s";
    
    public enum Section
    {
      General = 0,
      HowBuy,
      HowSell,
      Billing,
      Rules
    }
  }
}
