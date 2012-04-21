using System;
using GT.BO.Caching.Functionality;
using GT.BO.Caching.Loading;

namespace GT.BO.Caching.Management
{
    public class ArrayCacheManager<ArrayItemType> : CacheManager<ArrayItemType[]>
      where ArrayItemType : class, IArrayCacheItem
    {
        public override void MergeData(CacheLoadContext<ArrayItemType[]> loadContext)
        {
            int? maxIndex = GetMaxIndex(loadContext.Data);
            if (maxIndex.HasValue)
            {
                if (IsEmpty)
                {
                    Initialize(maxIndex.Value + 1);
                }
                else
                {
                    ResizeIfNeeded(maxIndex.Value + 1);
                }
            }
            foreach (ArrayItemType item in loadContext.Data)
            {
                if (item != null)
                {
                    PremergeArrayItem(item);
                    MergeArrayItem(item);
                }
            }
        }

        protected virtual void MergeArrayItem(ArrayItemType item)
        {
            _Data.SetValue(item, item.ItemIndex);
        }

        protected virtual void PremergeArrayItem(ArrayItemType item)
        { }

        protected void Initialize(int length)
        {
            _Data = new ArrayItemType[length];
        }

        protected virtual int? GetMaxIndex(ArrayItemType[] p_Data)
        {
            if (p_Data.Length > 0)
            {
                int maxIndex = 0;
                for (int i = 0; i < p_Data.Length; i++)
                {
                    int itemIndex = (p_Data.GetValue(i) as ArrayItemType).ItemIndex;
                    if (maxIndex < itemIndex)
                    {
                        maxIndex = itemIndex;
                    }
                }
                return maxIndex;
            }
            return null;
        }

        protected void ResizeIfNeeded(int contingentLength)
        {
            if (_Data.Length < contingentLength)
            {
                Array.Resize<ArrayItemType>(ref _Data, contingentLength);
            }
        }

        private bool IsIndexOutside(int itemIndex)
        {
            return IsEmpty || Data.Length < itemIndex || itemIndex < 0;
        }

        public ArrayItemType this[int itemIndex]
        {
            get
            {
                if (IsIndexOutside(itemIndex))
                {
                    return null;
                }
                else
                {
                    return (Data.GetValue(itemIndex) as ArrayItemType);
                }
            }
            set
            {
                if (IsIndexOutside(itemIndex))
                {
                    //There is no data in the cache, throw an exception
                }
                else
                {
                    Data.SetValue(value, itemIndex);
                }
            }
        }

        //no need to lock
        public override void BeginRead()
        { }
        public override void EndRead()
        { }
        public override void BeginWrite()
        { }
        public override void EndWrite()
        { }
    }
}
