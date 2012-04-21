using System;
using System.Collections.Generic;
using System.Threading;
using GT.BO.Caching.Configuration;
using GT.BO.Caching.DataSource;
using GT.BO.Caching.Functionality;
using GT.BO.Caching.Loading;
using GT.BO.Caching.Management;
using GT.BO.Properties;
using GT.Common;
using GT.Common.Exceptions;

namespace GT.BO.Caching
{
    /// <summary>
    /// Абстрактный класс, описывающий базовую кэш-структуру
    /// </summary>
    /// <typeparam name="DataType">Тип кэшируемых данных</typeparam>
    /// <typeparam name="CacheConfiguratorType"></typeparam>
    /// <typeparam name="CacheDataProviderType"></typeparam>
    /// <typeparam name="CacheManagerType"></typeparam>
    public abstract class Cache<DataType, CacheConfiguratorType, CacheDataSourceProviderType, CacheManagerType>
        : IGenericCache<DataType>
        where DataType : class
        where CacheConfiguratorType : class, ICacheConfigurator
        where CacheDataSourceProviderType : class, ICacheDataSourceProvider
        where CacheManagerType : class, ICacheManager<DataType>
    {
        #region Events

        public event ReloadCacheDelegate OnAfterReloadCache;

        #endregion

        #region Fields

        protected readonly object _innerLock = new object();
        protected readonly object _threadLock = new object();

        protected volatile Thread _periodicLoaderThread = null;
        protected volatile Thread _loaderThread = null;

        protected volatile IEnumerable<string> _displayColumns = null;
        private volatile bool _acceptChanges = true;
        //вместо volatile используется Interlocked
        private long _changesCount = 0;

        protected volatile CacheConfiguratorType _configurator = null;
        protected volatile CacheDataSourceProviderType _dataSourceProvider = null;
        protected volatile CacheManagerType _manager = null;

        #endregion

        #region Constructors

        public Cache()
        {
        }

        public Cache(
            CacheConfiguratorType p_oConfigurator,
            CacheDataSourceProviderType p_oDataSourceProvider,
            CacheManagerType p_oManager)
        {
            _configurator = p_oConfigurator;
            _dataSourceProvider = p_oDataSourceProvider;
            _manager = p_oManager;
        }

        #endregion

        #region Abstract

        protected abstract IEnumerable<string> FillDisplayColumns(CacheLoadContext<DataType> _loadContext);

        #endregion

        #region Virtual

        public virtual IEnumerable<string> DisplayColumns
        {
            get
            {
                if (FirstLoadCompleted)
                    return _displayColumns;
                return new List<string>();
            }
        }

        protected virtual bool IsInAction
        {
            get
            {
                return _loaderThread != null && _loaderThread.IsAlive;
            }
        }

        protected virtual bool IsInPeriodicAction
        {
            get
            {
                return _periodicLoaderThread != null && _periodicLoaderThread.IsAlive;
            }
        }

        public virtual bool FirstLoadCompleted
        {
            get
            {
                return _manager.IsEmpty == false;
            }
        }

        protected virtual long ChangesCount
        {
            get { return Interlocked.Read(ref _changesCount); }
        }

        protected virtual void PrepareData(CacheLoadContext<DataType> loadContext)
        { }

        protected virtual void HandleAbortException(ThreadAbortException p_ex)
        { }

        protected virtual void AfterReloadCache()
        { }

        protected virtual void HandleException(Exception p_ex)
        {
            AssistLogger.Log<ExceptionHolder>(p_ex,
                new AssistLogger.Category[] { AssistLogger.Category.Cache, AssistLogger.Category.General },
                AssistLogger.Priority.High,
                System.Diagnostics.TraceEventType.Critical);
        }

        protected virtual bool LoadDataFromDataSource(CacheLoadContext<DataType> loadContext)
        {
            return _dataSourceProvider.LoadData<DataType>(loadContext);
        }

        protected virtual void LoadData(object p_loadContext)
        {
            try
            {
                /*AssistLogger.WriteTraceStart(
                    string.Format(Resources.CacheThreadStarted, Thread.CurrentThread.Name, GetType(),
                    Thread.CurrentThread.ManagedThreadId), "Load Cache");*/

                ClearChanges();
                SetAcceptChanges(false);
                CacheLoadContext<DataType> loadContext = p_loadContext as CacheLoadContext<DataType>;
                LoadDataFromDataSource(loadContext);
                _displayColumns = FillDisplayColumns(loadContext);
                PrepareData(loadContext);
                MergeDataInternal(loadContext);
                SetAcceptChanges(true);
                FireReloadCacheEvent();

                /*AssistLogger.WriteTraceStop(
                    string.Format(Resources.CacheThreadFinished, Thread.CurrentThread.Name, GetType(),
                    Thread.CurrentThread.ManagedThreadId), "Load Cache");*/
            }
            catch (ThreadAbortException abortEx)
            {
                HandleAbortException(abortEx);
            }
            catch (Exception ex)
            {
                _dataSourceProvider.HandleDataLoadingException(ex);
                HandleException(ex);
                if (FirstLoadCompleted == false)
                {
                    throw ex;
                }
            }
            finally
            {
                if (_configurator.PeriodicReloadTimeSpan.TotalSeconds > 0)
                {
                    ClearChanges();
                    _periodicLoaderThread = StartPeriodicLoaderThread(PeriodicReloadCache);
                }
            }
        }

        public virtual void Dispose()
        {
            lock (_innerLock)
            {
                if (IsInAction)
                {
                    _loaderThread.Abort();
                    _loaderThread = null;
                }

                if (IsInPeriodicAction)
                {
                    _periodicLoaderThread.Abort();
                    _periodicLoaderThread = null;
                }

                ClearChanges();
                //m_oConfigurator.Dispose();
                _manager.Dispose();
                _dataSourceProvider.Dispose();
                _configurator = null;
                _dataSourceProvider = null;
                _manager = null;
            }
        }

        #endregion

        #region Protected

        protected void FireReloadCacheEvent()
        {
            if (OnAfterReloadCache != null)
            {
                OnAfterReloadCache();
            }
            AfterReloadCache();
        }

        protected void AddChange()
        {
            Interlocked.Increment(ref _changesCount);
        }

        protected void ClearChanges()
        {
            Interlocked.Exchange(ref _changesCount, 0);
        }

        protected void ReloadCacheIfNeeded()
        {
            if (IsCacheExpired && IsInAction == false)
            {
                lock (_threadLock)
                {
                    if (IsInAction == false)
                    {
                        _loaderThread = StartLoaderThread(LoadData, new CacheLoadContext<DataType>());
                    }
                }
            }

            if (FirstLoadCompleted == false)
            {
                lock (_threadLock)
                {
                    if (FirstLoadCompleted == false)
                    {
                        Type oCurrentCacheType = this.GetType();
                        int iCurrentManagedThreadId = Thread.CurrentThread.ManagedThreadId;

                        AssistLogger.WriteTraceStart(
                            string.Format(Resources.CacheFirstLoading, oCurrentCacheType, iCurrentManagedThreadId), "Load Cache");

                        if (IsInAction && !_loaderThread.Join(_configurator.ReloadTimeout))
                            HandleException(new Exception(string.Format(Resources.CacheLoadingTimeout, oCurrentCacheType, iCurrentManagedThreadId)));

                        AssistLogger.WriteTraceStop(
                            string.Format(Resources.CacheFinishLoading, oCurrentCacheType, iCurrentManagedThreadId), "Load Cache");
                    }
                }
            }
        }

        protected void MergeDataInternal(CacheLoadContext<DataType> loadContext)
        {
            _manager.MergeData(loadContext);
        }

        protected void PeriodicReloadCache()
        {
            Thread.Sleep(_configurator.PeriodicReloadTimeSpan);
            LoadCache();
        }

        protected void SetAcceptChanges(bool p_bAccept)
        {
            _acceptChanges = p_bAccept;
        }

        protected bool AcceptChanges
        {
            get
            {
                return _acceptChanges;
            }
        }

        protected static Thread StartLoaderThread(ParameterizedThreadStart p_start, CacheLoadContext<DataType> loadContext)
        {
            Thread loader = new Thread(p_start);
            loader.Name = p_start.Method.Name;
            loader.Priority = ThreadPriority.AboveNormal;
            loader.Start(loadContext);
            return loader;
        }

        protected static Thread StartPeriodicLoaderThread(ThreadStart p_start)
        {
            Thread loader = new Thread(p_start);
            loader.Name = p_start.Method.Name;
            loader.Priority = ThreadPriority.Normal;
            loader.Start();
            return loader;
        }

        #endregion

        #region IGenericCache Members

        public virtual void ClearCache()
        {
            AddChange();
            if (_configurator.IsLazyLoad == false)
            {
                LoadCacheEntirely();
            }
        }

        /// <summary>
        /// Перегружает кэш
        /// </summary>
        public virtual void LoadCache()
        {
            AddChange();
            ReloadCacheIfNeeded();
        }

        /// <summary>
        /// Вызывает полную перегрузку кэша
        /// <remarks>Не создает отдельного потока, а выполняется в том потоке, который вызвал данный метод, поэтому требуется ожидание выполнения</remarks>
        /// </summary>
        public virtual void LoadCacheEntirely()
        {

            lock (_threadLock)
            {
                while (IsInAction)
                {
                    Thread.Sleep(_configurator.LockTimeout);
                }
                LoadData(new CacheLoadContext<DataType>(CacheLoadType.Entirely));
            }
        }
        /// <summary>
        /// Частично перезагружает кэш с ожиданием
        /// </summary>
        public virtual void ReloadCache()
        {
            lock ( _threadLock )
            {
                while ( IsInAction )
                {
                    Thread.Sleep( _configurator.LockTimeout );
                }
                LoadData( new CacheLoadContext<DataType>( CacheLoadType.Partially ) );
            }
        }

        public virtual bool IsCacheExpired
        {
            get
            {
                return !FirstLoadCompleted || ChangesCount > 0 || _dataSourceProvider.HasNewData;
            }
        }

        public virtual DataType Data
        {
            get
            {
                ReloadCacheIfNeeded();
                return _manager.Data;
            }
        }

        public virtual bool IsLazyLoad
        {
            get
            {
                return _configurator.IsLazyLoad;
            }
        }

        #endregion
    }
}
