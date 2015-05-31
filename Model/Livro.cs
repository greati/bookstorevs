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
    [Table(Name="livro")]
    public class Livro
    {
        public Livro(){}

        public Livro(int id, string titulo, string autor, CategoriaLivro categoria, int edicao,
                     string idioma, int ano, int paginas, string descricao, string isbn, double preco,
                     int quantidade, Usuario proprietario, string imageUrl):this() {

            this.Id = id;
            this.Titulo = titulo;
            this.Autor = autor;
            this.Categoria = categoria;
            this.Edicao = edicao;
            this.Idioma = idioma;
            this.Ano = ano;
            this.Paginas = paginas;
            this.Descricao = descricao;
            this.Isbn = isbn;
            this.Preco = preco;
            this.Quantidade = quantidade;
            this.Proprietario = proprietario;
            this.ImageUrl = imageUrl;
        }

        private int id;
        [Column(Name = "id", IsPrimaryKey = true, IsDbGenerated = true)]
        public int Id {
            get {
                return id;
            }
            set {
                id = value;
            }
        }

        private string titulo;
        [Column(Name = "titulo")]
        public string Titulo {
            get {
                return titulo;
            }
            set {
                titulo = value;
            }
        }

        private string autor;
        [Column(Name = "autor")]
        public string Autor {
            get {
                return autor;
            }
            set {
                autor = value;
            }
        }

        private int idCategoria;
        [Column(Name = "idCategoria")]
        public int IdCategoria
        {
            get
            {
                return idCategoria;
            }
            set
            {
                this.idCategoria = value;
            }
        }

        private EntityRef<CategoriaLivro> categoria = new EntityRef<CategoriaLivro>();//EntityRef<CategoriaLivro> categoria;
        [Association(Storage="categoria",ThisKey="IdCategoria",OtherKey="Id",IsForeignKey=true)]
        public CategoriaLivro Categoria
        {
            get {
                return this.categoria.Entity;
            }
            set {

                CategoriaLivro catAnt = categoria.Entity;
                CategoriaLivro catNova = value;

                if(catAnt != catNova){
                    //remover o livro antigo da lista de livros da categoria
                    categoria.Entity = null;
                    if (catAnt != null) {
                        catAnt.Livros.Remove(this);
                    }
                    //muda a categoria para o novo valor
                    categoria.Entity = catNova;
                    //adiciona este livro à lista de livros da nova categoria
                    if (catNova != null) {
                        catNova.Livros.Add(this);
                    }
                }
            }
        }

        private int edicao;
        [Column(Name = "edicao")]
        public int Edicao {
            get {
                return edicao;
            }
            set {
                edicao = value;
            }
        }

        private string idioma;
        [Column(Name = "idioma")]
        public string Idioma {
            get {
                return idioma;
            }
            set {
                idioma = value;
            }
        }

        private int ano;
        [Column(Name = "ano")]
        public int Ano {
            get {
                return ano;
            }
            set {
                ano = value;
            }
        }

        private int paginas;
        [Column(Name = "paginas")]
        public int Paginas {
            get {
                return paginas;
            }
            set {
                paginas = value;
            }
        }

        private string descricao;
        [Column(Name = "descricao")]
        public string Descricao {
            get {
                return descricao;
            }
            set {
                descricao = value;
            }
        }

        private string isbn;
        [Column(Name = "isbn")]
        public string Isbn {
            get {
                return isbn;
            }
            set {
                isbn = value;
            }
        }

        private double preco;
        [Column(Name = "preco")]
        public double Preco {
            get {
                return preco;
            }
            set {
                preco = value;
            }
        }

        private int quantidade;
        [Column(Name = "quantidade")]
        public int Quantidade {
            get {
                return quantidade;
            }
            set {
                quantidade = value;
            }
        }

        private int idUsuario;
        [Column(Name = "idUsuario")]//,Association(IsForeignKey=true)]
        public int IdUsuario
        {
            get
            {
                return idUsuario;
            }
            set
            {
                this.idUsuario = value;
            }
        }

        private EntityRef<Usuario> proprietario = new EntityRef<Usuario>();
        [Association(Storage = "proprietario", ThisKey = "IdUsuario", OtherKey = "Id",IsForeignKey=true)]
        public Usuario Proprietario
        {
            get {
                return this.proprietario.Entity;
            }
            set
            {
                Usuario usuAnt = proprietario.Entity;
                Usuario usuNovo = value;

                if (usuNovo != usuAnt)
                {
                    //remover o livro antigo da lista de livros da categoria
                    proprietario.Entity = null;
                    if (usuAnt != null)
                    {
                        usuAnt.Livros.Remove(this);
                    }
                    //muda a categoria para o novo valor
                    proprietario.Entity = usuNovo;
                    //adiciona este livro à lista de livros da nova categoria
                    if (usuNovo != null)
                    {
                        usuNovo.Livros.Add(this);
                    }
                }
            }
        }

        private string imageUrl;
        [Column(Name = "imageUrl")]
        public string ImageUrl {
            get {
                return imageUrl;
            }
            set {
                imageUrl = value;
            }
        }

        private DateTime created;
        [Column(Name="created")]
        public DateTime Created{
            get{
                return created;
            }
            set{
                created = value;
            }
        }

        private EntitySet<CarrinhoLivro> carrinhoLivros = new EntitySet<CarrinhoLivro>();
        [Association(Storage = "carrinhoLivros", ThisKey = "Id", OtherKey = "IdLivro")]
        internal ICollection<CarrinhoLivro> CarrinhoLivros
        {
            get
            {
                return carrinhoLivros;
            }
            set
            {
                carrinhoLivros.Assign(value);
            }
        }

        public ICollection<Carrinho> Carrinhos
        {
            get
            {
                //tudo isso para nos avisar sobre mudanças na collection
                var carrinhos = new ObservableCollection<Carrinho>(from cl in CarrinhoLivros select cl.Carrinho);
                carrinhos.CollectionChanged += CarrinhoCollectionChanged; //method defined below
                return carrinhos;
            }
            set { }
        }

        private void onCarrinhoAdicionado(Carrinho carrinhoAdded) {
            CarrinhoLivro cl = new CarrinhoLivro() { Carrinho = carrinhoAdded, Livro = this };
        }

        private void OnCarrinhoRemoved(Carrinho carrinhoRem) {
            CarrinhoLivro cl = CarrinhoLivros.SingleOrDefault(cl2 => cl2.Livro == this && cl2.Carrinho == carrinhoRem);
            if (cl != null) {
                cl.Remove(); // method Remove() defined below
            }
        }

        // avisa sobre todas as mudanças ocorridas na coleção de Carrinhos
        // a cada mudança, realiza a alteração correspondente no banco
        private void CarrinhoCollectionChanged(object sender, NotifyCollectionChangedEventArgs e) {
            if (NotifyCollectionChangedAction.Add == e.Action)
            {
                foreach(Carrinho carrinhoAdded in e.NewItems){
                    onCarrinhoAdicionado(carrinhoAdded);
                }
            }

            if (NotifyCollectionChangedAction.Remove == e.Action)
            {
                foreach (Carrinho carrinhoRemoved in e.OldItems)
                {
                    OnCarrinhoRemoved(carrinhoRemoved);
                }
            }
        }



    } // end class

} // end namespace