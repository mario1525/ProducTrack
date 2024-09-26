using Entity;
using Data;

namespace Services
{
    public class RegisOrdenLogical
    {
        private readonly DaoRegisOrden _orden;
        private readonly DaoOrdenCampVal _camp;


        public RegisOrdenLogical(DaoRegisOrden orden, DaoOrdenCampVal camp)
        {
            _orden = orden;
            _camp = camp;
        }

        public async Task<List<RegisOrden>> Gets(string IdCompania)
        {
            
            return await _orden.Gets(IdCompania);
        }

        public async Task<List<RegisOrden>> GetsUser(string IdUsuario)
        {
            return await _orden.GetsUser(IdUsuario);
        }

        public async Task<List<RegisOrden>> Get(string Id)
        {
            return await _orden.Get(Id);
        }

        public Mensaje Create(CreateRegisOrden value)
        {
            string uid = DateTime.Now.ToString("yyyyMMddHHmmssffff");
            value.Orden.Id = uid;
            string uidOrProEtap = DateTime.Now.ToString("yyyyMMddHHmmssffff");
            
            foreach (OrdenCampVal campo in value.Campos)
            {
                string uidCamp = DateTime.Now.ToString("yyyyMMddHHmmssffff");
                campo.Id = uidCamp;                
            }

            _orden.Set("I", uidOrProEtap, value);

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid;
            return mensaje;

        }

        public Mensaje Update(CreateRegisOrden value)
        {           
            _orden.Set("A", null, value);
            foreach (OrdenCampVal campo in value.Campos)
            {               
                _camp.Set("A", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "Actualizado";
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