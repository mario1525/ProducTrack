using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisProductProcesEtap : BaseDao<RegisProductProcesEtap>
    {
        public DaoRegisProductProcesEtap(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisProductProcesEtap>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpRegisProductProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@IdRegisProduct", ""),
                new SqlParameter("@IdProcesEtap", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisProductProcesEtap>> Gets()
        {
            const string procedureName = "dbo.dbSpRegisProductProcesEtapGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdRegisProduct", ""),
                new SqlParameter("@IdProcesEtap", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, RegisProductProcesEtap regisProductProcesEtap)
        {
            if (regisProductProcesEtap == null)
            {
                throw new ArgumentNullException(nameof(regisProductProcesEtap));
            }

            string procedureName = "dbo.dbSpRegisProductProcesEtapSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", regisProductProcesEtap.Id),
                new SqlParameter("@IdRegisProduct", regisProductProcesEtap.IdRegisProduct),
                new SqlParameter("@IdProcesEtap", regisProductProcesEtap.IdProcesEtap),
                new SqlParameter("@IdUsuario", regisProductProcesEtap.IdUsuario),
                new SqlParameter("@Estado", regisProductProcesEtap.Estado),
                new SqlParameter("@Eliminado", regisProductProcesEtap.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisProductProcesEtapDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisProductProcesEtapActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisProductProcesEtap
        protected override List<RegisProductProcesEtap> MapDataTableToList(DataTable dataTable)
        {
            List<RegisProductProcesEtap> regisProductProcesEtapList = new List<RegisProductProcesEtap>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisProductProcesEtap regisProductProcesEtap = new RegisProductProcesEtap
                {
                    Id = row["Id"].ToString(),
                    IdRegisProduct = row["IdRegisProduct"].ToString(),
                    IdProcesEtap = row["IdProcesEtap"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                regisProductProcesEtapList.Add(regisProductProcesEtap);
            }
            return regisProductProcesEtapList;
        }
    }
}
