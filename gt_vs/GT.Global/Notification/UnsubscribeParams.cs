using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.Global.Notification
{
  public static class UnsubscribeParams
  { 
    public const string UserId = "uid";
    public const string NotificationType = "nt";
    
    public enum Notification
    {
      None = 0,
      Email = 1,
      Icq = 2
    }
  }
}
