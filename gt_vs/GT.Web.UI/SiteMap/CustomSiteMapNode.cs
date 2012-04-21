using System.Collections;
using System.Collections.Specialized;
using System.Web;
using GT.Common.Types;
using System.Threading;
using GT.Global.Localization;

namespace GT.Web.UI.SiteMap
{
  public class CustomSiteMapNode : SiteMapNode
  {
    private string m_stemplateName;
    private string m_sjavascript;
    private int m_iPageID;

    private string m_TitleRU;
    private string m_DescriptionRU;

    private string _keyWords;
    private string _keyWordsRu;

    private string m_PageTitle;
    private string m_PageTitleRu;

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key) :
      base(provider, key)
    {
    }

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key, string url) :
      base(provider, key, url)
    {
    }

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key, string url, string title) :
      base(provider, key, url, title)
    {
    }

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key, string url, string title, string titleRU, string description, string descriptionRU) :
      base(provider, key, url, title, description)
    {
      m_TitleRU = titleRU;
      m_DescriptionRU = descriptionRU;
    }

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key, string url, string title, string titleRU, string description, string descriptionRU,
                          IList roles, NameValueCollection attributes, NameValueCollection explicitResourceKeys,
                          string implicitResourceKey) :
      base(
                              provider, key, url, title, description, roles, attributes, explicitResourceKeys,
                              implicitResourceKey)
    {
      m_TitleRU = titleRU;
      m_DescriptionRU = descriptionRU;
    }

    public CustomSiteMapNode(CustomSiteMapProvider provider, string key, string url, string title, string titleRU, string description, string descriptionRU, IList roles, string templateName, string javascript, int pageID, string keyWords, string keyWordsRu, string pageTitle, string pageTitleRu) :
      base(provider, key, url, title, description, roles, null, null,
                               null)
    {
      m_stemplateName = templateName;
      m_sjavascript = javascript;
      m_iPageID = pageID;
      m_DescriptionRU = descriptionRU;
      m_TitleRU = titleRU;
      _keyWords = keyWords;
      _keyWordsRu = keyWordsRu;
      m_PageTitle = pageTitle;
      m_PageTitleRu = pageTitleRu;
    }

    public bool IsEmpty
    {
      get
      {
        return string.IsNullOrEmpty(Title) &&
               string.IsNullOrEmpty(Description);
      }
    }

    public string TemplateName
    {
      get { return m_stemplateName; }
      set { m_stemplateName = value; }
    }

    public string JavaScript
    {
      get { return m_sjavascript; }
      set { m_sjavascript = value; }
    }

    public int PageID
    {
      get { return m_iPageID == 0 ? TypeConverter.ToInt32(Key) : m_iPageID; }
      set { m_iPageID = value; }
    }

    public override string Title
    {
      get
      {
        switch (Thread.CurrentThread.CurrentCulture.TwoLetterISOLanguageName)
        {
          case "ru":
            return m_TitleRU;

          default:
            return base.Title;
        }
      }
    }

    public override string Description
    {
      get
      {
        switch (Thread.CurrentThread.CurrentCulture.TwoLetterISOLanguageName)
        {
          case "ru":
            return m_DescriptionRU;

          default:
            return base.Description;
        }
      }
    }
    
    public string KeyWords
    {
      get
      {
        return Localizator.GetLocalizedProperty(_keyWords, _keyWordsRu, _keyWords);
      }
    }

    public string PageTitle
    {
        get
        {
            return Localizator.GetLocalizedProperty(m_PageTitle, m_PageTitleRu, m_PageTitle);
        }
    }
  }
}