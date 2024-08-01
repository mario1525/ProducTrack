

using Data;
using Entity;

namespace Services
{
    public class ProductLogical
    {
        private readonly DaoProducto  _Dao;
        private readonly DaoProductCamp _camp;

        public ProductLogical(DaoProducto orden, DaoProductCamp camp)
        {
            _Dao = orden;
            _camp = camp;
        }

        public async Task<List<Producto>> Gets(string IdCompania)
        {
            return await _Dao.Gets(IdCompania);
        }

        public async Task<List<Producto>> Get(string Id)
        {
            return await _Dao.Get(Id);
        }

        public Mensaje Create(CreateProduct Value)
        {
            Guid uid = Guid.NewGuid();
            Value.producto.Id = uid.ToString();
            _Dao.Set("I", Value.producto);
            Task.Delay(1000);
            foreach (ProductCamp campo in Value.campos)
            {
                Guid uidCamp = Guid.NewGuid();
                campo.Id = uidCamp.ToString();
                campo.IdProduct = uid.ToString();
                _camp.Set("I", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(Producto value)
        {
            _Dao.Set("A", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _Dao.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;
        }

        public Mensaje Active(string Id, int estado)
        {
            _Dao.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;
        }
    }
}
