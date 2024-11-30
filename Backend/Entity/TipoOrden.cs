
namespace Entity
{
    public class TipoOrden
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string IdProyecto { get; set; }
        public bool Estado { get; set; }
        public string Fecha_log { get; set; }
    }
}
