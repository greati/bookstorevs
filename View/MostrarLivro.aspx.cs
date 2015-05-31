using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.Model;
using Livraria.DAL;
using System.Data.Linq;

namespace Livraria.View
{
    public partial class MostrarLivro : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";

            CarrinhoDAO carrinhoDAO = new CarrinhoDAO();
            HttpCookie idCarrinhoCookie = Request.Cookies["idCarrinho"];

            if (idCarrinhoCookie == null)
            {
                idCarrinhoCookie = new HttpCookie("idCarrinho", carrinhoDAO.addCarrinho().ToString());
                Response.Cookies.Add(idCarrinhoCookie);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["id"] == null) Response.Redirect("ConsultarAcervo.aspx");

            LivroDAO livroDAO = new LivroDAO();

            String idLivro = Request.QueryString.Get("id").ToString();

            Livro livro = livroDAO.getById(Convert.ToInt32(idLivro));

            HttpContext.Current.Items.Add("Livro",livro);

            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());

            CarrinhoDAO carrinhoDAO = new CarrinhoDAO();
            Livraria.Model.Carrinho carrinho = carrinhoDAO.getCarrinhoById(Convert.ToInt32(Request.Cookies["idCarrinho"].Value.ToString()));
            bool temLivro = false;
            foreach (Livro l in carrinho.Livros){
                if (l.Id == livro.Id) { 
                    temLivro = true;
                    break;
                }
            }
            HttpContext.Current.Items.Add("temLivro",temLivro);
        }
    }
}