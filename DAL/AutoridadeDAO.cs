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
    public class AutoridadeDAO
    {
        private LivrariaDataContext ldc;

        public AutoridadeDAO()
        {
            ldc = new LivrariaDataContext();
        }

        public bool AddToUsuario(Autoridade autoridade, Usuario usuario)
        {
            Autoridade aut = ldc.Autoridades.Single(a => a.Id == autoridade.Id);
            Usuario usu = ldc.Usuarios.Single(u => u.Id == usuario.Id);

            aut.Usuarios.Add(usu);
            ldc.SubmitChanges();
            return true;
        }

        public bool DeleteFromUsuario(Autoridade autoridade, Usuario usuario)
        {
            try
            {
                Autoridade aut = ldc.Autoridades.Single(a => a.Id == autoridade.Id);
                Usuario usu = ldc.Usuarios.Single(u => u.Id == usuario.Id);
                aut.Usuarios.Remove(usu);
                ldc.SubmitChanges();
                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }

        public Autoridade getAutoridadeById(int id)
        {
            return ldc.Autoridades.SingleOrDefault(a => a.Id == id);
        }

        public List<Autoridade> Listar() {
            return ldc.GetTable<Autoridade>().ToList();
        }

    }
}