using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;
using System.Collections.ObjectModel;
using System.Collections.Specialized;

namespace Livraria.Model
{
    [Table(Name="carrinho")]
    public class Carrinho
    {
        public Carrinho() {}

        public Carrinho(int id, DateTime created):this()
        {
            this.Id = id;
            this.Created = created;
            //this.Livros = new EntitySet<CarrinhoLivro>();
        }

        private int id;
        [Column(Name="id",IsPrimaryKey=true,IsDbGenerated=true)]
        public int Id {
            get {
                return id;
            }
            set {
                id = value;
            }
        }

        private EntitySet<CarrinhoLivro> carrinhoLivros = new EntitySet<CarrinhoLivro>();
        [Association(Storage = "carrinhoLivros", ThisKey = "Id", OtherKey = "IdCarrinho")]
        public ICollection<CarrinhoLivro> CarrinhoLivros
        {
            get {
                return carrinhoLivros;
            }
            set {
                carrinhoLivros.Assign(value);
            }
        }

        public ICollection<Livro> Livros
        {
            get
            {
                var livros = new ObservableCollection<Livro>(from cl in CarrinhoLivros select cl.Livro);
                livros.CollectionChanged += LivroCollectionChanged;
                return livros;
            }
            set { }
        }

        private void LivroCollectionChanged(object sender, NotifyCollectionChangedEventArgs e) {
            if (NotifyCollectionChangedAction.Add == e.Action)
            {
                foreach(Livro livroAdded in e.NewItems){
                    OnLivroAdicionado(livroAdded);
                }
            }

            if (NotifyCollectionChangedAction.Remove == e.Action)
            {
                foreach (Livro livroRemoved in e.OldItems)
                {
                    OnLivroRemovido(livroRemoved);
                }
            }
        }

        private void OnLivroAdicionado(Livro livroAdicionado) {
            CarrinhoLivro cl = new CarrinhoLivro() { Carrinho = this, Livro = livroAdicionado};
        }

        private void OnLivroRemovido(Livro livroRemovido) {
            CarrinhoLivro cl = CarrinhoLivros.SingleOrDefault(cl2 => cl2.Carrinho == this && cl2.Livro == livroRemovido);
            if (cl != null) {
                cl.Remove();
            }
        }

        private DateTime created;
        [Column(Name="created")]
        public DateTime Created {
            get {
                return created;
            }
            set {
                created = value;
            }
        }

    }
}