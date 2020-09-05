<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            font-size: large;
        }
        .auto-style2 {
            text-decoration: underline;
        }
        .auto-style3 {
            font-size: x-large;
        }
        .auto-style4 {
            text-decoration: underline;
            font-size: x-large;
        }
        .auto-style5 {
            width: 401px;
            text-align: center;
        }
        .auto-style6 {
            text-align: center;
        }
        .auto-style7 {
            width: 401px;
            text-align: center;
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div class="auto-style1">
    
        <span class="auto-style4">
    
        <strong>Bancsqo Dim-Dim Fácil</strong></span><br />
        <br />
        Digite o número da conta corrente:
        <asp:TextBox ID="txtNumContaCorrente" runat="server"></asp:TextBox>
&nbsp;<asp:Button ID="btnOK" runat="server" Text="OK" OnClick="btnOK_Click" style="height: 26px" />
        <br />
        <asp:SqlDataSource ID="SqlPesqConta" runat="server" ConnectionString="<%$ ConnectionStrings:dim_dim_facilConnectionString %>" ProviderName="<%$ ConnectionStrings:dim_dim_facilConnectionString.ProviderName %>" SelectCommand="SELECT id_conta, nome_cli, num_contacorrente, cpf_cli, saldo_contacorrente FROM contacorrente WHERE (num_contacorrente = @NUMCONTA)">
            <SelectParameters>
                <asp:Parameter Name="NUMCONTA" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblMensagem" runat="server"></asp:Label>
        <br />
        <strong>Seja bem vindo Sr.
            <asp:Label ID="lblNome" runat="server" Text=""></asp:Label>
            </strong>
            <br />
        <div style="border: thin solid #000000;">
        <span class="auto-style2"><em>Confira seus dados:</em></span><br />
            CPF:
            <asp:Label ID="lblCPF" runat="server" Text=""></asp:Label>
            <br />
            Saldo R$:
            <asp:Label ID="lblSaldo" runat="server" Text=""></asp:Label>
        <br /></div>
        <br />
        <table style="width:100%;">
            <tr>
                <td class="auto-style7"><em>Digite um valor e escolha uma função:</em></td>
                <td class="auto-style6"><strong><span class="auto-style3">Saldo Atualizado R$:
                    <asp:Label ID="lblSaldoFinal" runat="server" Text=""></asp:Label>
                    </span></strong></td>
            </tr>
            <tr>
                <td class="auto-style5">Digite o valor R$:
            <asp:TextBox ID="txtValor" runat="server"></asp:TextBox>
                </td>
                <td class="auto-style6" rowspan="2">
                    <asp:GridView ID="GridView1" runat="server" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" DataKeyNames="id_transacao">
                        <AlternatingRowStyle BackColor="#CCCCCC" />
                        <Columns>
                            <asp:BoundField DataField="id_transacao" HeaderText="Código" InsertVisible="False" ReadOnly="True" SortExpression="id_transacao" />
                            <asp:BoundField DataField="tipo_transacao" HeaderText="Tipo da transacao" SortExpression="tipo_transacao" />
                            <asp:BoundField DataField="valor_transacao" DataFormatString="{0:c}" HeaderText="Valor da transacao" SortExpression="valor_transacao" />
                            <asp:BoundField DataField="num_contacorrente" HeaderText="Nº da contacorrente" SortExpression="num_contacorrente" />
                        </Columns>
                        <FooterStyle BackColor="#CCCCCC" />
                        <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlTabela" runat="server" ConnectionString="<%$ ConnectionStrings:dim_dim_facilConnectionString %>" ProviderName="<%$ ConnectionStrings:dim_dim_facilConnectionString.ProviderName %>" SelectCommand="SELECT transacoes.id_transacao, transacoes.tipo_transacao, transacoes.valor_transacao, contacorrente.num_contacorrente FROM transacoes INNER JOIN contacorrente ON transacoes.id_conta = contacorrente.id_conta"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style5">
            <asp:Button ID="btnDepositar" runat="server" Text="Depositar" OnClick="btnDepositar_Click" />
&nbsp;<asp:Button ID="btnSacar" runat="server" Text="Sacar" OnClick="btnSacar_Click" style="height: 26px" />
                </td>
            </tr>
        </table>
        <asp:SqlDataSource ID="SqlUpdateSaldo" runat="server" ConnectionString="<%$ ConnectionStrings:dim_dim_facilConnectionString %>" ProviderName="<%$ ConnectionStrings:dim_dim_facilConnectionString.ProviderName %>" SelectCommand="SELECT * FROM contacorrente" UpdateCommand="UPDATE contacorrente SET saldo_contacorrente = @NOVOSALDO WHERE (id_conta = @CONTA)">
            <UpdateParameters>
                <asp:Parameter Name="NOVOSALDO" />
                <asp:SessionParameter Name="CONTA" SessionField="idconta" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlCadastrarTransacao" runat="server" ConnectionString="<%$ ConnectionStrings:dim_dim_facilConnectionString %>" InsertCommand="INSERT INTO transacoes(tipo_transacao, valor_transacao, id_conta) VALUES (@TIPO, @VALORTRANS, @IDCONTA)" ProviderName="<%$ ConnectionStrings:dim_dim_facilConnectionString.ProviderName %>" SelectCommand="SELECT * FROM transacoes">
            <InsertParameters>
                <asp:Parameter Name="VALORTRANS" />
                <asp:Parameter Name="TIPO" />
                <asp:SessionParameter Name="IDCONTA" SessionField="idconta" />
            </InsertParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblMensagem2" runat="server"></asp:Label>
        <br />
        <br />
        <br />
        
    
    </div>
    </form>
</body>
</html>
