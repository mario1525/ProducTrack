using Entity;
using Data.SQLClient;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Data
{
    public class DaoProductCamp : BaseDao<ProductCamp>
    {
        public DaoProductCamp(SqlClient dbContext) : base(dbContext)
        {
        }

        // Metodo Get
        public async Task<List<ProductCamp>> Get(string Id)
        {
            const string procedureName = "dbo.dbSpProductCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),                
                new SqlParameter("@IdProducto", ""),
                new SqlParameter("@Estado", 1),               
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Gets
        public async Task<List<ProductCamp>> Gets(string IdProducto)
        {
            const string procedureName = "dbo.dbSpProductCampGet";
            var parameters = new[]
            {
                new SqlParameter("@Id", ""),
                new SqlParameter("@Nombre", ""),
                new SqlParameter("@TipoDato", ""),                
                new SqlParameter("@IdProducto", IdProducto),
                new SqlParameter("@Estado", 1)              
            };
            return await GetList(procedureName, parameters);
        }

        // Metodo Set
        public async void Set(string operacion, ProductCamp productCamp)
        {
            if (productCamp == null)
            {
                throw new ArgumentNullException(nameof(productCamp));
            }

            string procedureName = "dbo.dbSpProductCampSet";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", productCamp.Id),
                new SqlParameter("@Nombre", productCamp.Nombre),
                new SqlParameter("@TipoDato", productCamp.TipoDato),
                new SqlParameter("@Obligatorio", productCamp.Obligatorio),
                new SqlParameter("@IdProducto", productCamp.IdProduct),
                new SqlParameter("@Estado", productCamp.Estado),                
                new SqlParameter("@Operacion", operacion),
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Delete
        public async void Delete(string Id)
        {
            string procedureName = "dbo.dbSpProductCampDel";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo Active
        public async void Active(string Id, int estado)
        {
            string procedureName = "dbo.dbSpProductCampActive";
            SqlParameter[] parameters =
            {
                new SqlParameter("@Id", Id),
                new SqlParameter("@Estado", estado)
            };
            await ExecuteProcedure(procedureName, parameters);
        }

        // Metodo para mapear DataTable a una lista de ProductCamp
        protected override List<ProductCamp> MapDataTableToList(DataTable dataTable)
        {
            List<ProductCamp> productCampList = new List<ProductCamp>();
            foreach (DataRow row in dataTable.Rows)
            {
                ProductCamp productCamp = new ProductCamp
                {
                    Id = row["Id"].ToString(),
                    Nombre = row["Nombre"].ToString(),
                    TipoDato = row["TipoDato"].ToString(),
                    Obligatorio = Convert.ToBoolean(row["Obligatorio"]),
                    IdProduct = row["IdProduct"].ToString(),
                    Estado = Convert.ToBoolean(row["Estado"]),                   
                    Fecha_log = row["Fecha_log"].ToString(),
                };
                productCampList.Add(productCamp);
            }
            return productCampList;
        }
    }
}
