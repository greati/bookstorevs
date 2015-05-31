using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using Livraria.Model;
using System.Data;
using System.Data.Linq;

namespace Livraria.DAL
{
    public class CarrinhoDAO
    {
        private LivrariaDataContext ldc;
        private LivroDAO livroDAO;

        public CarrinhoDAO()
        {
            ldc = new LivrariaDataContext();
            livroDAO = new LivroDAO();
        }

        public int addCarrinho() {

            LivrariaDataContext ldc2 = new LivrariaDataContext();
            Carrinho carrinho = new Carrinho();

            DateTime myDate = DateTime.Now;

            carrinho.Created = myDate;

            ldc2.Carrinhos.InsertOnSubmit(carrinho);
            ldc2.SubmitChanges();
            return carrinho.Id;
        }

        public bool addLivro(Carrinho carrinho, Livro livro) {

            LivrariaDataContext ldc2 = new LivrariaDataContext();

            Carrinho car = ldc2.Carrinhos.Single(c => c.Id == carrinho.Id);
            System.Diagnostics.Debug.WriteLine("Carrinho:"+car);
            Livro liv = ldc2.Livros.Single(l => l.Id == livro.Id);
            System.Diagnostics.Debug.WriteLine("Livro:" + liv);
            car.Livros.Add(liv);
            ldc2.SubmitChanges();
            return true;
        }

        public bool deleteLivro(int idCarrinho, int idLivro) { 

            try {
                Carrinho car = ldc.Carrinhos.SingleOrDefault(c => c.Id == idCarrinho);
                Livro liv = ldc.Livros.SingleOrDefault(l => l.Id == idLivro);
                car.Livros.Remove(liv);
                ldc.SubmitChanges();
                return true;
            }catch(Exception e){
                return false;
            }

        }

        public Carrinho getCarrinhoById(int id) {
            LivrariaDataContext ldc2 = new LivrariaDataContext();
            Carrinho carrinho = ldc2.Carrinhos.SingleOrDefault(c => c.Id == id);
            return carrinho;
        }

    }
}