<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="InserirUsuario.aspx.cs" Inherits="Livraria.View.InserirUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Inserir usuário</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Cadastro</h2>

    <div class="form_padrao">
        
        <p>
            <label for="inpEmail">E-mail</label><input type="text" id="inpEmail" name="inpEmail" runat="server"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="inpEmail"></asp:RequiredFieldValidator>
        </p>        

        <p>
            <label for="inpUsername">Usuário</label><input type="text" id="inpUsername" name="inpUsername" runat="server"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="inpUsername"></asp:RequiredFieldValidator>
        </p>

        <p>
            <label for="inpSenha">Senha</label><input type="password" id="inpSenha" name="inpSenha" runat="server"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="inpSenha"></asp:RequiredFieldValidator>
        </p>
       
        <p>
            <asp:Button ID="btSalvar" class="btForm" runat="server" Text="Salvar" 
                onclick="btSalvar_Click" />
            <button type="reset" class="btForm">Limpar</button> 
        </p>

    </div>

    <asp:SqlDataSource ID="dsUsuario" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        DeleteCommand="DELETE FROM [usuario] WHERE [id] = @id" 
        InsertCommand="INSERT INTO [usuario] ([username], [senha], [email], [dataCadastro], [descricao], [imageurl]) VALUES (@username, @senha, @email, @dataCadastro, @descricao, @imageurl)" 
        SelectCommand="SELECT * FROM [usuario]" 
        UpdateCommand="UPDATE [usuario] SET [username] = @username, [senha] = @senha, [email] = @email, [dataCadastro] = @dataCadastro, [descricao] = @descricao, [imageurl] = @imageurl WHERE [id] = @id">
        <DeleteParameters>
            <asp:Parameter Name="id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="senha" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="imageurl" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="senha" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="imageurl" Type="String" />
            <asp:Parameter Name="id" Type="Int32" />
        </UpdateParameters>
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