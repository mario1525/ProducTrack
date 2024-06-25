using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;


namespace Data
{
    public class DaoOrden : BaseDao<Orden>
    {
        public DaoOrden(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<Orden>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<Orden>> Gets(string IdCompania)
        {
            const string procedureName = "dbo.dbSpOrdenGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, Orden orden)
        {
            if (orden == null)
            {
                throw new ArgumentNullException(nameof(orden));
            }

            string procedureName = "dbo.dbSpOrdenSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", orden.Id),
                new SqlParameter("@Nombre", orden.Nombre),
                new SqlParameter("@IdCompania", orden.IdCompania),
                new SqlParameter("@Estado", orden.Estado),
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpOrdenDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpOrdenActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de Orden
        protected override List<Orden> MapDataTableToList(DataTable dataTable)
        {
            List<Orden> ordenList = new List<Orden>();
            foreach (DataRow row in dataTable.Rows)
            {
                Orden orden = new Orden
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["Compania"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),
                    Eliminado = Convert.ToBoolean(row["Eliminado"]),
                    Fecha_log = row["Fecha_log"].ToString(),
                };
                ordenList.Add(orden);
            }
            return ordenList;
        }
    }
}