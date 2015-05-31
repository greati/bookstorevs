<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="Carrinho.aspx.cs" Inherits="Livraria.View.Carrinho" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Carrinho de compras</title>
    <script type="text/javascript" src="../js/funcoes.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Carrinho</h2>

    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" CssClass="tabela_padrao" 
        DataKeyNames="idCarrinho,idLivro" DataSourceID="dsCarrinhoProduto" EmptyDataText="O carrinho está vazio.">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" 
                        CommandName="Update" Text="Salvar" CssClass="controles_grid"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Cancel" Text="Cancelar" CssClass="controles_grid"></asp:LinkButton>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                        CommandName="Edit" Text="Editar" CssClass="controles_grid"></asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" 
                        CommandName="Delete" onclientclick="return confirmarDelete()" Text="Deletar" CssClass="controles_grid"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField SortExpression="imageurl">
                <EditItemTemplate>
                    <asp:Image ID="Image2" runat="server" 
                        ImageUrl='<%# Eval("imageurl","~/images/{0}") %>' Width="40px" Height="60px" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Image ID="Image1" runat="server" 
                        ImageUrl='<%# Eval("imageurl","~/images/{0}") %>' Width="40px" Height="60px" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="titulo" HeaderText="Título" ReadOnly="True" 
                SortExpression="titulo" />
            <asp:BoundField DataField="idLivro" HeaderText="Código" ReadOnly="True" 
                SortExpression="idLivro" />
            <asp:BoundField DataField="quantidade" HeaderText="Quantidade" 
                SortExpression="quantidade" />
            <asp:BoundField DataField="preco" HeaderText="Preço" ReadOnly="True" 
                SortExpression="preco" />
        </Columns>
    </asp:GridView>

    <asp:SqlDataSource ID="dsCarrinhoProduto" runat="server" 
        ConflictDetection="CompareAllValues" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        DeleteCommand="DELETE FROM [carrinho_livro] WHERE [idCarrinho] = @original_idCarrinho AND [idLivro] = @original_idLivro AND [quantidade] = @original_quantidade" 
        InsertCommand="INSERT INTO [carrinho_livro] ([idCarrinho], [idLivro], [quantidade]) VALUES (@idCarrinho, @idLivro, @quantidade)" 
        OldValuesParameterFormatString="original_{0}" 
        SelectCommand="SELECT carrinho_livro.idCarrinho, carrinho_livro.idLivro, carrinho_livro.quantidade, livro.titulo, livro.preco, livro.imageurl FROM carrinho_livro INNER JOIN livro ON carrinho_livro.idLivro = livro.id AND carrinho_livro.idLivro = livro.id WHERE (carrinho_livro.idCarrinho = @idCarrinho)" 
        UpdateCommand="UPDATE [carrinho_livro] SET [quantidade] = @quantidade WHERE [idCarrinho] = @original_idCarrinho AND [idLivro] = @original_idLivro AND [quantidade] = @original_quantidade">
        <DeleteParameters>
            <asp:Parameter Name="original_idCarrinho" Type="Int32" />
            <asp:Parameter Name="original_idLivro" Type="Int32" />
            <asp:Parameter Name="original_quantidade" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="idCarrinho" Type="Int32" />
            <asp:Parameter Name="idLivro" Type="Int32" />
            <asp:Parameter Name="quantidade" Type="Int32" />
        </InsertParameters>
        <SelectParameters>
            <asp:CookieParameter CookieName="idCarrinho" Name="idCarrinho" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="quantidade" Type="Int32" />
            <asp:Parameter Name="original_idCarrinho" Type="Int32" />
            <asp:Parameter Name="original_idLivro" Type="Int32" />
            <asp:Parameter Name="original_quantidade" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

<p class="mini_info">Aceitamos pagamentos apenas via boleto.</p>

<div id="controles_adicionais">
    <asp:Button ID="btComprar" runat="server" Text="Comprar" OnClientClick='alert("Função indisponível.")' />
</div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="Admin" runat="server" />

		<nav id="navCategorias" class="widget">
			<h2>Categorias</h2>
			<ul>
            <% List<Livraria.Model.CategoriaLivro> categorias = (List<Livraria.Model.CategoriaLivro>) HttpContext.Current.Items["categorias"]; %>
                <%foreach (Livraria.Model.CategoriaLivro categoria in categorias)
                  {%>
				    <li><a href="ConsultarAcervo.aspx?cat=<%= categoria.Id %>"><%=categoria.Nome %></a></li>
                <%}%>
			</ul>
		</nav>

</asp:Content>