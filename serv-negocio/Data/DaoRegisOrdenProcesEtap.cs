using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisOrdenProcesEtap : BaseDao<RegisOrdenProcesEtap>
    {
        public DaoRegisOrdenProcesEtap(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisOrdenProcesEtap>> Get(string idOrden, string idProEtap)
        {
            const string procedureName = "dbo.dbSpRegisOrdenProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdRegisOrden", idOrden),
                new SqlParameter("@IdProcesEtap", idProEtap),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisOrdenProcesEtap>> Gets()
        {
            const string procedureName = "dbo.dbSpRegisOrdenProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdProcesEtap", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, RegisOrdenProcesEtap regisOrdenProcesEtap)
        {
            if (regisOrdenProcesEtap == null)
            {
                throw new ArgumentNullException(nameof(regisOrdenProcesEtap));
            }

            string procedureName = "dbo.dbSpRegisOrdenProcesEtapSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", regisOrdenProcesEtap.Id),
                new SqlParameter("@IdRegisOrden", regisOrdenProcesEtap.IdRegisOrden),
                new SqlParameter("@IdProcesEtap", regisOrdenProcesEtap.IdProcesEtap),
                new SqlParameter("@IdUsuario", regisOrdenProcesEtap.IdUsuario),
                new SqlParameter("@Estado", regisOrdenProcesEtap.Estado),                
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisOrdenProcesEtapDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisOrdenProcesEtapActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisProductProcesEtap
        protected override List<RegisOrdenProcesEtap> MapDataTableToList(DataTable dataTable)
        {
            List<RegisOrdenProcesEtap> regisOrdenProcesEtapList = new List<RegisOrdenProcesEtap>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisOrdenProcesEtap regisOrdenProcesEtap = new RegisOrdenProcesEtap
                {
                    Id = row["Id"].ToString(),
                    IdRegisOrden = row["IdRegisOrden"].ToString(),
                    IdProcesEtap = row["IdProcesEtap"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString()
                };
                regisOrdenProcesEtapList.Add(regisOrdenProcesEtap);
            }
            return regisOrdenProcesEtapList;
        }
    }
}