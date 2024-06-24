using Data;
using Entity;
using System.Data;

namespace Services
{
    public class CompaniaLogical
    {
        private readonly DaoCompania _daoCompania;
        public CompaniaLogical(DaoCompania daoCompania)
        {
            _daoCompania = daoCompania;
        }

        public async Task<List<Compania>> GetCompania(String compania)
        {            
            return await _daoCompania.Get(compania);
        }

        public async Task<List<VistaCompania>> GetCompanias()
        {
            return await _daoCompania.Gets();
        }

        public Mensaje CreateCompania(Compania compania)
        {
            Guid uid = Guid.NewGuid();
            compania.Id = uid.ToString();
            _daoCompania.Set("I", compania);
            Mensaje mensaje = new Mensaje();    
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje UpdateCompania(Compania compania)
        {
            _daoCompania.Set("A", compania);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "Comapañia actualizada";
            return mensaje;

        }

        public Mensaje DeleteCompania(string Id)
        {
            _daoCompania.Delete(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "Comapañia eliminada";
            return mensaje;

        }

        public Mensaje ActiveCompania(string Id, int estado)
        {
            _daoCompania.Active(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "se cambio el estado de la compañia";
            return mensaje;

        }        
    }
}
