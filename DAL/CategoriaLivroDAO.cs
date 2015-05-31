using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Livraria.Model;
using System.Configuration;
using System.Data.SqlClient;
using System.Data.Linq;

namespace Livraria.DAL
{
    public class CategoriaLivroDAO
    {

        private LivrariaDataContext ldc;

        public CategoriaLivroDAO()
        {
            ldc = new LivrariaDataContext();
        }

        public List<CategoriaLivro> Listar(){
            return ldc.Categorias.ToList();
        }

        public CategoriaLivro getById(int id) {
            return ldc.Categorias.Single(c => c.Id == id);
        }

        public void Inserir(CategoriaLivro categoria)
        {
            try
            {
                ldc.Categorias.InsertOnSubmit(categoria);
                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void Editar(CategoriaLivro categoriaNova)
        {
            try
            {
                CategoriaLivro categoriaVelha = getById(categoriaNova.Id);

                categoriaVelha.Nome = categoriaNova.Nome;

                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void Excluir(CategoriaLivro categoria)
        {
            try
            {
                ldc.Categorias.DeleteOnSubmit(categoria);
                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

    }
}