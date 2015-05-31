<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="GerenciarCategorias.aspx.cs" Inherits="Livraria.View.GerenciarCategorias" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Gerenciar categorias</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Gerenciar categorias</h2>

    <div class="form_padrao">
        <p>
            <label for="inpNome">Nome</label>
            <input type="text" name="inpNome" id="inpNome" runat="server"/>
        </p>

        <p>
            <asp:Button ID="btSalvar" OnClick="btSalvar_click" class="btForm" runat="server" Text="Criar" />
            <asp:Button ID="btNovo" OnClick="btNovo_click" class="btForm" runat="server" Text="Nova" />
            <asp:HiddenField ID="idEditar" runat="server" Value="-1"/>
        </p>
    </div>

    <div class="tabela_gerenciar">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            DataSourceID="dsLivraria" SelectedRowStyle-CssClass="gridSelected" DataKeyNames="id"  
            EmptyDataText="Não há categorias." AllowPaging="True" 
            onrowdeleted="GridView1_RowDeleted1" 
            onselectedindexchanged="GridView1_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" 
                            CommandName="Select" CssClass="controles_grid" Text="Selecionar"></asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="nome" HeaderText="Nome" SortExpression="nome" HtmlEncode="false"/>
            </Columns>

<SelectedRowStyle CssClass="gridSelected"></SelectedRowStyle>
        </asp:GridView>
    </div>

            <div id="controles_adicionais">
                <span class="onde_estou">
                    <% if (((GridView)GridView1).SelectedRow == null)
                       { %>
                        SELECIONE UMA CATEGORIA
                    <%}
                       else
                       { %>
                        AÇÕES PARA "<%=((GridView)GridView1).SelectedRow.Cells[1].Text%>"
                    <%} %>
                </span>
                <asp:Button ID="btExibirDetalhes" runat="server" Text="Excluir" OnClick="btExcluir_click" 
                    CssClass="btDisabled" Enabled="False" OnClientClick="return confirmarDelete()" />
            </div>

    <asp:SqlDataSource ID="dsLivraria" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        SelectCommand="SELECT [nome], [id] FROM [categoria]"></asp:SqlDataSource>

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
