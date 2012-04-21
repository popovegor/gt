using System;
using NUnit.Framework;
using GT.BO.Implementation.News;
using System.Diagnostics;

namespace GT.BO.Implementation.Test.News
{
    [TestFixture]
    public class NewsFacadeTestFixture
    {
        [TestAttribute]
        public void TestAddNews()
        {
            GT.BO.Implementation.News.News newNews = NewsFacade.Add(CreateNews());
            Assert.GreaterOrEqual(newNews.NewsId, 0);
            Trace.WriteLine(string.Format("The added news ID : {0}", newNews.NewsId));
        }

        public static GT.BO.Implementation.News.News CreateNews()
        {
            Guid uniqueNews = Guid.NewGuid();
            GT.BO.Implementation.News.News n = new GT.BO.Implementation.News.News();
            n.Title = String.Format("test title {0}", uniqueNews);
            n.Body = String.Format("test body {0}", uniqueNews);
            return n;
        }
    }
}
