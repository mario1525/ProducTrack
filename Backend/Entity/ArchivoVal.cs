
namespace Entity
{
    public class ArchivoVal
    {
        public string Id { get; set; }
        public string Nombre_Archivo { get; set; }
        public string Extension { get; set; }
        public string Formato { get; set; }
        public byte[] Archivos { get; set; }
        public double Tamanio { get; set; }
        public string IdArchivo { get; set; }
        public bool Estado { get; set; }
        public bool Eliminado { get; set; }
        public DateTime Fecha_log { get; set; }
    }
}
