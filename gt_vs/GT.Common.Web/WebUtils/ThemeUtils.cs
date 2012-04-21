
namespace GT.Common.Web.WebUtils
{

    public enum eThemes
    {
        Default
    }

    public static class ThemeUtils
    {

        public static eThemes CurrentTheme
        {
            get
            {
                return eThemes.Default;
            }
        }
    }
}
