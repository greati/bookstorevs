<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="VerPerfil.aspx.cs" Inherits="Livraria.View.VerPerfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Ver perfil</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <%
        Livraria.DAL.UsuarioDAO usuarioDAO = new Livraria.DAL.UsuarioDAO();
        Livraria.Model.Usuario usuario = usuarioDAO.getById(Convert.ToInt32(Request.QueryString.Get("id")));

        if (usuario == null) Response.Redirect("GerenciarLivros.aspx");   
    %>

    
    <h2 class="page-title">Perfil de <%= usuario.Username %></h2>


    <img id="avatarPerfil" src="../images/<%= usuario.ImageUrl %>" />

    <table id="detalhesPerfil">
        <tr>
            <th>Username</th>
            <td><%= usuario.Username %></td>
        </tr>
        <tr>
            <th>E-mail</th>
            <td><%= usuario.Email %></td>
        </tr>
        <tr>
            <th>Usuário desde</th>
            <td><%= usuario.DataCadastro.ToString() %></td>
        </tr>
    </table>

    <asp:GridView ID="gvLivrosUsuario" runat="server" AllowPaging="True" 
        AllowSorting="True" AutoGenerateColumns="False" CssClass="tabela_padrao livrosUsuario" 
        DataSourceID="dsLivros">
        <Columns>
            <asp:TemplateField SortExpression="imageurl">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("imageurl") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("imageurl", "../images/{0}") %>' Height="60px" Width="40px"/>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:HyperLinkField DataNavigateUrlFields="id" 
                DataNavigateUrlFormatString="MostrarLivro.aspx?id={0}" DataTextField="titulo" 
                HeaderText="Título" />
            <asp:BoundField DataField="nome" HeaderText="Categoria" SortExpression="nome" />
            <asp:BoundField DataField="autor" HeaderText="Autor" SortExpression="autor" />
            <asp:BoundField DataField="preco" HeaderText="Preço" SortExpression="preco" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" 
                SortExpression="quantidade" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="dsLivros" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT livro.titulo, livro.autor, livro.preco, livro.quantidade, livro.imageurl, categoria.nome, livro.id FROM livro INNER JOIN categoria ON livro.idCategoria = categoria.id WHERE (livro.idUsuario = @idUsuario)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="idUsuario" 
                QueryStringField="id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="Admin" runat="server" />
		
        <% if (Session["usuarioLogado"] != null)
           {
               if (Request.QueryString["id"] == Session["idUsuarioLogado"].ToString())
               {       
        %>
		        <nav id="navCategorias" class="widget">
			        <h2>Painel do usuário</h2>
			        <ul>
			            <li><a href="InserirLivros.aspx">Cadastrar livro</a></li>
                        <li><a href="GerenciarLivros.aspx">Meus livros</a></li>
                        <li><a href="VerPerfil.aspx">Ver perfil</a></li>
                        <li><a href="EditarPerfil.aspx">Editar perfil</a></li>
                        <% Livraria.Model.Usuario usuario = (Livraria.Model.Usuario) Session["usuarioLogado"]; %>
                        <% if (usuario.Autoridades.Contains<Livraria.Model.Autoridade>(new Livraria.Model.Autoridade { Id = 3 })) {%>
                            <li><a href="GerenciarCategorias.aspx">Gerenciar categorias</a></li>
                        <% } %>

                        <% if (usuario.Autoridades.Contains<Livraria.Model.Autoridade>(new Livraria.Model.Autoridade { Id = 4 })) {%>
                            <li><a href="GerenciarUsuarios.aspx">Gerenciar usuários</a></li>
                        <% } %>
                
			        </ul>
		        </nav>

        <%  }
          }%>

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