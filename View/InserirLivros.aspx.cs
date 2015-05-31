using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.Model;
using Livraria.DAL;
using System.Web.UI.HtmlControls;

namespace Livraria.View
{
    public partial class InserirLivros : System.Web.UI.Page
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
                Response.Redirect("Login.aspx?r="+"InserirLivros.aspx", true);
            }

            // popular categorias
            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();

            if (!Page.IsPostBack)
            {

                inpCategoria.DataSource = categoriaDAO.Listar();
                inpCategoria.DataTextField = "Nome";
                inpCategoria.DataValueField = "Id";
                inpCategoria.DataBind();
            }

        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            LivroDAO livroDAO = new LivroDAO();
            CategoriaLivroDAO catDAO = new CategoriaLivroDAO();

            Livro livro = new Livro
            {
                Ano = Int32.Parse(inpAno.Value),
                Autor = inpAutor.Value,
                Categoria = catDAO.getById(Int32.Parse(inpCategoria.Value)),
                Descricao = inpDescricao.Value,
                Edicao = Int32.Parse(inpEdicao.Value),
                Idioma = inpIdioma.Value,
                ImageUrl = uploadImg.HasFile ? uploadImg.FileName: "default.png",
                Isbn = inpISBN.Value,
                Paginas = Int32.Parse(inpPaginas.Value),
                Preco = Int32.Parse(inpPreco.Value),
                Quantidade = Int32.Parse(inpQuantidade.Value),
                Titulo = inpTitulo.Value,
               
                Proprietario = new Usuario { Id = ((Usuario)Session["usuarioLogado"]).Id }
            };

            //salvar o arquivo na pasta images
            if (uploadImg.HasFile)
            {
                uploadImg.SaveAs(Server.MapPath("../images/" + uploadImg.FileName));
            }

            livroDAO.Inserir(livro);
            Response.Redirect("GerenciarLivros.aspx");
        }
    }
}