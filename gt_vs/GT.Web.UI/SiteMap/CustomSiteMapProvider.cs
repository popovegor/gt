using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration.Provider;
using System.Data;
using System.Text;
using System.Web;
using GT.Common;
using GT.Common.Data;
using GT.Common.Exceptions;
using GT.Common.Types;
using GT.Common.Web.Exceptions;
using GT.Common.Web.WebUtils;
using System.Linq;
using System.Data.Linq;

namespace GT.Web.UI.SiteMap
{
  public class CustomSiteMapProvider : StaticSiteMapProvider
  {
    private enum UriMatch
    {
      None = -1,
      PathAndQuery = 0,
      PathOnly = 1,
      QueryOnly = 2
    }

    private const string EQ_ID_COL = "EqualityIndex";

    private static readonly object s_oLock = new object();
    private static readonly object s_oResolveLock = new object();
    private static readonly Dictionary<string, string> s_dictResolvedNodes = new Dictionary<string, string>();
    private static SiteMapNode s_oRoot;

    public CustomSiteMapProvider()
    {
      GT.DA.SiteMap.SiteMap.Instance.OnAfterReloadCache += SiteMapDBLogic_OnAfterReloadCache;
    }

    private void SiteMapDBLogic_OnAfterReloadCache()
    {
      if (s_oRoot != null)
      {
        lock (s_oLock)
        {
          if (s_oRoot != null)
          {
            Clear();
            s_oRoot = null;
          }
        }
        lock (s_oResolveLock)
          s_dictResolvedNodes.Clear();
      }
    }

    public override SiteMapNode BuildSiteMap()
    {
      if (s_oRoot == null)
        lock (s_oLock)
        {
          if (s_oRoot == null)
            try
            {
              DataSet dsNodes = GT.DA.SiteMap.SiteMap.Instance.Data;

              if (dsNodes != null)
              {
                DataRow[] drRoot =
                    dsNodes.Tables[0].Select(string.Format("{0} = 0", GT.DA.SiteMap.SiteMap.ID_COL));

                if (drRoot != null &&
                    drRoot.Length > 0)
                {
                  s_oRoot = CreateNodeFromRow(drRoot[0]);
                  AddNode(s_oRoot, null);

                  foreach (DataRow row in dsNodes.Tables[0].Rows)
                  {
                    if (TypeConverter.ToInt32(row[GT.DA.SiteMap.SiteMap.ID_COL]) != 0)
                    {
                      CustomSiteMapNode node = CreateNodeFromRow(row);
                      AddNode(node, GetParentNodeFromDataRow(row));
                    }
                  }
                }
                else
                  throw new ProviderException("Cannot find root node in SiteMap.");
              }
            }
            catch (Exception e)
            {
              AssistLogger.Log<ExceptionHolder>(e);
            }
        }
      return s_oRoot;
    }

    private CustomSiteMapNode GetParentNodeFromDataRow(DataRow childRow)
    {
      if (childRow == null)
        throw new ProviderException("DataRow in SiteMap is null.");

      DataRow parentRow = childRow.GetParentRow(GT.DA.SiteMap.SiteMap.PARENT_CHILD_REL);
      if (parentRow == null)
        throw new ProviderException(string.Format("Cannot find parent for SiteMap node with ID {0}",
                                                  childRow[GT.DA.SiteMap.SiteMap.ID_COL]));

      return CreateNodeFromRow(parentRow);
    }

