using System;
using System.Collections.Generic;
using System.Linq;
using GT.BO.Implementation.Offers.SearchFilters;
using GT.Common.Types;
using GT.Global.Offers;
using CommonResources = GT.Localization.Resources.CommonResources;
using GT.Global.Entities;
using GT.DA.Dictionaries;

namespace GT.Web.Site.Offers
{
  public partial class Filter : System.Web.UI.UserControl
  {
    [System.ComponentModel.DefaultValue(EntityType.SellingOffer)]
    public EntityType Entity
    {
      get;
      set;
    }

    public class DelegateWrapper
    {
      public delegate string TempDelegate();
      TempDelegate m_TD;

      public DelegateWrapper(TempDelegate td)
      {
        m_TD = td;
      }

      public string Value
      {
        get
        {
          return m_TD.Invoke();
        }
      }
    }

    private SearchInTypes? _searchIn = null;
    private string _searchValue = null;
    private int? _gameId = null;
    private int? _gameServerId = null;

    protected Dictionary<SearchInTypes, object> SearchInCollection
    {
      get
      {
        string key = "SearchInCollection";
        if (Cache[key] == null)
        {
          var data = new Dictionary<SearchInTypes, object>();
          data.Add(SearchInTypes.Game, new DelegateWrapper(delegate() { return CommonResources.Game; }));
          data.Add(SearchInTypes.Server, new DelegateWrapper(delegate() { return CommonResources.Server; }));
          data.Add(SearchInTypes.Title, new DelegateWrapper(delegate() { return CommonResources.Title; }));
          data.Add(SearchInTypes.Description, new DelegateWrapper(delegate() { return CommonResources.Description; }));
          Cache[key] = data;
        }
        return Cache[key] as Dictionary<SearchInTypes, object>;
      }
    }

    protected int? GameServerId
    {
      get
      {
        if (_gameServerId.HasValue == false)
        {
          int serverId = TypeConverter.ToInt32(Request.QueryString[ViewFilterParams.GameServerId], 0);
          _gameServerId = serverId > 0 ? new Nullable<int>(serverId) : null;
        }
        return _gameServerId;
      }
    }

    protected int? GameId
    {
      get
      {
        if (_gameId.HasValue == false)
        {
          int gameId = TypeConverter.ToInt32(Request.QueryString[ViewFilterParams.GameId], 0);
          _gameId = gameId > 0 ? new Nullable<int>(gameId) : null;
        }
        return _gameId;
      }
    }

    protected SearchInTypes SearchIn
    {
      get
      {
        if (false == _searchIn.HasValue)
        {
          _searchIn = SearchInCollection.Keys.First();
          Array.ForEach(SearchInCollection.Keys.ToArray(), d => _searchIn |= d); //search in all
          string temp = TypeConverter.ToString(Request.QueryString[ViewFilterParams.SearchIn]);
          int values = 0;
          if (true == int.TryParse(temp, out values))
          {
            _searchIn = (SearchInTypes)values;
          }
        }
        return _searchIn.Value;
      }
    }

    protected string SearchValue
    {
      get
      {
        if (_searchValue == null)
        {
          _searchValue = TypeConverter.ToString(Request.QueryString[ViewFilterParams.SearchValue]);
        }
        return _searchValue;
      }
    }


    private Guid? _userId = null;

    protected Guid? UserId
    {
      get
      {
        if (_userId.HasValue == false)
        {
          var userId = TypeConverter.ToGuid(Request.QueryString[ViewFilterParams.UserId]);
          _userId = userId != Guid.Empty ? new Nullable<Guid>(userId) : null;

        }
        return _userId;
      }
    }

    private int? _productCategoryId = null;

    protected int? ProductCategoryId
    {
      get
      {
        if (_productCategoryId.HasValue == false)
        {
          var category = TypeConverter.ToInt32(Request.QueryString[ViewFilterParams.ProductCategoryId], 0);
          _productCategoryId = category > 0 ? new Nullable<int>(category) : null;
        }
        return _productCategoryId;
      }
    }

    protected IEnumerable<KeyValuePair<string, string>> GetProductCategories()
    {
      return new[] { new KeyValuePair<int, string>(0, CommonResources.Offers_Filter_AnyProductCategory) }
        .Union(Dictionaries.Instance.GetProductCategoriesAsPairs()).Select(e
          => new KeyValuePair<string, string>(e.Key.ToString(), e.Value));
    }

    public BaseSearchFilter SearchFilter
    {
      get
      {
        BaseSearchFilter filter = new BaseSearchFilter();

        filter.GameName = EnumHelper.HasFlags<SearchInTypes>(SearchIn, SearchInTypes.Game)
              ? SearchValue : null;
        filter.GameServerName = EnumHelper.HasFlags<SearchInTypes>(SearchIn, SearchInTypes.Server)
            ? SearchValue : null;
        filter.Title = EnumHelper.HasFlags<SearchInTypes>(SearchIn, SearchInTypes.Title)
            ? SearchValue : null;
        filter.Description = EnumHelper.HasFlags<SearchInTypes>(SearchIn, SearchInTypes.Description)
            ? SearchValue : null;
        if (true == GameServerId.HasValue)
        {
          filter.GameServerId = GameServerId.Value;
        }
        if (true == GameId.HasValue)
        {
          filter.GameId = GameId.Value;
        }
        if (true == UserId.HasValue)
        {
          filter.UserId = UserId.Value;
        }
        if (true == ProductCategoryId.HasValue)
        {
          filter.ProductCategoryId = ProductCategoryId.Value;
        }

        return filter;
      }
    }

    protected void ddlProductCategory_DataBound(object sender, EventArgs e)
    {
      if (ProductCategoryId > 0)
      {
        ddlProductCategory.SelectedValue = ProductCategoryId.ToString();
      }
    }

    protected void Page_Load(object sender, EventArgs e)
    {

    }
  }
}