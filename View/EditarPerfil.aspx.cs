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
    public partial class EditarPerfil : System.Web.UI.Page
    {
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        Usuario usuario = null;

        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuLog = (Usuario)Session["usuarioLogado"];
            if (usuLog == null)
            {
                Server.Transfer("Login.aspx?r=EditarPerfil.aspx", true);
            }

            String id = Request.QueryString["id"];
            if (id == null)
            {
                usuario = usuarioDAO.getById(((Usuario)Session["usuarioLogado"]).Id);
            }
            else {
                AutoridadeDAO autDAO = new AutoridadeDAO();
                if (usuLog.Autoridades.Contains<Autoridade>(autDAO.getAutoridadeById(4)))
                {
                    usuario = usuarioDAO.getById(Int32.Parse(id));
                }
                else {
                    Server.Transfer("Login.aspx?r=EditarPerfil.aspx", true);
                }
            }

            if (!Page.IsPostBack)
            {
                inpDescricao.Value = usuario.Descricao;
                inpEmail.Value = usuario.Email;
                inpUsername.Value = usuario.Username;

                AutoridadeDAO autDAO = new AutoridadeDAO();
                List<Autoridade> auts = autDAO.Listar();
                foreach (Autoridade a in auts) {
                    ListItem nli = new ListItem(a.Nome, a.Id.ToString());
                    if (usuario.Autoridades.Contains<Autoridade>(a)) nli.Selected = true;
                    //nli.Attributes.CssStyle();
                    cblAutoridades.Items.Add(nli);
                }

            }
        }

        protected void Page_PreInit(object sender, EventArgs e)
        {
            if (Request.Cookies["thm"] != null)
                Page.Theme = Request.Cookies["thm"].Value.ToString();
            else
                Page.Theme = "TemaLaranja";
        }

        protected void btSalvar_Click(object sender, EventArgs e)
        {
            if (inpSenha.Value == "") 
            {
                inpSenha.Value = ((Usuario)Session["usuarioLogado"]).Senha;
            }

            usuario.Descricao = inpDescricao.Value;
            usuario.Email = inpEmail.Value;
            usuario.Senha = inpSenha.Value;
            usuario.Username = inpUsername.Value;
            usuario.ImageUrl = uploadImg.HasFile ? uploadImg.FileName : "defaultUsu.png";

            AutoridadeDAO autDAO = new AutoridadeDAO();

            Autoridade a;
            foreach(ListItem l in cblAutoridades.Items){
                a = autDAO.getAutoridadeById(Int32.Parse(l.Value));
                if (l.Selected && !usuario.Autoridades.Contains<Autoridade>(a))
                {
                    autDAO.AddToUsuario(a, usuario);
                }
                else if (!l.Selected && usuario.Autoridades.Contains<Autoridade>(a))
                {
                    autDAO.DeleteFromUsuario(a, usuario);
                }
            }

            if (uploadImg.HasFile)
            {
                uploadImg.SaveAs(Server.MapPath("../images/" + uploadImg.FileName));
            }
            else { 
                
            }

            usuarioDAO.Editar(usuario);

            Session["usuarioLogado"] = usuarioDAO.getById(Convert.ToInt32(Session["idUsuarioLogado"]));
            Response.Redirect("VerPerfil.aspx?id="+usuario.Id);
        }

    }
}