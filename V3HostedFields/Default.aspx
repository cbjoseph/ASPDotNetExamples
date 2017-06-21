<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FourteenLadders.Default" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="inpClientToken" runat="server" />
        <asp:Label ID="lblInfo" runat="server"></asp:Label>

        <div id="error-message"></div>

        <label for="card-number">Card Number</label>s
        <div class="hosted-field" id="card-number"></div>

        <label for="cvv">CVV</label>
        <div class="hosted-field" id="cvv"></div>

        <label for="expiration-date">Expiration Date</label>
        <div class="hosted-field" id="expiration-date"></div>

        <asp:HiddenField ID="inpPaymentMethodNonce" runat="server" /> 
        <asp:Button ID="btnSubmit" Text="Pay $10" Enabled="false" runat="server" OnClick="btnSubmit_OnClick" />

        <!-- Load the Client component. -->
        <script src="https://js.braintreegateway.com/web/3.12.0/js/client.min.js"></script>

        <!-- Load the Hosted Fields component. -->
        <script src="https://js.braintreegateway.com/web/3.12.0/js/hosted-fields.min.js"></script>

        <script>
            var form = document.querySelector('#<%= this.FormClientID %>');
            var submitButton = document.querySelector('#<%= btnSubmit.ClientID %>');

            braintree.client.create({
                // Replace this with your own authorization.
                authorization: document.getElementById('<%= inpClientToken.ClientID %>').value
            }, function (clientErr, clientInstance) {
                if (clientErr) {
                    // Handle error in client creation
                    return;
                }

                braintree.hostedFields.create({
                    client: clientInstance,
                    styles: {
                        'input': {
                            'font-size': '14pt'
                        },
                        'input.invalid': {
                            'color': 'red'
                        },
                        'input.valid': {
                            'color': 'green'
                        }
                    },
                    fields: {
                        number: {
                            selector: '#card-number',
                            placeholder: '4111 1111 1111 1111'
                        },
                        cvv: {
                            selector: '#cvv',
                            placeholder: '123'
                        },
                        expirationDate: {
                            selector: '#expiration-date',
                            placeholder: '10/2019'
                        }
                    }
                }, function (hostedFieldsErr, hostedFieldsInstance) {
                    if (hostedFieldsErr) {
                        // Handle error in Hosted Fields creation
                        return;
                    }

                    submitButton.removeAttribute('disabled');

                    form.addEventListener('submit', function (event) {
                        event.preventDefault();

                        hostedFieldsInstance.tokenize(function (tokenizeErr, payload) {
                            //window.alert(payload.nonce);
                            if (tokenizeErr) {
                                window.alert(tokenizeErr.message);

                                // Handle error in Hosted Fields tokenization
                                return;
                            }

                            //Store the nonce value in the hidden input 
                            document.querySelector('input[id="<%= inpPaymentMethodNonce.ClientID %>"]').value = payload.nonce;

                            //Submit the form, using the Javascript ASP.NET generated for us to initiate a postback
                            //event from a button click on 
                            <%= this.ClientScript.GetPostBackEventReference(new PostBackOptions(this.btnSubmit)) %>;
                        });
                    }, false);
                });
            });
        </script>
    </form>
</body>
</html>
