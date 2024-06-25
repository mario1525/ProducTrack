

using Azure;
using Data;
using Entity;

namespace Services
{
    public class OrdenLogical
    {
        private readonly DaoOrden _orden;
        private readonly DaoOrdenCamp _camp;

        public OrdenLogical(DaoOrden orden, DaoOrdenCamp camp)
        {
            _orden = orden;
            _camp = camp;
        }

        public async Task<List<Orden>> Gets(string IdCompania)
        {
            return await _orden.Gets(IdCompania);
        }

        public async Task<List<Orden>> Get(String Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(CreateOrden Orden)
        {
            Guid uid = Guid.NewGuid();
            Orden.Orden.Id = uid.ToString();
            _orden.Set("I", Orden.Orden);
            foreach (OrdenCamp campo in Orden.Campos)
            {
                Guid uidCamp = Guid.NewGuid();
                campo.Id = uidCamp.ToString();
                campo.IdOrden = uid.ToString();
                _camp.Set("I", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(Orden value)
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
