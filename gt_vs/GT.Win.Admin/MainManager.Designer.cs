namespace GT.Win.Admin
{
  partial class MainManager
  {
    /// <summary>
    /// Required designer variable.
    /// </summary>
    private System.ComponentModel.IContainer components = null;

    /// <summary>
    /// Clean up any resources being used.
    /// </summary>
    /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
    protected override void Dispose(bool disposing)
    {
      if (disposing && (components != null))
      {
        components.Dispose();
      }
      base.Dispose(disposing);
    }

    #region Windows Form Designer generated code

    /// <summary>
    /// Required method for Designer support - do not modify
    /// the contents of this method with the code editor.
    /// </summary>
    private void InitializeComponent()
    {
      this.txtAmount = new System.Windows.Forms.TextBox();
      this.lblAmount = new System.Windows.Forms.Label();
      this.btnTopUp = new System.Windows.Forms.Button();
      this.txtUser = new System.Windows.Forms.TextBox();
      this.lblUser = new System.Windows.Forms.Label();
      this.lblResult = new System.Windows.Forms.Label();
      this.SuspendLayout();
      // 
      // txtAmount
      // 
      this.txtAmount.Location = new System.Drawing.Point(12, 76);
      this.txtAmount.Name = "txtAmount";
      this.txtAmount.Size = new System.Drawing.Size(258, 22);
      this.txtAmount.TabIndex = 0;
      // 
      // lblAmount
      // 
      this.lblAmount.AutoSize = true;
      this.lblAmount.Location = new System.Drawing.Point(12, 56);
      this.lblAmount.Name = "lblAmount";
      this.lblAmount.Size = new System.Drawing.Size(56, 17);
      this.lblAmount.TabIndex = 1;
      this.lblAmount.Text = "Amount";
      // 
      // btnTopUp
      // 
      this.btnTopUp.Location = new System.Drawing.Point(195, 104);
      this.btnTopUp.Name = "btnTopUp";
      this.btnTopUp.Size = new System.Drawing.Size(75, 23);
      this.btnTopUp.TabIndex = 2;
      this.btnTopUp.Text = "Top up";
      this.btnTopUp.UseVisualStyleBackColor = true;
      this.btnTopUp.Click += new System.EventHandler(this.btnTopUp_Click);
      // 
      // txtUser
      // 
      this.txtUser.Location = new System.Drawing.Point(12, 31);
      this.txtUser.Name = "txtUser";
      this.txtUser.Size = new System.Drawing.Size(258, 22);
      this.txtUser.TabIndex = 3;
      // 
      // lblUser
      // 
      this.lblUser.AutoSize = true;
      this.lblUser.Location = new System.Drawing.Point(12, 11);
      this.lblUser.Name = "lblUser";
      this.lblUser.Size = new System.Drawing.Size(38, 17);
      this.lblUser.TabIndex = 4;
      this.lblUser.Text = "User";
      // 
      // lblResult
      // 
      this.lblResult.AutoSize = true;
      this.lblResult.Location = new System.Drawing.Point(12, 167);
      this.lblResult.Name = "lblResult";
      this.lblResult.Size = new System.Drawing.Size(0, 17);
      this.lblResult.TabIndex = 6;
      // 
      // MainManager
      // 
      this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
      this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
      this.ClientSize = new System.Drawing.Size(282, 255);
      this.Controls.Add(this.lblResult);
      this.Controls.Add(this.lblUser);
      this.Controls.Add(this.txtUser);
      this.Controls.Add(this.btnTopUp);
      this.Controls.Add(this.lblAmount);
      this.Controls.Add(this.txtAmount);
      this.Name = "MainManager";
      this.Text = "MainManager";
      this.ResumeLayout(false);
      this.PerformLayout();

    }

    #endregion

    private System.Windows.Forms.TextBox txtAmount;
    private System.Windows.Forms.Label lblAmount;
    private System.Windows.Forms.Button btnTopUp;
    private System.Windows.Forms.TextBox txtUser;
    private System.Windows.Forms.Label lblUser;
    private System.Windows.Forms.Label lblResult;
  }
}