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
    [Table(Name="autoridade")]
    public class Autoridade
    {
        private int id;
        [Column(Name = "id", IsPrimaryKey = true, IsDbGenerated=true)]
        public int Id {
            set {
                id = value;
            }
            get {
                return id;
            }
        }

        private string nome;
        [Column(Name = "nome")]
        public string Nome {
            get {
                return nome;
            }
            set {
                nome = value;
            }
        }

        private EntitySet<UsuarioAutoridade> usuarioAutoridades = new EntitySet<UsuarioAutoridade>();
        [Association(Storage = "usuarioAutoridades", ThisKey = "Id", OtherKey = "IdAutoridade")]
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

        public ICollection<Usuario> Usuarios
        {
            get
            {
                var usuarios = new ObservableCollection<Usuario>(from cl in UsuarioAutoridades select cl.Usuario);
                usuarios.CollectionChanged += UsuarioCollectionChanged;
                return usuarios;
            }
            set { }
        }

        private void UsuarioCollectionChanged(object sender, NotifyCollectionChangedEventArgs e)
        {
            if (NotifyCollectionChangedAction.Add == e.Action)
            {
                foreach (Usuario usuarioAdded in e.NewItems)
                {
                    OnUsuarioAdicionado(usuarioAdded);
                }
            }

            if (NotifyCollectionChangedAction.Remove == e.Action)
            {
                foreach (Usuario usuarioRemoved in e.OldItems)
                {
                    OnUsuarioRemovido(usuarioRemoved);
                }
            }
        }

        private void OnUsuarioAdicionado(Usuario usuarioAdicionado)
        {
            UsuarioAutoridade ua = new UsuarioAutoridade() { Autoridade = this, Usuario = usuarioAdicionado };
        }

        private void OnUsuarioRemovido(Usuario usuarioRemovido)
        {
            UsuarioAutoridade ua = UsuarioAutoridades.SingleOrDefault(ua2 => ua2.Autoridade == this && ua2.Usuario == usuarioRemovido);
            if (ua != null)
            {
                ua.Remove();
            }
        }


        public override bool Equals(object obj)
        {
            if (obj == null) return false;
            Autoridade other = obj as Autoridade;
            if (other == null) return false;
            return other.Id == this.Id;// || other.Nome == this.Nome;
        }

        public override int GetHashCode()
        {
            return Id.GetHashCode();
        }

    }
}