using System;
using System.Security.Cryptography;
using System.Text;

namespace GT.Common.Cryptography
{
    public class TripleDES : IDisposable
    {
        private readonly MD5CryptoServiceProvider hashmd5;
        private readonly byte[] pwdhash;
        private TripleDESCryptoServiceProvider des;

        public TripleDES(string p_sPassword)
        {
            if (string.IsNullOrEmpty(p_sPassword))
                throw new ArgumentOutOfRangeException("p_sPassword");
            hashmd5 = new MD5CryptoServiceProvider();
            pwdhash = hashmd5.ComputeHash(Encoding.UTF8.GetBytes(p_sPassword));
            hashmd5 = null;
            des = new TripleDESCryptoServiceProvider();
            des.Key = pwdhash;
            des.Mode = CipherMode.ECB; //CBC, CFB
        }

        #region IDisposable Members

        public void Dispose()
        {
            des = null;
        }

        #endregion

        public string Encrypt(string p_sText)
        {
            if (!string.IsNullOrEmpty(p_sText))
            {
                byte[] buff = Encoding.UTF8.GetBytes(p_sText);
                return HexEncoder.GetString(
                    des.CreateEncryptor().TransformFinalBlock(buff, 0, buff.Length)
                    );
            }
            return string.Empty;
        }

        public string Decrypt(string p_sEcnrypted)
        {
            if (!string.IsNullOrEmpty(p_sEcnrypted))
            {
                byte[] buff = HexEncoder.GetBytes(p_sEcnrypted);
                return Encoding.UTF8.GetString(
                    des.CreateDecryptor().TransformFinalBlock(buff, 0, buff.Length)
                    );
            }
            return string.Empty;
        }
    }
}