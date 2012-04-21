using System;
using System.Collections.Generic;
using System.Diagnostics;
using GT.Common.Exceptions;
using GT.Common.Text;
using Microsoft.Practices.EnterpriseLibrary.Logging;

namespace GT.Common
{
    public class AssistLogger
    {
        public enum Priority
        {
            Low = 0,
            Medium = 1,
            High = 2
        }

        public enum Category
        {
            General = 0,
            Database,
            Code,
            Cache,
            Email,
            Login,
            Registration,
            Log404,
            Trace,
            Debug,
            Shutdown,
            WebMoney
        }

        public static T Log<T>(Exception p_ex)
            where T : ExceptionHolder
        {
            return Log<T>(p_ex, Category.General);
        }

        public static T Log<T>(Exception p_ex, Category p_category)
            where T : ExceptionHolder
        {
            return Log<T>(p_ex, p_category, Priority.High, TraceEventType.Error);
        }

        public static T Log<T>(Exception p_ex, Category p_category, Priority p_priority, TraceEventType p_severity)
            where T : ExceptionHolder
        {
            return Log<T>(p_ex, new Category[] { p_category }, p_priority, p_severity);
        }

        public static T Log<T>(Exception p_ex, Category[] p_categories, Priority p_priority, TraceEventType p_severity)
            where T : ExceptionHolder
        {
            p_ex = GetHolder<T>(p_ex);
            if (((ExceptionHolder)p_ex).ShouldLog)
            {
                Logger.Write(p_ex, GetCategoriesString(p_categories), (int) p_priority, 1, p_severity, string.Empty,
                             ((T) p_ex).Data);
                ((ExceptionHolder) p_ex).ShouldLog = false;
            }
            return p_ex as T;
        }

        public static T Log<T>(Exception p_ex, string p_sCategory)
            where T : ExceptionHolder
        {
            p_ex = GetHolder<T>(p_ex);
            if (((ExceptionHolder)p_ex).ShouldLog)
            {
                Logger.Write(p_ex, p_sCategory, (int)Priority.High, 1, TraceEventType.Error, string.Empty,
                             ((T)p_ex).Data);
                ((ExceptionHolder)p_ex).ShouldLog = false;
            }
            return p_ex as T;
        }

        public static void  WriteInformation(string p_sMessage, Category p_category)
        {
            WriteInformation(p_sMessage, string.Empty, p_category);
        }

        public static void  WriteInformation(string p_sMessage, string p_sTitle, Category p_category)
        {
            Logger.Write(p_sMessage, GetCategoriesString(new Category[] { p_category }), 
                (int) Priority.Low, 1, TraceEventType.Information, p_sTitle,
                             new Dictionary<string, object>(0));
        }

        public static void WriteInformation(string p_sMessage, string p_sCategory)
        {
            Logger.Write(p_sMessage, p_sCategory, (int)Priority.Low, 1, TraceEventType.Information, string.Empty,
                             new Dictionary<string, object>(0));
        }

        public static void WriteDebugInformation(string p_sMessage, string p_sTitle)
        {
            Logger.Write(p_sMessage, GetCategoriesString(new Category[] { Category.Debug }),
                (int)Priority.Low, 1, TraceEventType.Information, p_sTitle,
                             new Dictionary<string, object>(0));
        }

        public static void WriteTraceInformation(string p_sMessage, string p_sTitle)
        {
            Logger.Write(p_sMessage, GetCategoriesString(new Category[] { Category.Trace }),
                (int)Priority.Low, 1, TraceEventType.Information, p_sTitle,
                             new Dictionary<string, object>(0));
        }

        public static void WriteTraceStart(string p_sMessage, string p_sTitle)
        {
            Logger.Write(p_sMessage, GetCategoriesString(new Category[] { Category.Trace }),
                (int)Priority.Low, 1, TraceEventType.Start, p_sTitle,
                             new Dictionary<string, object>(0));
        }

        public static void WriteTraceStop(string p_sMessage, string p_sTitle)
        {
            Logger.Write(p_sMessage, GetCategoriesString(new Category[] { Category.Trace }),
                (int)Priority.Low, 1, TraceEventType.Stop, p_sTitle,
                             new Dictionary<string, object>(0));
        }

        public static SeparatedString GetExceptionDescription(Exception p_ex)
        {
            SeparatedString exceptionDescription = new SeparatedString(Environment.NewLine);
            if (p_ex != null)
            {
                exceptionDescription.Add(p_ex.GetType().ToString(), true);
                exceptionDescription.Add(p_ex.Message, true);
                exceptionDescription.Add(p_ex.Source, true);
                exceptionDescription.Add(p_ex.StackTrace, true);
                while (p_ex.InnerException != null)
                {
                    exceptionDescription.Add("Inner exception: ");
                    exceptionDescription.Add(GetExceptionDescription(p_ex.InnerException).ToString());
                    p_ex = p_ex.InnerException;
                }
            }
            return exceptionDescription;
        }

        private static Exception GetHolder<T>(Exception p_ex)
            where T: ExceptionHolder
        {
            if (p_ex.InnerException != null &&
                (p_ex.InnerException is T ||
                 p_ex.InnerException.GetType().IsSubclassOf(typeof(T))))
                return p_ex.InnerException;
            if (!(p_ex is T) &&
                  !p_ex.GetType().IsSubclassOf(typeof(T)))
                p_ex = (Exception)typeof(T).InvokeMember(null, System.Reflection.BindingFlags.CreateInstance, null, null,
                                            new object[] { p_ex });
            return p_ex;
        }

        private static string[] GetCategoriesString(Category[] p_categories)
        {
            return Array.ConvertAll(p_categories, new Converter<Category, string>(CategoryString));
        }

        private static string CategoryString(Category p_cat)
        {
            return p_cat.ToString();
        }
    }
}
