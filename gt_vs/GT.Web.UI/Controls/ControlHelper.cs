using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using GT.BO.Entities;

namespace GT.Web.UI.Controls
{
  public static class ControlHelper
  {
    public static string GenerateHtml(this Control ctl)
    {
      //ctl.TemplateControl.LoadTemplate();
      StringBuilder sb = new StringBuilder();
      using (StringWriter sw = new StringWriter(sb))
      {
        using (HtmlTextWriter htw = new HtmlTextWriter(sw))
        {
          ctl.DataBind();
          ctl.RenderControl(htw);
        }
      }
      return sb.ToString();
    }

    public static void PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
      var gv = sender as GridView;
      gv.PageIndex = e.NewPageIndex;
    }

    public static void RowDataBound(object sender, GridViewRowEventArgs e)
    {
      var gv = sender as GridView;
      if (e != null
        && e.Row.DataItem != null
        && e.Row.RowType == DataControlRowType.DataRow)
      {
        var count = (gv.DataSource as BaseEntity[]).Count();
        var pageSize = gv.PageSize;
        /*if (e.Row.RowIndex != pageSize - 1
          && e.Row.DataItemIndex != count - 1)
        {
          e.Row.CssClass += "row separator";
        }*/
        e.Row.Attributes.Add("entity", string.Format("{0}", (e.Row.DataItem as BaseEntity).Id));
      }
    }
  }
}
