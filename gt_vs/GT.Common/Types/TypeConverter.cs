using System;
using System.Collections.Generic;
using System.Text;
using GT.Common.Text;

namespace GT.Common.Types
{
  /// <summary>
  /// Summary description for TypeConverter.
  /// </summary>
  public class TypeConverter
  {
    private const int BitCollectionInt32Lenght = sizeof(int) * 8 - 1;
    private const int BitCollectionInt64Lenght = sizeof(long) * 8 - 1;
    private static readonly int[] _bitCollectionOfInt32 = new int[BitCollectionInt32Lenght];
    private static readonly long[] _bitCollectionOfLong64 = new long[BitCollectionInt64Lenght];

    public static bool LogExceptions = false;

    static TypeConverter()
    {
      _bitCollectionOfInt32[0] = 1;
      _bitCollectionOfLong64[0] = 1;
      for (int i = 1; i < BitCollectionInt64Lenght; i++)
      {
        if (i < BitCollectionInt32Lenght)
        {
          _bitCollectionOfInt32[i] = _bitCollectionOfInt32[i - 1] << 1;
        }
        _bitCollectionOfLong64[i] = _bitCollectionOfLong64[i - 1] << 1;
      }
    }

    public static List<int> ToBitCollection(int bitSum)
    {
      List<int> bitCollection = new List<int>();
      for (int i = 0; i < _bitCollectionOfInt32.Length; i++)
      {
        if ((bitSum | _bitCollectionOfInt32[i]) == bitSum)
        {
          bitCollection.Add(_bitCollectionOfInt32[i]);
        }
      }
      return bitCollection;
    }

    public static List<long> ToBitCollection(long bitSum)
    {
      List<long> bitCollection = new List<long>();
      for (int i = 0; i < _bitCollectionOfLong64.Length; i++)
      {
        if ((bitSum | _bitCollectionOfLong64[i]) == bitSum)
        {
          bitCollection.Add(_bitCollectionOfLong64[i]);
        }
      }
      return bitCollection;
    }
    
    public static bool ToBool(object p_value, bool defaultValue)
    {
      bool bValue = defaultValue;
      if (!IsNull(p_value))
      {
        try
        {
          bValue = Convert.ToBoolean(p_value);
        }
        catch
        {
          try
          {
            if (p_value is int)
              return Int32ToBool((int)p_value);
            else if (p_value is string)
              return StringToBool((string)p_value);
            else
              throw;
          }
          catch (Exception e)
          {
            HandleException(e);
          }
        }
      }
      return bValue;
    }

    public static bool ToBool(object p_value)
    {
      return ToBool(p_value, false);
    }

    private static bool Int32ToBool(int p_iValue)
    {
      return p_iValue > 0;
    }

    private static bool StringToBool(string p_sValue)
    {
      return !IsNullOrEmpty(p_sValue) && (p_sValue.ToUpper() == "ON" || p_sValue.ToUpper() == "TRUE" ||
                (StringUtils.IsDigitString(p_sValue) && ToInt32(p_sValue) > 0));

    }

    public static int ToInt32(object p_value)
    {
      return ToInt32(p_value, 0);
    }

