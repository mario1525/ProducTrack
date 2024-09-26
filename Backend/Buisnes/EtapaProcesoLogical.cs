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

        public async Task<etapas> GetsOrden(String IdOrden)
        {
          int Netap =   await _Etap.GetUetapOr(IdOrden);
          List<ProcesEtap> etapa =  await _Etap.GetsOrden(IdOrden);
            etapas etapas = new etapas
            {
                etapa = etapa.ToArray(),
                Uetapa = Netap
            };
            return etapas;
        }

        public async Task<List<ProcesEtap>> Get(String IdProceso)
        {
            return await _Etap.Get(IdProceso);
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
