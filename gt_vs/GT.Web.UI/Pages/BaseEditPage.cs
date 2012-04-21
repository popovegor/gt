using GT.Common.Types;

namespace GT.Web.UI.Pages
{
  public class BaseEditPage : BasePage
  {
    private const string IdParamName = "id";
    private const string UrlParamName = "url";

    public EditPageAction EditPageMode
    {
      get
      {
        return Id > 0 ? EditPageAction.Edit : EditPageAction.Add;
      }
    }

    public int Id
    {
      get
      {
        if (Request.QueryString[IdParamName] is string)
        {
          return TypeConverter.ToInt32(Request.QueryString[IdParamName], 0);
        }
        return 0;
      }
    }

    public string RedirectUrl
    {
      get
      {
        if (Request.QueryString[UrlParamName] is string)
        {
          return TypeConverter.ToString(Request.QueryString[UrlParamName]);
        }
        return string.Empty;
      }
    }
  }
}
