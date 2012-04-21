using System;
namespace GT.Global.Offers
{
  [Flags]
  public enum SearchInTypes : short
  {
    Game = 1,
    Server = 2,
    Title = 4,
    Description = 8
  }
}
