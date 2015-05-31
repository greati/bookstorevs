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
    public partial class InserirUsuario : System.Web.UI.Page
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
            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            UsuarioDAO usuarioDAO = new UsuarioDAO();

            DateTime myDate = DateTime.Now;
            string sqlFormattedDate = myDate.ToString("yyyy-MM-dd HH:mm:ss");

            Usuario usuario = new Usuario
            {
                DataCadastro = myDate,
                Email = inpEmail.Value,
                Senha = inpSenha.Value,
                Username = inpUsername.Value,
                ImageUrl = "defaultUsu.png"
            };

            usuarioDAO.Inserir(usuario);
            Response.Redirect("Login.aspx");
        }
    }
}