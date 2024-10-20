using Entity;
using Data;


namespace Services
{
    public class RegisOrdenEtapLogical
    {

        private readonly DaoRegisOrdenProcesEtap _Dao;

        public RegisOrdenEtapLogical(DaoRegisOrdenProcesEtap daoRegisOrdenProcesEtap)
        { 
            _Dao = daoRegisOrdenProcesEtap;
        }

        public async Task<List<RegisOrdenProcesEtap>> Get(string idOrden, string idProEtap)
        {
            return await _Dao.Get(idOrden, idProEtap);
        }

        public Mensaje create(RegisOrdenProcesEtap value)
        {
            string uid = DateTime.Now.ToString("yyyyMMddHHmmssffff");
            value.Id = uid;

            _Dao.Set("I", value);

            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = uid;
            return mensaje;

        }
    

    }
}
