using System;
using System.Collections.Generic;
using System.Text;
using NUnit.Framework;
using GT.BO.Implementation.Messages;
using System.Diagnostics;
using System.Security.Principal;
using GT.Web.Security;

namespace GT.Web.Site.Test.WebServices.Ajax
{
    [TestFixture]
    public class MessagesServiceTestFixture
    {
        [Test]
        public void GetMessages()
        {
            MessageSearchFilter sf = new MessageSearchFilter();
            GT.Web.Site.WebServices.Ajax.MessagesService serv = new GT.Web.Site.WebServices.Ajax.MessagesService();
            IPrincipal user =  new System.Security.Principal.GenericPrincipal(new System.Security.Principal.GenericIdentity("user2"), new string[] { });
            serv.Credentials = new CredentialHelper(user);
            string messages = serv.GetMessages(sf);
            Trace.WriteLine(messages);
        }
    }
}
