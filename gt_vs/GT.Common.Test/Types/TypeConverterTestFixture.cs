using System;
using System.Collections.Generic;
using GT.Common.Types;
using NUnit.Framework;

namespace GT.Common.Test.Types
{
    [TestFixture]
    public class TypeConverterTestFixture
    {
        [Test]
        public void TestToBitCollectionOfInt()
        {
            int bitSum = 65600;
            List<int> actualBitCollection = TypeConverter.ToBitCollection(bitSum);
            List<int> expectedBitCollection = new List<int>(new int[] { 64, 65536 });
            Assert.AreEqual(actualBitCollection.Count, expectedBitCollection.Count);
            expectedBitCollection.ForEach(new Action<int>(
                delegate(int expectedBit) { Assert.IsTrue(actualBitCollection.Contains(expectedBit)); }
                ));

        }

        [Test]
        public void TestToBitCollectionOfLong()
        {
            long bitSum = 2147549184;
            List<long> actualBitCollection = TypeConverter.ToBitCollection(bitSum);
            List<long> expectedBitCollection = new List<long>(new long[] { 2147483648, 65536 });
            Assert.AreEqual(actualBitCollection.Count, expectedBitCollection.Count);
            expectedBitCollection.ForEach(new Action<long>(
                delegate(long expectedBit) { Assert.IsTrue(actualBitCollection.Contains(expectedBit)); }
                ));
        }

        [TestCase("", Result="")]
        [TestCase(12, Result="12")]
        [TestCase(null, Result = "")]
        public string TestToString(object value)
        {
            return TypeConverter.ToString(value);
        }

        [TestCase("", "12", Result = "")]
        [TestCase(12, "", Result = "12")]
        [TestCase(null, "12", Result = "12")]
        public string TestToString(object value, string defaultValue)
        {
            return TypeConverter.ToString(value, defaultValue);
        }
    }
}