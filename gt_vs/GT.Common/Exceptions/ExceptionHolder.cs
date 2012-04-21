using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.Serialization;
using GT.Common.Net;

namespace GT.Common.Exceptions
{
    public class ExceptionHolder : Exception
    {
        protected Exception m_InnerException;
        private Dictionary<string, object> m_dicExtendedProperties;
        private bool m_bShouldLog;

        public ExceptionHolder(Exception p_ex)
            : this(p_ex, true)
        {
        }

        public ExceptionHolder(Exception p_ex, bool p_bShouldLog)
        {
            m_InnerException = p_ex;
            m_bShouldLog = p_bShouldLog;
            FillExtendedProperties();
        }

        public override Exception GetBaseException()
        {
            return m_InnerException.GetBaseException();
        }

        public override void GetObjectData(SerializationInfo info, StreamingContext context)
        {
            m_InnerException.GetObjectData(info, context);
        }

        public override string HelpLink
        {
            get { return m_InnerException.HelpLink; }
            set { m_InnerException.HelpLink = value; }
        }

        public override string Message
        {
            get { return m_InnerException.Message; }
        }

        public override string Source
        {
            get { return m_InnerException.Source; }
            set { m_InnerException.Source = value; }
        }

        public override string StackTrace
        {
            get { return m_InnerException.StackTrace; }
        }

        public new Exception InnerException
        {
            get { return m_InnerException.InnerException; }
        }

        public new MethodBase TargetSite
        {
            get { return m_InnerException.TargetSite; }
        }

        public new Dictionary<string, object> Data
        {
            get
            {
                if (m_dicExtendedProperties == null)
                {
                    m_dicExtendedProperties = new Dictionary<string, object>(m_InnerException.Data.Count);
                    foreach (DictionaryEntry entry in m_InnerException.Data)
                    {
                        string sKey = string.Empty;
                        if (entry.Key != null)
                        {
                            sKey = entry.Key.ToString();
                            m_dicExtendedProperties.Add(sKey, string.Empty);
                        }
                        if (sKey != string.Empty &&
                            entry.Value != null)
                            m_dicExtendedProperties[sKey] = entry.Value.ToString();
                    }
                }
                return m_dicExtendedProperties;
            }
        }

        public string Code
        {
            get { return Data["Code"].ToString(); }
        }

        public string ServerCode
        {
            get { return Data["ServerCode"].ToString(); }
        }

        public bool ShouldLog
        {
            get { return m_bShouldLog; }
            set { m_bShouldLog = value; }
        }

        protected virtual void FillExtendedProperties()
        {
            string sCode = base.Message.GetHashCode().ToString();
            sCode = (sCode.Length > 4) ? sCode.Substring(0, 4) : sCode;
            Data.Add("Code", sCode);
            Data.Add("ServerCode", DNSUtility.CurrentServerIPCode);
            Data.Add("Type", m_InnerException.GetType().ToString());
            Data.Add("Message", Message);
            Data.Add("Source", Source);
            Data.Add("StackTrace", StackTrace);
            Data.Add("InnerException", AssistLogger.GetExceptionDescription(InnerException).ToString());
        }

        public Type GetExceptionType()
        {
            return m_InnerException.GetType();
        }
    }
}