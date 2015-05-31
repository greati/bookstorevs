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
    public partial class GerenciarCategorias : System.Web.UI.Page
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
            AutoridadeDAO autDAO = new AutoridadeDAO();
            Usuario usuLogado = (Usuario)Session["usuarioLogado"];
            // verifica login
            if (usuLogado == null)
            {
                Response.Redirect("Login.aspx?r=GerenciarCategorias.aspx", true);
            }
            else if (!usuLogado.Autoridades.Contains<Autoridade>(autDAO.getAutoridadeById(3)))
            {
                Response.Redirect("Login.aspx?r=GerenciarCategorias.aspx", true);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((Button)btExibirDetalhes).CssClass = "";
            ((Button)btExibirDetalhes).Enabled = true;

            inpNome.Value = ((GridView)GridView1).SelectedRow.Cells[1].Text.ToString();
            idEditar.Value = ((GridView)GridView1).DataKeys[((GridView)GridView1).SelectedIndex]["id"].ToString();
            btSalvar.Text = "Editar";
        }

        protected void GridView1_RowDeleted1(object sender, GridViewDeletedEventArgs e)
        {
            //para não dar ArrayOutOfBounds exception quando deletar uma row selecionada
            GridView1.SelectedIndex = -1;
        }

        protected void btExcluir_click(object sender, EventArgs e) {
            CategoriaLivroDAO catDAO = new CategoriaLivroDAO();
            LivroDAO livDAO = new LivroDAO();
            String id = idEditar.Value;
            if(id!="-1"){
                CategoriaLivro cat = catDAO.getById(Int32.Parse(id));

                foreach (Livro l in cat.Livros) {
                    
                    livDAO.Excluir(l);
                }

                catDAO.Excluir(catDAO.getById(Int32.Parse(id)));
                Response.Redirect("GerenciarCategorias.aspx", true);
            }
        }

        protected void btNovo_click(object sender, EventArgs e) {
            idEditar.Value = "-1";
            GridView1.SelectedIndex = -1;
            inpNome.Value = "";
            btSalvar.Text = "Criar";
        }

        protected void btSalvar_click(object sender, EventArgs e)
        {
            CategoriaLivroDAO catDAO = new CategoriaLivroDAO();
            String id = idEditar.Value;
            if (id != "-1")
            {
                catDAO.Editar(new CategoriaLivro { Id = Int32.Parse(id), Nome = inpNome.Value });
            }
            else {
                catDAO.Inserir(new CategoriaLivro {Nome = inpNome.Value});
            }
            Response.Redirect("GerenciarCategorias.aspx", true);
        }

    }
}