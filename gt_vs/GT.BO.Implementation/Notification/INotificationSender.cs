using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Implementation.MessageSystem;

namespace GT.BO.Implementation.Notification
{
  public interface INotificationSender
  {
    void Send(Message m);
  }
}
