
namespace GT.BO.Caching.Functionality
{
    /// <summary>
    /// ��������� ���� ������ ��� ������
    /// </summary>
    public interface IReadOnlyCache<DataType> : IGenericCache<DataType>
        where DataType : class
    {

    }
}
