<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!-- Load the Client component. -->
        <script src="https://js.braintreegateway.com/js/braintree-2.32.0.min.js"></script>

        <script>
            braintree.setup("<%= this.inpClientToken.Value %>", "custom", {
                id: "<%= this.Form.ClientID %>",
                hostedFields: {
                    styles: {
                        'input': {
                            'font-size': '16px',
                            'color': '#3A3A3A'
                        },
                        '.number': {
                            'font-family': 'monospace'
                        },
                        ':focus': {
                            'color': 'blue'
                        },
                        '.valid': {
                            'color': 'green'
                        },
                        '.invalid': {
                            'color': 'red'
                        },
                        '@media screen and(max-width: 700px)': {
                            'input': {
                                'font-size': '14px'
                            }
                        }
                    },
                    number: {
                        selector: "#card-number"
                    },
                    cvv: {
                        selector: "#cvv"
                    },
                    expirationDate: {
                        selector: "#expiration-date"
                    }
                },
                onPaymentMethodReceived: function (paymentMethod) {
                    document.querySelector('input[id="<%= inpPaymentMethodNonce.ClientID %>"]').value = paymentMethod.nonce;

                //Submit the form, using the Javascript ASP.NET generated for us to initiate a postback
                //event from a button click on 
                    // included paymentmethod as callback to assign nonce value before form submit
                    <%= this.ClientScript.GetPostBackEventReference(new PostBackOptions(this.btnSubmit)) %>;
                }
            });
    </script>
    <form id="form1" runat="server">
        <asp:HiddenField ID="inpPaymentMethodNonce" runat="server" />
        <asp:HiddenField ID="inpClientToken" runat="server" />
        <asp:Label ID="lblInfo" runat="server"></asp:Label>

        <div id="error-message"></div>

        <label for="card-number">Card Number</label>s
        <div class="hosted-field" id="card-number"></div>

        <label for="cvv">CVV</label>
        <div class="hosted-field" id="cvv"></div>

        <label for="expiration-date">Expiration Date</label>
        <div class="hosted-field" id="expiration-date"></div>

        <asp:Button ID="btnSubmit" Text="Pay $10" runat="server" OnClick="btnSubmit_OnClick" />

        
    </form>
</body>
</html>
