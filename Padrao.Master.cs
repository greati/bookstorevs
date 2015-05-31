using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Linq;

namespace Livraria
{
    public partial class Padrao : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Logout_event(Object sender, EventArgs e)
        {
            Session["usuarioLogado"] = null;
            Session["idUsuarioLogado"] = null;
            Page.Response.Redirect(Page.Request.Url.ToString(), true);
        }

        protected void Buscar_Evento(Object sender, EventArgs e) {
            string busca = tbBusca.Text;
            Response.Redirect("ResultadosBusca.aspx?search="+busca);
        }

        protected void BtLaranja_Evento(Object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("thm");
            cookie.Value = "TemaLaranja";
            Response.Cookies.Add(cookie);
            Response.Redirect(HttpContext.Current.Request.Url.AbsolutePath + Request.Url.Query);
        }

        protected void BtPreto_Evento(Object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("thm");
            cookie.Value = "TemaPreto";
            Response.Cookies.Add(cookie);
            Response.Redirect(HttpContext.Current.Request.Url.AbsolutePath + Request.Url.Query);
        }

        protected void BtVerde_Evento(Object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("thm");
            cookie.Value = "TemaVerde";
            Response.Cookies.Add(cookie);
            Response.Redirect(HttpContext.Current.Request.Url.AbsolutePath + Request.Url.Query);
        }

        protected void BtAzul_Evento(Object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("thm");
            cookie.Value = "TemaAzul";
            Response.Cookies.Add(cookie);
            Response.Redirect(HttpContext.Current.Request.Url.AbsolutePath + Request.Url.Query);
        }
    }
}