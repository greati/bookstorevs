using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.DAL;
using Livraria.Model;

namespace Livraria.View
{
    public partial class GerenciarLivros1 : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["usuarioLogado"] == null)
            {
                HttpContext.Current.Items.Add("lastPage", "GerenciarLivros.aspx");
                Response.Redirect("Login.aspx?r=GerenciarLivros.aspx", true);
            }

            if (((GridView)GridView1).SelectedRow != null){
                ((Button)btEditarDetalhes).CssClass = "";
                ((Button)btEditarDetalhes).Enabled = true;

                ((Button)btExibirDetalhes).CssClass = "";
                ((Button)btExibirDetalhes).Enabled = true;
            }
        }

        protected void btEditarDetalhes_Click(object sender, EventArgs e)
        {
            string idLivro = ((GridView)GridView1).DataKeys[((GridView)GridView1).SelectedIndex]["id"].ToString();

            Response.Redirect("~/view/EditarLivro.aspx?id="+idLivro);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string idLivro = ((GridView)GridView1).DataKeys[((GridView)GridView1).SelectedIndex]["id"].ToString();

            Response.Redirect("~/view/MostrarLivro.aspx?id=" + idLivro);
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((Button)btEditarDetalhes).CssClass = "";
            ((Button)btEditarDetalhes).Enabled = true;

            ((Button)btExibirDetalhes).CssClass = "";
            ((Button)btExibirDetalhes).Enabled = true;
        }

        protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            //para não dar ArrayOutOfBounds exception quando deletar uma row selecionada
            GridView1.SelectedIndex = -1;
        }

        protected void OnRowDeleting_Evento(object sender, GridViewDeleteEventArgs e) {
            if (Request.Cookies["idCarrinho"] != null)
            {
                int idLivro = Convert.ToInt32(GridView1.DataKeys[e.RowIndex].Value);

                LivroDAO livroDAO = new LivroDAO();
                Livro livro = livroDAO.getById(idLivro);

                CarrinhoDAO carDAO = new CarrinhoDAO();
                foreach (Model.Carrinho c in livro.Carrinhos)
                {
                    carDAO.deleteLivro(c.Id, livro.Id);
                }

            }
        }
    }
}