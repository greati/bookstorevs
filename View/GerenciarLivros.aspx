<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="GerenciarLivros.aspx.cs" Inherits="Livraria.View.GerenciarLivros1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Gerenciar livros</title>
    <script type="text/javascript" src="../js/funcoes.js"></script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Gerenciar livros</h2>

        <div class="tabela_gerenciar">
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="id" 
                DataSourceID="dsLivros" SelectedRowStyle-CssClass="gridSelected" 
                onselectedindexchanged="GridView1_SelectedIndexChanged" 
                onrowdeleted="GridView1_RowDeleted" OnRowDeleting="OnRowDeleting_Evento" EmptyDataText="Você não possui livros.">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                                CommandName="Update" Text="Atualizar" EnableTheming="True"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                CommandName="Cancel" Text="Cancelar" EnableTheming="True"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                                CommandName="Edit" Text="Editar" EnableTheming="True"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                                CommandName="Select" Text="Selecionar" EnableTheming="True"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" 
                                CommandName="Delete" onclientclick="return confirmarDelete()" Text="Excluir" EnableTheming="True"></asp:LinkButton>
                        </ItemTemplate>
                        <ControlStyle CssClass="controles_grid" />
                        <ItemStyle Width="150px" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Título" SortExpression="titulo">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("titulo") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ControlToValidate="TextBox1" ErrorMessage="*" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("titulo") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Autor" SortExpression="autor">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("autor") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="TextBox2" ErrorMessage="*" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("autor") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Categoria" SortExpression="nome">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="dsCategoria" 
                                DataTextField="nome" DataValueField="id" 
                                SelectedValue='<%# Bind("idCategoria") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("nome") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Quantidade" SortExpression="quantidade">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("quantidade") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="TextBox3" ErrorMessage="*" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("quantidade") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Preço" SortExpression="preco">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("preco") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="TextBox4" ErrorMessage="*" ForeColor="#CC0000"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("preco") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

<SelectedRowStyle CssClass="gridSelected"></SelectedRowStyle>
            </asp:GridView>

            <div id="controles_adicionais">
                <span class="onde_estou">
                    <% if (((GridView)GridView1).SelectedRow == null)
                       { %>
                        SELECIONE UM LIVRO
                    <%}
                       else
                       { %>
                        AÇÕES DISPONÍVEIS
                    <%} %>
                </span>
                <asp:Button ID="btEditarDetalhes" runat="server" Text="Editar detalhes" 
                    onclick="btEditarDetalhes_Click" CssClass="btDisabled" Enabled="False" />
                <asp:Button ID="btExibirDetalhes" runat="server" Text="Exibir livro" 
                    onclick="Button1_Click" CssClass="btDisabled" Enabled="False" />
            </div>

        </div>

        <asp:SqlDataSource ID="dsLivros" runat="server" 
            ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
            DeleteCommand="DELETE FROM livro WHERE (id = @id)" 
            InsertCommand="INSERT INTO [livro] ([isbn], [paginas], [edicao], [idioma], [titulo], [autor], [ano], [preco], [quantidade], [descricao], [idCategoria], [idUsuario], [imageurl]) VALUES (@isbn, @paginas, @edicao, @idioma, @titulo, @autor, @ano, @preco, @quantidade, @descricao, @idCategoria, @idUsuario, @imageurl)" 
            SelectCommand="SELECT livro.id, livro.isbn, livro.paginas, livro.edicao, livro.idioma, livro.titulo, livro.autor, livro.ano, livro.preco, livro.quantidade, livro.descricao, livro.idCategoria, livro.idUsuario, livro.imageurl, categoria.nome FROM livro INNER JOIN categoria ON livro.idCategoria = categoria.id WHERE (livro.idUsuario = @idUsuario)" 
            
            
            
            UpdateCommand="UPDATE [livro] SET [titulo] = @titulo, [autor] = @autor, [preco] = @preco, [quantidade] = @quantidade, [idCategoria] = @idCategoria WHERE [id] = @id">
            <DeleteParameters>
                <asp:Parameter Name="id" Type="Int32" />
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
                <asp:SessionParameter DefaultValue="0" Name="idUsuario" 
                    SessionField="idUsuarioLogado" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="titulo" Type="String" />
                <asp:Parameter Name="autor" Type="String" />
                <asp:Parameter Name="preco" Type="Decimal" />
                <asp:Parameter Name="quantidade" Type="Int32" />
                <asp:Parameter Name="idCategoria" Type="Int32" />
                <asp:Parameter Name="id" Type="Int32" />
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