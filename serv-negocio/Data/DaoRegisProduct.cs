using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoRegisProduct : BaseDao<RegisProduct>
    {
        public DaoRegisProduct(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<RegisProduct>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpRegisProductGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@IdProducto", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)                
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<RegisProduct>> Gets(string IdCompania)
        {
            const string procedureName = "dbo.dbSpRegisProductGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdProducto", ""),
                new SqlParameter("@IdCompania", IdCompania),
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)                
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<RegisProduct>> GetsOrden(string IdOrden)
        {
            const string procedureName = "dbo.dbSpRegisProductGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdProducto", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdRegisOrden", IdOrden),
                new SqlParameter("@IdUsuario", ""),
                new SqlParameter("@Estado", 1)
            };
            return await GetList(procedureName, parameters);
        }

        public async Task<List<RegisProduct>> GetsUser(string IdUsuario)
        {
            const string procedureName = "dbo.dbSpRegisProductGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@IdProducto", ""),
                new SqlParameter("@IdCompania", ""),
                new SqlParameter("@IdRegisOrden", ""),
                new SqlParameter("@IdUsuario", IdUsuario),
                new SqlParameter("@Estado", 1)               
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, RegisProduct regisProduct)
        {
            if (regisProduct == null)
            {
                throw new ArgumentNullException(nameof(regisProduct));
            }

            string procedureName = "dbo.dbSpRegisProductSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", regisProduct.Id),
                new SqlParameter("@IdProducto", regisProduct.IdProduct),
                new SqlParameter("@IdRegisOrden", regisProduct.IdRegisOrden),
                new SqlParameter("@IdCompania", regisProduct.IdCompania),
                new SqlParameter("@IdUsuario", regisProduct.IdUsuario),
                new SqlParameter("@Estado", regisProduct.Estado),                
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpRegisProductDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpRegisProductActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de RegisProduct
        protected override List<RegisProduct> MapDataTableToList(DataTable dataTable)
        {
            List<RegisProduct> regisProductList = new List<RegisProduct>();
            foreach (DataRow row in dataTable.Rows)
            {
                RegisProduct regisProduct = new RegisProduct
                {
                    Id = row["Id"].ToString(),
                    IdProduct = row["IdProduct"].ToString(),
                    IdRegisOrden = row["IdRegisOrden"].ToString(),
                    IdUsuario = row["IdUsuario"].ToString(),
                    IdCompania = row["IdCompania"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                    
                    Fecha_log = row["Fecha_log"].ToString()
                };
                regisProductList.Add(regisProduct);
            }
            return regisProductList;
        }
    }
}