    public static int ToInt32(object p_value, int p_iDefaultValue)
    {
      int iValue = p_iDefaultValue;
      if (!IsNull(p_value))
      {
        try
        {
          if (p_value is double ||
              p_value is float)
          {
            double dValue = Convert.ToDouble(p_value);
            iValue = Convert.ToInt32(dValue);
            return iValue;
          }

          iValue = Convert.ToInt32(p_value);
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }
      return iValue;
    }

    public static long ToInt64(object p_value)
    {
      return ToInt64(p_value, 0);
    }

    public static long ToInt64(object p_value, long p_lDefaultValue)
    {
      long iValue = p_lDefaultValue;
      if (!IsNull(p_value))
      {
        try
        {
          if (p_value is double ||
              p_value is float)
          {
            double dValue = Convert.ToDouble(p_value);
            iValue = Convert.ToInt64(dValue);
            return iValue;
          }

          iValue = Convert.ToInt64(p_value);
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }
      return iValue;
    }

    public static double ToDouble(object p_value)
    {
      return ToDouble(p_value, 0.0);
    }

    public static double ToDouble(object p_value, double p_dDefaultValue)
    {
      double dValue = p_dDefaultValue;
      if (!IsNull(p_value))
      {
        try
        {
          dValue = Convert.ToDouble(p_value);
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }
      return dValue;
    }

    public static decimal ToDecimal(object p_value)
    {
      return ToDecimal(p_value, 0);
    }

    public static decimal ToDecimal(object p_value, decimal p_dDefaultValue)
    {
      decimal dValue = p_dDefaultValue;
      if (!IsNull(p_value))
      {
        try
        {
          dValue = Convert.ToDecimal(p_value);
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }
      return dValue;
    }

    public static string ToString(object value, string defaultValue)
    {
      string result = defaultValue;
      if (!IsNull(value))
      {
        try
        {
          result = Convert.ToString(value);
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }
      return result;
    }

    public static string ToString(object p_value)
    {
      return ToString(p_value, string.Empty);
    }

    public static DateTime ToDateTime(object p_value)
    {
      return ToDateTime(p_value, DateTime.Now);
    }

    public static DateTime ToDateTime(object p_value, DateTime p_dtDefault)
    {
      if (!IsNull(p_value))
      {
        try
        {
          return Convert.ToDateTime(p_value);
        }
        catch
        {
        }
      }
      return p_dtDefault;
    }

    public static DateTime ToDate()
    {
      return ToDate(DateTime.Now);
    }

    public static DateTime ToDate(DateTime p_dt)
    {
      return p_dt.AddHours(-p_dt.Hour).AddMinutes(-p_dt.Minute).AddSeconds(-p_dt.Second).AddMilliseconds(-p_dt.Millisecond);
    }

    public static TimeSpan ToTimeSpan(object p_value)
    {
      DateTime dt = ToDateTime(p_value);
      return dt - ToDate(dt);
    }

    public static T ToEnumMember<T>(string p_sValue)
        where T : struct
    {
      return ToEnumMember<T>(p_sValue, default(T));
    }

    public static T ToEnumMember<T>(string p_sValue, T p_default)
        where T : struct
    {
      if (!string.IsNullOrEmpty(p_sValue))
        try
        {
          return (T)Enum.Parse(typeof(T), p_sValue, true);
        }
        catch (Exception e)
        {
          HandleException(e);
        }
      return p_default;
    }

    public static T ToEnumMember<T>(int p_iValue)
        where T : struct
    {
      try
      {
        return (T)Enum.Parse(typeof(T), Enum.GetName(typeof(T), p_iValue), true);
      }
      catch (Exception e)
      {
        HandleException(e);
        return default(T);
      }
    }

    public static int ByteArrayToInt32(byte[] p_bytes)
    {
      int i = 0;
      i |= p_bytes[0] & 0xFF;
      i <<= 8;
      i |= p_bytes[1] & 0xFF;
      i <<= 8;
      i |= p_bytes[2] & 0xFF;
      i <<= 8;
      i |= p_bytes[3] & 0xFF;
      return i;
    }

    public static string ByteArrayToString(byte[] p_bytes)
    {
      return ByteArrayToString(p_bytes, Encoding.ASCII);
    }

    public static string ByteArrayToString(byte[] p_bytes, Encoding p_encoding)
    {
      string sReturn = string.Empty;
      try
      {
        sReturn = p_encoding.GetString(p_bytes);
      }
      catch (Exception ex)
      {
        HandleException(ex);
      }
      return sReturn;
    }

    public static bool IsNull(object p_oValue)
    {
      return (p_oValue == null || Convert.IsDBNull(p_oValue));
    }

    public static bool IsNullOrEmpty(string p_sInput)
    {
      return (p_sInput == null || p_sInput == string.Empty);
    }

    public static object TryConvert(object val, Type p_targetType)
    {
      try
      {
        if (p_targetType.IsGenericType)
        {
          Type[] genericTypes = p_targetType.GetGenericArguments();
          if (genericTypes.Length == 1)
          {
            return TryConvert(val, genericTypes[0]);
          }
        }
        else
        {
          if (p_targetType.IsEnum)
          {
            return Convert.ChangeType(Enum.ToObject(p_targetType, ToInt32(val, 0)), p_targetType);
          }
          else
          {
            try
            {
              return Convert.ChangeType(val, p_targetType);
            }
            catch
            {
              return Convert.ChangeType(val, p_targetType, System.Globalization.CultureInfo.InvariantCulture);
            }
          }
        }
      }
      catch (Exception ex)
      {
        HandleException(ex);
        return null;
      }
      return null;
    }

    public static object TryConvert(ValueType p_val, Type p_targetType)
    {
      return TryConvert((object)p_val, p_targetType);
    }

    public static Guid ToGuid(object obj)
    {
      Guid res = Guid.Empty;

      if (!IsNull(obj))
      {
        try
        {
          if (obj is Guid)
          {
            return (Guid)obj;
          }

          if (obj is string)
          {
            return new Guid((string)obj);
          }
        }
        catch (Exception ex)
        {
          HandleException(ex);
        }
      }

      return res;
    }

    private static void HandleException(Exception p_ex)
    {
      if (LogExceptions)
        AssistLogger.Log<Exceptions.ExceptionHolder>(p_ex);
    }
  }
}