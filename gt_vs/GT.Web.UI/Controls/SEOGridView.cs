using System;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using GT.Common.Types;
using System.Web.UI;

namespace GT.Web.UI.Controls
{
  public class SEOGridView : GridView
  {
    const string QUERY_PAGE = "page";
    const int DEFAULT_PAGEBUTTONCOUNT = 10;

    public string PagerCss { get; set; }

    void Fake(Control c)
    { }

    protected override void OnLoad(EventArgs e)
    {
      base.OnLoad(e);

      if (Page.Request.QueryString[QUERY_PAGE] != null)
      {
        int page = TypeConverter.ToInt32(Page.Request.QueryString[QUERY_PAGE]);
        PageIndex = page > 0 ? page - 1 : 0;
      }

      if (PagerSettings.PageButtonCount == 0)
      {
        PagerSettings.PageButtonCount = DEFAULT_PAGEBUTTONCOUNT;
      }

      PagerTemplate = new CompiledTemplateBuilder(new BuildTemplateMethod(Fake));

      DataBind();
    }

    protected override void OnRowCreated(GridViewRowEventArgs e)
    {
      if (e.Row.RowType == DataControlRowType.Pager)
      {
        e.Row.ApplyStyle(new Style() { CssClass = PagerCss });
        TableCell tc = e.Row.Cells[0];

        int start = 0;
        int end = 0;

        if (PageIndex > PageCount)
        {
          PageIndex = 0;
        }

        if (PagerSettings.PageButtonCount >= PageCount)
        {
          start = 1;
          end = PageCount;
        }
        else
        {
          start = PageIndex + 1 <= PagerSettings.PageButtonCount / 2 ? 1 :
                  PageIndex + 1 >= PageCount - PagerSettings.PageButtonCount / 2 ?
                          PageCount - PagerSettings.PageButtonCount > 1 ? PageCount - PagerSettings.PageButtonCount : 1
                                                                                 :
                          PageIndex - PagerSettings.PageButtonCount / 2 + 1;

          end = PageCount < PagerSettings.PageButtonCount || PageCount < start + PagerSettings.PageButtonCount - 1 ? PageCount : start + PagerSettings.PageButtonCount - 1;
        }

        for (int i = start; i <= end; i++)
        {
          WebControl wc = null;

          if (i == PageIndex + 1)
          {
            wc = new Label();
            ((Label)wc).Text = i.ToString();
          }
          else
          {
            wc = new HyperLink();
            ((HyperLink)wc).Text = i.ToString();
            ((HyperLink)wc).NavigateUrl 
              = null != Page.Request.QueryString[QUERY_PAGE] 
              ? Regex.Replace(Page.Request.RawUrl
                , QUERY_PAGE + "=" + Page.Request.QueryString[QUERY_PAGE]
                , QUERY_PAGE + "=" + i.ToString())
              : Page.Request.RawUrl + (Page.Request.QueryString.Count > 0 
                ? "&" + QUERY_PAGE + "=" 
                : "?" + QUERY_PAGE + "=") + i.ToString();
          }

          wc.Attributes.Add("style", m_PagerStyle);
          tc.Controls.Add(wc);
        }
      }
      else
      {
        base.OnRowCreated(e);
      }
    }

    string m_PagerStyle;
    public string PagerStyle
    {
      get
      {
        return m_PagerStyle;
      }
      set
      {
        m_PagerStyle = value;
      }
    }
  }
}
