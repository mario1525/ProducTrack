using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class RegisOrdenProcesEtap
    {
        public string Id { get; set; }
        public string IdRegisOrden { get; set; }
        public string IdProcesEtap { get; set; }
        public string IdUsuario { get; set; }
        public bool Estado { get; set; }
        public string Fecha_log { get; set; }
    }
}
