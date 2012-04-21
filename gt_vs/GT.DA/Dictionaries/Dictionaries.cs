using System;
using System.Data;
using GT.BO.Caching;
using GT.BO.Caching.Management;
using GT.Common.Types;
using GT.DA.Caching.Configuration;
using GT.Global.Caching;
using GT.Global.Offers;
using GT.DA.MessageSystem;
using GT.Global.MessageSystem;
using System.Linq;
using System.Collections.Generic;
using System.Collections;
using System.Data.Linq;

namespace GT.DA.Dictionaries
{
  public class Dictionaries : DataSetCache<CacheConfigurator, DictionariesCacheDatabaseProvider, ReadOnlyDataSetCacheManager>
  {
    #region Singleton

    private Dictionaries()
    {
    }

    public static Dictionaries Instance
    {
      get { return Nested.instance; }
    }

    private class Nested
    {
      internal static readonly Dictionaries instance = new Dictionaries();

      static Nested()
      {
        instance._configurator = CacheConfigurationManager.GetConfigurationForType(CacheTypes.Dictionaries);
        instance._dataSourceProvider = new DictionariesCacheDatabaseProvider();
        instance._manager = new ReadOnlyDataSetCacheManager();
      }
    }

    #endregion

    #region select filters

    private static class SelectFilters
    {
      public const string GameByName = " ({0} LIKE '%{1}%') ";
      public const string PhaseByName = " ({0} = '{1}') ";
      public const string TimeZoneByDotNetId = "({0} = '{1}')";
    }

    #endregion

    protected override void AfterReloadCache()
    {
      //set table names
      var setTableName = new Action<DataTable, DictionaryTypes>((dt, dic)
        => dt.TableName = Enum.GetName(typeof(DictionaryTypes), dic));
      setTableName(Data.Tables[0],  DictionaryTypes.Game);
      setTableName(Data.Tables[1],  DictionaryTypes.GameServer);
      setTableName(Data.Tables[2],  DictionaryTypes.TransactionPhase);
      setTableName(Data.Tables[3],  DictionaryTypes.BuyerStatus);
      setTableName(Data.Tables[4],  DictionaryTypes.RealMoneySource);
      setTableName(Data.Tables[5],  DictionaryTypes.FeedbackType);
      setTableName(Data.Tables[6],  DictionaryTypes.MessageTemplate);
      setTableName(Data.Tables[7],  DictionaryTypes.TransferStatus);
      setTableName(Data.Tables[8],  DictionaryTypes.TimeZone);
      setTableName(Data.Tables[9],  DictionaryTypes.WebMoneyMessage);
      setTableName(Data.Tables[10], DictionaryTypes.WebMoneyMessageType);
      setTableName(Data.Tables[11], DictionaryTypes.ProductCategory);
      //set primary keys
      var setPrimaryKey = new Action<DataTable, string>((dt, pk)
        => dt.PrimaryKey = new DataColumn[] { dt.Columns[pk] });
      setPrimaryKey(Games, GameFields.GameId);
      setPrimaryKey(GameServers, GameServerFields.GameServerId);
      setPrimaryKey(TransactionPhases, TransactionPhaseFields.TransactionPhaseId);
      setPrimaryKey(BuyerStatuses, BuyerStatusFields.BuyerStatusId);
      setPrimaryKey(RealMoneySources, RealMoneySourceFields.RealMoneySourceId);
      setPrimaryKey(FeedbackTypes, FeedbackTypeFields.FeedbackTypeId);
      setPrimaryKey(MessageTemplates, MessageTemplateFields.MessageTemplateId);
      setPrimaryKey(TransferStatuses, TransferStatusFields.TransferStatusId);
      setPrimaryKey(TimeZones, TimeZoneFields.TimeZoneId);
      setPrimaryKey(WebMoneyMessages, WebMoneyMessageFields.WebMoneyMessageId);
      setPrimaryKey(WebMoneyMessagesTypes, WebMoneyMessageTypeFields.WebMoneyMessageTypeId);
      setPrimaryKey(ProductCategories, ProductCategoryFields.ProductCategoryId);
    }

    public DataTable GetDictionary(DictionaryTypes dictionaryType)
    {
      return Data.Tables[Enum.GetName(typeof(DictionaryTypes), dictionaryType)];
    }
    
    #region product category

    public DataTable ProductCategories
    {
      get
      {
        return GetDictionary(DictionaryTypes.ProductCategory);
      }
    }
    
    public IEnumerable<KeyValuePair<int, string>> GetProductCategoriesAsPairs()
    {
      return ProductCategories.Select()
        .Select(product 
          => new  KeyValuePair<int, string>(
            TypeConverter.ToInt32( product[ProductCategoryFields.ProductCategoryId])
            , TypeConverter.ToString( product[ProductCategoryFields.LocalizedName])));
    }
    
    public string GetProductCategoryNameById(int id)
    {
      var p = ProductCategories.Rows.Find(id);
      if(p != null)
      {
        return TypeConverter.ToString(p[ProductCategoryFields.LocalizedName]);
      }
      return string.Empty;
    }
    
