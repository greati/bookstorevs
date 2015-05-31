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
    public partial class Index : System.Web.UI.Page
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
            LivroDAO livroDAO = new LivroDAO();
            HttpContext.Current.Items.Add("recentes", livroDAO.Listar(8));

            UsuarioDAO usuarioDAO = new UsuarioDAO();
            HttpContext.Current.Items.Add("usuariosRecentes", usuarioDAO.getRecentes(5));

            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());
        }
    }
}