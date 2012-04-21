using System;
using System.Drawing;
using GT.Common.Text;
using GT.Common.Types;

namespace GT.ImageGenerator.Serialization
{
    public delegate string SerializeDelegate(object p_obj);

    public delegate object DeserializeDelegate(string p_str);

    internal sealed class Converter
    {
        public static SerializeDelegate GetSerializationMethod(Type p_TargetType)
        {
            if (p_TargetType == typeof (Color))
                return SerializeColor;
            else if (p_TargetType.IsEnum)
                return delegate(object p_obj) { return TypeConverter.ToInt32(p_obj).ToString(); };
            else if (p_TargetType == typeof (bool))
                return delegate(object p_obj) { return ((bool) p_obj) ? "1" : "0"; };
            else
                return delegate(object p_obj) { return TypeConverter.ToString(p_obj); };
        }

        public static DeserializeDelegate GetDeserializationMethod(Type p_TargetType)
        {
            if (p_TargetType == typeof (Color))
                return DeserializeColor;
            if (p_TargetType.IsEnum)
            {
                return delegate(string p_str)
                           {
                               if (p_str.IndexOf(",") != -1)
                               {
                                   string[] sValues = p_str.Split(',');
                                   int oReturn =
                                       (int)DeserializeEnumMember(p_TargetType, sValues[0]);
                                   for (int i = 1; i < sValues.Length; ++i)
                                       oReturn |=
                                           (int)DeserializeEnumMember(p_TargetType, sValues[i]);
                                   return oReturn;
                               }
                               else
                                   return DeserializeEnumMember(p_TargetType, p_str);
                           };
            }
            else if (p_TargetType == typeof (bool))
                return delegate(string p_str) { return TypeConverter.ToBool(p_str); };
            else
                return delegate(string p_str)
                           {
                               try
                               {
                                   return Convert.ChangeType(p_str, p_TargetType);
                               }
                               catch
                               {
                               }
                               return null;
                           };
        }

        private static string SerializeColor(object p_color)
        {
            return ColorTranslator.ToWin32((Color) p_color).ToString();
        }

        private static object DeserializeColor(string p_str)
        {
            if (p_str.StartsWith("#"))
                return ColorTranslator.FromHtml(p_str);
            return ColorTranslator.FromWin32(TypeConverter.ToInt32(p_str));
        }

        private static object DeserializeEnumMember(Type p_TargetType, string p_str)
        {
            if (!string.IsNullOrEmpty(p_str))
            {
                p_str = p_str.Trim();
                if (StringUtils.IsDigitString(p_str))
                    return TypeConverter.ToInt32(p_str);
                else
                    return Enum.Parse(p_TargetType, p_str, true);
            }
            return 0;
        }

    }
}