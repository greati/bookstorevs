using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.DAL;

namespace Livraria.View
{
    public partial class VerPerfil : System.Web.UI.Page
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
            string id = Request.QueryString["id"];

            if (id == null && Session["usuarioLogado"]==null) {
                Response.Redirect("Login.aspx?r=" + "VerPerfil.aspx", true);
            }else if(id==null){
                Response.Redirect("~/view/VerPerfil.aspx?id="+Session["idUsuarioLogado"].ToString());
            }

            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());
        }
    }
}