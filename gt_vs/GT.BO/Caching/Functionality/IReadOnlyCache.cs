
namespace GT.BO.Caching.Functionality
{
    /// <summary>
    /// Интерфейс кэша только для чтения
    /// </summary>
    public interface IReadOnlyCache<DataType> : IGenericCache<DataType>
        where DataType : class
    {

    }
}
