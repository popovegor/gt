﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.4927
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GT.BO.Properties
{


  /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "2.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class Resources {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal Resources() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("GT.BO.Properties.Resources", typeof(Resources).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to The requested entry index[{0}] is out of range. Array length = {1}.
        /// </summary>
        internal static string ArrayIndexIsOutOfRange {
            get {
                return ResourceManager.GetString("ArrayIndexIsOutOfRange", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Cached data is empty.
        /// </summary>
        internal static string CachedDataIsEmpty {
            get {
                return ResourceManager.GetString("CachedDataIsEmpty", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Finished waiting for the first load in {0}. ManagedThreadId: {1}..
        /// </summary>
        internal static string CacheFinishLoading {
            get {
                return ResourceManager.GetString("CacheFinishLoading", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Started waiting for the first load in {0}. ManagedThreadId: {1}..
        /// </summary>
        internal static string CacheFirstLoading {
            get {
                return ResourceManager.GetString("CacheFirstLoading", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to Loader thread in {0} is timed out. ManagedThreadId: {1}..
        /// </summary>
        internal static string CacheLoadingTimeout {
            get {
                return ResourceManager.GetString("CacheLoadingTimeout", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {0} thread finished in {1}. ManagedThreadId: {2}..
        /// </summary>
        internal static string CacheThreadFinished {
            get {
                return ResourceManager.GetString("CacheThreadFinished", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to {0} thread started in {1}. ManagedThreadId: {2}..
        /// </summary>
        internal static string CacheThreadStarted {
            get {
                return ResourceManager.GetString("CacheThreadStarted", resourceCulture);
            }
        }
    }
}