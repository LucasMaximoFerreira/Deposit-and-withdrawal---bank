using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class _Default : System.Web.UI.Page 
{
    Criptografia cripto = new Criptografia("ETEP");
    String tipo;
    double saldo, valor, novoSaldo;
    DataTable listaDescriptografada = new DataTable();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnOK_Click(object sender, EventArgs e)
    {
        DataView contaPesq;

        SqlPesqConta.SelectParameters["NUMCONTA"].DefaultValue = cripto.Encrypt(txtNumContaCorrente.Text);

        contaPesq = (DataView)SqlPesqConta.Select(DataSourceSelectArguments.Empty);

        if(contaPesq.Table.Rows.Count > 0)
        {
            Session["idconta"] = contaPesq.Table.Rows[0]["id_conta"].ToString();
            txtNumContaCorrente.Text = cripto.Decrypt(contaPesq.Table.Rows[0]["num_contacorrente"].ToString());
            lblNome.Text = cripto.Decrypt(contaPesq.Table.Rows[0]["nome_cli"].ToString());
            lblCPF.Text = cripto.Decrypt(contaPesq.Table.Rows[0]["cpf_cli"].ToString());
            double saldo;
            saldo = Convert.ToDouble(cripto.Decrypt(contaPesq.Table.Rows[0]["saldo_contacorrente"].ToString()).Replace('.', ','));
            lblSaldo.Text = saldo.ToString();

            lblMensagem.Text = "";
        }
        else
        {
            lblMensagem.Text = "Dados não cadastrados";

        }
    }

    protected void btnSacar_Click(object sender, EventArgs e)
    {
        
        saldo = Convert.ToDouble(lblSaldo.Text);
        valor = Convert.ToDouble(txtValor.Text);

        novoSaldo = saldo - valor;

        lblSaldoFinal.Text = Convert.ToString(novoSaldo);
        SqlUpdateSaldo.UpdateParameters["NOVOSALDO"].DefaultValue = cripto.Encrypt(novoSaldo.ToString());
        SqlUpdateSaldo.Update();

        tipo = "SAQUE";

        SqlCadastrarTransacao.InsertParameters["VALORTRANS"].DefaultValue = cripto.Encrypt(valor.ToString().Replace(',', '.'));
        SqlCadastrarTransacao.InsertParameters["TIPO"].DefaultValue = cripto.Encrypt(tipo);

        SqlCadastrarTransacao.Insert();
        lblMensagem2.Text = "Dados Atualizados com sucesso.";
        carregarGrid();

    }

    protected void btnDepositar_Click(object sender, EventArgs e)
    {
        saldo = Convert.ToDouble(lblSaldo.Text);
        valor = Convert.ToDouble(txtValor.Text);

        novoSaldo = saldo + valor;

        lblSaldoFinal.Text = Convert.ToString(novoSaldo);
        SqlUpdateSaldo.UpdateParameters["NOVOSALDO"].DefaultValue = cripto.Encrypt(novoSaldo.ToString());
        SqlUpdateSaldo.Update();

        tipo = "DEPOSITO";

        SqlCadastrarTransacao.InsertParameters["VALORTRANS"].DefaultValue = cripto.Encrypt(valor.ToString().Replace(',', '.'));
        SqlCadastrarTransacao.InsertParameters["TIPO"].DefaultValue = cripto.Encrypt(tipo);

        SqlCadastrarTransacao.Insert();
        lblMensagem2.Text = "Dados Atualizados com sucesso.";
        carregarGrid();

    }
    private void carregarGrid()
    {
        listaDescriptografada.Columns.Add("id_transacao", typeof(int));
        listaDescriptografada.Columns.Add("tipo_transacao", typeof(String));
        listaDescriptografada.Columns.Add("valor_transacao", typeof(double));
        listaDescriptografada.Columns.Add("num_contacorrente", typeof(String));


        DataView listaTransacoes;
        listaTransacoes = (DataView)SqlTabela.Select(DataSourceSelectArguments.Empty);

        for (int i = 0; i < listaTransacoes.Table.Rows.Count; i++)
        {
            DataRow linha = listaDescriptografada.NewRow();

            linha["id_transacao"] = listaTransacoes.Table.Rows[i]["id_transacao"].ToString();
            linha["tipo_transacao"] = cripto.Decrypt(listaTransacoes.Table.Rows[i]["tipo_transacao"].ToString());
            linha["valor_transacao"] = cripto.Decrypt(listaTransacoes.Table.Rows[i]["valor_transacao"].ToString());
            linha["num_contacorrente"] = cripto.Decrypt(listaTransacoes.Table.Rows[i]["num_contacorrente"].ToString());



            listaDescriptografada.Rows.Add(linha);
        }
        GridView1.DataSource = listaDescriptografada;
        GridView1.DataBind();

        Session["listaDescriptografada"] = listaDescriptografada;
        

    }

}