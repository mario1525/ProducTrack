using Data;
using Entity;


namespace Services
{
    public class RegisProductCampValLogical
    {
        private readonly DaoProductCampVal _orden;

        public RegisProductCampValLogical(DaoProductCampVal orden)
        {
            _orden = orden;
        }

        public async Task<List<ProductCampVal>> Gets(string IdRegisProduct)
        {
            return await _orden.Gets(IdRegisProduct);
        }

        public async Task<List<ProductCampVal>> Get(string Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(ProductCampVal value)
        {
            Guid uid = Guid.NewGuid();
            value.Id = uid.ToString();
            _orden.Set("I", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(ProductCampVal value)
        {
            _orden.Set("A", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _orden.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;
        }

        public Mensaje Active(string Id, int estado)
        {
            _orden.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;
        }
    }
}

