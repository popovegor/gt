using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Entities;
using GT.DA.Dictionaries;

namespace GT.BO.Implementation.BillingSystem
{
  public class RealMoneySource : BaseEntity
  {
    private int _realMoneySourceId = 0;
    private string _name;
    private string _description;
    private decimal _commission;
    private decimal _ourCommission;
    private decimal _minTransferAmount;

    [BaseSourceMapping(RealMoneySourceFields.RealMoneySourceId)]
    public int RealMoneySourceId
    {
      get { return this._realMoneySourceId; }
      set { this._realMoneySourceId = value; }
    }

    [BaseSourceMapping(RealMoneySourceFields.Name)]
    public string Name
    {
      get { return this._name; }
      set { this._name = value; }
    }

    [BaseSourceMapping(RealMoneySourceFields.Description)]
    public string Description
    {
      get { return this._description; }
      set { this._description = value; }
    }

    [BaseSourceMapping(RealMoneySourceFields.Commission)]
    public virtual decimal Commission
    {
      get { return this._commission; }
      set { this._commission = value; }
    }

    [BaseSourceMapping(RealMoneySourceFields.OurCommission)]
    public virtual decimal OurCommission
    {
      get { return this._ourCommission; }
      set { this._ourCommission = value; }
    }

    [BaseSourceMapping(RealMoneySourceFields.MinTransferAmount)]
    public decimal MinTransferAmount
    {
      get { return this._minTransferAmount; }
      set { this._minTransferAmount = value; }
    }

    public override int Id
    {
      get { return RealMoneySourceId; }
      set { RealMoneySourceId = value; }
    }
  }
}
