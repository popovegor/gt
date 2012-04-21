using System;

namespace GT.Common
{
    [Flags]
    public enum BracketType
    {
        Round = 1,
        Square = 2,
        Brace = 4,
        Angle = 8
    }

    public static class Constants
    {
    }
}