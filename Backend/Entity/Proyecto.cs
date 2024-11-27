using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class Proyecto
    {
        public string Id { get; set; }
        public string Nombre { get; set; }        
        public string IdCompania { get; set; }
        public string Descripcion { get; set; }
        public bool Estado { get; set; }
        public string Fecha_log { get; set; }

        public Proyecto() { }
    }
}
