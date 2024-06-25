using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoOrdenCamp : BaseDao<OrdenCamp>
    {
        public DaoOrdenCamp(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<OrdenCamp>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpOrdenCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),
                new SqlParameter("@Obligatorio", 0),
                new SqlParameter("@IdOrden", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<OrdenCamp>> Gets(string IdOrden)
        {
            const string procedureName = "dbo.dbSpOrdenCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),
                new SqlParameter("@Obligatorio", 0),
                new SqlParameter("@IdOrden", IdOrden),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, OrdenCamp ordenCamp)
        {
            if (ordenCamp == null)
            {
                throw new ArgumentNullException(nameof(ordenCamp));
            }

            string procedureName = "dbo.dbSpOrdenCampSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", ordenCamp.Id),
                new SqlParameter("@Nombre", ordenCamp.Nombre),
                new SqlParameter("@TipoDato", ordenCamp.TipoDato),
                new SqlParameter("@Obligatorio", ordenCamp.Obligatorio),
                new SqlParameter("@IdOrden", ordenCamp.IdOrden),
                new SqlParameter("@Estado", ordenCamp.Estado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpOrdenCampDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpOrdenCampActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de OrdenCamp
        protected override List<OrdenCamp> MapDataTableToList(DataTable dataTable)
        {
            List<OrdenCamp> ordenCampList = new List<OrdenCamp>();
            foreach (DataRow row in dataTable.Rows)
            {
                OrdenCamp ordenCamp = new OrdenCamp
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    TipoDato = row["TipoDato"].ToString(),
                    Obligatorio = Convert.ToBoolean(row["Obligatorio"]),
                    IdOrden = row["IdOrden"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = Convert.ToDateTime(row["Fecha_log"])
                };
                ordenCampList.Add(ordenCamp);
            }
            return ordenCampList;
        }
    }
}
