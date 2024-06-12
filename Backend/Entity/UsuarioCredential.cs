using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class UsuarioCredential
    {
        public string Id { get; set; }
        public string Usuario { get; set; }
        public string Contrasenia { get; set; }
        public string IdUsuario { get; set; }        
        public string Estado { get; set; }        
        public string Fecha_log { get; set; }

        // Constructor vacío
        public UsuarioCredential() { }
    }
}
