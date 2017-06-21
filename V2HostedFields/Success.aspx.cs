using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Success : System.Web.UI.Page
{
    protected string Status { get; set; }
    protected string ID { get; set; }
    protected string TransactionType { get; set; }
    protected string Amount { get; set; }

    protected string Token { get; set; }
    protected string CardType { get; set; }
    protected string CardBin { get; set; }
    protected string ExpirationDate { get; set; }
    
        protected void Page_Load(object sender, EventArgs e)
    {
        
        this.Status = Session["TransactionStatus"].ToString();
        this.ID = Session["TransactionID"].ToString();
        this.TransactionType = Session["TransactionType"].ToString();
        this.Amount = Session["TransactionAmount"].ToString();

        this.Token = Session["PaymentToken"].ToString();
        this.CardType = Session["CardType"].ToString();
        this.CardBin = Session["Bin"].ToString();
        this.ExpirationDate = Session["ExpirationDate"].ToString();

        this.lblStatus.Text = Session["TransactionStatus"].ToString();
    }
    
}