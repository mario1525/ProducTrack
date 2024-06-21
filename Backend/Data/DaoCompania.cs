using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoCompania : BaseDao<Compania>
    {
        public DaoCompania(SqlClient dbContext) : base(dbContext)
        {
        }

        public async Task<List<Compania>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpCompaniaGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),                
                new SqlParameter("@NIT", ""),
                new SqlParameter("@Direccion", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<Compania>> Gets()
        {
            const string procedureName = "dbo.dbSpCompaniaGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@NIT", ""),
                new SqlParameter("@Direccion", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async void Set(string operacion, Compania compania)
        {
            if (compania == null)
            {
                throw new ArgumentNullException(nameof(compania));
            }

            string procedureName = "dbo.dbSpCompaniaSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", compania.Id),
                new SqlParameter("@Nombre", compania.Nombre),
                new SqlParameter("@NIT", compania.NIT),
                new SqlParameter("@Direccion", compania.Direccion),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpCompaniaDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpCompaniaActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        protected override List<Compania> MapDataTableToList(DataTable dataTable)
        {
            List<Compania> companiaList = new List<Compania>();
            foreach (DataRow row in dataTable.Rows)
            {
                Compania compania = new Compania
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    NIT = row["NIT"].ToString(),
                    Direccion = row["Direccion"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    //Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                    // Asigna otras propiedades según tu DataTable
                };
                companiaList.Add(compania);
            }
            return companiaList;
        }
    }
}
