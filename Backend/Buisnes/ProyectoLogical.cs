
using Data;
using Entity;

namespace Services
{
    public class ProyectoLogical
    {
        private readonly DaoProyecto _daoProyecto;
        public ProyectoLogical(DaoProyecto daoProyecto)
        {
            _daoProyecto = daoProyecto;
        }

        public async Task<List<Proyecto>> Gets(String IdCompania)
        {
            return await _daoProyecto.Gets(IdCompania);
        }

        public async Task<List<Proyecto>> Get(String Proyecto)
        {
            return await _daoProyecto.Get(Proyecto);
        }

        public Mensaje Create(Proyecto proyecto)
        {
            Guid uid = Guid.NewGuid();
            proyecto.Id = uid.ToString();
            _daoProyecto.Set("I", proyecto);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(Proyecto Proyecto)
        {
            _daoProyecto.Set("A", Proyecto);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _daoProyecto.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;

        }

        public Mensaje Active(string Id, int estado)
        {
            _daoProyecto.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "se cambio el estado de la proyecto";
            return mensaje;

        }
    }
}

