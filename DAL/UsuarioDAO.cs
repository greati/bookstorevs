using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;
using Livraria.Model;
using System.Data.Linq;

namespace Livraria.DAL
{
    public class UsuarioDAO
    {

        private LivrariaDataContext ldc;

        public UsuarioDAO()
        {
            ldc = new LivrariaDataContext();
        }

        public Usuario Login(String username, String senha) {
            return ldc.Usuarios.SingleOrDefault(u => u.Username == username && u.Senha == senha);
        }

        public List<Usuario> getRecentes(int num)
        {
            List<Usuario> usuarios = ldc.Usuarios.ToList();
            usuarios.Reverse(0,usuarios.Count);

            if (usuarios.Count > num)
            {
                usuarios.RemoveRange(num, usuarios.Count - num);
            }
            
            return usuarios;
        }

        public Usuario getById(int id)
        {
            return ldc.Usuarios.Single(c => c.Id == id);
        }

        public void Inserir(Usuario usuario)
        {
            try
            {
                ldc.Usuarios.InsertOnSubmit(usuario);
                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void Editar(Usuario usuarioNovo)
        {
            try
            {
                Usuario usuarioVelho = getById(usuarioNovo.Id);

                usuarioVelho.DataCadastro = usuarioNovo.DataCadastro;
                usuarioVelho.Descricao = usuarioNovo.Descricao;
                usuarioVelho.Email = usuarioNovo.Email;
                usuarioVelho.ImageUrl = usuarioNovo.ImageUrl;
                usuarioVelho.Livros = usuarioNovo.Livros;
                usuarioVelho.Senha = usuarioNovo.Senha;
                usuarioVelho.Username = usuarioNovo.Username;
                usuarioVelho.Autoridades = usuarioNovo.Autoridades;

                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }

        public void Excluir(Usuario usuario)
        {
            try
            {
                ldc.Usuarios.DeleteOnSubmit(usuario);

                LivroDAO livroDAO = new LivroDAO();
                foreach (Livro l in usuario.Livros)
                {
                    livroDAO.Excluir(l);
                }

                AutoridadeDAO autDAO = new AutoridadeDAO();
                foreach (Autoridade a in usuario.Autoridades) {
                    autDAO.DeleteFromUsuario(a, usuario);
                }

                ldc.SubmitChanges();
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }
        }
    }
}