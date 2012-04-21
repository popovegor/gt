using System.Web.Profile;
using System.Xml;
using System.Xml.Serialization;
using System.ComponentModel;
using Converter=GT.Common.Types.TypeConverter;

namespace GT.Web.Security
{
    [XmlRoot("cup")]
    public class CustomUserProfile : ProfileBase
    {
        object m_Sync = new object();

        [XmlAttribute("fn")]
        [SettingsAllowAnonymous(false)]
        public string FirstName
        {
            get { return base["FirstName"] as string; }
            set { base["FirstName"] = value; }
        }

        [XmlAttribute("ln")]
        [SettingsAllowAnonymous(false)]
        public string LastName
        {
            get { return (string)base["LastName"]; }
            set { base["LastName"] = value; }
        }

        [XmlAttribute("nn")]
        [SettingsAllowAnonymous(false)]
        public string Nickname
        {

            get { return (string)base["Nickname"]; }
            set { base["Nickname"] = value; }
        }

        [XmlAttribute("p")]
        [SettingsAllowAnonymous(false)]
        public string Phone
        {
            get { return (string)base["Phone"]; }
            set { base["Phone"] = value; }
        }

        [XmlAttribute("mp")]
        [SettingsAllowAnonymous(false)]
        public string MobilePhone
        {
            get { return (string)base["MobilePhone"]; }
            set { base["MobilePhone"] = value; }
        }

        [XmlAttribute("icq")]
        [SettingsAllowAnonymous(false)]
        public string ICQ
        {
            get { return (string)base["ICQ"]; }
            set { base["ICQ"] = value; }
        }

        [XmlAttribute("s")]
        [SettingsAllowAnonymous(false)]
        public string Skype
        {
            get { return (string)base["Skype"]; }
            set { base["Skype"] = value; }
        }

        [XmlAttribute("a")]
        [SettingsAllowAnonymous(false)]
        public string Address
        {
            get { return (string)base["Address"]; }
            set { base["Address"] = value; }
        }

        [XmlAttribute("n")]
        [SettingsAllowAnonymous(false)]
        public string Note
        {
            get { return (string)base["Note"]; }
            set { base["Note"] = value; }
        }

        [XmlAttribute("tz")]
        [SettingsAllowAnonymous(false)]
        public string TimeZone
        {
          get { return (string)base["TimeZone"]; }
          set { base["TimeZone"] = value; }
        }

        [XmlAttribute("notification_email")]
        [SettingsAllowAnonymous(false)]
        [DefaultValue(true)]
        public bool EmailMessageNotification
        {
          get { return (bool)base["EmailMessageNotification"]; }
          set { base["EmailMessageNotification"] = value; }
        }

        [XmlAttribute("notification_icq")]
        [SettingsAllowAnonymous(false)]
        [DefaultValue(true)]
        public bool IcqMessageNotification
        {
          get { return (bool)base["IcqMessageNotification"]; }
          set { base["IcqMessageNotification"] = value; }
        }
    }
}
