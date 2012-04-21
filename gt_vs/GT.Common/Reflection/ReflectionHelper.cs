using System;
using System.Collections.Generic;
using System.IO;
using System.Reflection;
using System.Runtime.InteropServices;
using GT.Common.Exceptions;

namespace GT.Common.Reflection
{
    public static class ReflectionHelper
    {    
        public static Dictionary<MemberInfo, T> GetMembersWithCustomAttribute<T>(object o)
            where T : Attribute
        {
            Type type = o.GetType();
            Dictionary<MemberInfo, T>  members = new Dictionary<MemberInfo, T>();
            foreach (MemberInfo mi in type.GetMembers())
            {
                T a = Attribute.GetCustomAttribute(mi, typeof(T), true) as T;
                if (null != a)
                {
                    members.Add(mi, a);
                }
            }
            return members;
        }

        public static object GetPropertyValue(object p_object, string p_sComplexName)
        {
            object oValue = null;

            if (p_object != null && p_sComplexName != null && p_sComplexName != string.Empty)
            {
                oValue = p_object;

                string[] sPropNames = p_sComplexName.Split('.');

                foreach (string sName in sPropNames)
                {
                    try
                    {
                        oValue = oValue.GetType().GetProperty(sName).GetValue(oValue, null);
                    }
                    catch (TargetParameterCountException)
                    {
                        oValue = null;
                    }
                    catch (AmbiguousMatchException)
                    {
                        oValue = null;
                    }
                    catch (TargetInvocationException)
                    {
                        oValue = null;
                    }
                    catch (Exception e)
                    {
                        AssistLogger.Log<ExceptionHolder>(
                            new Exception(string.Format("Cannot get {0} object's {1} property value. \nException: {2}",
                                                        p_object.GetType().FullName, p_sComplexName, e)));
                        oValue = null;
                    }

                    if (oValue == null)
                        break;
                }
            }
            return oValue;
        }

        public static bool SetPropertyValue(object p_object, string p_sComplexName, object p_Value)
        {
            bool bReturn = false;

            if (p_object != null &&
                p_sComplexName != null && p_sComplexName != string.Empty)
            {
                object oValue = p_object;
                string[] sPropNames = p_sComplexName.Split('.');

                for (int i = 0; i < sPropNames.Length - 1; ++i)
                {
                    try
                    {
                        oValue = oValue.GetType().GetProperty(sPropNames[i]).GetValue(oValue, null);
                    }
                    catch (Exception e)
                    {
                        AssistLogger.Log<ExceptionHolder>(
                            new Exception(string.Format("Cannot get {0} object's {1} property value. \nException: {2}",
                                                        p_object.GetType().FullName, p_sComplexName, e)));
                        bReturn = false;
                    }

                    if (oValue == null)
                        return false;
                }

                try
                {
                    PropertyInfo pi = oValue.GetType().GetProperty(sPropNames[sPropNames.Length - 1]);
                    if (pi.CanWrite)
                    {
                        pi.SetValue(oValue, p_Value, null);
                        bReturn = true;
                    }
                }
                catch (Exception e)
                {
                    AssistLogger.Log<ExceptionHolder>(
                        new Exception(
                            string.Format("Cannot set {0} object's {1} property value to {2}. \nException: {3}",
                                          p_object.GetType().FullName, p_sComplexName, p_Value.ToString(), e)));
                    bReturn = false;
                }
            }

            return bReturn;
        }

        public static bool SetCOMObjectPropertyValue(Type p_type, object p_object, string p_sPropertyName,
                                                     object p_Value)
        {
            bool bReturn = false;

            if (p_object != null &&
                p_sPropertyName != null && p_sPropertyName != string.Empty)
            {
                try
                {
                    bool bHasProperty = true;
                    try
                    {
                        p_type.InvokeMember(p_sPropertyName, BindingFlags.Instance | BindingFlags.GetProperty, null,
                                            p_object, null);
                    }
                    catch (COMException)
                    {
                        bHasProperty = false;
                    }

                    if (bHasProperty)
                    {
                        p_type.InvokeMember(p_sPropertyName, BindingFlags.Instance | BindingFlags.SetProperty, null,
                                            p_object,
                                            new object[] { p_Value });
                        bReturn = true;
                    }
                }
                catch (Exception e)
                {
                    AssistLogger.Log<ExceptionHolder>(
                        new Exception(
                            string.Format("Cannot set {0} COMObject's {1} property value to {2}. \nException: {3}",
                                          p_object.GetType().FullName, p_sPropertyName, p_Value.ToString(), e)));
                    bReturn = false;
                }
            }

            return bReturn;
        }

        public static object GetCOMObjectPropertyValue(Type p_type, object p_object, string p_sPropertyName)
        {
            object oValue = null;

            if (p_object != null && p_sPropertyName != null && p_sPropertyName != string.Empty)
            {
                try
                {
                    oValue =
                        p_type.InvokeMember(p_sPropertyName, BindingFlags.Instance | BindingFlags.GetProperty, null,
                                            p_object, null);
                }
                catch (Exception e)
                {
                    AssistLogger.Log<ExceptionHolder>(
                        new Exception(string.Format("Cannot get {0} COMObject's {1} property value. \nException: {2}",
                                                    p_object.GetType().FullName, p_sPropertyName, e)));
                    oValue = null;
                }
            }
            return oValue;
        }

        public static string ReadEmbeddedResource(Assembly p_oAssembly, string p_sResourceName)
        {
            Stream oStream = p_oAssembly.GetManifestResourceStream(p_sResourceName);
            if (oStream == null)
                return null;
            StreamReader oStreamReader = new StreamReader(oStream);
            string sResouce = oStreamReader.ReadToEnd();
            oStreamReader.Close();
            return sResouce;
        }
    }
}