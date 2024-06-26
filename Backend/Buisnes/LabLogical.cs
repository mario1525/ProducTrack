

using Data;
using Entity;

namespace Services
{    public class LabLogical
    {
        private readonly DaoLab _lab;
        private readonly DaoLabCamp _camp;

        public LabLogical(DaoLab orden, DaoLabCamp camp)
        {
            _lab = orden;
            _camp = camp;
        }

        public async Task<List<Lab>> Gets(string IdCompania)
        {
            return await _lab.Gets(IdCompania);
        }

        public async Task<List<Lab>> Get(string Id)
        {
            return await _lab.Get(Id);
        }

        public Mensaje Create(CreateLab Value)
        {
            Guid uid = Guid.NewGuid();
            Value.Lab.Id = uid.ToString();
            _lab.Set("I", Value.Lab);
            foreach (LabCamp campo in Value.Campos)
            {
                Guid uidCamp = Guid.NewGuid();
                campo.Id = uidCamp.ToString();
                campo.IdLab = uid.ToString();
                _camp.Set("I", campo);
            }

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(Lab value)
        {
            _lab.Set("A", value);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _lab.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;
        }

        public Mensaje Active(string Id, int estado)
        {
            _lab.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;
        }
    }
}
