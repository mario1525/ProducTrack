
namespace Entity
{
    public class RegisLabProcesEtap
    {
        public string Id { get; set; }
        public string IdRegisProductProcesEtap { get; set; }
        public string IdUsuario { get; set; }
        public string IdLab { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }
    }
}
