using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.DAL;
using System.Reflection;

namespace Livraria.View
{
    public partial class ConsultarAcervo : System.Web.UI.Page
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";
        }

        protected void SelectedChanged_Evento(object sender, System.EventArgs e){}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Web.HttpContext.Current.Request.HttpMethod == "GET" && Request.QueryString["cat"] != null)
            {
                int idCategoria = Convert.ToInt32(Request.QueryString["cat"].ToString());
                DropDownList1.SelectedValue = idCategoria.ToString();
            }

            CategoriaLivroDAO categoriaDAO = new CategoriaLivroDAO();
            HttpContext.Current.Items.Add("categorias", categoriaDAO.Listar());
        }

        protected void Titulo_click(Object sender, EventArgs e){}
    }
}