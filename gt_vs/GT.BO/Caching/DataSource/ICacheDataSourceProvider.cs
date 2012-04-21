using System;
using GT.BO.Caching.Loading;

namespace GT.BO.Caching.DataSource
{
    /// <summary>
    /// ��������� ��������� ������ ��� ����
    /// </summary>
    public interface ICacheDataSourceProvider : IDisposable
    {
        bool LoadData<DataType>(CacheLoadContext<DataType> loadContext)
            where DataType : class;
        bool HasNewData { get; }
        void HandleDataLoadingException(Exception p_ex);
    }
}
