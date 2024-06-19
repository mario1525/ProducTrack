

namespace Entity
{
    public class RegisOrden
    {
        public string Id { get; set; }
        public string IdOrden { get; set; }
        public string IdUsuario { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }
    }
}
