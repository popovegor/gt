
namespace GT.BO.Caching.Functionality
{
    public interface IArrayCacheItem
    {
        #region Properties

        bool IsLoadCompleted { get; }
        int ItemIndex { get; set;}

        #endregion

        #region Methods

        #endregion
    }
}
