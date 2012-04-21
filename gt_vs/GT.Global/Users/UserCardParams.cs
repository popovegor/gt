using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.Global.Users
{
  public static class UserCardParams
  {
    public const string UserId = "uid";
    public const string DataType = "dt";

    public enum Data
    {
      Info = 0,
      Conversation = 1
    }
  }
}