    private CustomSiteMapNode CreateNodeFromRow(DataRow siteMapRow)
    {
      if (siteMapRow == null)
        throw new ProviderException("DataRow in SiteMap is null.");

      int id = TypeConverter.ToInt32(siteMapRow[GT.DA.SiteMap.SiteMap.ID_COL]);
      string title = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.TITLE_COL_DEFAULT]).Trim();
      string url = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.URL_COL]).Trim();
      string description = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.DESCRIPTION_COL_DEFAULT]).Trim();
      string templateName = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.TPL_NAME_COL]).Trim();
      string roles = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.ROLES_COL]).Trim();
      string javascript = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.JS_COL]).Trim();
      string titleRU = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.TITLE_COL_RU]).Trim();
      string descriptionRU = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.DESCRIPTION_COL_RU]).Trim();
      int pageID = TypeConverter.ToInt32(siteMapRow[GT.DA.SiteMap.SiteMap.ID_COL]);
      string keyWords = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.KeyWords]);
      string keyWordsRu = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.KeyWordsRu]);
      string pageTitle = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.PAGE_TITLE]);
      string pageTitleRu = TypeConverter.ToString(siteMapRow[GT.DA.SiteMap.SiteMap.PAGE_TITLE_RU]);
      string[] rolelist = null;
      if (!string.IsNullOrEmpty(roles))
        rolelist = roles.Split(new char[] { ',', ';' }, 512);

      return new CustomSiteMapNode(
          this, id.ToString(), url, title, titleRU, description, descriptionRU, rolelist, templateName, javascript, pageID, keyWords, keyWordsRu, pageTitle, pageTitleRu);
    }


    protected override SiteMapNode GetRootNodeCore()
    {
      if (s_oRoot == null)
      {
        lock (s_oLock)
        {
          if (s_oRoot == null)
            return BuildSiteMap();
        }
      }
      return s_oRoot;
    }
    
    //private int GetIndexOfLastMatchedSymbol(string x, string y)
    //{
    //  x = x.ToUpper();
    //  y = y.ToUpper();
    //  var index = 0;
    //  for (index = 0; index < Math.Min(x.Length, y.Length); index++)
    //  {
    //    if (x[index].Equals(y[index]) == false)
    //    {
    //      break;
    //    }
    //  }
    //  return index;
    //}
    
    public override SiteMapNode FindSiteMapNode(HttpContext context)
    {
      SiteMapNode node = null;
      var uri = context.Request.Url;
      var qs = new ComparableQueryString(context.Request.QueryString);
      try
      {
        var filter = string.Format("{0} LIKE '%{1}%'"
          , GT.DA.SiteMap.SiteMap.URL_COL, uri.GetComponents(
            UriComponents.Path, UriFormat.UriEscaped));
        
        var nodes = GT.DA.SiteMap.SiteMap.Instance.Data.Tables[0].Select(filter
          , string.Format("{0} ASC", GT.DA.SiteMap.SiteMap.ID_COL));
        var index = -1;
        var key = -1;
        for(int i  = 0; i < nodes.Length; i++)
        {
          var nodeUrl = nodes[i][GT.DA.SiteMap.SiteMap.URL_COL].ToString().TrimStart('~','/');
          var questionIndex = nodeUrl.IndexOf('?');
          if(questionIndex > 0 && nodeUrl.Contains("?&") == false)
          {
            nodeUrl = nodeUrl.Insert(questionIndex + 1, "&");
          }
          var nodeQueryString  = HttpUtility.ParseQueryString(nodeUrl);
          var temp = qs.GetEqualityIndex(nodeQueryString);
          if(temp > index)
          {
            index = temp;
            key = (int)nodes[i][GT.DA.SiteMap.SiteMap.ID_COL];
          }
        }
        if(key > -1)
        {
          node = FindSiteMapNodeFromKey(key.ToString());
        }
      }
      catch (Exception e)
      {
        AssistLogger.Log<WebExceptionHolder>(new Exception("Cannot resolve sitemap node.", e));
      }
      
      if(node == null)
      {
        node = base.FindSiteMapNode(context);
      }
      return node;
    }

    //public override SiteMapNode FindSiteMapNode(HttpContext context)
    //{
    //  SiteMapNode node = null;// = base.FindSiteMapNode(context);
    //  //if (node == null)
    //  //{
    //  try
    //  {
    //    Uri requestUri = context.Request.Url;
    //    lock (s_oResolveLock)
    //    {  
    //       if (s_dictResolvedNodes.ContainsKey(requestUri.ToString()))
    //        return FindSiteMapNodeFromKey(s_dictResolvedNodes[requestUri.ToString()])
           
    //    }
    //    StringBuilder sLocalPath = new StringBuilder(requestUri.AbsoluteUri.Length);
    //    for (int i = 0; i < requestUri.Segments.Length - 1; i++)
    //      sLocalPath.Append(requestUri.Segments[i]);
    //    if (sLocalPath[0] == '/')
    //      sLocalPath.Insert(0, '~');

    //    DataTable dt = GT.DA.SiteMap.SiteMap.Instance.Data.Tables[0];
    //    DataRow[] drFolderPages =
    //        dt.Select(string.Format("{0} LIKE '{1}%'", GT.DA.SiteMap.SiteMap.URL_COL, sLocalPath));

    //    if (drFolderPages != null &&
    //        drFolderPages.Length > 0)
    //    {
    //      string sKey = string.Empty;
    //      sLocalPath.Append(requestUri.Segments[requestUri.Segments.Length - 1]);
    //      NameValueCollection queryString = HttpUtility.ParseQueryString(requestUri.Query);

    //      DataSet dsMatches = new DataSet();
    //      DataTable dtMatch = ADOUtils.GetNewTableFromRow(drFolderPages[0]);
    //      for (int i = 0; i <= (int)UriMatch.QueryOnly; i++)
    //      {
    //        dsMatches.Tables.Add(dtMatch.Clone());
    //        dsMatches.Tables[i].TableName = ((UriMatch)i).ToString();
    //        dsMatches.Tables[i].Columns.Add(new DataColumn(EQ_ID_COL, typeof(int)));
    //      }

    //      foreach (DataRow page in drFolderPages)
    //      {
    //        int iEqIndex = 0;
    //        int iMatch = (int)CompareUri(page[GT.DA.SiteMap.SiteMap.URL_COL].ToString(),
    //                                      sLocalPath.ToString(), queryString, ref iEqIndex);
    //        if ((UriMatch)iMatch != UriMatch.None)
    //        {
    //          DataRow drMatch = dsMatches.Tables[iMatch].NewRow();
    //          ADOUtils.DataRowsCopy(page, drMatch);
    //          drMatch[EQ_ID_COL] = iEqIndex;
    //          dsMatches.Tables[iMatch].Rows.Add(drMatch);
    //        }
    //      }

    //      foreach (DataTable table in dsMatches.Tables)
    //      {
    //        if (table.Rows.Count != 0)
    //          sKey = GetMostApplicableKeyFromDT(table);
    //        if (sKey != string.Empty)
    //          break;
    //      }

    //      if (sKey == string.Empty)
    //        sKey = drFolderPages[0][GT.DA.SiteMap.SiteMap.PARENT_COL].ToString();

    //      if (sKey != string.Empty)
    //        node = FindSiteMapNodeFromKey(sKey);

    //      if (node != null)
    //        lock (s_oResolveLock)
    //        {
    //          s_dictResolvedNodes[requestUri.ToString()] = sKey;
    //        }
    //    }
    //  }
    //  catch (Exception e)
    //  {
    //    AssistLogger.Log<WebExceptionHolder>(new Exception("Cannot resolve sitemap node.", e));
    //  }
    //  //}

    //  if (node == null)
    //  {
    //    node = base.FindSiteMapNode(context);
    //  }

    //  return node;
    //}

    private static string GetMostApplicableKeyFromDT(DataTable p_dt)
    {
      if (p_dt.Rows.Count == 1)
        return p_dt.Rows[0][GT.DA.SiteMap.SiteMap.ID_COL].ToString();
      return
          p_dt.Select(string.Empty, string.Format("{0} DESC, {1} ASC", EQ_ID_COL, GT.DA.SiteMap.SiteMap.ID_COL))[0]
              [GT.DA.SiteMap.SiteMap.ID_COL].
              ToString();
    }

    private static UriMatch CompareUri(string p_sUrl, string p_sLocalPath, NameValueCollection p_queryString,
                                       ref int p_iQueryEqualityIndex)
    {
      ComparableQueryString qs = null;
      if (p_sUrl.IndexOf('?') != -1)
        qs = new ComparableQueryString(HttpUtility.ParseQueryString(p_sUrl.Substring(p_sUrl.IndexOf('?'))));

      if (p_sUrl.StartsWith(p_sLocalPath))
      {
        if (qs != null)
        {
          p_iQueryEqualityIndex = qs.GetEqualityIndex(p_queryString);
          if (p_iQueryEqualityIndex > 0)
            return UriMatch.PathAndQuery;
        }
        return UriMatch.PathOnly;
      }
      else if (qs != null)
      {
        p_iQueryEqualityIndex = qs.GetEqualityIndex(p_queryString);
        if (p_iQueryEqualityIndex > 0)
          return UriMatch.QueryOnly;
      }
      return UriMatch.None;
    }
  }
}