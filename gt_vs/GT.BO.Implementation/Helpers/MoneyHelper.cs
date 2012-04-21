using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace GT.BO.Implementation.Helpers
{
  public static class MoneyHelper
  {
    public static decimal ToMoney(this decimal money)
    {
      return Decimal.Round(money, 2, MidpointRounding.AwayFromZero);
    }
    
    public static string ToFormattedMoney(this decimal money, string format)
    {
      return string.Format(format, money.ToMoney());
    }
  }
}
