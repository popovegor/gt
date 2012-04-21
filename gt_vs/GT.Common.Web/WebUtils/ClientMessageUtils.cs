using System;
using System.Collections;
using System.Text;
using System.Web;
using System.Web.UI;

namespace GT.Common.Web.WebUtils
{
    /// <summary>
    /// MessageBox is only to be used in Web Applications! Does not have to be instantiated!
    /// </summary>
    /// <remarks>
    /// Enables the use of a web message box by simply typing WilsToolbox.MessageBox.Show("message")
    /// </remarks>
    public class ClientMessageUtils
    {
        //  public MessageBox() { }

        private void MessageBox() { }

        /// <summary>
        /// This will contains the PageName[QueuedMessage]
        /// </summary>
        private static Hashtable m_executingPages = new Hashtable();

        /// <summary>
        /// Pass a string through this method to display a javascript popup
        /// </summary>
        /// <remarks>
        /// Identify the calling Page, use it as the Hashtable Key, and put the Queue in as the value       
        /// For use with Web Applications Only
        /// </remarks>
        public static void Show(string sMessage)
        {
            // If this is the first time a page has called this method then
            if (!m_executingPages.Contains(HttpContext.Current.Handler))
            {
                // Attempt to cast HttpHandler as a Page.
                // Simply put, this sets the current page as the executing page
                Page executingPage = HttpContext.Current.Handler as Page;
                // error correction; ensure the page was successfully identified
                if (executingPage != null)
                {
                    // Create a Queue to hold one or more messages.
                    Queue messageQueue = new Queue();

                    // Add our message to the Queue
                    messageQueue.Enqueue(sMessage);

                    // Add our message queue to the hash table. Use our page reference
                    // (IHttpHandler) as the key.
                    // this will ensure that all messages put here will be displayed
                    // in order of placement, to the page that called it.
                    m_executingPages.Add(HttpContext.Current.Handler, messageQueue);

                    // Wire up Unload event so that we can inject 
                    // some JavaScript for the alerts.
                    // simply put; set the method we have as the event handler
                    // for the calling pages Unload event (after page has rendered)
                    executingPage.Unload += new EventHandler(ExecutingPage_Unload);
                }
            }
            else
            {
                // We have already been here previously, and the Show() method has already been 
                // called from this particular Executing Page.
                // Therefore we have already created a message queue in memory and have already
                // stored a reference to it in our hashtable. 
                // So, lets add a new entry for this executing page
                Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];

                // And add our latest message to the Queue
                queue.Enqueue(sMessage);
            }
        }

        /// <summary>
        /// Pass a string through this method to display a javascript popup
        /// </summary>
        /// <remarks>
        /// Our page has finished rendering so lets output the JavaScript to produce the alert's
        /// </remarks>
        private static void ExecutingPage_Unload(object sender, EventArgs e)
        {
            // Get our message queue from the hashtable
            Queue queue = (Queue)m_executingPages[HttpContext.Current.Handler];

            if (queue != null)
            {
                StringBuilder sb = new StringBuilder();

                // How many messages have been registered?
                int iMsgCount = queue.Count;

                // Use StringBuilder to build up our client slide JavaScript.
                sb.Append("<script language='javascript'>");

                // Loop round registered messages
                string sMsg;
                while (iMsgCount-- > 0)
                {
                    sMsg = (string)queue.Dequeue();
                    sMsg = sMsg.Replace("\n", "\\n");
                    sMsg = sMsg.Replace("\"", "'");
                    sb.Append(@"alert( """ + sMsg + @""" );");
                }

                // Close our JS

                sb.Append(@"</" + "script>");

                // Were done, so remove our page reference from the hashtable
                m_executingPages.Remove(HttpContext.Current.Handler);

                // Write the JavaScript to the end of the response stream.
                HttpContext.Current.Response.Write(sb.ToString());
            }
        }
    }
}