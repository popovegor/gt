using System;
using System.Security.Cryptography;
using System.Text;
using GT.Common.Exceptions;
using GT.Common.Types;

namespace GT.Common.Cryptography
{
    public class Hash
    {
        public const string MD5 = "MD5";
        public const string SHA1 = "SHA1";

        private static HashAlgorithm GetAlgorithm(string p_sName)
        {
            switch (p_sName)
            {
                case MD5:
                    return new MD5CryptoServiceProvider();
                case SHA1:
                    return new SHA1CryptoServiceProvider();

                default:
                    throw AssistLogger.Log<ExceptionHolder>(
                        new ArgumentException("Invalid algorithm name", "p_sName"), AssistLogger.Category.Code);
            }
        }

        public static string Compute(string p_sAlgorithmName, string p_sInput)
        {
            return Compute(p_sAlgorithmName, p_sInput, Encoding.Default);
        }

        public static string Compute(string p_sAlgorithmName, string p_sInput, Encoding p_encoding)
        {
            if (string.IsNullOrEmpty(p_sInput))
                return string.Empty;

            return TypeConverter.ByteArrayToString(ComputeInternal(p_sAlgorithmName, p_sInput, p_encoding),
                                                   p_encoding);
        }

        private static byte[] ComputeInternal(string p_sAlgorithmName, string p_sInput, Encoding p_encoding)
        {
            if (string.IsNullOrEmpty(p_sInput))
                return new byte[0] {};

            HashAlgorithm provider = GetAlgorithm(p_sAlgorithmName);
            return provider.ComputeHash(p_encoding.GetBytes(p_sInput));
        }

        public static string ReadableHash(string p_sAlgorithmName, string p_sInput)
        {
            return ReadableHash(p_sAlgorithmName, p_sInput, Encoding.Default);
        }

        public static string ReadableHash(string p_sAlgorithmName, string p_sInput, Encoding p_encoding)
        {
            if (string.IsNullOrEmpty(p_sInput))
                return string.Empty;

            return HexEncoder.GetString(ComputeInternal(p_sAlgorithmName, p_sInput, p_encoding));
        }
    }
}