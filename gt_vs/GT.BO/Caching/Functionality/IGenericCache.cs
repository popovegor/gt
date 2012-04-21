
namespace GT.BO.Caching.Functionality
{
    public interface IGenericCache<DataType> : ICache
        where DataType : class
    {
        #region Properties

        DataType Data { get; }
       
        #endregion
    }
}
