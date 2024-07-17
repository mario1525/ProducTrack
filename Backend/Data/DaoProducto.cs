using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoProducto : BaseDao<Producto>
    {
        public DaoProducto(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<Producto>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProductoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1),               
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<Producto>> Gets(string IdCompania)
        {
            const string procedureName = "dbo.dbSpProductoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1),                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, Producto producto)
        {
            if (producto == null)
            {
                throw new ArgumentNullException(nameof(producto));
            }

            string procedureName = "dbo.dbSpProductoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", producto.Id),
                new SqlParameter("@Nombre", producto.Nombre),
                new SqlParameter("@IdCompania", producto.IdCompania),
                new SqlParameter("@IdProceso", producto.IdProceso),
                new SqlParameter("@Estado", producto.Estado),               
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProductoDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProductoActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de Producto
        protected override List<Producto> MapDataTableToList(DataTable dataTable)
        {
            List<Producto> productoList = new List<Producto>();
            foreach (DataRow row in dataTable.Rows)
            {
                Producto producto = new Producto
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    IdProceso = row["IdProceso"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString(),
                };
                productoList.Add(producto);
            }
            return productoList;
        }
    }
}
