using System;
using System.Collections;
using System.Data;
using System.Text.RegularExpressions;

namespace GT.Common.Data
{
    public class ADOUtils
    {
        public static void CopyColumnsValuesInRow(DataRow p_dr, string[] p_fromColumns, string[] p_toColumns)
        {
            if (p_fromColumns.Length != p_toColumns.Length)
                throw new ArgumentException("p_fromColumns.Length is not equal to p_toColumns.Lenght");

            for (int i = 0; i < p_fromColumns.Length; i++)
                p_dr[p_toColumns[i]] = p_dr[p_fromColumns[i]];
        }

        public static bool DataRowsCmp(DataRow p_dr1, DataRow p_dr2, string[] p_sColumns)
        {
            for (int i = 0; i < p_sColumns.Length; i++)
                if (!p_dr1[p_sColumns[i]].Equals(p_dr2[p_sColumns[i]]))
                    return false;
            return true;
        }

        public static void DataRowsCopy(DataRow p_drFrom, DataRow p_drTo, string[] p_fromColumns, string[] p_toColumns)
        {
            if (p_toColumns.Length != p_fromColumns.Length)
                throw new ArgumentException("p_fromColumns.Length is not equal to p_toColumns.Lenght");
            for (int i = 0; i < p_toColumns.Length; i++)
                p_drTo[p_toColumns[i]] = p_drFrom[p_fromColumns[i]];
        }

        public static void DataRowsCopy(DataRow p_drFrom, DataRow p_drTo, string[] p_columns)
        {
            for (int i = 0; i < p_columns.Length; i++)
                p_drTo[p_columns[i]] = p_drFrom[p_columns[i]];
        }

        public static void DataRowsCopy(DataRow p_drFrom, DataRow p_drTo)
        {
            for (int i = 0; i < p_drFrom.Table.Columns.Count; i++)
                p_drTo[p_drFrom.Table.Columns[i].ColumnName] = p_drFrom[p_drFrom.Table.Columns[i].ColumnName];
        }

        public static DataTable GetNewTableFromRow(DataRow p_dr)
        {
            DataTable dt = p_dr.Table.Clone();
            DataRow dr = dt.NewRow();
            DataRowsCopy(p_dr, dr);
            dt.Rows.Add(dr);
            return dt;
        }

        public static string[] GetRowsValues(DataRow p_dr, string[] p_columns)
        {
            string[] values = new string[p_columns.Length];
            for (int i = 0; i < p_columns.Length; i++)
                values[i] = p_dr[p_columns[i]].ToString();
            return values;
        }

        public static string[] GetRowsValuesForColumn(DataTable p_dt, string p_sColumn)
        {
            string[] values = new string[p_dt.Rows.Count];

            for (int i = 0; i < p_dt.Rows.Count; i++)
                values[i] = Convert.ToString(p_dt.Rows[i][p_sColumn]);

            return values;
        }

        public static DataSet ConcatDataTables(DataTable p_dt, DataTable p_dt2)
        {
            DataSet ds = new DataSet();
            ds.Tables.Add(p_dt.Copy());

            foreach (DataRow dr in p_dt2.Rows)
            {
                ds.Tables[0].Rows.Add(dr.ItemArray);
            }
            ds.AcceptChanges();

            return ds;
        }

        public static void ReplaceTableInDataSet(DataTable p_dtRemove, DataTable p_dtAdd, bool p_bLeaveName)
        {
            if (p_bLeaveName)
                p_dtAdd.TableName = p_dtRemove.TableName;

            p_dtAdd.DataSet.Tables.Remove(p_dtAdd);
            DataSet ds = p_dtRemove.DataSet;
            if (ds != null)
            {
                int iIndex = ds.Tables.IndexOf(p_dtRemove);

                ArrayList alTables = new ArrayList();
                for (int i = iIndex + 1; i < ds.Tables.Count; i++)
                {
                    alTables.Add(ds.Tables[i]);
                    ds.Tables.Remove(ds.Tables[i]);
                }
                ds.Tables.Remove(p_dtRemove);
                ds.Tables.Add(p_dtAdd);
                for (int i = 0; i < alTables.Count; i++)
                {
                    ds.Tables.Add((DataTable) alTables[i]);
                }
            }
        }

        public static string GetDBEscapedString(string p_strInput)
        {
            Regex RegexObj = new Regex("\\[|\\]");
            p_strInput = RegexObj.Replace(p_strInput, new MatchEvaluator(ReplaceSqBrackets));
            return p_strInput.Replace("%", "[%]").Replace("*", "[*]").Replace("'", "''");
        }

        private static string ReplaceSqBrackets(Match p_match)
        {
            if (p_match.Value == "]")
                return "[]]";
            else
                return "[[]";
        }
    }
}