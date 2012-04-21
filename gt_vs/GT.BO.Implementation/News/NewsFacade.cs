using System;
using GT.DA.News;
using System.Data;
using System.Linq;

namespace GT.BO.Implementation.News
{
    public static class NewsFacade
    {
        const int MAX_NEWS_LENGTH = 400;

        public static News Add(News n)
        {
            return new News().Load<News>(NewsDataAdapter.Add(n));
        }

        public static News[] GetAll()
        {
            return Array.ConvertAll<DataRow, News>(NewsDataAdapter.GetAll()
                             , delegate(DataRow dr) { return new News().Load<News>(dr); });
        }

        public static News[] GetAllNotEmpty()
        {
            return GetAll().Where(p => !String.IsNullOrEmpty(p.LocalizedBody)).ToArray();
        }

        public static News GetById(int id)
        {
            return new News().Load<News>(NewsDataAdapter.GetById(id));
        }

        public static string CutNews(News n)
        {
            return n.LocalizedBody.Length <= MAX_NEWS_LENGTH ? n.LocalizedBody :
                    n.LocalizedBody.Substring(0, n.LocalizedBody.LastIndexOf(' ', MAX_NEWS_LENGTH + 1, MAX_NEWS_LENGTH)) + "...";
        }
    }
}
