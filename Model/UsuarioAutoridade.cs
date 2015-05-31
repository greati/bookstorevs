using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;
using Livraria.DAL;

namespace Livraria.Model
{
    [Table(Name="usuario_autoridade")]
    public class UsuarioAutoridade
    {

        private int idUsuario;
        [Column(Name = "idUsuario", IsPrimaryKey=true)]
        public int IdUsuario {
            get {
                return idUsuario;
            }
            set {
                idUsuario = value;
            }
        }

        private int idAutoridade;
        [Column(Name = "idAutoridade", IsPrimaryKey=true)]
        public int IdAutoridade {
            get {
                return idAutoridade;
            }
            set {
                idAutoridade = value;
            }
        }

        private EntityRef<Usuario> usuario = new EntityRef<Usuario>();
        [Association(IsForeignKey = true, Storage = "usuario", ThisKey = "IdUsuario", OtherKey = "Id")]
        public Usuario Usuario
        {
            get
            {
                return this.usuario.Entity;
            }
            set
            {

                Usuario usuAnt = usuario.Entity;
                Usuario usuNov = value;

                if (usuAnt != usuNov)
                {
                    usuario.Entity = null;
                    if (usuAnt != null)
                    {
                        usuAnt.UsuarioAutoridades.Remove(this);
                    }
                    // "automático", graças ao CarrinhoCollectionChanged em Carrinho 
                    usuario.Entity = usuNov;
                    usuNov.UsuarioAutoridades.Add(this);
                }
            }
        }

        private EntityRef<Autoridade> autoridade = new EntityRef<Autoridade>();
        [Association(IsForeignKey = true, Storage = "autoridade", ThisKey = "IdAutoridade", OtherKey = "Id")]
        public Autoridade Autoridade
        {
            get
            {
                return this.autoridade.Entity;
            }
            set
            {
                Autoridade autAnt = autoridade.Entity;
                Autoridade autNov = value;

                if (autAnt != autNov)
                {
                    autoridade.Entity = null;

                    if (autAnt != null)
                    {
                        autAnt.UsuarioAutoridades.Remove(this);
                    }

                    autoridade.Entity = autNov;
                    autNov.UsuarioAutoridades.Add(this);
                }

            }
        }

        public void Remove()
        {
            LivrariaDataContext.RemoveRecord(this); //method defined in ldc

            Autoridade autAnt = Autoridade;
            autAnt.UsuarioAutoridades.Remove(this);

            Usuario usuAnt = Usuario;
            usuAnt.UsuarioAutoridades.Remove(this);
        }



    }
}