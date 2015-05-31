<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="Livraria.View.Index" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Venda seus livros e compre outros!</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div id="index">
        <section id="indexUltimosLivros">
            <h3>Livros recentes</h3>

            <%List<Livraria.Model.Livro> recentes = (List<Livraria.Model.Livro>)HttpContext.Current.Items["recentes"]; %>
            <%foreach (Livraria.Model.Livro livro in recentes)
              {%>
                <article class="livroUltimosLivros">
                    <img src="../images/<%= livro.ImageUrl %>" />
                    <h4><a href="MostrarLivro.aspx?id=<%= livro.Id %>"><%= livro.Titulo %></a></h4>
                    <span class="autor"><%= livro.Autor %></span><br />
                    <span class="preco">R$<%= livro.Preco %></span>
                </article>        
            <%} %>
            <div class="clear"></div>
        </section>

        <section id="indexUsuariosRecentes">
            <h3>Novos usuários</h3>

            <% List<Livraria.Model.Usuario> usuariosRecentes = (List<Livraria.Model.Usuario>)HttpContext.Current.Items["usuariosRecentes"]; %>
            <table>
                <tr>
                    <th></th>
                    <th>username</th>
                    <th>desde</th>
                </tr>
                <%foreach (Livraria.Model.Usuario usuario in usuariosRecentes)
                  {%>
                    <tr>
                        <td><img src="../images/<%= usuario.ImageUrl %>" /></td>
                        <td class="username"><%= usuario.Username %></td>
                        <td class="username"><%= usuario.DataCadastro.ToString("dd/MM/yyyy") %></td>
                    </tr>        
                <%} %>
            </table>
        </section>

        <section id="registre">
            <h3>Registre-se!</h3>
            <p><br />Cadastrando-se, você poderá vender e comprar livros!</p><br /><br />
            <p>Já possui cadastro? Logue-se então!</p>
            <a href="InserirUsuario.aspx" class="btCadastro">Cadastro</a>
            <a href="Login.aspx" class="btCadastro">Logue-se</a>
        </section>

    </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="Admin" runat="server" />

		<nav id="navCategorias" class="widget">
			<h2>Categorias</h2>
			<ul>
                <% List<Livraria.Model.CategoriaLivro> categorias = (List<Livraria.Model.CategoriaLivro>)HttpContext.Current.Items["categorias"]; %>
                <%foreach (Livraria.Model.CategoriaLivro categoria in categorias){%>
				    <li><a href="ConsultarAcervo.aspx?cat=<%= categoria.Id %>"><%=categoria.Nome %></a></li>
                <%}%>
			</ul>
		</nav>
</asp:Content>