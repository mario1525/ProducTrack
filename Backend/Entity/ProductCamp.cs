
namespace Entity
{
    public class ProductCamp
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string TipoDato { get; set; }
        public bool Obligatorio { get; set; }
        public string IdProduct { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }
    }
}
