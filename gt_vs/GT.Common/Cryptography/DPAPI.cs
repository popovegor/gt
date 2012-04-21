using System.Security.Cryptography;
using System.Text;

namespace GT.Common.Cryptography
{
    public class DPAPI
    {
        private static Encoding m_encoding = Encoding.UTF8;
        private static DataProtectionScope m_scope = DataProtectionScope.CurrentUser;

        public static string Encrypt(string p_sText)
        {
            if (!string.IsNullOrEmpty(p_sText))
            {
                byte[] ecryptedData = ProtectedData.Protect(m_encoding.GetBytes(p_sText),
                                                            null, m_scope);
                return HexEncoder.GetString(ecryptedData);
            }
            return string.Empty;
        }

        public static string Decrypt(string p_sEcnrypted)
        {
            if (!string.IsNullOrEmpty(p_sEcnrypted))
            {
                byte[] rawData = HexEncoder.GetBytes(p_sEcnrypted);
                byte[] unprotected = ProtectedData.Unprotect(rawData, null, m_scope);
                return m_encoding.GetString(unprotected);
            }
            return string.Empty;
        }
    }
}