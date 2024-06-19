using Data;
using Entity;


namespace Services
{
    public class EtapaProcesoLogical
    {
        private readonly DaoProcesEtap _Etap;

        public EtapaProcesoLogical(DaoProcesEtap etap)
        {
            _Etap = etap;
        }

        public async Task<List<ProcesEtap>> Gets(String IdProceso)
        {
            return await _Etap.Gets(IdProceso);
        }

        public Mensaje Create(ProcesEtap Process)
        {
            Guid uid = Guid.NewGuid();
            Process.Id = uid.ToString();
            _Etap.Set("I", Process);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(ProcesEtap proceso)
        {
            _Etap.Set("A", proceso);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _Etap.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;

        }

        public Mensaje Active(string Id, int estado)
        {
            _Etap.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;

        }
    }
}
