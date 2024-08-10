using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoOrdenCampVal : BaseDao<OrdenCampVal>
    {
        public DaoOrdenCampVal(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<OrdenCampVal>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpOrdenCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdOrdenCamp", ""),
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<OrdenCampVal>> Gets(string IdRegisOrden)
        {
            const string procedureName = "dbo.dbSpOrdenCampValGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Valor", ""),
                new SqlParameter("@IdOrdenCamp", ""),
                new SqlParameter("@IdRegisOrden", IdRegisOrden),
                new SqlParameter("@Eliminado", 0)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, OrdenCampVal ordenCampVal)
        {
            if (ordenCampVal == null)
            {
                throw new ArgumentNullException(nameof(ordenCampVal));
            }

            string procedureName = "dbo.dbSpOrdenCampValSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", ordenCampVal.Id),
                new SqlParameter("@Valor", ordenCampVal.Valor),
                new SqlParameter("@IdOrdenCamp", ordenCampVal.IdOrdenCamp),
                new SqlParameter("@IdRegisOrden", ordenCampVal.IdRegisOrden),
                new SqlParameter("@Eliminado", ordenCampVal.Eliminado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpOrdenCampValDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int eliminado)
        {
            string procedureName = "dbo.dbSpOrdenCampValActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Eliminado", eliminado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de OrdenCampVal
        protected override List<OrdenCampVal> MapDataTableToList(DataTable dataTable)
        {
            List<OrdenCampVal> ordenCampValList = new List<OrdenCampVal>();
            foreach (DataRow row in dataTable.Rows)
            {
                OrdenCampVal ordenCampVal = new OrdenCampVal
                {
                    Id = row["Id"].ToString(),
                    Valor = row["Valor"].ToString(),
                    IdOrdenCamp = row["IdOrdenCamp"].ToString(),
                    IdRegisOrden = row["IdRegisOrden"].ToString(),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                ordenCampValList.Add(ordenCampVal);
            }
            return ordenCampValList;
        }
    }
}
