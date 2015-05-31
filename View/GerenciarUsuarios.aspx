<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="GerenciarUsuarios.aspx.cs" Inherits="Livraria.View.GerenciarUsuarios" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Gerenciar usuários</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2 class="page-title">Gerenciar usuários</h2>

    <div class="tabela_gerenciar">
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" DataKeyNames="id" SelectedRowStyle-CssClass="gridSelected"
            AllowSorting="True" AutoGenerateColumns="False" DataSourceID="dsLivraria" EmptyDataText="Não existem usuários cadastrados."
            OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" CssClass="controles_grid" Text="Selecionar"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Eval("imageurl") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Image ID="Image1" runat="server" Height="60px" ImageAlign="Middle" 
                            ImageUrl='<%# Eval("imageurl", "~/images/{0}") %>' Width="50px" />
                    </ItemTemplate>
                    <ItemStyle Height="60px" Width="50px" />
                </asp:TemplateField>
                <asp:BoundField DataField="username" HeaderText="Usuário" 
                    SortExpression="username" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="dataCadastro" HeaderText="Desde" 
                    SortExpression="dataCadastro" >
                <ControlStyle Height="60px" />
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="email" HeaderText="E-mail" SortExpression="email" />
            </Columns>

            <EditRowStyle HorizontalAlign="Center" VerticalAlign="Middle" />
            <RowStyle HorizontalAlign="Center" VerticalAlign="Middle" />

<SelectedRowStyle CssClass="gridSelected"></SelectedRowStyle>
        </asp:GridView>
    </div>

            <div id="controles_adicionais">
                <span class="onde_estou">
                    <% if (((GridView)GridView1).SelectedRow == null)
                       { %>
                        SELECIONE UM USUÁRIO
                    <%}
                       else
                       { %>
                        AÇÕES PARA "<%=((GridView)GridView1).SelectedRow.Cells[2].Text%>"
                    <%} %>
                </span>
                <asp:Button ID="btExcluir" runat="server" Text="Excluir" OnClick="btExcluir_click" 
                    CssClass="btDisabled" Enabled="False" OnClientClick="return confirmarDelete()" />
                <asp:Button ID="btEditarDetalhes" runat="server" Text="Editar" OnClick="btEditar_click" 
                    CssClass="btDisabled" Enabled="False"/>
            </div>

    <asp:SqlDataSource ID="dsLivraria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        
        
        
        SelectCommand="SELECT [username], [dataCadastro], [imageurl], [id], [email] FROM [usuario]" 
        ConflictDetection="CompareAllValues" 
        DeleteCommand="DELETE FROM [usuario] WHERE [id] = @original_id AND [username] = @original_username AND [dataCadastro] = @original_dataCadastro AND [imageurl] = @original_imageurl AND [email] = @original_email" 
        InsertCommand="INSERT INTO [usuario] ([username], [dataCadastro], [imageurl], [email]) VALUES (@username, @dataCadastro, @imageurl, @email)" 
        OldValuesParameterFormatString="original_{0}" 
        UpdateCommand="UPDATE [usuario] SET [username] = @username, [dataCadastro] = @dataCadastro, [imageurl] = @imageurl, [email] = @email WHERE [id] = @original_id AND [username] = @original_username AND [dataCadastro] = @original_dataCadastro AND [imageurl] = @original_imageurl AND [email] = @original_email">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_username" Type="String" />
            <asp:Parameter Name="original_dataCadastro" Type="DateTime" />
            <asp:Parameter Name="original_imageurl" Type="String" />
            <asp:Parameter Name="original_email" Type="String" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="imageurl" Type="String" />
            <asp:Parameter Name="email" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="imageurl" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
            <asp:Parameter Name="original_username" Type="String" />
            <asp:Parameter Name="original_dataCadastro" Type="DateTime" />
            <asp:Parameter Name="original_imageurl" Type="String" />
            <asp:Parameter Name="original_email" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
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
