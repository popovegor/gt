using System.Web.UI.WebControls;

namespace GT.Common.Web.ControlUtils
{
    public class ListControl
    {
        public static void AddEmptyItemToList(DropDownList p_ddl)
        {
            AddEmptyItemToList(p_ddl, string.Empty);
        }

        public static void AddEmptyItemToList(DropDownList p_ddl, string p_sText)
        {
            ListItem li = new ListItem(p_sText, "0");
            p_ddl.Items.Insert(0, li);
        }

        
    }
}