    public int GetProductCategoryMiscId
    {
      get
      {
        return 4;
      }
    }
    
    #endregion

    #region time zone

    public DataTable TimeZones
    {
      get
      {
        return GetDictionary(DictionaryTypes.TimeZone);
      }
    }

    public TimeZoneInfo GetTimeZoneInfoByOffset(int offsetInMinutes, bool dst, out int timeZoneId)
    {
      TimeZoneInfo timeZoneInfo = null;
      timeZoneId = int.MinValue;
      var dr = TimeZones.AsEnumerable().FirstOrDefault(tz
        => TimeSpan.Parse(tz[TimeZoneFields.Offset].ToString()).TotalMinutes == offsetInMinutes);
      if (dr != null)
      {
        timeZoneId = TypeConverter.ToInt32(dr[TimeZoneFields.TimeZoneId]);
        timeZoneInfo = GetTimeZoneInfoById(timeZoneId);
      }
      return timeZoneInfo;
    }

    public TimeZoneInfo GetTimeZoneInfoById(int id)
    {
      TimeZoneInfo timeZone = null;
      var zone = TimeZones.Rows.Find(id);
      if (null != zone)
      {
        var dotNetId = TypeConverter.ToString(zone[TimeZoneFields.DotNetTimeZoneId]);
        timeZone = TimeZoneInfo.FindSystemTimeZoneById(dotNetId);
      }
      return timeZone;
    }

    public int GetDefaultTimeZone()
    {
      var zones = TimeZones.Select(
        string.Format(SelectFilters.TimeZoneByDotNetId, TimeZoneFields.DotNetTimeZoneId, TimeZoneInfo.Utc.Id));
      if (zones != null)
      {
        return TypeConverter.ToInt32(zones[0][TimeZoneFields.TimeZoneId], 61);
      }
      else
      {
        return 61;
      }
    }

    public string GetTimeZoneNameById(int id)
    {
      var name = string.Empty;
      var zone = TimeZones.Rows.Find(id);
      if (null != zone)
      {
        name = TypeConverter.ToString(zone[TimeZoneFields.LocalizedName], string.Empty);
      }
      return name;
    }

    #endregion

    #region billing system

    public DataTable TransferStatuses
    {
      get
      {
        return GetDictionary(DictionaryTypes.TransferStatus);
      }
    }

    public string GetTransferStatusNameById(int id)
    {
      return TypeConverter.ToString(TransferStatuses.Rows.Find(id)[TransferStatusFields.LocalizedName]);
    }

    #endregion

    #region message system

    public DataTable MessageTemplates
    {
      get
      {
        return GetDictionary(DictionaryTypes.MessageTemplate);
      }
    }

    public DataRow GetMessageTemplateById(int id)
    {
      return MessageTemplates.Rows.Find(id);
    }

    public DataRow GetMessageTemplate(MessageTemplate t)
    {
      return MessageTemplates.Rows.Find((int)t);
    }

    #endregion

    #region feedback types

    public DataTable FeedbackTypes
    {
      get
      {
        return GetDictionary(DictionaryTypes.FeedbackType);
      }
    }

    public string GetFeedbackTypeNameById(int id)
    {
      return TypeConverter.ToString(FeedbackTypes.Rows.Find(id)[FeedbackTypeFields.LocalizedName]);
    }

    #endregion

    #region real money sources

    public DataTable RealMoneySources
    {
      get
      {
        return GetDictionary(DictionaryTypes.RealMoneySource);
      }
    }
    
    public DataRow GetRealMoneySourceById(int id)
    {
      return RealMoneySources.Rows.Find(id);
    }

    public decimal GetRealMoneySourceCommissionById(int id)
    {
      return TypeConverter.ToDecimal(RealMoneySources.Rows.Find(id)[RealMoneySourceFields.Commission], 0);
    }

    public decimal GetRealMoneySourceOurCommissionById(int id)
    {
      return TypeConverter.ToDecimal(RealMoneySources.Rows.Find(id)[RealMoneySourceFields.OurCommission], 0);
    }

    public string GetRealMoneySourceNameById(int realSourceMoneyId)
    {
      return RealMoneySources.Rows.Find(
          realSourceMoneyId)[RealMoneySourceFields.Name].ToString();
    }

    public int[] GetRealMoneySourceIds()
    {
      return Array.ConvertAll<DataRow, int>(RealMoneySources.Select(),
          delegate(DataRow dr) { return TypeConverter.ToInt32(dr[RealMoneySourceFields.RealMoneySourceId]); });
    }

    #endregion

    #region buyer statuses

    public DataTable BuyerStatuses
    {
      get
      {
        return GetDictionary(DictionaryTypes.BuyerStatus);
      }
    }

    #endregion

    #region transaction phase

    public DataTable TransactionPhases
    {
      get
      {
        return GetDictionary(DictionaryTypes.TransactionPhase);
      }
    }

    public DataRow GetTransactionPhaseById(int transactionPhaseId)
    {
      return TransactionPhases.Rows.Find(transactionPhaseId);
    }

