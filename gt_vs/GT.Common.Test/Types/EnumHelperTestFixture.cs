using System;
using GT.Common.Types;
using NUnit.Framework;

namespace GT.Common.Test.Types
{
    [TestFixture]
    public class EnumHelperTestFixture
    {
        [FlagsAttribute]
        public enum testEnum : short
        {
            None = 0
            , One = 1
            , Second = 2
            , Four = 4
            , Eight = 8
        }

        [TestCase(testEnum.Four | testEnum.One, testEnum.One, Result=true)]
        [TestCase(testEnum.Four, testEnum.One, Result = false)]
        [TestCase((testEnum)1, testEnum.None, Result = true)]
        [TestCase((testEnum)2,testEnum.One, Result = false)]
        [TestCase((testEnum)2, testEnum.Second, Result = true)]
        [TestCase((testEnum)2, testEnum.None, Result = true)]
        public bool TestHasFlag(testEnum e, testEnum f)
        {
            return EnumHelper.HasFlags<testEnum>(e, f);
        }
    }
}
