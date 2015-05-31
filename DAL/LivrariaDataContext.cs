using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Linq.Mapping;
using System.Data.Linq;
using System.Configuration;
using Livraria.Model;

namespace Livraria.DAL
{
    [Database(Name="Livraria")]
    public class LivrariaDataContext : DataContext
    {
        public LivrariaDataContext() : base("Data Source=.\\SQLEXPRESS;AttachDbFilename=|DataDirectory|\\LIVRARIA.mdf;Integrated Security=True;User Instance=True"){}
    
        public Table<Usuario> Usuarios;
        public Table<Livro> Livros;
        public Table<CategoriaLivro> Categorias;
        public Table<Carrinho> Carrinhos;
        public Table<Autoridade> Autoridades;


        public static void RemoveRecord<T>(T recordToRemove) where T : class {
            // Retrieve BookCatalog instance in way
            // that's consistent with your DataContext strategy
            LivrariaDataContext ldc = new LivrariaDataContext();

            Table<T> tableData = ldc.GetTable<T>();
            var deleteRecord = tableData.SingleOrDefault(record => record == recordToRemove);
            if (deleteRecord != null)
            {
                tableData.DeleteOnSubmit(deleteRecord);
            }

            // If you created a new BookCatalog instance, submit it's changes here
            ldc.SubmitChanges();            
        }

    }
}