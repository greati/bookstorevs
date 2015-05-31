<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Livraria.View.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Login</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Login</h2>

    <form id="loginForm">
        <asp:Login ID="Login1" runat="server" OnAuthenticate="ValidarLogin" CssClass="form_login" LoginButtonType="Button" LoginButtonText="Entrar" UserNameLabelText="Usuário" PasswordLabelText="Senha" FailureText="Dados incorretos. Tente de novo, por favor." RememberMeText="Lembre-me" TitleText="Logar" TitleTextStyle-CssClass="texto_logar">
        </asp:Login>
    </form> 

    <div id="convite_cadastro">
        <h3>Não possui uma conta? Deixa disso e vem!</h3>
        <p>Cadastre-se gratuitamente para poder vender seus livros!</p>
        <a href="InserirUsuario.aspx">Cadastro</a>
    </div>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="Admin" runat="server" />

		<nav id="navCategorias" class="widget">
			<h2>Categorias</h2>
			<ul>
            <% List<Livraria.Model.CategoriaLivro> categorias = (List<Livraria.Model.CategoriaLivro>)HttpContext.Current.Items["categorias"]; %>
                <%foreach (Livraria.Model.CategoriaLivro categoria in categorias)
                  {%>
				    <li><a href="ConsultarAcervo.aspx?cat=<%= categoria.Id %>"><%=categoria.Nome %></a></li>
                <%}%>
			</ul>
		</nav>

</asp:Content>