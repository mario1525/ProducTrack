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
                new SqlParameter("@IdProyecto", ""),
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
                new SqlParameter("@IdProyecto", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1),                
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<Producto>> GetsP(string idProyecto)
        {
            const string procedureName = "dbo.dbSpProductoGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@IdProyecto", idProyecto),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdProceso", ""),
                new SqlParameter("@Estado", 1),
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, CreateProduct producto)
        {
            if (producto == null)
            {
                throw new ArgumentNullException(nameof(producto));
            }

            DataTable camposTable = new DataTable();
            camposTable.Columns.Add("id", typeof(string));
            camposTable.Columns.Add("nombre", typeof(string));
            camposTable.Columns.Add("tipodato", typeof(string));
            camposTable.Columns.Add("obligatorio", typeof(bool));

            // Recorrer el array de campos y agregar cada campo como una fila al DataTable
            if (operacion == "I")
            {
                foreach (var campo in producto.campos)
                {
                    camposTable.Rows.Add(campo.Id, campo.Nombre, campo.TipoDato, campo.Obligatorio);
                }

            }

            string procedureName = "dbo.dbSpProductoSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", producto.producto.Id),
                new SqlParameter("@Nombre", producto.producto.Nombre),
                new SqlParameter("@IdProyecto", producto.producto.IdProyecto),
                new SqlParameter("@IdProceso", producto.producto.IdProceso),
                new SqlParameter("@Estado", producto.producto.Estado),
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
                    IdProyecto = row["IdProyecto"].ToString(),
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
