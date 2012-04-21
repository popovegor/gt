using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using GT.BO.Entities;
using System.Xml.Serialization;
using GT.DA.Statistics;

namespace GT.BO.Implementation.Statistic
{
  [Serializable]
  [XmlRoot("GameStat")]
  public class GameStat : BaseEntity
  {
    [BaseSourceMapping(StatisticsFields.GameId)]
    public override int Id
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.BuyingTotal)]
    public int BuyingTotal
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.BuyingArmory)]
    public int BuyingArmory
    {
      get;
      set;
    }


    [BaseSourceMapping(StatisticsFields.BuyingCharacter)]
    public int BuyingCharacter
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.BuyingCurrency)]
    public int BuyingCurrency
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.BuyingMisc)]
    public int BuyingMisc
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.SellingTotal)]
    public int SellingTotal
    {
      get;
      set;
    }


    [BaseSourceMapping(StatisticsFields.SellingActive)]
    public int SellingActive
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.SellingActiveArmory)]
    public int SellingActiveArmory
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.SellingActiveCurrency)]
    public int SellingActiveCurrency
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.SellingActiveCharacter)]
    public int SellingActiveCharacter
    {
      get;
      set;
    }

    [BaseSourceMapping(StatisticsFields.SellingActiveMisc)]
    public int SellingActiveMisc
    {
      get;
      set;
    }
  }
}
