
namespace GT.Common.Patterns
{
    public class Singleton<T> where T : new()
    {
        protected Singleton()
        { }

        public static T Instance
        {
            get { return Nested.instance; }
        }

        private class Nested
        {
            internal static readonly T instance = new T();

            static Nested()
            {
            }
        }
    }
}
