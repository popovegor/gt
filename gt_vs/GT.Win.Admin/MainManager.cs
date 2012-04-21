using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using GT.BO.Implementation.BillingSystem;
using GT.Global.BillingSystem;
using GT.BO.Implementation.Users;
using GT.Web.Security;
using System.Web.Security;

namespace GT.Win.Admin
{
  public partial class MainManager : Form
  {
    public MainManager()
    {
      InitializeComponent();
    }

    private void btnTopUp_Click(object sender, EventArgs e)
    {
      var userName = txtUser.Text;
      var userId = UsersFacade.GetUser(userName).UserId();
      var amount = int.Parse(txtAmount.Text);
      var t = TransferFactory.CreateRealSourceToUser(RealMoneySourceType.WebMoney, userId, amount, string.Empty);
      var nt = BillingSystemFacade.AddTransfer(t);
      BillingSystemFacade.CompleteTransfer(nt.TransferId);
      lblResult.Text = string.Format("Transfer[{0}] is completed", amount);
    }
  }
}
