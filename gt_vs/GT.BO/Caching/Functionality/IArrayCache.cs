
namespace GT.BO.Caching.Functionality
{
    public interface IArrayCache<ArrayItemType> : IGenericCache<ArrayItemType[]>
        where ArrayItemType : class, IArrayCacheItem
    {
        #region Properties

        ArrayItemType this[int index]
        { get; set;}

        #endregion
    }
}
