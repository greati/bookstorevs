using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.DAL;
using System.Data.Linq;
using Livraria.Model;
using System.Web.UI.HtmlControls;

namespace Livraria.View
{
    public partial class EditarLivro : System.Web.UI.Page
    {
        LivroDAO livroDAO = new LivroDAO();
        Livro livro = null;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // verifica login
            if(Session["usuarioLogado"]==null){
                Response.Redirect("Login.aspx?r=EditarLivro.aspx", true);
            }

            // verifica se a url está correta
            if (Request.QueryString.Get("id") == null){

                Response.Redirect("GerenciarLivros.aspx", true);

            } else {
                livro = livroDAO.getById(Convert.ToInt32(Request.QueryString.Get("id")));
                // se o livro não pertencer ao usuário
                if (livro.Proprietario.Id != Convert.ToInt32(Session["idUsuarioLogado"].ToString()))
                {
                    Response.Redirect("GerenciarLivros.aspx", true);
                }
            }

            if (!Page.IsPostBack)
            {
                CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
                //HtmlSelect inpCategoria = (HtmlSelect)FindControl("inpCategoria");
                inpCategoria.DataSource = categoriaDAO.Listar();
                inpCategoria.DataTextField = "Nome";
                inpCategoria.DataValueField = "Id";
                inpCategoria.DataBind();

                // se está tudo ok
                inpAno.Value = livro.Ano.ToString();
                inpAutor.Value = livro.Autor;
                inpCategoria.Value = livro.Categoria.Id.ToString();
                inpDescricao.Value = livro.Descricao;
                inpEdicao.Value = livro.Edicao.ToString();
                inpIdioma.Value = livro.Edicao.ToString();
                inpISBN.Value = livro.Isbn;
                inpPaginas.Value = livro.Paginas.ToString();
                inpPreco.Value = livro.Preco.ToString();
                inpQuantidade.Value = livro.Quantidade.ToString();
                inpTitulo.Value = livro.Titulo.ToString();
            }

        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            livro.Ano = Int32.Parse(inpAno.Value);
            livro.Autor = inpAutor.Value;
            livro.Categoria = new CategoriaLivro { Id = Int32.Parse(inpCategoria.Value) };
            livro.Descricao = inpDescricao.Value;
            livro.Edicao = Int32.Parse(inpEdicao.Value);
            livro.Idioma = inpIdioma.Value;
            livro.ImageUrl = uploadImg.HasFile ? uploadImg.FileName : livro.ImageUrl;
            livro.Isbn = inpISBN.Value;
            livro.Paginas = Int32.Parse(inpPaginas.Value);
            livro.Preco = Int32.Parse(inpPreco.Value);
            livro.Quantidade = Int32.Parse(inpQuantidade.Value);
            livro.Titulo = inpTitulo.Value;
            livro.Proprietario = new Usuario { Id = ((Usuario)Session["usuarioLogado"]).Id };

            //salvar o arquivo na pasta images
            if (uploadImg.HasFile)
            {
                uploadImg.SaveAs(Server.MapPath("../images/" + uploadImg.FileName));
            }

            livroDAO.Editar(livro);
            Response.Redirect("GerenciarLivros.aspx");
        }
    }
}