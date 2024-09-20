 namespace Entity
{
    public class Orden
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string IdCompania { get; set; }
        public string IdProceso { get; set; }
        public bool Estado { get; set; }        
        public string Fecha_log { get; set; }

        public Orden() { }
    }
}
