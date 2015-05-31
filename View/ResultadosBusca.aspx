<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="ResultadosBusca.aspx.cs" Inherits="Livraria.View.ResultadosBusca" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Busca</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Busca</h2>

    <% if (Request.QueryString["search"] != null)
       { %>
        <span class="onde_estou">RESULTADOS PARA "<%=Request.QueryString["search"].ToString()%>"</span>
    <% }
       else
       { %>
        <span class="onde_estou">DIGITE ALGO PARA BUSCAR.</span>
       <%} %>
    
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="dsLivros" CssClass="tabela_padrao" 
    AllowPaging="True" AllowSorting="True" EmptyDataText="Não foram encontrados resultados.">
        <Columns>
            <asp:TemplateField SortExpression="imageurl">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("imageurl") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("imageurl", "../images/{0}") %>' Height="60px" Width="40px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="MostrarLivro.aspx?id={0}" DataTextField="titulo" 
                HeaderText="Titulo" SortExpression="titulo" />
            <asp:BoundField DataField="edicao" HeaderText="Edição" 
                SortExpression="edicao" />
            <asp:BoundField DataField="idioma" HeaderText="Idioma" 
                SortExpression="idioma" />
            <asp:BoundField DataField="autor" HeaderText="Autor" SortExpression="autor" />
            <asp:BoundField DataField="preco" HeaderText="Preço" SortExpression="preco" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" 
                SortExpression="quantidade" />
            <asp:BoundField DataField="nome" HeaderText="Categoria" 
                SortExpression="idCategoria" />
            <asp:BoundField DataField="username" HeaderText="Proprietário" 
                SortExpression="idUsuario" />
        </Columns>
    </asp:GridView>


    <asp:SqlDataSource ID="dsLivros" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT livro.id, livro.isbn, livro.paginas, livro.edicao, livro.idioma, livro.titulo, livro.autor, livro.ano, livro.preco, livro.quantidade, livro.descricao, livro.idCategoria, livro.idUsuario, livro.imageurl, usuario.username, categoria.nome FROM livro INNER JOIN usuario ON livro.idUsuario = usuario.id INNER JOIN categoria ON livro.idCategoria = categoria.id WHERE (livro.titulo LIKE '%' + @titulo + '%')">
        <SelectParameters>
            <asp:QueryStringParameter Name="titulo" QueryStringField="search" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>


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