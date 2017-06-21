using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Braintree;

namespace FourteenLadders
{
    public partial class Default : System.Web.UI.Page
    {
        protected string FormClientID { get; private set; }

        BraintreeGateway gateway = new BraintreeGateway
        {
            Environment = Braintree.Environment.SANDBOX,
            MerchantId = "MerchantID",
            PublicKey = "PublicKey",
            PrivateKey = "PrivateKey"
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                this.FormClientID = this.Form.ClientID;
                this.inpClientToken.Value = gateway.ClientToken.generate();
            }
        }

        protected void btnSubmit_OnClick(object sender, EventArgs e)
        {
            var nonce = inpPaymentMethodNonce.Value;
            this.lblInfo.Text = $"Nonce={nonce}";

            var request = new TransactionRequest
            {
                Amount = 10.00M,
                PaymentMethodNonce = nonce,
                Options = new TransactionOptionsRequest
                {
                    StoreInVaultOnSuccess = true,
                    SubmitForSettlement = true,
                }
            };

            Transaction transaction = null;
            var result = gateway.Transaction.Sale(request);
            if (result.IsSuccess())
            { transaction = result.Target;
                Session["TransactionID"] = transaction.Id;
                Session["TransactionType"] = transaction.Type;
                Session["TransactionStatus"] = transaction.Status;
                Session["TransactionAmount"] = transaction.Amount;

                Session["PaymentToken"] = transaction.CreditCard.Token;
                Session["CardType"] = transaction.CreditCard.CardType;
                Session["Bin"] = transaction.CreditCard.Bin;
                Session["ExpirationDate"] = transaction.CreditCard.ExpirationDate;
                Response.Redirect("Success.aspx");

                    }
            //else
            //{
            //    lblInfo.Text = "Transaction failed!";
            //    transaction = result.Transaction;
            //    if (transaction.Status == TransactionStatus.PROCESSOR_DECLINED)
            //    {
            //        lblInfo.Text += $" {transaction.ProcessorResponseCode}, {transaction.ProcessorResponseText}";
            //    }
            //}
        }
    }
}