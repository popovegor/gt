using System;
using GT.BO.Entities;
using System.Data.Common;
using System.Data;
using GT.Common.Data;

namespace GT.DA.News
{
    public static class NewsDataAdapter
    {
        private const string AddProcName = "p_News_Add";
        private const string GetAllProcName = "p_News_GetAll";
        private const string GetByIdProcName = "p_News_GetById";

        public static DataRow Add(BaseEntity news)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(AddProcName))
            {
                DB.Gt.AddInParameter(cmd, "@News", DbType.Xml, news.ToXmlString());
                return DB.Gt.ExecuteDataRow(cmd);
            }
        }

        public static DataRow[] GetAll()
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetAllProcName))
            {
                return  DB.Gt.ExecuteDataSet(cmd).Tables[0].Select();
            }
        }

        public static DataRow GetById(int id)
        {
            using (DbCommand cmd = DB.Gt.GetStoredProcCommand(GetByIdProcName))
            {
                DB.Gt.AddInParameter(cmd, "@NewsId", DbType.Int32, id);
                return DB.Gt.ExecuteDataRow(cmd);
            }
        }
    }
}
