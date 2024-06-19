using Data.SQLClient;
using Entity;
using System.Data;
using Microsoft.Data.SqlClient;

namespace Data
{
    public class DaoProceso : BaseDao<Proceso>
    {
        public DaoProceso(SqlClient dbContext) : base(dbContext)
        {
        }

        public async Task<List<Proceso>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProcesoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<Proceso>> Gets()
        {
            const string procedureName = "dbo.dbSpProcesoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async void Set(string operacion, Proceso proceso)
        {
            if (proceso == null)
            {
                throw new ArgumentNullException(nameof(proceso));
            }

            string procedureName = "dbo.dbSpProcesoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", proceso.Id),
                new SqlParameter("@Nombre", proceso.Nombre),
                new SqlParameter("@IdCompania", proceso.IdCompania),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProcesoDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProcesoActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        protected override List<Proceso> MapDataTableToList(DataTable dataTable)
        {
            List<Proceso> procesoList = new List<Proceso>();
            foreach (DataRow row in dataTable.Rows)
            {
                Proceso proceso = new Proceso
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["NIT"].ToString(),
                    Estado = row["Estado"].ToString(),
                    Fecha_log = row["Fecha_log"].ToString(),
                    // Asigna otras propiedades según tu DataTable
                };
                procesoList.Add(proceso);
            }
            return procesoList;
        }
    }
}

