
namespace Entity
{
    public class RegisProductProcesEtap
    {
        public string Id { get; set; }
        public string IdRegisProduct { get; set; }
        public string IdProcesEtap { get; set; }
        public string IdUsuario { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }
    }
}
