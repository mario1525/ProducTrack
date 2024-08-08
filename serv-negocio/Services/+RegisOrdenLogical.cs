using Entity;
using Data;

namespace Services
{
    public class RegisOrdenLogical
    {
        private readonly DaoRegisOrden _orden;        

        public RegisOrdenLogical(DaoRegisOrden orden)
        {
            _orden = orden;            
        }

        public async Task<List<RegisOrden>> Gets(string IdCompania)
        {
            return await _orden.Gets(IdCompania);
        }

        public async Task<List<RegisOrden>> Get(string Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(RegisOrden value)
        {
            Guid uid = Guid.NewGuid();
            value.Id = uid.ToString();
            _orden.Set("I", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(RegisOrden value)
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