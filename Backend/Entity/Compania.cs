namespace Entity
{
    public class Compania
    {
        public string Id { get; set; }
        public string Nombre { get; set; }
        public string NIT { get; set; }
        public string Sector { get; set; }
        public string Ciudad { get; set; }
        public string Direccion { get; set; }
        public bool Estado { get; set; }       
        public string Fecha_log { get; set; }

        // Constructor vacío
        public Compania() { }
    }
}
