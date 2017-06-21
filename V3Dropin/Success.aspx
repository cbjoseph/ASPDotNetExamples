<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Success.aspx.cs" Inherits="Success" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
            <h1>Transaction information:</h1>
            <p>id: <%= ID %></p>
            <p>status: <%= Status %></p>
            <p>transaction type: <%= TransactionType %></p>
            <p>amount: <%= Amount %></p>
            <h1>Payment Info:</h1>
            <p>token: <%= Token %></p>
            <p>card type: <%= CardType %></p>
            <p>bin: <%= CardBin %></p>
            <p>expiration date: <%= ExpirationDate %></p>
       
    </div>
    </form>
</body>
</html>
