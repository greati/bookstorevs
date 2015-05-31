using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using Livraria.Model;
using System.Data.Linq;

namespace Livraria.DAL
{
    public class LivroDAO
    {
        private LivrariaDataContext ldc;
        
        public LivroDAO()
        {
            ldc = new LivrariaDataContext();
        }

        public List<Livro> Listar() {
            return ldc.Livros.ToList();
        }

        public List<Livro> Listar(int num) {

            List<Livro> livros = ldc.Livros.ToList();

            if (livros.Count > num)
            {
                livros.RemoveRange(num, livros.Count - num);
            }

            return livros;
        }

        public Livro getById(int id)
        {
            return ldc.Livros.SingleOrDefault(l => l.Id == id);
        }

        public void Inserir(Livro livro) {

            //DateTime myDate;
            //String format = "dd/MM/yyyy hh:mm:ss";
            //DateTime.TryParse(DateTime.Now.ToString(format), out myDate);

            livro.Created = DateTime.Now;

            livro.Categoria = ldc.Categorias.SingleOrDefault(c=>c.Id == livro.Categoria.Id);
            livro.Proprietario = ldc.Usuarios.SingleOrDefault(u => u.Id == livro.Proprietario.Id);
            ldc.Livros.InsertOnSubmit(livro);
            ldc.SubmitChanges();
        }

        public void Editar(Livro livroNovo) {
            try
            {
                Livro livroVelho = getById(livroNovo.Id);

                livroVelho.Ano = livroNovo.Ano;
                livroVelho.Autor = livroNovo.Autor;
                livroVelho.Categoria = ldc.Categorias.SingleOrDefault(c => c.Id == livroNovo.Categoria.Id);
                livroVelho.Descricao = livroNovo.Descricao;
                livroVelho.Edicao = livroNovo.Edicao;
                livroVelho.Idioma = livroNovo.Idioma;
                livroVelho.ImageUrl = livroNovo.ImageUrl;
                livroVelho.Isbn = livroNovo.Isbn;
                livroVelho.Paginas = livroNovo.Paginas;
                livroVelho.Preco = livroNovo.Preco;
                livroVelho.Proprietario = ldc.Usuarios.SingleOrDefault(u => u.Id == livroNovo.Proprietario.Id);
                livroVelho.Quantidade = livroNovo.Quantidade;
                livroVelho.Titulo = livroNovo.Titulo;

                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void Excluir(Livro livro) {
            try {
                livro = ldc.Livros.SingleOrDefault(l => l.Id == livro.Id);

                CarrinhoDAO carDAO = new CarrinhoDAO();
                foreach(Carrinho c in livro.Carrinhos){
                    carDAO.deleteLivro(c.Id, livro.Id);
                }

                ldc.Livros.DeleteOnSubmit(livro);
                ldc.SubmitChanges();
            }catch(Exception e){
                throw new Exception(e.Message);
            }
        }
    }
}