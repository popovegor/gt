using System;

namespace GT.BO.Caching
{
    #region Delegates

    public delegate void ReloadCacheDelegate();
    public delegate void ClearCacheDelegate();
    public delegate void HandleExceptionDelegate(Exception ex);
    public delegate void HandleDataLoadingExceptionDelegate(Exception ex);

    #endregion

    #region Enums

    public enum CacheLoadType
    { 
        Default,
        Entirely,
        Partially
    }

    #endregion

    public static class Constants
    {
    }
}
