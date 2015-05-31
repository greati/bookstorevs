<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="ConsultarAcervo.aspx.cs" Inherits="Livraria.View.ConsultarAcervo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Consultar acervo</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">O Acervo</h2>

    <span class="onde_estou">ESCOLHA A CATEGORIA</span>
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" 
        DataSourceID="SqlDataSource1" DataTextField="nome" DataValueField="id" 
        CssClass="masterDetailsCb" OnSelectedIndexChanged="SelectedChanged_Evento">
    </asp:DropDownList>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT * FROM [categoria] ORDER BY [nome]">
    </asp:SqlDataSource>

    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
        DataKeyNames="id" DataSourceID="dsLivros" CssClass="tabela_padrao" 
        AllowPaging="True" EmptyDataText="Não foram encontrados resultados.">
        <Columns>
            <asp:TemplateField SortExpression="imageurl">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("imageurl") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" Height="60px" 
                        ImageUrl='<%# Eval("imageurl", "../images/{0}") %>' Width="40px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="MostrarLivro.aspx?id={0}" DataTextField="titulo" 
                HeaderText="Título" />
            <asp:BoundField DataField="edicao" HeaderText="Edição" 
                SortExpression="edicao" />
            <asp:BoundField DataField="idioma" HeaderText="Idioma" 
                SortExpression="idioma" />
            <asp:BoundField DataField="autor" HeaderText="Autor" 
                SortExpression="autor" />
            <asp:BoundField DataField="preco" HeaderText="Preço" 
                SortExpression="preco" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" 
                SortExpression="quantidade" />
            <asp:BoundField DataField="username" HeaderText="Proprietário" 
                SortExpression="idUsuario" />
            <asp:BoundField DataField="nome" HeaderText="Categoria" SortExpression="nome" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="dsLivros" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        
        SelectCommand="SELECT livro.id, livro.isbn, livro.paginas, livro.edicao, livro.idioma, livro.titulo, livro.autor, livro.ano, livro.preco, livro.quantidade, livro.descricao, livro.idCategoria, livro.idUsuario, livro.imageurl, categoria.nome, usuario.username FROM livro INNER JOIN categoria ON livro.idCategoria = categoria.id INNER JOIN usuario ON livro.idUsuario = usuario.id WHERE (livro.idCategoria = @idCategoria)">
        <SelectParameters>
            <asp:ControlParameter ControlID="DropDownList1" Name="idCategoria" 
                PropertyName="SelectedValue" Type="Int32" />
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