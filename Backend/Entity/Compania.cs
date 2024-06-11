using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Compania
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string NIT { get; set; }
        public string Direccion { get; set; }
        public string Estado { get; set; }        
        public string Fecha_log { get; set; }

        // Constructor vacío
        public Compania() { }
    }
}
