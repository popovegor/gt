using System.Globalization;
using System.Text;

namespace GT.Common.Cryptography
{
    public static class HexEncoder
    {
        public static string GetString(byte[] p_data)
        {
            if (p_data != null &&
                p_data.Length > 0)
            {
                StringBuilder sbResults = new StringBuilder();
                for (int i = 0; i < p_data.Length; i++)
                    sbResults.Append(p_data[i].ToString("X2").ToLower());
                return sbResults.ToString();
            }
            return string.Empty;
        }

        public static byte[] GetBytes(string p_sData)
        {
            if (string.IsNullOrEmpty(p_sData))
                return new byte[0];
            byte[] bytesResults = new byte[p_sData.Length/2];
            for (int i = 0; i < p_sData.Length; i += 2)
            {
                byte b;
                if (
                    !byte.TryParse(p_sData.Substring(i, 2), NumberStyles.HexNumber, NumberFormatInfo.InvariantInfo,
                                   out b))
                    return new byte[0];
                bytesResults[i/2] = b;
            }
            return bytesResults;
        }
    }
}