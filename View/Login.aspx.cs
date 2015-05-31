using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using System.Web.Security;
using Livraria.Model;
using Livraria.DAL;

namespace Livraria.View
{
    public partial class Login : System.Web.UI.Page
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

        protected void ValidarLogin(object sender, EventArgs e) {
            //query for the user

            UsuarioDAO usuDAO = new UsuarioDAO();
            Usuario u = usuDAO.Login(Login1.UserName, Login1.Password);

            if (u != null)
            {
                Session.Add("usuarioLogado", u);
                Session.Add("idUsuarioLogado", u.Id.ToString());

                string red = Request.QueryString.Get("r"); //page to redirect

                if (red != null)
                {
                    Response.Redirect(red);
                }
                else
                {
                    Response.Redirect("GerenciarLivros.aspx");
                }
            }
            else
            {
                Login1.FailureText = "Dados incorretos.";
            }
        }
    }
}