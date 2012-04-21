using System;
using System.Xml.Serialization;
using GT.BO.Caching.Functionality;
using GT.BO.Entities;
using System.Web.Security;

namespace GT.BO.Implementation.Users
{
  [XmlRoot("u")]
  [Obsolete]
  public class _User : BaseEntity, IArrayCacheItem
  {
    private int _index = 0;

    public _User(MembershipUser mu)
    {
      Data = mu;
      Id = (Guid)mu.ProviderUserKey;
    }

    public Guid Id
    {
      get;
      private set;
    }

    public MembershipUser Data
    {
      get;
      private set;
    }

    #region IArrayCacheItem Members

    public bool IsLoadCompleted
    {
      get { throw new Exception("The method or operation is not implemented."); }
    }

    [System.Xml.Serialization.XmlAttribute("index")]
    public int ItemIndex
    {
      get
      {
        return _index;
      }
      set
      {
        _index = value;
      }
    }

    #endregion
  }
}
