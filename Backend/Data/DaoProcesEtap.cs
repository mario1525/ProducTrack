using Entity; 
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;


namespace Data
{
    public class DaoProcesEtap : BaseDao<ProcesEtap>
    {
        public DaoProcesEtap(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Gets
        public async Task<List<ProcesEtap>> Gets(string Id)
        {
            const string procedureName = "dbo.dbSpProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@IdProcesEtap", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@NEtapa", ""),
                new SqlParameter("@IdProceso", Id),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<int> GetUetapOr(string Id)
        {
            
            const string procedureName = "dbo.dbSpLastOrdenEtap";
            var parameters = new[]
            {
                new SqlParameter("@IdOrden", Id),
                
            };
            
            int NEtapa = 0;
            DataTable dataTable = await _sqlClient.ExecuteStoredProcedure(procedureName, parameters);
            foreach (DataRow row in dataTable.Rows)
            {               
               NEtapa = Convert.ToInt16(row["NEtapa"]);
            };            
            return NEtapa;
        }
        public async Task<List<ProcesEtap>> GetsOrden(string Id)
        {
            const string procedureName = "dbo.dbSpEtapasOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@IdOrden", Id),                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Get
        public async Task<List<ProcesEtap>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@IdProcesEtap", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@NEtapa", ""),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, ProcesEtap procesEtap)
        {
            if (procesEtap == null)
            {
                throw new ArgumentNullException(nameof(procesEtap));
            }

            string procedureName = "dbo.dbSpProcesEtapSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", procesEtap.Id),
                new SqlParameter("@Nombre", procesEtap.Nombre),
                new SqlParameter("@NEtapa", procesEtap.NEtapa),
                new SqlParameter("@IdProceso", procesEtap.IdProceso),
                new SqlParameter("@Estado", procesEtap.Estado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProcesEtapDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProcesEtapActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de ProcesEtap
        protected override List<ProcesEtap> MapDataTableToList(DataTable dataTable)
        {
            List<ProcesEtap> procesEtapList = new List<ProcesEtap>();
            foreach (DataRow row in dataTable.Rows)
            {
                ProcesEtap procesEtap = new ProcesEtap
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    NEtapa = Convert.ToInt16(row["NEtapa"]),
                    IdProceso = row["IdProceso"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    //Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = row["Fecha_log"].ToString()
                };
                procesEtapList.Add(procesEtap);
            }
            return procesEtapList;
        }
    }
}
