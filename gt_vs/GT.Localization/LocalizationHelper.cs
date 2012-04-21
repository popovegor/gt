using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.Localization.Resources;

namespace GT.Localization
{
  public static class LocalizationHelper
  {

    public static string GetMessagesName(int number)
    {
      var index = GetNameIndexForNumber(number);
      switch (index)
      {
        case 1:
        default:
          return CommonResources.MessagesName1;
        case 2:
          return CommonResources.MessagesName2;
        case 3:
          return CommonResources.MessagesName3;
      }
    }

    public static string GetOffersName(int number)
    {
      var index = GetNameIndexForNumber(number);
      switch (index)
      {
        case 1:
        default:
          return CommonResources.OffersName1;
        case 2:
          return CommonResources.OffersName2;
        case 3:
          return CommonResources.OffersName3;
      }
    }

    public static int GetNameIndexForNumber(int number)
    {
      var numberName = number.ToString();
      var lastSymbol = numberName[numberName.Length - 1];
      if (lastSymbol == '0'
        || lastSymbol == '5'
        || lastSymbol == '6'
        || lastSymbol == '7'
        || lastSymbol == '8'
        || lastSymbol == '9'
        || (number >= 11 && number <= 14))
      {
        return 1;
      }
      if (lastSymbol == '1')
      {
        return 2;
      }
      if (lastSymbol == '2' || lastSymbol == '3' || lastSymbol == '4')
      {
        return 3;
      }
      return 1;
    }
  }
}
