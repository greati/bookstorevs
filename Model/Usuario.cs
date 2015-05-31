using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;
using System.Collections.Specialized;
using System.Collections.ObjectModel;

namespace Livraria.Model
{
    [Table(Name="usuario")]
    public class Usuario
    {
        public Usuario() { }

        public Usuario(int id, string username, string senha, string email, DateTime dataCadastro,
                       string descricao, string imageUrl):this() {
            this.Id = id;
            this.Username = username;
            this.Senha = senha;
            this.Email = email;
            this.DataCadastro = dataCadastro;
            this.Descricao = descricao;
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

        private string username;
        [Column(Name="username")]
        public string Username {
            get {
                return username;
            }
            set {
                username = value;
            }
        }

        private string senha;
        [Column(Name = "senha")]
        public string Senha{
            get {
                return senha;
            }
            set {
                senha = value;
            }
        }


        private string email;
        [Column(Name = "email")]
        public string Email {
            get {
                return email;
            }
            set {
                email = value;
            }
        }

        private DateTime dataCadastro;
        [Column(Name = "dataCadastro")]
        public DateTime DataCadastro {
            get {
                return dataCadastro;
            }
            set {
                dataCadastro = value;
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

        private string imageUrl;
        [Column(Name = "imageurl")]
        public string ImageUrl {
            get {
                return imageUrl;
            }
            set {
                imageUrl = value;
            }
        }

        private EntitySet<Livro> livros = new EntitySet<Livro>();
        [Association(Storage = "livros", ThisKey = "Id", OtherKey = "IdUsuario")]
        public EntitySet<Livro> Livros
        {
            get
            {
                return livros;
            }
            set
            {
                this.livros = value;
            }
        }

        private EntitySet<UsuarioAutoridade> usuarioAutoridades = new EntitySet<UsuarioAutoridade>();
        [Association(Storage = "usuarioAutoridades", ThisKey = "Id", OtherKey = "IdUsuario")]
        public ICollection<UsuarioAutoridade> UsuarioAutoridades
        {
            get
            {
                return usuarioAutoridades;
            }
            set
            {
                usuarioAutoridades.Assign(value);
            }
        }

        public ICollection<Autoridade> Autoridades
        {
            get
            {
                var autoridades = new ObservableCollection<Autoridade>(from cl in UsuarioAutoridades select cl.Autoridade);
                autoridades.CollectionChanged += AutoridadeCollectionChanged;
                return autoridades;
            }
            set { }
        }

        private void AutoridadeCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (NotifyCollectionChangedAction.Add == e.Action)
            {
                foreach (Autoridade autoridadeAdded in e.NewItems)
                {
                    OnAutoridadeAdicionada(autoridadeAdded);
                }
            }

            if (NotifyCollectionChangedAction.Remove == e.Action)
            {
                foreach (Autoridade autoridadeRemoved in e.OldItems)
                {
                    OnAutoridadeRemovida(autoridadeRemoved);
                }
            }
        }

        private void OnAutoridadeAdicionada(Autoridade autoridadeAdicionada)
        {
            UsuarioAutoridade ua = new UsuarioAutoridade() { Autoridade = autoridadeAdicionada, Usuario = this };
        }

        private void OnAutoridadeRemovida(Autoridade autoridadeRemovida)
        {
            UsuarioAutoridade ua = UsuarioAutoridades.SingleOrDefault(ua2 => ua2.Usuario == this && ua2.Autoridade == autoridadeRemovida);
            if (ua != null)
            {
                ua.Remove();
            }
        }

    } 
} 