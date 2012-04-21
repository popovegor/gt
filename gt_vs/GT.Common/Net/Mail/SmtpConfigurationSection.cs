using System.Configuration;

namespace GT.Common.Net.Mail
{
  public class SmtpConfigurationSection : ConfigurationSection
  {
    public const string SectionName = "smtpConfiguration";
    private const string EnabledPropertyName = "enabled";
    private const string FromPropertyName = "from";
    private const string Email4ErrosPropertyName = "email4errors";
    private const string RegistrationEmailPropertyName = "registrationemail";
    private const string SupportEmailPropertyName = "supportemail";
    private const string NoreplyEmailPropertyName = "noreply";

    public SmtpConfigurationSection()
    {
    }

    [ConfigurationProperty(EnabledPropertyName, IsRequired = false, DefaultValue = true)]
    public bool Enabled
    {
      get
      {
        return (bool)this[EnabledPropertyName];
      }
      set
      {
        this[EnabledPropertyName] = value;
      }
    }

    [ConfigurationProperty(FromPropertyName, IsRequired = false, DefaultValue = "registration@gameismoney.ru")]
    public string From
    {
      get
      {
        return (string)this[FromPropertyName];
      }
      set
      {
        this[FromPropertyName] = value;
      }
    }

    [ConfigurationProperty(Email4ErrosPropertyName, IsRequired = false, DefaultValue = "gameismoney.ru@gmail.com")]
    public string Email4Errors
    {
      get
      {
        return (string)this[Email4ErrosPropertyName];
      }
      set
      {
        this[Email4ErrosPropertyName] = value;
      }
    }

    [ConfigurationProperty(RegistrationEmailPropertyName, IsRequired = false, DefaultValue = "registration@gameismoney.ru")]
    public string RegistrationEmail
    {
      get
      {
        return (string)this[RegistrationEmailPropertyName];
      }
      set
      {
        this[RegistrationEmailPropertyName] = value;
      }
    }

    [ConfigurationProperty(NoreplyEmailPropertyName, IsRequired = false, DefaultValue = "noreply@gameismoney.ru")]
    public string NoreplyEmail
    {
      get
      {
        return (string)this[NoreplyEmailPropertyName];
      }
      set
      {
        this[NoreplyEmailPropertyName] = value;
      }
    }

    [ConfigurationProperty(SupportEmailPropertyName, IsRequired = false, DefaultValue = "support@gameismoney.ru")]
    public string SupportEmail
    {
      get
      {
        return (string)this[SupportEmailPropertyName];
      }
      set
      {
        this[SupportEmailPropertyName] = value;
      }
    }
  }
}
