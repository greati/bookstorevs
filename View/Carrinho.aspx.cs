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
    public partial class Carrinho : System.Web.UI.Page
    {

        private CarrinhoDAO carrinhoDAO;
        private LivroDAO livroDAO;

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            // listagem de categorias
            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());
            
            // verificando a existência de carrinho
            carrinhoDAO = new CarrinhoDAO();
            HttpCookie idCarrinhoCookie = Request.Cookies["idCarrinho"];

            if(idCarrinhoCookie == null){
                idCarrinhoCookie = new HttpCookie("idCarrinho",carrinhoDAO.addCarrinho().ToString());
                Response.Cookies.Add(idCarrinhoCookie);
            }

            Livraria.Model.Carrinho carrinho = carrinhoDAO.getCarrinhoById(Convert.ToInt32(idCarrinhoCookie.Value.ToString()));

            // pediu para adicionar um novo livro ao carrinho?
            livroDAO = new LivroDAO();
            string idAddLivro = Request.QueryString.Get("add");
            if (idAddLivro != null)
            {
                carrinhoDAO.addLivro(carrinho, livroDAO.getById(Convert.ToInt32(idAddLivro)));
                carrinho = carrinhoDAO.getCarrinhoById(Convert.ToInt32(idCarrinhoCookie.Value.ToString()));
                HttpContext.Current.Items.Add("Carrinho", carrinho);
                Response.Redirect("Carrinho.aspx");
            }
            
            HttpContext.Current.Items.Add("Carrinho", carrinho);
        }
    }
}