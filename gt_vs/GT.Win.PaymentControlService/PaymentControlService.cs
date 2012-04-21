using System.ComponentModel;
using System.Diagnostics;
using System.ServiceProcess;
using System.Threading;
using GT.Global.EventLog;
using GT.Common;
using GT.Common.Exceptions;
using System.Configuration;
using GT.BO.Implementation.BillingSystem;
using GT.BO.Implementation.Payments;
using GT.Global.BillingSystem;
using System;
using System.Linq;
using System.Collections.Generic;

namespace GT.Win.PaymentControlService
{
    public partial class PaymentControlService : ServiceBase
    {
        const string CONFIG_TIMEOUT = "timeout";

        Thread m_Worker;

        public PaymentControlService()
        {
            InitializeComponent();
        }

        protected override void OnStart(string[] args)
        {
            OnStop();

            m_Worker = new Thread(new ThreadStart(Work));
            m_Worker.Start();
        }

        protected override void OnStop()
        {
            StopWorker();
        }

        void StopWorker()
        {
            if (m_Worker != null && m_Worker.IsAlive)
            {
                if (m_Worker != Thread.CurrentThread)
                {
                    m_Worker.Interrupt();
                    m_Worker.Abort();
                    m_Worker = null;
                }
            }
        }

        void Work()
        {
            try
            {
                int timeout = GT.Common.Types.TypeConverter.ToInt32(ConfigurationSettings.AppSettings[CONFIG_TIMEOUT], 900);
                while (true)
                {
                    try
                    {
                        List<Transfer> transfers = new List<Transfer>(BillingSystemFacade.GetTransfersByStatus(TransferStatus.Pending));
                        Transfer t = transfers.Where(p => p.FromTransferParticipant.ActualEntityType == GT.Global.Entities.EntityType.RealMoneySource &&
                                                          p.ToTransferParticipant.ActualEntityType == GT.Global.Entities.EntityType.User)
                                              .OrderBy(q => q.CreateDate)
                                              .FirstOrDefault();

                        if (transfers.Count > 0)
                        {
                            if (t != null)
                            {
                                WebMoneyManager.UpdateOutgoingInvoices(t.CreateDate, transfers);
                            }

                            t = transfers.OrderBy(p => p.CreateDate).FirstOrDefault();

                            if (t != null)
                            {
                                WebMoneyManager.UpdateTransferStatus(t.CreateDate, transfers);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        AssistLogger.Log<ExceptionHolder>(ex);
                    }

                    Thread.Sleep(timeout * 1000);
                }
            }
            catch (Exception e)
            {
                EventLog.WriteEntry(EventLogSource.EVENTLOG_SOURCE, e.ToString(), EventLogEntryType.Error);
                StopWorker();
            }
        }
    }
}
