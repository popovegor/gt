using System;
using GT.BO.Caching.Loading;

namespace GT.BO.Caching.Management
{
    /// <summary>
    /// Интерфейс управления хранилищем кэшированных данных
    /// </summary>
    public interface ICacheManager<DataType> : IDisposable
        where DataType : class
    {
        /// <summary>
        /// 
        /// <remarks>Обязательно нужна блокировка на чтение</remarks>
        /// </summary>
        bool IsEmpty { get; }
        /// <summary>
        /// 
        /// <remarks>Обязательно нужна блокировка на чтение</remarks>
        /// </summary>
        DataType Data { get; }
        /// <summary>
        /// 
        /// </summary>
        /// <remarks>Обязательно нужна блокировка на изменение</remarks>
        /// <param name="p_oData"></param>
        void MergeData(CacheLoadContext<DataType> loadContext);
        /// <summary>
        /// 
        /// </summary>
        void BeginRead();
        /// <summary>
        /// 
        /// </summary>
        void EndRead();
        /// <summary>
        /// 
        /// </summary>
        void BeginWrite();
        /// <summary>
        /// 
        /// </summary>
        void EndWrite();
    }
}
