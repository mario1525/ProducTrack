using Data;
using Entity;
using Middlewares;

namespace Services
{
    public class UsuarioCredentialLogical
    {
        private readonly DaoUsuarioCredential _daoCredential;
        private readonly HashPassword _password;
        public UsuarioCredentialLogical(DaoUsuarioCredential daoUsuario, HashPassword password)
        {
            _daoCredential = daoUsuario;
            _password = password;
        }

        public async Task<bool> VerifyCredentials(Login login)
        {
            List<UsuarioCredential> credential = await _daoCredential.GetUserName(login.Usuario);
            if (credential == null)
            {
                return false;
            }
            return _password.VerifyPassword(login.Contrasenia, credential[0].Contrasenia);
        }

        public Mensaje CreateUsuario(UsuarioCredential usuario)
        {
            Guid uid = Guid.NewGuid();
            usuario.Id = uid.ToString();
            string PassHash = _password.Hashpassword(usuario.Contrasenia);
            usuario.Contrasenia = PassHash;
            _daoCredential.SetUsers("I", usuario);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "credenciales guardadas correctamente";
            return mensaje;

        }

        public Mensaje UpdateUsuario(UsuarioCredential usuario)
        {
            string PassHash = _password.Hashpassword(usuario.Contrasenia);
            usuario.Contrasenia = PassHash;
            _daoCredential.SetUsers("A", usuario);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "credenciales actualizadas";
            return mensaje;

        }

        public Mensaje DeleteUsuario(string Id)
        {
            _daoCredential.DeleteUser(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "credenciales eliminadas";
            return mensaje;

        }

        public Mensaje ActiveUsuario(string Id, int estado)
        {
            _daoCredential.ActiveUser(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "se cambio el estado de las credenciales";
            return mensaje;

        }
    }
}
