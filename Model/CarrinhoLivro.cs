using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;
using Livraria.DAL;

namespace Livraria.Model
{
    [Table(Name="carrinho_livro")]
    public class CarrinhoLivro
    {
        public CarrinhoLivro() {}

        private int quantidade;
        [Column(Name = "quantidade")]
        public int Quantidade {
            get {
                return this.quantidade;
            }
            set {
                this.quantidade = value;
            }
        }

        private int idCarrinho;
        [Column(Name="idCarrinho", IsPrimaryKey=true)]
        public int IdCarrinho {
            get {
                return idCarrinho;
            }
            set {
                this.idCarrinho = value;
            }
        }

        private int idLivro;
        [Column(Name = "idLivro", IsPrimaryKey=true)]
        public int IdLivro
        {
            get
            {
                return idLivro;
            }
            set
            {
                this.idLivro = value;
            }
        }

        private EntityRef<Carrinho> carrinho = new EntityRef<Carrinho>();
        [Association(IsForeignKey=true, Storage="carrinho", ThisKey="IdCarrinho", OtherKey="Id")]
        public Carrinho Carrinho {
            get {
                return this.carrinho.Entity;
            }
            set {

                Carrinho carAnt = carrinho.Entity;
                Carrinho carNov = value;

                if (carAnt != carNov) {
                    carrinho.Entity = null;
                    if (carAnt != null) {
                        carAnt.CarrinhoLivros.Remove(this);
                    }
                    // "automático", graças ao CarrinhoCollectionChanged em Carrinho 
                    carrinho.Entity = carNov;
                    carNov.CarrinhoLivros.Add(this);
                }
            }
        }

        private EntityRef<Livro> livro = new EntityRef<Livro>();
        [Association(IsForeignKey = true, Storage = "livro", ThisKey = "IdLivro", OtherKey = "Id")]
        public Livro Livro
        {
            get
            {
                return this.livro.Entity;
            }
            set
            {
                Livro livAnt = livro.Entity;
                Livro novoLiv = value;

                if (livAnt != novoLiv) {
                    livro.Entity = null;

                    if(livAnt != null){
                        livAnt.CarrinhoLivros.Remove(this);
                    }

                    livro.Entity = novoLiv;
                    novoLiv.CarrinhoLivros.Add(this);
                }
                
            }
        }

        public void Remove() {
            LivrariaDataContext.RemoveRecord(this); //method defined in ldc

            Livro livroAnt = Livro;
            livroAnt.CarrinhoLivros.Remove(this);

            Carrinho carrinhoAnt = Carrinho;
            carrinhoAnt.CarrinhoLivros.Remove(this);
        }

    }
}