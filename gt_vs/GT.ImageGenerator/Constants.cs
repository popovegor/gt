using System;

namespace GT.ImageGenerator
{
    public class Constants
    {
    }

    [Flags]
    public enum CornerType
    {
        TopLeft = 1,
        BottomLeft = 2,
        TopRight = 4,
        BottomRight = 8
    }

    public enum MoveType
    {
        HorisontalRight,
        HorisontalLeft,
        VerticalUp,
        VerticalDown
    }
}