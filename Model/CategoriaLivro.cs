using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;

namespace Livraria.Model
{
    [Table(Name = "categoria")]
    public class CategoriaLivro
    {
        
        public CategoriaLivro() {
            livros = new EntitySet<Livro>(OnLivroAdicionado, OnLivroRemovido);
        }

        public CategoriaLivro(int id, string nome):this()
        {
            this.Id = id;
            this.Nome = nome;
            livros = new EntitySet<Livro>(OnLivroAdicionado, OnLivroRemovido);
        }

        public int id;
        [Column(Name = "id", IsPrimaryKey = true, IsDbGenerated = true)]
        public int Id
        {
            get
            {
                return id;
            }
            set
            {
                id = value;
            }
        }

        private string nome;
        [Column(Name = "nome")]
        public string Nome
        {
            get
            {
                return nome;
            }
            set
            {
                nome = value;
            }
        }

        private EntitySet<Livro> livros;// = new EntitySet<Livro>();
        [Association(Storage = "livros", ThisKey = "Id", OtherKey = "IdCategoria")]//, IsForeignKey=true)]
        internal ICollection<Livro> Livros {
            get {
                return livros;
            }
            set {
                livros.Assign(value);
            }
        }

        private void OnLivroAdicionado(Livro livroAdded) {
            livroAdded.Categoria = this;
        }

        private void OnLivroRemovido(Livro livroRemoved) {
            livroRemoved.Categoria = null;
        }

    }
}