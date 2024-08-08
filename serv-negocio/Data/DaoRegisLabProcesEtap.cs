using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisLabProcesEtap : BaseDao<RegisLabProcesEtap>
    {
        public DaoRegisLabProcesEtap(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisLabProcesEtap>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpRegisLabProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@IdRegisProductProcesEtap", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@IdLab", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisLabProcesEtap>> Gets()
        {
            const string procedureName = "dbo.dbSpRegisLabProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdRegisProductProcesEtap", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@IdLab", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, RegisLabProcesEtap regisLabProcesEtap)
        {
            if (regisLabProcesEtap == null)
            {
                throw new ArgumentNullException(nameof(regisLabProcesEtap));
            }

            string procedureName = "dbo.dbSpRegisLabProcesEtapSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", regisLabProcesEtap.Id),
                new SqlParameter("@IdRegisProductProcesEtap", regisLabProcesEtap.IdRegisProductProcesEtap),
                new SqlParameter("@IdUsuario", regisLabProcesEtap.IdUsuario),
                new SqlParameter("@IdLab", regisLabProcesEtap.IdLab),
                new SqlParameter("@Estado", regisLabProcesEtap.Estado),
                new SqlParameter("@Eliminado", regisLabProcesEtap.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisLabProcesEtapDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisLabProcesEtapActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisLabProcesEtap
        protected override List<RegisLabProcesEtap> MapDataTableToList(DataTable dataTable)
        {
            List<RegisLabProcesEtap> regisLabProcesEtapList = new List<RegisLabProcesEtap>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisLabProcesEtap regisLabProcesEtap = new RegisLabProcesEtap
                {
                    Id = row["Id"].ToString(),
                    IdRegisProductProcesEtap = row["IdRegisProductProcesEtap"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    IdLab = row["IdLab"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                regisLabProcesEtapList.Add(regisLabProcesEtap);
            }
            return regisLabProcesEtapList;
        }
    }
}
