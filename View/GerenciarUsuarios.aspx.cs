using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Livraria.Model;
using Livraria.DAL;

namespace Livraria.View
{
    public partial class GerenciarUsuarios : System.Web.UI.Page
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
            Usuario usuLog = (Usuario)Session["usuarioLogado"];
            AutoridadeDAO autDAO = new AutoridadeDAO();

            if (usuLog == null || !usuLog.Autoridades.Contains<Autoridade>(autDAO.getAutoridadeById(4)))
            {
                Response.Redirect("Login.aspx?r=GerenciarUsuarios.aspx", true);
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            ((Button)btEditarDetalhes).CssClass = "";
            ((Button)btEditarDetalhes).Enabled = true;

            ((Button)btExcluir).CssClass = "";
            ((Button)btExcluir).Enabled = true;

        }

        protected void GridView1_RowDeleted1(object sender, GridViewDeletedEventArgs e)
        {
            //para não dar ArrayOutOfBounds exception quando deletar uma row selecionada
            GridView1.SelectedIndex = -1;
        }

        protected void btExcluir_click(object sender, EventArgs e)
        {
            String id = ((GridView)GridView1).DataKeys[((GridView)GridView1).SelectedIndex]["id"].ToString();
            if(id != null){
                UsuarioDAO usuDAO = new UsuarioDAO();
                usuDAO.Excluir(usuDAO.getById(Int32.Parse(id)));
                Response.Redirect("GerenciarUsuarios.aspx");
            }
        }

        protected void btEditar_click(object sender, EventArgs e)
        {
            Response.Redirect("EditarPerfil.aspx?id=" + ((GridView)GridView1).DataKeys[((GridView)GridView1).SelectedIndex]["id"].ToString());
        }


    }
}