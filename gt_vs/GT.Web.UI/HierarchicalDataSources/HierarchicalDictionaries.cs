using System;
using System.Data;
using System.Web.UI.WebControls;
using GT.DA.Dictionaries;
using GT.Web.UI.Properties;

namespace GT.Web.UI.HierarchicalDataSources
{
  public class HierarchicalDictionaries
  {

    #region Singleton

    private HierarchicalDictionaries()
    {
    }

    public static HierarchicalDictionaries Instance
    {
      get { return Nested.instance; }
    }

    private class Nested
    {
      internal static readonly HierarchicalDictionaries instance = new HierarchicalDictionaries();

      static Nested()
      {
      }
    }

    #endregion


    public TreeNode GetGamesServers()
    {
      TreeNode root = new TreeNode(Resources.GameServerRootNodeName);

      root.Value = Guid.Empty.ToString();

      DataTable games = Dictionaries.Instance.Games;

      DataTable servers = Dictionaries.Instance.GameServers;

      foreach (DataRow game in games.Rows)
      {
        TreeNode node = new TreeNode(game[GameFields.LocalizedName].ToString());
        node.Value = game[GameFields.GameId].ToString();

        DataRow[] gameServers = servers.Select(string.Format("{0} = {1}",
                                                              GameServerFields.GameId,
                                                              game[GameFields.GameId].ToString()));

        foreach (DataRow server in gameServers)
        {
          TreeNode nodeServ = new TreeNode(server[GameServerFields.LocalizedName].ToString());
          nodeServ.Value = server[GameServerFields.GameServerId].ToString();

          node.ChildNodes.Add(nodeServ);
        }

        root.ChildNodes.Add(node);
      }

      return root;
    }
  }
}
