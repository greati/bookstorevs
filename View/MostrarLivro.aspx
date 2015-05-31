<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="MostrarLivro.aspx.cs" Inherits="Livraria.View.MostrarLivro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Mostrar livro</title>
    <script type="text/javascript" src="../js/funcoes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <% Livraria.Model.Livro livro = (Livraria.Model.Livro) HttpContext.Current.Items["Livro"]; %>
    
    <article class="livroCompleto">
    
	    <img class="img_livro" src="../images/<%= livro.ImageUrl %>" alt="Imagem do livro"/>
	    
        <div id="info_livro">
            <h1><%= livro.Titulo %></h1>

		    <div id="financeiro">
                <span class="preco"><span>R$</span><%= livro.Preco %></span>	
                <% bool temLivro = Convert.ToBoolean(HttpContext.Current.Items["temLivro"]); %>
                
                <% if (!temLivro)
                   { %>
                    <a class="bt_comprar" href="Carrinho.aspx?add=<%= livro.Id %>">Adicionar ao <br /><span>carrinho<span></a>
                <%}
                   else
                   { %> 
                <a class="bt_nao_comprar" href="#">PRODUTO JÁ NO<br /><span>CARRINHO<span></a>
                <%} %>  
            </div>
            <div id="pre_info">
                <br />
                <span>Oferecido por <%= livro.Proprietario.Username %></span><span class="separador">//</span>
                <span>Categoria: <%= livro.Categoria.Nome %></span><span class="separador">//</span>
                <span>Estoque: <%= livro.Quantidade %> unidades.</span>
            </div>

            <table id="detalhesLivro">
                <tr>
                    <th>Código</th>
                    <td><%= livro.Id %></td>
                </tr>
                <tr>
                    <th>Título</th>
                    <td><%= livro.Titulo %></td>
                </tr>
                <tr>
                    <th>Autor</th>
                    <td><%= livro.Autor %></td>
                </tr>
                <tr>
                    <th>Categoria</th>
                    <td><%= livro.Categoria.Nome %></td>
                </tr>
                <tr>
                    <th>Edição</th>
                    <td><%= livro.Edicao %></td>
                </tr>
                <tr>
                    <th>Idioma</th>
                    <td><%= livro.Idioma %></td>
                </tr>
                <tr>
                    <th>Ano</th>
                    <td><%= livro.Ano %></td>
                </tr>
                <tr>
                    <th>Páginas</th>
                    <td><%= livro.Paginas %></td>
                </tr>
                <tr>
                    <th>Descrição</th>
                    <td><%= livro.Descricao %></td>
                </tr>
                <tr>
                    <th>ISBN</th>
                    <td><%= livro.Isbn %></td>
                </tr>
            </table>
        </div>
    </article>


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