    public string GetTransactionPhaseNameById(int transactionPhaseId)
    {
      DataRow tp = GetTransactionPhaseById(transactionPhaseId);
      return tp != null ? TypeConverter.ToString(tp[TransactionPhaseFields.LocalizedName]) : null;
    }

    public TransactionPhase GetTransactionPhaseByName(string name)
    {
      DataRow[] rows = TransactionPhases.Select(string.Format(SelectFilters.PhaseByName, TransactionPhaseFields.LocalizedName, name));
      if (rows != null && rows.Length == 1)
      {
        return TypeConverter.ToEnumMember<TransactionPhase>(TypeConverter.ToInt32(rows[0][TransactionPhaseFields.TransactionPhaseId]));
      }

      return GT.Global.Offers.TransactionPhase.None;
    }

    #endregion

    #region games

    public DataTable Games
    {
      get
      {
        return GetDictionary(DictionaryTypes.Game);
      }
    }

    public DataRow[] GetSortedGames()
    {
        return Games.Select("", String.Format("{0} DESC, {1}", GameFields.Priority, GameFields.LocalizedName));
    }

    public int GetGameIdByGameServerId(int gameServerId)
    {
      DataRow g = GetGameByGameServerId(gameServerId);
      return g != null ? TypeConverter.ToInt32(g[GameFields.GameId], 0) : 0;
    }

    public string GetGameNameByGameServerId(int gameServerId)
    {
      DataRow g = GetGameByGameServerId(gameServerId);
      return g != null ? TypeConverter.ToString(g[GameFields.LocalizedName]) : null;
    }

    public DataRow GetGameByGameServerId(int gameServerId)
    {
      DataRow gs = GetGameServerById(gameServerId);
      return gs != null ? GetGameById(TypeConverter.ToInt32(gs[GameServerFields.GameId])) : null;
    }

    public DataRow[] GetGamesByNamePattern(string gameNamePattern)
    {
      return Games.Select(string.Format(SelectFilters.GameByName, GameFields.LocalizedName, gameNamePattern));
    }

    public DataRow GetGameById(int gameId)
    {
      return Games.Rows.Find(gameId);
    }

    public string GetGameNameById(int gameId)
    {
      string sGameName = string.Empty;
      sGameName = GetGameById(gameId)[GameFields.LocalizedName] as string;
      return sGameName;
    }

    #endregion

    #region game servers

    public DataTable GameServers
    {
      get { return GetDictionary(DictionaryTypes.GameServer); }
    }

    public DataRow[] GetGameServersByGameId(int gameId)
    {
        return GameServers.Select(string.Format("{0} = {1}", GameServerFields.GameId, gameId), GameServerFields.LocalizedName);
    }

    public DataRow GetGameServerById(int gameServerId)
    {
      return GameServers.Rows.Find(gameServerId);
    }

    public string GetGameServerNameById(int gameServerId)
    {
      DataRow gs = GetGameServerById(gameServerId);
      return gs != null ? TypeConverter.ToString(gs[GameServerFields.LocalizedName]) : null;
    }

    #endregion

    #region webmoney messages

    public DataTable WebMoneyMessages
    {
        get
        {
            return GetDictionary(DictionaryTypes.WebMoneyMessage);
        }
    }

    public string GetWebMoneyMessageById(int id)
    {
        DataRow row = WebMoneyMessages.Rows.Find(id);
        return row != null ? TypeConverter.ToString(row[WebMoneyMessageFields.LocalizedMessage]) : null;
    }

    public string GetWebMoneyDefaultSystemErrorMessage()
    {
        return GetWebMoneyMessageLocalized(-1, 4);
    }

    public DataRow GetWebMoneyMessageByRetcodeAndType(int retcode, int type)
    {
        DataRow[] rows = WebMoneyMessages.Select(String.Format("{0} = {1} AND {2} = {3}",
                                                 WebMoneyMessageFields.Retcode,
                                                 retcode,
                                                 WebMoneyMessageFields.Type,
                                                 type));

        if (rows.Length == 1)
        {
            return rows[0];
        }

        return null;
    }

    public string GetWebMoneyMessageLocalized(int retcode, int type)
    {
        DataRow r = GetWebMoneyMessageByRetcodeAndType(retcode, type);
        if (r != null)
        {
            return TypeConverter.ToString(r[WebMoneyMessageFields.LocalizedMessage]);
        }

        return null;
    }

    public int? GetWebMoneyMessageIdByRetcodeAndType(int retcode, int type)
    {
        DataRow r = GetWebMoneyMessageByRetcodeAndType(retcode, type);
        if (r != null)
        {
            return TypeConverter.ToInt32(r[WebMoneyMessageFields.WebMoneyMessageId]);
        }

        return null;
    }

    #endregion
      
    #region webmoney messages types

    public DataTable WebMoneyMessagesTypes
    {
        get
        {
            return GetDictionary(DictionaryTypes.WebMoneyMessageType);
        }
    }

    #endregion
  }
}
