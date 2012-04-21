using System.ComponentModel;
using System.Configuration.Install;
using System.Diagnostics;
using GT.Global.EventLog;
using System.Collections;

namespace GT.Win.PaymentControlService
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : Installer
    {
        public ProjectInstaller()
        {
            InitializeComponent();
        }

        public override void Install(IDictionary stateSaver)
        {
            base.Install(stateSaver);
            if (!EventLog.SourceExists(EventLogSource.EVENTLOG_SOURCE))
            {
                EventLog.CreateEventSource(EventLogSource.EVENTLOG_SOURCE, EventLogSource.EVENTLOG_LOG); 
            }
        }
    }
}
