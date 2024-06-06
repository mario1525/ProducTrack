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

        public List<Compania> GetCompaniaList(Compania compania)
        {
            Task<DataTable> taskDataTable = _daoCompania.GetCompania(compania);
            DataTable companias = taskDataTable.Result;
            List<Compania> ListaCompania = MapDataTableToList(companias);
            return ListaCompania;

        }

        private static List<Compania> MapDataTableToList(DataTable dataTable)
        {
            List<Compania> usuariosList = new List<Compania>();

            foreach (DataRow row in dataTable.Rows)
            {
                Compania compania = new Compania 
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    NIT = row["NIT"].ToString(),
                    Direccion = row["Direccion"].ToString(),
                    Estado = row["Estado"].ToString(),
                    Eliminado = row["Eliminado"].ToString(),
                    Fecha_log = row["Fecha_log"].ToString(),
                    // Asigna otras propiedades según tu DataTable
                };
                usuariosList.Add(compania);
            }
            return usuariosList;
        }
    }
}
