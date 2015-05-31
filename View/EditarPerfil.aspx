<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="EditarPerfil.aspx.cs" Inherits="Livraria.View.EditarPerfil" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Editar perfil</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Editar perfil</h2>

    <div class="form_padrao">
        <p>
            <label for="inpUsername">Usuário</label><input type="text" id="inpUsername" name="inpUsername" runat="server"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="inpUsername"></asp:RequiredFieldValidator>
        </p>
        
        <p>
            <label for="inpSenha">Nova senha</label><input type="password" id="inpSenha" name="inpSenha" runat="server"/>
        </p>
        
        <p>
            <label for="inpEmail">E-mail</label><input type="text" id="inpEmail" name="inpEmail" runat="server"/>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="inpEmail"></asp:RequiredFieldValidator>
        </p>
        
        <p>
            <label for="inpDescricao">Descrição</label><textarea type="text" id="inpDescricao" name="inpDescricao" runat="server"></textarea>
        </p>
        
        <% Livraria.Model.Usuario usuLogado = (Livraria.Model.Usuario)Session["usuarioLogado"];
           Livraria.DAL.AutoridadeDAO autDAO = new Livraria.DAL.AutoridadeDAO();
           if (usuLogado.Autoridades.Contains<Livraria.Model.Autoridade>(autDAO.getAutoridadeById(4)))
           {%>
                <p class="checkboxlist">
                    <label>Autoridades</label>
                    <asp:CheckBoxList ID="cblAutoridades" runat="server"></asp:CheckBoxList>
                </p>
        <% } %>

        <p class="fileupload">
            <label for="uploadImg">Imagem:</label>
            <asp:FileUpload ID="uploadImg" runat="server" />
        </p>
       
        <p>
            <asp:Button ID="btSalvar" class="btForm" runat="server" Text="Salvar" 
                onclick="btSalvar_Click" />
            <button type="reset" class="btForm">Limpar</button> 
        </p>

    </div>


    <asp:SqlDataSource ID="dsUsuario" runat="server" 
        ConnectionString="<%$ ConnectionStrings:livrariaConnectionString %>" 
        DeleteCommand="DELETE FROM [usuario] WHERE [id] = @original_id" 
        InsertCommand="INSERT INTO [usuario] ([username], [senha], [email], [dataCadastro], [descricao], [imageurl]) VALUES (@username, @senha, @email, @dataCadastro, @descricao, @imageurl)" 
        SelectCommand="SELECT * FROM [usuario] WHERE ([id] = @id)" 
        
        UpdateCommand="UPDATE [usuario] SET [username] = @username, [senha] = @senha, [email] = @email, [dataCadastro] = @dataCadastro, [descricao] = @descricao, [imageurl] = @imageurl WHERE [id] = @original_id" 
        OldValuesParameterFormatString="original_{0}">
        <DeleteParameters>
            <asp:Parameter Name="original_id" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="senha" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="imageurl" Type="String" />
        </InsertParameters>
        <SelectParameters>
            <asp:SessionParameter Name="id" SessionField="idUsuarioLogado" 
                Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="username" Type="String" />
            <asp:Parameter Name="senha" Type="String" />
            <asp:Parameter Name="email" Type="String" />
            <asp:Parameter Name="dataCadastro" Type="DateTime" />
            <asp:Parameter Name="descricao" Type="String" />
            <asp:Parameter Name="imageurl" Type="String" />
            <asp:Parameter Name="original_id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

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