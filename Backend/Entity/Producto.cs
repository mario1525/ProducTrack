namespace Entity
{
    public class Producto
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string IdCompania { get; set; }
        public string IdProceso { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }

        public Producto() { }
    }
}
