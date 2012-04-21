using System.Configuration;
using System.Data;
using GT.Common.Data;
using GT.Common.Types;
using Microsoft.Practices.EnterpriseLibrary.Data;
using NUnit.Framework;

namespace GT.Common.Test.Data
{
    [TestFixture]
    public class DatabaseExtensionsTestFixture
    {
        [Test]
        public void TestExecuteDataRow()
        {
            int count = ConfigurationManager.ConnectionStrings.Count;
            Assert.GreaterOrEqual(count, 2);
            Database db = DatabaseFactory.CreateDatabase(ConfigurationManager.ConnectionStrings[1].Name);
            string query = "select 1";
            using (var cmd = db.GetSqlStringCommand(query))
            {
                DataRow dr = db.ExecuteDataRow(cmd);
                Assert.IsNotNull(dr);
                Assert.AreEqual(1, TypeConverter.ToInt32(dr[0]));
            }
            
        }
    }
}
