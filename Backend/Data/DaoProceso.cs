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
                new SqlParameter("@IdProceso", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<Proceso>> Gets(string IdCompania)
        {
            const string procedureName = "dbo.dbSpProcesoGet";
            var parameters = new[]
            {
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async void Set(string operacion, CreateProces proceso)
        {
            if (proceso == null)
            {
                throw new ArgumentNullException(nameof(proceso));
            }

            DataTable camposTable = new DataTable();
            camposTable.Columns.Add("id", typeof(string));
            camposTable.Columns.Add("netapa", typeof(int));
            camposTable.Columns.Add("nombre", typeof(string));
                       

            // Recorrer el array de campos y agregar cada campo como una fila al DataTable
            if (operacion == "I")
            {
                foreach (var campo in proceso.procesEtaps)
                {
                    camposTable.Rows.Add(campo.Id,  campo.NEtapa, campo.Nombre);
                }

            }

            string procedureName = "dbo.dbSpProcesoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", proceso.Process.Id),
                new SqlParameter("@Nombre", proceso.Process.Nombre),
                new SqlParameter("@IdCompania", proceso.Process.IdCompania),
                new SqlParameter("@Estado", proceso.Process.Estado),
                new SqlParameter
                    {
                        ParameterName = "@campos",
                        SqlDbType = SqlDbType.Structured,
                        Value = camposTable // Pasar el DataTable como parámetro
                    },
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
                    IdCompania = row["IdCompania"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Fecha_log = row["Fecha_log"].ToString(),
                    // Asigna otras propiedades según tu DataTable
                };
                procesoList.Add(proceso);
            }
            return procesoList;
        }
    }
}

