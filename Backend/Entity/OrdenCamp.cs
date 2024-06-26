namespace Entity
{
    public class OrdenCamp
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string TipoDato { get; set; }
        public bool Obligatorio { get; set; }
        public string IdOrden { get; set; }
        public bool Estado { get; set; }        
        public DateTime Fecha_log { get; set; }
    }
}
