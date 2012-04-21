using System;

namespace GT.Common.Types
{
    public static class EnumHelper
    {
        public static bool HasFlags<T>(T enumerate, params T[] flags)
            where T: struct
        {
            int e = TypeConverter.ToInt32(enumerate);
            return Array.TrueForAll(
                Array.ConvertAll(flags, flag => TypeConverter.ToInt32(flag)) //int[]
                , new Predicate<int>(flag => flag == (e & flag)));
            
        }

        /*public static T SetFlag<T>(T enumerate, T flag)
        {
            return (T)TypeConverter.TryConvert(TypeConverter.ToInt32(enumerate) | TypeConverter.ToInt32(flag), 
                typeof(T));
        }*/
    }
}
