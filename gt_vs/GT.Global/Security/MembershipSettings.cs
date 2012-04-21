using System;

namespace GT.Global.Security
{
  public static class MembershipSettings
  {
    public static Guid SystemUserKey
    {
      get
      {
        return new Guid("ffffffff-ffff-ffff-ffff-ffffffffffff");
      }
    }

    public static string SystemUserName
    {
      get
      {
        return "noreplay";
      }
    }
    
    public const string SessionSingUpSecurityKey = "SignUpSecurityKey";
  }
}
