using System;
using System.Collections.Generic;

namespace GT.BO.Caching.Functionality
{
    public interface ICache : IDisposable
    {
        #region Properties

        bool FirstLoadCompleted { get; }
        bool IsCacheExpired { get; }
        bool IsLazyLoad { get; }
        IEnumerable<string> DisplayColumns { get; }

        #endregion

        #region Methods

        void ClearCache();
        void LoadCache();
        void LoadCacheEntirely();
        void ReloadCache();

        #endregion
    }
}
