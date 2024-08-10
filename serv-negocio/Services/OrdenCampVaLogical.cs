using Data;
using Entity;

namespace Services
{
    public class OrdenCampVaLogical
    {
        private readonly DaoOrdenCampVal _orden;

        public OrdenCampVaLogical(DaoOrdenCampVal orden)
        {
            _orden = orden;
        }

        public async Task<List<OrdenCampVal>> Gets(string IdCompania)
        {
            return await _orden.Gets(IdCompania);
        }
        
        public async Task<List<OrdenCampVal>> Get(string Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(OrdenCampVal value)
        {
            Guid uid = Guid.NewGuid();
            value.Id = uid.ToString();
            _orden.Set("I", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(OrdenCampVal value)
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
