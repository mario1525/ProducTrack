using Data;
using Entity;

namespace Services
{
    public class TipoOrdenLogical
    {
        private readonly DaoTipoOrden _Camp;

        public TipoOrdenLogical(DaoTipoOrden camp)
        {
            _Camp = camp;
        }

        public async Task<List<TipoOrden>> Gets(String IdProyecto)
        {
            return await _Camp.Gets(IdProyecto);
        }

        public async Task<List<TipoOrden>> Get(String Id)
        {
            return await _Camp.Get(Id);
        }

        public Mensaje Create(TipoOrden value)
        {
            Guid uid = Guid.NewGuid();
            value.Id = uid.ToString();
            _Camp.Set("I", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(TipoOrden value)
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
