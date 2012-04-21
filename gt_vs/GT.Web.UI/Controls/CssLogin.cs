using System.Web.UI.WebControls;
using System.Web.UI;

namespace GT.Web.UI.Controls
{
    public class CssLogin : Login
    {
        protected override void OnPreRender(System.EventArgs e)
        {
            base.OnPreRender(e);
            WebControl div = new WebControl(System.Web.UI.HtmlTextWriterTag.Div);
            LayoutTemplate.InstantiateIn(div);
            div.CopyBaseAttributes(this);
            div.CssClass = this.CssClass;
            for (int i = 0; i < this.Controls[0].Controls.Count; i++ )
            {
              if (Controls[0].Controls[i] as ITextControl != null)
                {
                  ((ITextControl)div.Controls[i]).Text = ((ITextControl)Controls[0].Controls[i]).Text;
                }
            }

            Controls.Clear();
            Controls.Add(div);
        }

        //protected override void Render(System.Web.UI.HtmlTextWriter writer)
        //{
            
        //}
    }
}
