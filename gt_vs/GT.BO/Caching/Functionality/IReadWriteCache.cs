
namespace GT.BO.Caching.Functionality
{
    /// <summary>
    /// Интерфейс кэша с возможностью перезаписи
    /// </summary>
    public interface IReadWriteCache<DataType, EntryType> : IReadOnlyCache<DataType>
        where DataType : class
        where EntryType : class
    {
        bool UpdateEntity(EntryType entry);
        bool DeleteEntity(EntryType entry);
        bool UpdateCacheEntry(EntryType entry);
    }
}
