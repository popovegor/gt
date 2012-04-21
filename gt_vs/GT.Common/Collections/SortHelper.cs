using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace GT.Common.Collections
{
  public static class SortHelper
  {
    public class ComparerDesc<T> : IComparer<T>
    where T : IComparable
    {
      public int Compare(T x, T y)
      {
        return y.CompareTo(x);
      }
    }
  }
}
