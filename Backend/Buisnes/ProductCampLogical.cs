
using Data;
using Entity;

namespace Services
{
    public class ProductCampLogical
    {
        private readonly DaoProductCamp _Camp;

        public ProductCampLogical(DaoProductCamp camp)
        {
            _Camp = camp;
        }

        public async Task<List<ProductCamp>> Gets(string IdOrden)
        {
            return await _Camp.Gets(IdOrden);
        }

        public Mensaje Create(ProductCamp value)
        {
            Guid uid = Guid.NewGuid();
            value.Id = uid.ToString();
            _Camp.Set("I", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(ProductCamp value)
        {
            _Camp.Set("A", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _Camp.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;

        }

        public Mensaje Active(string Id, int estado)
        {
            _Camp.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;

        }
    }
}
