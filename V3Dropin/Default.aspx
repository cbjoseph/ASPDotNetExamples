<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <!-- //note need to look at v2 hosted fields and replicate more that format, still funky organization with the form/setup -->
    
    <form id="form1" runat="server">
        <script src="https://js.braintreegateway.com/web/dropin/1.0.2/js/dropin.min.js"></script>
        <asp:HiddenField ID="inpClientToken" runat="server" />
        <asp:Label ID="lblInfo" runat="server"></asp:Label>
         <div id="dropin-container"> </div>
        <asp:HiddenField ID="inpPaymentMethodNonce" runat="server" />
        <asp:Button ID="btnSubmit" Text="Submit Payment" Enabled="false" UseSubmitBehavior="false" runat="server" OnClick="btnSubmit_OnClick" />
            
  
            
             <script>
             var form = document.querySelector('<%= this.Form.ClientID %>');
             var submitButton = document.querySelector('#<%= btnSubmit.ClientID %>');

    braintree.dropin.create({
      authorization: '<%= this.inpClientToken.Value %>',
             selector: '#dropin-container'
    }, function (createErr, instance) {
        submitButton.addEventListener('click', function () {
            console.log("button clicked");
        instance.requestPaymentMethod(function (requestPaymentMethodErr, payload) {
          // Submit payload.nonce to your server
            window.alert(payload.nonce);
            document.querySelector('input[id="<%= inpPaymentMethodNonce.ClientID %>"]').value = payload.nonce;

            <%= this.ClientScript.GetPostBackEventReference(new PostBackOptions(this.btnSubmit)) %>;
            });
        });

                 instance.on('paymentMethodRequestable', function (event) {
                     submitButton.removeAttribute("disabled");
                 });
    });
  </script>
      
   
    </form>
</body>
</html>
