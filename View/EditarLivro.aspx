<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="EditarLivro.aspx.cs" Inherits="Livraria.View.EditarLivro" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Editar livro</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Editar livro</h2>

    <div class="form_padrao">
        <p>
            <label for="inpTitulo">Título:</label><input type="text" name="inpTitulo" id="inpTitulo" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="inpTitulo"></asp:RequiredFieldValidator></p>

        <p>
            <label for="inpAutor">Autor:</label><input type="text" name="inpAutor" id="inpAutor" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="inpAutor"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpCategoria">Categoria:</label>
            <select type="text" name="inpCategoria" id="inpCategoria" runat="server" required="required"></select>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ErrorMessage="*" ControlToValidate="inpCategoria"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpEdicao">Edição:</label><input type="text" name="inpEdicao" id="inpEdicao" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="inpEdicao"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ErrorMessage="Somente números permitidos." Type="Integer" MaximumValue="20000" MinimumValue="1" ControlToValidate="inpEdicao"></asp:RangeValidator>
        </p>

        <p>
            <label for="inpIdioma">Idioma:</label><input type="text" name="inpIdioma" id="inpIdioma" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ErrorMessage="*" ControlToValidate="inpIdioma"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpAno">Ano:</label><input type="text" name="inpAno" id="inpAno" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="inpAno"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="Somente números permitidos." Type="Integer" MaximumValue="20000" MinimumValue="1" ControlToValidate="inpAno"></asp:RangeValidator>
        </p>

        <p>
            <label for="inpPaginas">Páginas:</label><input type="text" name="inpPaginas" id="inpPaginas" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="inpPaginas"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator3" runat="server" ErrorMessage="Somente números permitidos." Type="Integer" MaximumValue="20000" MinimumValue="1" ControlToValidate="inpPaginas"></asp:RangeValidator>
        </p>

        <p>
            <label for="inpDescricao">Descrição:</label><textarea name="inpDescricao" id="inpDescricao" runat="server" required="required"></textarea>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="*" ControlToValidate="inpDescricao"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpISBN">ISBN:</label><input type="text" name="inpISBN" id="inpISBN" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ErrorMessage="*" ControlToValidate="inpISBN"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpPreco">Preço:</label><input type="text" name="inpPreco" id="inpPreco" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="*" ControlToValidate="inpPreco"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Somente números permitidos." Type="Double" MaximumValue="20000" MinimumValue="1" ControlToValidate="inpPreco"></asp:RangeValidator>        
        </p>

        <p>
            <label for="inpQuantidade">Quantidade:</label><input type="text" name="inpQuantidade" id="inpQuantidade" runat="server" required="required"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="*" ControlToValidate="inpQuantidade"></asp:RequiredFieldValidator>
            <asp:RangeValidator ID="RangeValidator5" runat="server" ErrorMessage="Somente números permitidos." Type="Integer" MaximumValue="20000" MinimumValue="1" ControlToValidate="inpQuantidade"></asp:RangeValidator>        
        </p>

        <p>
            <label for="uploadImg">Imagem:</label>
            <asp:FileUpload ID="uploadImg" runat="server" />
        </p>

        <p>
            <asp:Button class="btForm" ID="btSalvar" runat="server" Text="Salvar" 
                onclick="btSalvar_Click" />
            <button type="reset" class="btForm">Limpar</button>
        </p>
    </div>

    <asp:SqlDataSource ID="dsLivraria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT * FROM [livro] WHERE ([id] = @id)" 
        DeleteCommand="DELETE FROM [livro] WHERE [id] = @original_id" 
        InsertCommand="INSERT INTO [livro] ([isbn], [paginas], [edicao], [idioma], [titulo], [autor], [ano], [preco], [quantidade], [descricao], [idCategoria], [idUsuario], [imageurl]) VALUES (@isbn, @paginas, @edicao, @idioma, @titulo, @autor, @ano, @preco, @quantidade, @descricao, @idCategoria, @idUsuario, @imageurl)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [livro] SET [isbn] = @isbn, [paginas] = @paginas, [edicao] = @edicao, [idioma] = @idioma, [titulo] = @titulo, [autor] = @autor, [ano] = @ano, [preco] = @preco, [quantidade] = @quantidade, [descricao] = @descricao, [idCategoria] = @idCategoria, [idUsuario] = @idUsuario, [imageurl] = @imageurl WHERE [id] = @original_id">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="isbn" Type="String" />
            <asp:Parameter Name="paginas" Type="Int32" />
            <asp:Parameter Name="edicao" Type="Int32" />
            <asp:Parameter Name="idioma" Type="String" />
            <asp:Parameter Name="titulo" Type="String" />
            <asp:Parameter Name="autor" Type="String" />
            <asp:Parameter Name="ano" Type="Int32" />
            <asp:Parameter Name="preco" Type="Decimal" />
            <asp:Parameter Name="quantidade" Type="Int32" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="idCategoria" Type="Int32" />
            <asp:Parameter Name="idUsuario" Type="Int32" />
            <asp:Parameter Name="imageurl" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="id" QueryStringField="id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="isbn" Type="String" />
            <asp:Parameter Name="paginas" Type="Int32" />
            <asp:Parameter Name="edicao" Type="Int32" />
            <asp:Parameter Name="idioma" Type="String" />
            <asp:Parameter Name="titulo" Type="String" />
            <asp:Parameter Name="autor" Type="String" />
            <asp:Parameter Name="ano" Type="Int32" />
            <asp:Parameter Name="preco" Type="Decimal" />
            <asp:Parameter Name="quantidade" Type="Int32" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="idCategoria" Type="Int32" />
            <asp:Parameter Name="idUsuario" Type="Int32" />
            <asp:Parameter Name="imageurl" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsCategoria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT * FROM [categoria]"></asp:SqlDataSource>


</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="Admin" runat="server" />

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
</asp:Content>