using Data;
using Entity;


namespace Services
{
    public class ProcesoLogical
    {
        private readonly DaoProceso _DataProces;
        private readonly DaoProcesEtap _Etap;

        public ProcesoLogical(DaoProceso DataProces,DaoProcesEtap Etapa )
        {
            _DataProces = DataProces;  
            _Etap = Etapa;

        }

        public async Task<List<Proceso>> Gets(string IdCompania)
        {
             return await _DataProces.Gets(IdCompania);
        }

        public async Task<List<Proceso>> Get(string Id)
        {
            return await _DataProces.Get(Id);
        }

        public Mensaje Create(CreateProces Process)
        {
            Guid uid = Guid.NewGuid();
            Process.Process.Id = uid.ToString();
            
          
            foreach (ProcesEtap etapa in Process.procesEtaps)
            {
                Guid uidEtap = Guid.NewGuid();
                etapa.Id = uidEtap.ToString();                
            }

            _DataProces.Set("I", Process);

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje Update(Proceso proceso)
        {
            CreateProces proces = new CreateProces();

            proces.Process = proceso;
            _DataProces.Set("A", proces);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "actualizado";
            return mensaje;

        }

        public Mensaje Delete(string Id)
        {
            _DataProces.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "eliminado";
            return mensaje;

        }

        public Mensaje Active(string Id, int estado)
        {
            _DataProces.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "estado actualizado";
            return mensaje;

        }
    }
}
