using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Entity
{
    public class ProcesEtap
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public int NEtapa { get; set; }
        public string IdProceso { get; set; }
        public bool Estado { get; set; }        
        public string Fecha_log { get; set; }
    }
}
