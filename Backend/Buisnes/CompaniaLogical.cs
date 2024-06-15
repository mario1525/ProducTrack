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
            return await _daoCompania.GetCompania(compania);
        }

        public async Task<List<Compania>> GetCompanias()
        {
            return await _daoCompania.GetCompanias();
        }

        public Mensaje CreateCompania(Compania compania)
        {
            Guid uid = Guid.NewGuid();
            compania.Id = uid.ToString();
            _daoCompania.SetCompania("I", compania);
            Mensaje mensaje = new Mensaje();    
            mensaje.mensaje = uid.ToString();
            return mensaje;

        }

        public Mensaje UpdateCompania(Compania compania)
        {
            _daoCompania.SetCompania("A", compania);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "Comapañia actualizada";
            return mensaje;

        }

        public Mensaje DeleteCompania(string Id)
        {
            _daoCompania.DeleteCompania(Id);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "Comapañia eliminada";
            return mensaje;

        }

        public Mensaje ActiveCompania(string Id, int estado)
        {
            _daoCompania.ActiveCompania(Id, estado);
            Mensaje mensaje = new Mensaje();
            mensaje.mensaje = "se cambio el estado de la compañia";
            return mensaje;

        }        
    }
}
