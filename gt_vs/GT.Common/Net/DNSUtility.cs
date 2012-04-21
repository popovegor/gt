using System.Net;

namespace GT.Common.Net
{
    public class DNSUtility
    {
        private static string m_sCurrentServerIPCode = string.Empty;
        private static readonly object _lockObject = new object();

        public static IPAddress [] GetIPByHostName(string p_sHostName)
        {
            IPHostEntry ipEntry = Dns.GetHostEntry(p_sHostName);
            if (ipEntry != null)
                return ipEntry.AddressList;
            return null;
        }

        public static IPAddress [] GetIPByHostName()
        {
            return GetIPByHostName(Dns.GetHostName());
        }

        static string GetCurrentServerIPCode()
        {
            string sReturn = string.Empty;
            IPAddress[] addrs = GetIPByHostName();
            if (addrs != null)
                foreach (IPAddress addr in addrs)
                {
                    byte [] addrBytes = addr.GetAddressBytes();
                    string sLast = addrBytes[addrBytes.Length - 1].ToString();
                    sReturn = (sReturn == string.Empty) ? sLast : string.Format("{0}-{1}", sReturn, sLast);
                }
            return sReturn;
        }

        public static string CurrentServerIPCode
        {
            get
            {
                if (string.IsNullOrEmpty(m_sCurrentServerIPCode))
                    lock (_lockObject)
                        if (string.IsNullOrEmpty(m_sCurrentServerIPCode))
                            m_sCurrentServerIPCode = GetCurrentServerIPCode();
                return m_sCurrentServerIPCode;
            }
        }
    }
}
