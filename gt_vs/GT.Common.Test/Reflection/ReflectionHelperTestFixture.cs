using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using GT.Common.Reflection;
using NUnit.Framework;

namespace GT.Common.Test.Reflection
{
    [TestFixture]
    public class ReflectionHelperTestFixture
    {

        #region nested

        [AttributeUsage(AttributeTargets.Property | AttributeTargets.Field, Inherited = true)]
        public class CustomAttribute : Attribute
        { 
        }

        public class TestClass
        { 
            [CustomAttribute()]
            public string Field = string.Empty;

            [CustomAttribute()]
            public int Property { get; set; }

            public int OtherProperty { get; set; }
        }

        #endregion

        [TestAttribute]
        public void TestGetMembersWithCustomAttribute()
        {
            TestClass tc = new TestClass();
            Dictionary<MemberInfo, CustomAttribute> members 
                = ReflectionHelper.GetMembersWithCustomAttribute<CustomAttribute>(tc);
            Assert.AreEqual(members.Count, 2);
            Assert.IsTrue( Array.Exists(members.Keys.ToArray(), m => m.Name.Equals("Property")));
            Assert.IsTrue(Array.Exists(members.Keys.ToArray(), m => m.Name.Equals("Field")));
        }
    }
}
