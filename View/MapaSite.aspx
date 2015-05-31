<%@ Page Title="" Language="C#" MasterPageFile="~/Padrao.Master" AutoEventWireup="true" CodeBehind="MapaSite.aspx.cs" Inherits="Livraria.View.MapaSite" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <title>Livre-se | Mapa do site</title>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<h2 class="page-title">Mapa do site</h2>

    <nav id="treeASP" class="widget">
        <div class="treeView">
            <asp:TreeView ID="TreeView1" runat="server" DataSourceID="Admin">
                <LeafNodeStyle CssClass="treeLeaf" />
                <ParentNodeStyle CssClass="treeParent" />
                <RootNodeStyle CssClass="treeRoot" />
                <SelectedNodeStyle CssClass="treeSelected" />
            </asp:TreeView>
        </div>
    </nav>

    <asp:SiteMapDataSource ID="Admin" runat="server" />

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="sidebar" runat="server">
        <asp:SiteMapDataSource ID="SiteMapDataSource1" runat="server" />

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