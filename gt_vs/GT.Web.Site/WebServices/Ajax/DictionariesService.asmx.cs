using System;
using System.Collections.Specialized;
using System.Data;
using System.Web.Script.Services;
using System.Web.Services;
using AjaxControlToolkit;
using GT.Common.Types;
using GT.DA.Dictionaries;
using GT.Web.Services;

namespace GT.Web.Site.WebServices.Ajax
{
    /// <summary>
    /// Summary description for AjaxDataService
    /// </summary>
    [WebService(Namespace = "http://gameismoney.ru/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [ScriptService]
    public class DictionariesService : BaseWebService
    {
        /// <summary>
        /// Returns games and then game servers by the passed (selected) game
        /// </summary>
        /// <param name="knownCategoryValues"></param>
        /// <param name="category"></param>
        /// <returns></returns>
        [WebMethod]
        [ScriptMethod]
        public CascadingDropDownNameValue[] GetCascadingDropDownDictionary(string knownCategoryValues, string category)
        {
            DictionaryTypes dicType = TypeConverter.ToEnumMember<DictionaryTypes>(category, DictionaryTypes.None);
            StringDictionary values = CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
            switch (dicType)
            {
                case DictionaryTypes.Game:
                    return Array.ConvertAll<DataRow, CascadingDropDownNameValue>(
                        Dictionaries.Instance.GetSortedGames()
                        , delegate(DataRow g) { return new CascadingDropDownNameValue(TypeConverter.ToString(g[GameFields.LocalizedName]), TypeConverter.ToString(g[GameFields.GameId])); });
                case DictionaryTypes.GameServer:
                    int gameId;
                    if (values[DictionaryTypes.Game.ToString()] is string
                        && int.TryParse(values[DictionaryTypes.Game.ToString()], out gameId))
                    {
                        return Array.ConvertAll<DataRow, CascadingDropDownNameValue>(
                            Dictionaries.Instance.GetGameServersByGameId(gameId)
                            , delegate(DataRow gs) { return new CascadingDropDownNameValue(TypeConverter.ToString(gs[GameServerFields.LocalizedName]), TypeConverter.ToString(gs[GameServerFields.GameServerId])); });
                    }
                    break;
            }
            return null;
        }
    }
}
